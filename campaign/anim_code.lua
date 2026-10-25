-- Sprite callbacks and tasks Inclement's animations need that vanilla's
-- engine doesn't have, ported from pokeemerald-1.13's C onto the engine's g4
-- animation helpers (anim_port/g4_pret.lua). tools/anim_convert.py points a
-- converted script at these names; vanilla's own callbacks stay as they are.
return function()
  local AnimCallbacks = require("src.core.game3.battle.anim_callbacks")
  local C = AnimCallbacks._g4
  if not C then return 0 end
  local P = C.P
  local CB = {}

  local function vmOf(s)
    if s._vm then return s._vm end
    local Anim = package.loaded["src.core.game3.battle.anim"] or require("src.core.game3.battle.anim")
    s._vm = Anim.vm and Anim.vm()
    return s._vm
  end
  local function opponentAttacker(vm) return P.sideId(P.atk(vm)) == 1 end

  -- battle_anim_mons.c InitSpritePosToAnimBattler: false (and the sprite
  -- gone) when that battler isn't on the field
  local function initPosToBattler(vm, s, animBattler, respect)
    local side = P.battlerSide(vm, animBattler)
    if side == nil then
      P.destroy(s)
      return false
    end
    if not respect then
      s.x, s.y = P.coord(vm, side, P.X), P.coord(vm, side, P.Y)
    elseif animBattler ~= 1 then
      s.x, s.y = P.coord(vm, side, P.X_2), P.coord(vm, side, P.Y_PIC_OFFSET)
    end
    local a = P.args(vm)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.y = s.y + (a[1] or 0)
    return true
  end

  -- battle_anim_electric.c AnimElectricity: arg 4 is the battler the spark
  -- sits on (Discharge sparks the target and both partners)
  CB.IncElectricity = function(s)
    AnimCallbacks.Electricity(s)  -- vanilla's set-up: frame, flip, duration, destroy after
    local vm = vmOf(s)
    initPosToBattler(vm, s, P.args(vm)[4] or 1, false)
  end

  -- battle_anim_bug.c AnimSpiderWeb: arg 2 centres the web on the target
  -- pair, args 0 and 1 offset it (x mirrored for the foe's side)
  CB.IncSpiderWeb = function(s)
    AnimCallbacks.SpiderWeb(s)  -- vanilla's set-up: blend and fade-out step
    local vm = vmOf(s)
    local a = P.args(vm)
    if (a[2] or 0) ~= 0 then s.x, s.y = P.averagePositions(vm, P.tgt(vm), false) end
    s.x = s.x + (opponentAttacker(vm) and -(a[0] or 0) or (a[0] or 0))
    s.y = s.y + (a[1] or 0)
  end

  local n = 0
  for name, fn in pairs(CB) do
    if AnimCallbacks[name] == nil then AnimCallbacks[name] = fn; n = n + 1 end
  end
  return n
end
