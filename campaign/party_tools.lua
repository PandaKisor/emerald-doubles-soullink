-- START > MOVE RELEARNER (free, unlimited: Emerald's relearner screen for any
-- party member) and START > IV / EV (a page per party member: IVs, EVs,
-- the nature's raised/lowered stats and Hidden Power's type; L/R flips
-- through the party, B closes). The EVs are editable (user, 2026-10-29:
-- trainers are EV trained, grinding them isn't fun): UP/DOWN picks a stat,
-- LEFT/RIGHT takes or adds 4, A fills it (up to 252, within 510 in all) or
-- clears it. Stats are recalculated at once; HP keeps its damage.
-- RELEARN MOVE also offers the egg moves of the Pokémon's line.
return function(mod, active, data, evolutions)
  local Runtime = require("src.core.game3.runtime")
  local Pokemon = require("src.core.game3.pokemon")
  local MoveLearn = require("src.core.game3.move_learn")
  local P = {}

  -- species -> what it evolves from, by the evolution rules
  local pre = {}
  for _, rules in ipairs(evolutions or {}) do
    for from, rows in pairs(rules) do
      for _, row in ipairs(rows) do
        local to = type(row) == "table" and tonumber(row.target or row.species)
        if to and not pre[to] then pre[to] = tonumber(from) end
      end
    end
  end
  -- egg moves of this species and everything before it, not yet known
  function P.eggMoves(mon)
    local out, seen = {}, {}
    for _, m in ipairs(mon.moves or {}) do seen[tonumber(type(m) == "table" and (m.id or m.move) or m) or 0] = true end
    local species, guard = Pokemon.speciesOf(mon), 0
    while species and guard < 4 do
      local row = data and data.species[species]
      for _, move in ipairs(row and row.eggMoves or {}) do
        if not seen[move] then seen[move] = true; out[#out + 1] = move end
      end
      species, guard = pre[species], guard + 1
    end
    return out
  end
  -- the Pledges come from RELEARN MOVE once two badges are in, for the Pokémon
  -- their tutor rows allow (no NPC teaches them on the vanilla map)
  local PLEDGE_BADGES = 2
  function P.pledges(mon)
    local out = {}
    local world = require("src.core.game3.marts")._campaignWorld
    if not (world and world.badges() >= PLEDGE_BADGES) then return out end
    local known = {}
    for _, m in ipairs(mon.moves or {}) do known[tonumber(type(m) == "table" and (m.id or m.move) or m) or 0] = true end
    local species = Pokemon.speciesOf(mon)
    for tutor, move in pairs(data.manifest.tutorMoves) do
      local name = data.moves[move] and data.moves[move].symbol
      if name and name:find("_PLEDGE$") and not known[move] and MoveLearn.canLearnTutorMove(species, tutor) then
        out[#out + 1] = move
      end
    end
    table.sort(out)
    return out
  end
  -- content.lua calls this after full/tutors.lua, which replaces the same function
  function P.installEggRelearn()
    local relearnable = MoveLearn.relearnableMoves
    function MoveLearn.relearnableMoves(mon, ...)
      local moves = relearnable(mon, ...)
      if not (mon and active()) then return moves end
      local have = {}
      for _, m in ipairs(moves) do have[m] = true end
      for _, m in ipairs(P.eggMoves(mon)) do
        if not have[m] then moves[#moves + 1] = m end
      end
      for _, m in ipairs(P.pledges(mon)) do
        if not have[m] then moves[#moves + 1] = m end
      end
      return moves
    end
  end

  local NATURES = { "HARDY", "LONELY", "BRAVE", "ADAMANT", "NAUGHTY", "BOLD", "DOCILE", "RELAXED", "IMPISH", "LAX",
    "TIMID", "HASTY", "SERIOUS", "JOLLY", "NAIVE", "MODEST", "MILD", "QUIET", "BASHFUL", "RASH",
    "CALM", "GENTLE", "SASSY", "CAREFUL", "QUIRKY" }
  -- pokeemerald nature order of stat effects: Atk, Def, Spe, SpA, SpD
  local NATURE_STAT = { "atk", "def", "spe", "spa", "spd" }
  local ROWS = { { "hp", "HP" }, { "atk", "ATTACK" }, { "def", "DEFENSE" }, { "spa", "SP. ATK" }, { "spd", "SP. DEF" }, { "spe", "SPEED" } }

  local function isEgg(mon) return mon and (mon.isEgg or mon.egg) end

  local function party(session)
    session = session or Runtime.getSession()
    return session, session and session.party
  end

  -- move relearner ---------------------------------------------------------------
  function P.openRelearner(_, session)
    if not active() then return end
    local s, mons = party(session)
    if not (mons and #mons > 0) then return end
    require("src.ui.game3.start_menu").close(true)
    local PartyMenu = require("src.ui.game3.party_menu")
    PartyMenu.show(mons, s.moveOverlay, {
      session = s, mode = "choose",
      validate = function(slot)
        local mon = mons[slot]
        if not mon or isEgg(mon) then return "An EGG can't learn moves." end
        if MoveLearn.countRelearnableMoves(mon) == 0 then return "There are no moves to remember." end
      end,
      onSelect = function(_, mon)
        if not mon then return end
        require("src.ui.game3.rse.move_relearner").show(mon, { session = s, onDone = function() end })
      end,
    })
  end

  -- EV editing -------------------------------------------------------------------
  P.EV_STAT_MAX, P.EV_TOTAL_MAX = 252, Pokemon.MAX_TOTAL_EVS or 510

  -- sets one EV, clamped to the stat's and the total's room; returns the value set
  function P.setEv(mon, key, value)
    local evs = Pokemon.evsOf(mon)
    if evs[key] == nil then return nil end
    local others = Pokemon.evCount(mon) - evs[key]
    value = math.floor(tonumber(value) or 0)
    value = math.max(0, math.min(value, P.EV_STAT_MAX, P.EV_TOTAL_MAX - others))
    if value == evs[key] then return value end
    evs[key] = value
    local oldMaxHp, oldHp = tonumber(mon.maxHp) or 0, tonumber(mon.hp) or 0
    Pokemon.applyStats(mon)
    local newMaxHp = tonumber(mon.maxHp) or oldMaxHp
    -- pokefirered/src/pokemon.c:2155, as vitamins do (a fainted mon stays fainted)
    if oldHp > 0 then mon.hp = math.max(1, math.min(newMaxHp, oldHp + (newMaxHp - oldMaxHp))) end
    return value
  end

  -- A on a stat: fill it, or clear it when it is already as full as it can be
  function P.toggleEv(mon, key)
    local evs = Pokemon.evsOf(mon)
    if evs[key] == nil then return nil end
    local room = math.min(P.EV_STAT_MAX, P.EV_TOTAL_MAX - (Pokemon.evCount(mon) - evs[key]))
    return P.setEv(mon, key, evs[key] >= room and 0 or room)
  end

  -- Nature Mint ------------------------------------------------------------------
  -- Nature comes from the personality, which also sets gender and ability slot
  -- (low 16 bits), shininess and Wurmple's branch. A new value keeps all of those,
  -- and mon.linkPersonality keeps the Soul Link identity (g3_coop lib/soullink.lua).
  local bit = require("bit")
  local function shinyValue(hi, lo, ot)
    return bit.bxor(hi, lo, math.floor(ot / 65536) % 65536, ot % 65536)
  end
  function P.setNature(mon, nature)
    local p = tonumber(mon.personality) or 0
    local lo, hi = p % 65536, math.floor(p / 65536)
    local ot = tonumber(mon.otId or mon.trainerId) or 0
    local shiny = shinyValue(hi, lo, ot) < 8
    for step = 0, 65535 do
      local h = (hi + step) % 65536
      local np = h * 65536 + lo
      if np % 25 == nature and (h % 10 < 5) == (hi % 10 < 5) and (shinyValue(h, lo, ot) < 8) == shiny then
        mon.linkPersonality = mon.linkPersonality or p
        mon.personality = np
        local oldMaxHp, oldHp = tonumber(mon.maxHp) or 0, tonumber(mon.hp) or 0
        Pokemon.applyStats(mon)
        local newMaxHp = tonumber(mon.maxHp) or oldMaxHp
        if oldHp > 0 then mon.hp = math.max(1, math.min(newMaxHp, oldHp + (newMaxHp - oldMaxHp))) end
        return true
      end
    end
    return false
  end
  local mintId = data and data.identity.namespaces.items.ITEM_NATURE_MINT
  local Bag = require("src.core.game3.bag")
  function P.mints(s)
    return (s and s.bag and mintId and Bag.get(s.bag, mintId)) or 0
  end
  function P.useMint(s, mon, nature)
    if P.mints(s) < 1 or Pokemon.natureId(mon.personality) == nature then return false end
    if not P.setNature(mon, nature) then return false end
    Bag.remove(s.bag, mintId, 1)
    return true
  end

  -- IV check ---------------------------------------------------------------------
  local Screen = { isMenu = true }
  local STACK_ID = "g3_campaign_iv_check"

  function P.ivRows(mon)
    local nature = Pokemon.natureId(mon.personality)
    local up, down = NATURE_STAT[math.floor(nature / 5) + 1], NATURE_STAT[nature % 5 + 1]
    if up == down then up, down = nil, nil end
    local ivs, evs = mon.ivs or {}, Pokemon.evsOf and Pokemon.evsOf(mon) or mon.evs or {}
    local rows = {}
    for _, r in ipairs(ROWS) do
      rows[#rows + 1] = { label = r[2], iv = tonumber(ivs[r[1]]) or 0, ev = tonumber(evs[r[1]]) or 0,
        mark = (r[1] == up and "+") or (r[1] == down and "-") or "" }
    end
    local hpType
    local ok, Damage = pcall(require, "src.core.game3.battle.damage")
    if ok and Damage.hiddenPower then
      local _, t = Damage.hiddenPower(mon)
      local okT, Types = pcall(require, "src.core.game3.battle.types")
      hpType = t and okT and Types.name and Types.name(t)
    end
    return rows, NATURES[nature + 1], hpType
  end

  function Screen.show(session, slot)
    local s, mons = party(session)
    if not (mons and #mons > 0) then return end
    Screen.session, Screen.slot, Screen.open, Screen.row = s, slot or 1, true, Screen.row or 1
    require("src.ui.game3.stack").push(STACK_ID, Screen, { hideBelow = false, drawUnder = true })
  end

  function Screen.close()
    Screen.open = false
    require("src.ui.game3.stack").pop(STACK_ID)
  end

  function Screen.handleInput(input)
    if not (Screen.open and input) then return end
    local mons = Screen.session and Screen.session.party or {}
    local n = #mons
    if Screen.pick and input:wasPressed("b") then Screen.pick = nil; return end
    if input:wasPressed("b") or input:wasPressed("start") or n == 0 then return Screen.close() end
    local mon = mons[Screen.slot]
    local key = ROWS[Screen.row][1]
    local editable = mon and not isEgg(mon)
    if Screen.pick then
      if input:wasPressed("right") then Screen.pick = (Screen.pick + 1) % 25
      elseif input:wasPressed("left") then Screen.pick = (Screen.pick - 1) % 25
      elseif input:wasPressed("a") then P.useMint(Screen.session, mon, Screen.pick); Screen.pick = nil
      elseif input:wasPressed("select") then Screen.pick = nil end
      return
    end
    if input:wasPressed("select") then
      if editable and P.mints(Screen.session) > 0 then Screen.pick = Pokemon.natureId(mon.personality) end
    elseif input:wasPressed("r") then Screen.slot = Screen.slot % n + 1
    elseif input:wasPressed("l") then Screen.slot = (Screen.slot - 2) % n + 1
    elseif input:wasPressed("down") then Screen.row = Screen.row % #ROWS + 1
    elseif input:wasPressed("up") then Screen.row = (Screen.row - 2) % #ROWS + 1
    elseif editable and input:wasPressed("right") then P.setEv(mon, key, Pokemon.evsOf(mon)[key] + 4)
    elseif editable and input:wasPressed("left") then P.setEv(mon, key, Pokemon.evsOf(mon)[key] - 4)
    elseif editable and input:wasPressed("a") then P.toggleEv(mon, key)
    end
  end

  local template
  function Screen.draw()
    if not Screen.open then return end
    local mons = Screen.session and Screen.session.party or {}
    local mon = mons[Screen.slot]
    if not mon then return end
    local Window = require("src.ui.game3.window")
    local Font = require("src.ui.game3.frlg_font")
    template = template or Window.template(1, 1, 28, 18)
    Window.stdFrame(template)
    local x, y = 16, 12
    if isEgg(mon) then
      Window.printPx("EGG", x, y)
      Window.printPx("No data until it hatches.", x, y + 20)
      return
    end
    local rows, nature, hpType = P.ivRows(mon)
    local name = Pokemon.displayName and Pokemon.displayName(mon) or Pokemon.name(mon.species)
    Window.printPx(("%s  Lv%d"):format(name, tonumber(mon.level) or 1), x, y)
    Window.printPx(("%d/%d"):format(Screen.slot, #mons), 200, y)
    Window.printPx(Screen.pick and ("← " .. NATURES[Screen.pick + 1] .. " →") or nature, x, y + 15)
    Window.printPx(("EV TOTAL %d/%d"):format(Pokemon.evCount(mon), P.EV_TOTAL_MAX), 104, y + 15)
    Window.printPx("IV", 120, y + 28)
    Window.printPx("EV", 168, y + 28)
    for i, r in ipairs(rows) do
      local ry = y + 28 + i * 12
      local color = (r.mark == "+" and Font.COLOR.FEMALE_NPC) or (r.mark == "-" and Font.COLOR.MALE_NPC) or nil
      Window.printPx(r.label .. (r.mark ~= "" and (" " .. r.mark) or ""), x, ry, { colors = color })
      Window.printPx(tostring(r.iv), 120, ry, { colors = r.iv == 31 and Font.COLOR.FEMALE_NPC or nil })
      if i == Screen.row then Window.cursorPx(158, ry) end
      Window.printPx(tostring(r.ev), 168, ry)
    end
    if hpType then Window.printPx("HIDDEN POWER: " .. hpType, x, y + 28 + 7 * 12 + 1) end
    Window.printPx(Screen.pick and ("A: USE MINT (%d)  B: CANCEL"):format(P.mints(Screen.session))
      or (P.mints(Screen.session) > 0 and "L/R  ←→: EV  A: MAX  SEL: MINT" or "L/R: PARTY  ←→: EV  A: MAX/0"), x, y + 28 + 8 * 12 + 2)
  end

  function P.openIvs(_, session)
    if not active() then return end
    local s, mons = party(session)
    if not (mons and #mons > 0) then return end
    require("src.ui.game3.start_menu").close(true)
    Screen.show(s, 1)
  end
  P.screen = Screen

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_ivs", label = "IV / EV", onSelect = P.openIvs })
    table.insert(copy, at, { id = "g3_campaign_relearn", label = "RELEARN MOVE", onSelect = P.openRelearner })
    return copy
  end)
  return P
end
