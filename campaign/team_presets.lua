-- START > TOOLS > TEAMS (user, 2026-11-01): three saved teams with their held
-- items, kept in the save. Loading pulls the team out of the party and boxes.
-- A Pokémon the Soul Link rules have banned stays boxed (mod.exports.coopBanned),
-- and an item only moves if the bag has it, so a preset can't bring back the
-- fallen or make an item appear.
return function(mod, active)
  local Storage = require("src.core.game3.storage")
  local Bag = require("src.core.game3.bag")
  local P = { SLOTS = 3 }

  local function uid(mon)
    local p, o = tonumber(mon.linkPersonality or mon.personality), tonumber(mon.otId or mon.trainerId)
    return ("%.0f:%.0f"):format((p or 0) % 4294967296, (o or 0) % 4294967296)
  end
  local function store(s)
    s.modData = s.modData or {}
    s.modData.g3_campaign = s.modData.g3_campaign or {}
    local root = s.modData.g3_campaign
    root.teams = root.teams or {}
    return root.teams
  end
  local function heldOf(mon) return tonumber(mon.item or mon.heldItem) or 0 end

  function P.save(s, slot)
    local team = {}
    for i, mon in ipairs(s.party or {}) do team[i] = { u = uid(mon), i = heldOf(mon) } end
    store(s)[slot] = team
    return #team
  end
  function P.size(s, slot)
    local team = store(s)[slot]
    return team and #team or 0
  end

  function P.load(s, slot, banned)
    local team = store(s)[slot]
    if not team or #team == 0 then return 0, 0 end
    local storage = Storage.ensure(s)
    local where = {}
    for i, mon in ipairs(s.party) do where[uid(mon)] = { mon = mon, party = i } end
    for boxId, box in pairs(storage.boxes) do
      for at = 1, Storage.IN_BOX_COUNT do
        local mon = box.mons and box.mons[at]
        if mon then where[uid(mon)] = where[uid(mon)] or { mon = mon, box = box, at = at } end
      end
    end
    local party, used, missing, free = {}, {}, 0, {}
    for _, row in ipairs(team) do
      local spot = where[row.u]
      if spot and not used[row.u] and not (banned and banned(spot.mon)) then
        used[row.u] = true
        party[#party + 1] = spot.mon
        spot.item = row.i
      else
        missing = missing + 1
      end
    end
    if #party == 0 then return 0, missing end
    -- out of the boxes first: those tiles take the old party
    for u in pairs(used) do
      local spot = where[u]
      if spot.box then
        spot.box.mons[spot.at] = nil
        free[#free + 1] = { spot.box, spot.at }
      end
    end
    for _, mon in ipairs(s.party) do
      if not used[uid(mon)] then
        local tile = table.remove(free, 1)
        if tile then
          tile[1].mons[tile[2]] = mon
        elseif not Storage.sendMonToPC(s, mon) then
          party[#party + 1] = mon -- every box is full: it stays in the party
        end
      end
    end
    s.party = party
    for u in pairs(used) do
      local spot = where[u]
      local want, have = spot.item, heldOf(spot.mon)
      if want ~= 0 and want ~= have and Bag.has(s.bag, want, 1) then
        Bag.remove(s.bag, want, 1)
        if have ~= 0 then Bag.add(s.bag, have, 1) end
        spot.mon.item, spot.mon.heldItem = want, want
      end
    end
    return #party, missing
  end

  function P.open(game, session)
    if not active() then return end
    local s = session or require("src.core.game3.runtime").getSession()
    local Message, Choice = require("src.ui.game3.message"), require("src.ui.game3.choice")
    require("src.ui.game3.start_menu").close(true)
    local labels = {}
    for i = 1, P.SLOTS do labels[i] = ("TEAM %d (%d)"):format(i, P.size(s, i)) end
    labels[#labels + 1] = "CANCEL"
    Message.show("Which team?", { stay = true })
    Choice.multi(labels, 0, function(index)
      if Message.isOpen() then Message.close() end
      local slot = index ~= 127 and index + 1 or nil
      if not slot or slot > P.SLOTS then return end
      Message.show(("TEAM %d: load it, or save\nyour party there?"):format(slot), { stay = true })
      Choice.multi({ "LOAD", "SAVE", "CANCEL" }, 0, function(act)
        if Message.isOpen() then Message.close() end
        if act == 0 then
          local got, missing = P.load(s, slot, function(mon)
            local ex = game and game.mods and game.mods.exports and game.mods.exports.g3_coop
            return ex and ex.coopBanned and ex.coopBanned(mon)
          end)
          if got == 0 then Message.show("That team has nobody to load.")
          elseif missing > 0 then Message.show(("Team loaded. %d couldn't come."):format(missing))
          else Message.show("Team loaded.") end
        elseif act == 1 then
          Message.show(("Saved %d POKéMON to TEAM %d."):format(P.save(s, slot), slot))
        end
      end)
    end)
  end

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local s = require("src.core.game3.runtime").getSession()
    if not (s and s.party and #s.party > 0) then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_teams", label = "TEAMS", onSelect = P.open })
    return copy
  end)
  return P
end
