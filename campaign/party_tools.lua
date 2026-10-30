-- START > MOVE RELEARNER (free, unlimited: Emerald's relearner screen for any
-- party member) and START > IV / EV (a page per party member: IVs, EVs,
-- the nature's raised/lowered stats and Hidden Power's type; L/R flips
-- through the party, B closes). The EVs are editable (user, 2026-10-29:
-- trainers are EV trained, grinding them isn't fun): UP/DOWN picks a stat,
-- LEFT/RIGHT takes or adds 4, A fills it (up to 252, within 510 in all) or
-- clears it. Stats are recalculated at once; HP keeps its damage.
return function(mod, active)
  local Runtime = require("src.core.game3.runtime")
  local Pokemon = require("src.core.game3.pokemon")
  local MoveLearn = require("src.core.game3.move_learn")
  local P = {}

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
    if input:wasPressed("b") or input:wasPressed("start") or n == 0 then return Screen.close() end
    local mon = mons[Screen.slot]
    local key = ROWS[Screen.row][1]
    local editable = mon and not isEgg(mon)
    if input:wasPressed("r") or input:wasPressed("select") then Screen.slot = Screen.slot % n + 1
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
    Window.printPx(nature, x, y + 15)
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
    Window.printPx("L/R: PARTY  ←→: EV  A: MAX/0", x, y + 28 + 8 * 12 + 2)
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
