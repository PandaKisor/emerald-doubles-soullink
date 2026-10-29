-- Field guide sync (user, 2026-10-27): on every save and from START > GUIDE
-- SYNC the campaign writes guide-sync.bin (JSON) into its mod storage folder
-- for the offline field guide to load. It holds this player's party and box,
-- the set event flags (badges, beaten trainers, picked-up items), the map,
-- the level cap, the Soul Link record, and the partner's party and box as
-- co-op last carried them. The guide reads it; nothing is ever read back.
--   soulLink.rows[i].mine/theirs: { state, species, uid, nickname }
--   mon: { species, level, item, ability, nature, iv hp/atk/def/spa/spd/spe,
--          ev x6, move x4, hp, maxHp, uid, nickname }
return function(mod, active)
  local Runtime = require("src.core.game3.runtime")
  local Json = require("src.link.Json")
  local Pokemon = require("src.core.game3.pokemon")
  local G = { KEY = "guide-sync", FORMAT = "emerald-guide-sync", VERSION = 1 }
  local STATS = { "hp", "atk", "def", "spa", "spd", "spe" }

  local function coop(game)
    local ex = game and game.mods and game.mods.exports
    return ex and ex.g3_coop
  end

  -- the ability battles use: the mon's own field, else species + personality (battle/damage.lua)
  local function ability(m)
    local a = tonumber(m.ability or m.abilityId)
    if a then return a end
    local ok, id = pcall(Pokemon.abilityId, m.species, m.personality)
    return ok and tonumber(id) or 0
  end

  function G.mon(m)
    if type(m) ~= "table" or not tonumber(m.species) or m.isEgg or m.egg then return nil end
    local pid = tonumber(m.personality) or 0
    local evs = Pokemon.evsOf and Pokemon.evsOf(m) or m.evs or {}
    local row = { tonumber(m.species), tonumber(m.level) or 1, tonumber(m.item or m.heldItem) or 0,
      ability(m), Pokemon.natureId(pid) }
    for _, k in ipairs(STATS) do row[#row + 1] = tonumber(m.ivs and m.ivs[k]) or 0 end
    for _, k in ipairs(STATS) do row[#row + 1] = tonumber(evs[k]) or 0 end
    for i = 1, 4 do row[#row + 1] = tonumber(m.moves and m.moves[i]) or 0 end
    row[#row + 1] = tonumber(m.hp) or 0
    row[#row + 1] = tonumber(m.maxHp) or 0
    local p, o = tonumber(m.personality), tonumber(m.otId or m.trainerId)
    row[#row + 1] = (p and o) and ("%.0f:%.0f"):format(p % 4294967296, o % 4294967296) or ""
    row[#row + 1] = type(m.nickname) == "string" and m.nickname or ""
    return row
  end

  function G.mons(list)
    local out = {}
    for _, m in ipairs(list or {}) do out[#out + 1] = G.mon(m) end
    return out
  end

  function G.box(session)
    local out, st = {}, session and session.storage
    for _, b in ipairs(st and st.boxes or {}) do
      for slot = 1, 30 do
        local r = G.mon(b.mons and b.mons[slot])
        if r then out[#out + 1] = r end
      end
    end
    return out
  end

  local function flagSet(session)
    local seen, out = {}, {}
    -- the live flag store, only when it was loaded for this session: after
    -- a New Game it may still hold the previous game's flags
    local Space = package.loaded["src.core.game3.scripting.space"]
    local store = Space and Space.store
    if store and Space._storeSession ~= session then store = nil end
    for _, src in ipairs({ session and session.flags or {}, store and store.flags or {} }) do
      for id, v in pairs(src) do
        local n = tonumber(id)
        if v and n and not seen[n] then seen[n] = true; out[#out + 1] = n end
      end
    end
    table.sort(out)
    return out
  end

  local function soulLink(game)
    local c = coop(game)
    local ok, tracker = pcall(function() return c and c.tracker and c.tracker() end)
    if not (ok and tracker and tracker.run) then return nil end
    local okV, v = pcall(tracker.view, tracker)
    if not okV or type(v) ~= "table" then return nil end
    local names = v.names or {}
    local side = function(x) return x and { x.state, tonumber(x.s) or 0, x.u or "", x.u and names[x.u] or "" } or nil end
    local areaName = tracker.d and tracker.d.areaName
    local rows, dead = {}, {}
    for _, r in ipairs(v.pairs or {}) do
      local okN, an = pcall(function() return areaName and areaName(r.a) end)
      rows[#rows + 1] = { a = r.a, name = okN and type(an) == "string" and an or nil,
                          mine = side(r.mine), theirs = side(r.theirs), status = r.status }
    end
    for u in pairs(v.banned or {}) do dead[#dead + 1] = u end
    return { rows = rows, banned = dead }
  end

  -- this player's party + box, for the partner (co-op carries it)
  function G.mine(session)
    return { name = session.name or session.playerName or "", party = G.mons(session.party), box = G.box(session) }
  end

  function G.snapshot(game, session)
    local c = coop(game)
    local cap
    if c and c.levelCap then pcall(function() cap = c.levelCap() end) end
    local partner
    if c and c.partnerGuide then pcall(function() partner = c.partnerGuide() end) end
    local mine = G.mine(session)
    return {
      format = G.FORMAT, v = G.VERSION, campaign = mod.manifest and mod.manifest.version or "",
      player = { name = mine.name, tid = tonumber(session.trainerId) or 0, map = session.map or "",
                 x = tonumber(session.x) or 0, y = tonumber(session.y) or 0, cap = tonumber(cap) or 0,
                 cleared = session.game_cleared == true },
      party = mine.party, box = mine.box, flags = flagSet(session),
      soulLink = soulLink(game), partner = partner,
    }
  end

  function G.write(game, session)
    if not active() then return false end
    game = game or Runtime._game
    session = session or Runtime.getSession()
    if not (game and session and session.party) then return false end
    local snap = G.snapshot(game, session)
    local c = coop(game)
    if c and c.shareGuide then pcall(c.shareGuide, G.mine(session)) end
    local okJ, text = pcall(Json.encode, snap)
    if not okJ then return false, text end
    local ok, err = mod.storage:writeBytes(game, G.KEY, text)
    -- and one copy in a folder that never changes (user, 2026-10-28: the
    -- playthrough folder is a long id that changes with every New Game)
    pcall(function() mod.storage:writeBytes(G.fixedGame(), G.KEY, text) end)
    return ok, err
  end

  -- the storage scope of that fixed copy: mod_storage/emerald/field-guide/g3_campaign/
  G.FIXED = "field-guide"
  function G.fixedGame()
    return { save = { version = "emerald", meta = { playthroughId = G.FIXED } } }
  end

  function G.path(game)
    local ok, ctx = pcall(function() return mod.storage:context(game) end)
    if not (ok and type(ctx) == "table" and ctx.playthroughId) then return nil end
    return ("mod_storage/%s/%s/%s/%s.bin"):format(ctx.gameVersion or "emerald", ctx.playthroughId, mod.id or "g3_campaign", G.KEY)
  end

  mod.events:on("save.writing", function()
    if active() then pcall(G.write) end
  end)

  function G.open(game, session)
    if not active() then return end
    game = game or Runtime._game
    local ok = G.write(game, session)
    require("src.ui.game3.start_menu").close(true)
    require("src.ui.game3.message").show(ok and ("Field guide synced! The file is\nguide-sync.bin in mod_storage/\nemerald/" .. G.FIXED
      .. "/g3_campaign/") or "The guide sync could not be written.")
  end

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "save" then at = i end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_guide", label = "GUIDE SYNC", onSelect = G.open })
    return copy
  end)
  return G
end
