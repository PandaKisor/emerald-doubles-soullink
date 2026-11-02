-- What the move menu doesn't say (user, 2026-11-01): stat stages, weather,
-- terrain, room and side effects with turns left, and how the highlighted move
-- does against each foe. g3_coop draws it as a card while a player chooses
-- (mod.exports.campaignBattleInfo). Reading only: nothing here touches the battle.
return function(mod, active)
  local State = require("src.core.game3.battle.state")
  local Moves = require("src.core.game3.battle.moves")
  local Rules = require("src.core.game3.battle.rules")
  local Info = {}
  local STAGES = { { "attack", "Atk" }, { "defense", "Def" }, { "spAtk", "SpA" }, { "spDef", "SpD" },
    { "speed", "Spe" }, { "accuracy", "Acc" }, { "evasion", "Eva" } }
  local WEATHER = { RAIN = "Rain", SUN = "Sun", SAND = "Sandstorm", HAIL = "Hail" }
  local SIDE = { { "expReflectTurns", "Reflect" }, { "expLightScreenTurns", "Light Screen" },
    { "campaignAuroraVeil", "Aurora Veil" }, { "campaignTailwind", "Tailwind" }, { "expSafeguardTurns", "Safeguard" },
    { "campaignLuckyChant", "Lucky Chant" }, { "campaignSeaOfFire", "Sea of Fire" }, { "campaignRainbow", "Rainbow" },
    { "campaignSwamp", "Swamp" } }
  local ROOMS = { { "trickRoom", "Trick Room" }, { "gravity", "Gravity" }, { "magicRoom", "Magic Room" },
    { "wonderRoom", "Wonder Room" } }

  local function sideText(side)
    local out = {}
    for _, row in ipairs(SIDE) do
      local n = side and tonumber(side[row[1]]) or 0
      if n > 0 then out[#out + 1] = row[2] .. " " .. n end
    end
    return table.concat(out, ", ")
  end

  function Info.stages(st)
    local lines = {}
    for id = 0, 3 do
      local b = State.battler(st, id)
      if b and not State.isAbsent(st, id) and b.stages then
        local parts = {}
        for _, row in ipairs(STAGES) do
          local n = tonumber(b.stages[row[1]]) or 0
          if n ~= 0 then parts[#parts + 1] = ("%s%+d"):format(row[2], n) end
        end
        if #parts > 0 then lines[#lines + 1] = State.displayName(b) .. ": " .. table.concat(parts, " ") end
      end
    end
    return lines
  end

  function Info.field(st, ad)
    local lines, parts = {}, {}
    local w = Rules.weather.effective(st, ad)
    if WEATHER[w] then
      local n = tonumber(st.weatherTurns) or 0
      parts[#parts + 1] = WEATHER[w] .. (n > 0 and (" " .. n) or "")
    end
    local f = st.campaignField or {}
    local Field = Moves._campaignField
    if f.terrain then parts[#parts + 1] = tostring(Field and Field.TERRAIN_NAME[f.terrain] or f.terrain) .. " Terrain " .. tostring(f.terrainTurns or "") end
    for _, row in ipairs(ROOMS) do
      local n = tonumber(f[row[1]]) or 0
      if n > 0 then parts[#parts + 1] = row[2] .. " " .. n end
    end
    if #parts > 0 then lines[1] = table.concat(parts, ", ") end
    local mine, theirs = sideText(st.playerSide), sideText(st.enemySide)
    if mine ~= "" then lines[#lines + 1] = "You: " .. mine end
    if theirs ~= "" then lines[#lines + 1] = "Foes: " .. theirs end
    return lines
  end

  local function label(mult)
    if mult == 0 then return "no effect" end
    if mult == 1 then return "x1" end
    return "x" .. tostring(mult)
  end
  -- the highlighted move against each foe on the field; a disguised foe stays hidden
  function Info.matchups(st, ad, Ui)
    if Ui._mode ~= "moves" then return nil end
    local id = tonumber(Ui._active) or 0
    local user = State.battler(st, id)
    local slot = tonumber(Ui._moveCursor and Ui._moveCursor[id]) or 1
    local mv = user and user.mon and user.mon.moves and user.mon.moves[slot]
    local rec = mv and mv ~= 0 and Moves.get(mv)
    local AI = Moves._campaignField and Moves._campaignField.ai
    if not (rec and AI and (tonumber(rec.power) or 0) > 0) then return nil end
    local parts = {}
    for _, tid in ipairs({ (id + 1) % 4, (id + 3) % 4 }) do
      local foe = State.battler(st, tid)
      if foe and not State.isAbsent(st, tid) and foe.side ~= user.side then
        local text = "?"
        if not (foe.campaignIllusion or foe.campaignIllusionShown) then
          local _, why, info = AI.estimate(ad, st, user, foe, rec, false)
          if why == "absorb" or why == "immune" or why == "blocked" then text = "no effect"
          elseif info and info.effectiveness then text = label(info.effectiveness) end
        end
        parts[#parts + 1] = State.displayName(foe) .. " " .. text
      end
    end
    if #parts == 0 then return nil end
    return Moves.displayName(mv) .. ": " .. table.concat(parts, ", ")
  end

  function Info.card()
    if not active() then return nil end
    local Battle = require("src.core.game3.battle")
    local Ui = require("src.core.game3.battle.ui")
    local st = Battle.isActive and Battle.isActive() and Battle.getState and Battle.getState()
    if not st or not (Ui._mode == "menu" or Ui._mode == "moves" or Ui._mode == "target") then return nil end
    local ad = Battle._adapter
    if not ad then return nil end
    local lines = {}
    for _, l in ipairs(Info.field(st, ad)) do lines[#lines + 1] = l end
    for _, l in ipairs(Info.stages(st)) do lines[#lines + 1] = l end
    local m = Info.matchups(st, ad, Ui)
    if m then lines[#lines + 1] = m end
    if #lines == 0 then return nil end
    return { dot = "wait", title = "BATTLE", lines = lines }
  end

  mod.exports.campaignBattleInfo = Info.card
  return Info
end
