-- START > MOVE RELEARNER (free, unlimited: Emerald's relearner screen for any
-- party member) and START > IV CHECK (a page per party member: IVs, EVs,
-- the nature's raised/lowered stats and Hidden Power's type; LEFT/RIGHT
-- flips through the party, B closes).
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
    Screen.session, Screen.slot, Screen.open = s, slot or 1, true
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
    if input:wasPressed("b") or input:wasPressed("a") or input:wasPressed("start") or n == 0 then Screen.close()
    elseif input:wasPressed("right") or input:wasPressed("down") then Screen.slot = Screen.slot % n + 1
    elseif input:wasPressed("left") or input:wasPressed("up") then Screen.slot = (Screen.slot - 2) % n + 1
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
    Window.printPx("IV", 120, y + 32)
    Window.printPx("EV", 168, y + 32)
    for i, r in ipairs(rows) do
      local ry = y + 32 + i * 13
      local color = (r.mark == "+" and Font.COLOR.FEMALE_NPC) or (r.mark == "-" and Font.COLOR.MALE_NPC) or nil
      Window.printPx(r.label .. (r.mark ~= "" and (" " .. r.mark) or ""), x, ry, { colors = color })
      Window.printPx(tostring(r.iv), 120, ry, { colors = r.iv == 31 and Font.COLOR.FEMALE_NPC or nil })
      Window.printPx(tostring(r.ev), 168, ry)
    end
    if hpType then Window.printPx("HIDDEN POWER: " .. hpType, x, y + 32 + 7 * 13 + 2) end
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
    table.insert(copy, at, { id = "g3_campaign_ivs", label = "IV CHECK", onSelect = P.openIvs })
    table.insert(copy, at, { id = "g3_campaign_relearn", label = "RELEARN MOVE", onSelect = P.openRelearner })
    return copy
  end)
  return P
end
