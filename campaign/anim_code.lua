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

  -- Callbacks of the donor's own (not variants of vanilla's) start the way
  -- the g4 port's do (g4_callbacks.lua): the sprite's template from the g4
  -- table (campaign/anim_templates.lua adds the donor's), data cleared, at
  -- the target's picture, then the callback, which installs its own step.
  local T = C.T
  local NEW = {}
  local function wrap(fn)
    return function(s)
      if not s._g4init then
        s._g4init = true
        local vm = vmOf(s)
        P.setupTemplate(s, T[s.template or ""] or T.EMPTY)
        for i = 0, 7 do s.data[i] = 0 end
        s.ox, s.oy = 0, 0
        s.visible = true
        if vm then
          s.x = P.coord(vm, P.tgt(vm), P.X_2)
          s.y = P.coord(vm, P.tgt(vm), P.Y_PIC_OFFSET)
        end
        s._pz = true
        P.setPriority(s, s.oamPriority or 2, s.subpriority or 0)
      end
      return fn(s, s._vm)
    end
  end
  local function partnerOnLeft(vm)
    -- BATTLE_PARTNER(attacker) == target, target in a left position
    local atk, tgt = vm:attackerId(), vm:targetId()
    local AnimCoords = require("src.core.game3.battle.anim_coords")
    return AnimCoords.partner(atk) == tgt and tgt < 2
  end

  -- battle_anim_new.c AnimSuckerPunch / AnimGrassKnot: vanilla's
  -- AnimSlidingKick, mirrored when the attacker targets its left-side partner
  local function slidingKickVariant(s)
    if not s._incInit then
      s._incInit = true
      local vm = vmOf(s)
      if vm and partnerOnLeft(vm) then vm.args[0] = -(vm.args[0] or 0) end
    end
    return AnimCallbacks.SlidingKick(s)
  end
  CB.AnimSuckerPunch, CB.AnimGrassKnot = slidingKickVariant, slidingKickVariant

  -- AnimateZenHeadbutt: on the attacker (arg 0 = 0) or the target, 18px
  -- below its picture centre, gone when the affine anim ends
  NEW.AnimateZenHeadbutt = function(s, vm)
    local side = (P.args(vm)[0] or 0) == 0 and P.atk(vm) or P.tgt(vm)
    s.x = P.coord(vm, side, P.X_2)
    s.y = P.coord(vm, side, P.Y_PIC_OFFSET) + 18
    P.storeCb(s, P.destroy)
    s.callback = P.runStoredWhenAffineEnds
  end

  -- AnimPoisonJabProjectile: from the target's picture to its centre,
  -- rotated along the way
  NEW.AnimPoisonJabProjectile = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    local tgt = P.tgt(vm)
    local tx, ty = P.coord(vm, tgt, P.X_2), P.coord(vm, tgt, P.Y_PIC_OFFSET)
    P.trySetRotScale(s, 0x100, 0x100, P.ArcTan2Neg(tx - s.x, ty - s.y))
    s.data[0], s.data[2], s.data[4] = a[2] or 0, tx, ty
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- AnimKnockOffAquaTail: circles 20px round its start until its anim ends
  local function aquaTailStep(s)
    s.data[1] = P.band(s.data[1] + s.data[0], 0xFF)
    s.ox = P.Cos(s.data[1], 20)
    s.oy = P.Sin(s.data[1], 20)
    if s.animEnded then P.destroy(s) end
    s.data[2] = s.data[2] + 1
  end
  NEW.AnimKnockOffAquaTail = function(s, vm)
    local a = P.args(vm)
    if P.sideId(P.tgt(vm)) == 0 then
      s.x = s.x - (a[0] or 0)
      s.y = s.y + (a[1] or 0)
      s.data[0], s.data[1] = -11, 192
      P.startAffineAnim(s, 1)
    else
      s.data[0], s.data[1] = 11, 192
      s.x = s.x + (a[0] or 0)
      s.y = s.y + (a[1] or 0)
    end
    s.callback = aquaTailStep
  end

  -- AnimForcePalm: affine anim arg 3, on the attacker (arg 2 = 0) or target
  NEW.AnimForcePalm = function(s, vm)
    local a = P.args(vm)
    P.startAffineAnim(s, a[3] or 0)
    if (a[2] or 0) == 0 then P.initPosToAttacker(vm, s, true) else P.initPosToTarget(vm, s, true) end
    s.callback = P.runStoredWhenAffineEnds
    P.storeCb(s, P.destroy)
  end

  -- AnimAquaTail: the same code as AnimForcePalm
  NEW.AnimAquaTail = NEW.AnimForcePalm

  -- AnimRockPolishSparkle: on the attacker, gone when its anim ends
  NEW.AnimRockPolishSparkle = function(s, vm)
    P.initPosToAttacker(vm, s, true)
    P.storeCb(s, P.destroy)
    s.callback = P.runStoredWhenAnimEnds
  end

  -- AnimMoveFeintZoom: on the target, gone when its affine anim ends
  NEW.AnimMoveFeintZoom = function(s, vm)
    P.initPosToTarget(vm, s, true)
    P.storeCb(s, P.destroy)
    s.callback = P.runStoredWhenAffineEnds
  end

  -- AnimPsychoCut: from the attacker towards the target, mirrored for the
  -- foe's side and for a left-side ally target, rotated along its path
  NEW.AnimPsychoCut = function(s, vm)
    local a = P.args(vm)
    local atk, tgt = P.atk(vm), P.tgt(vm)
    if P.sideId(atk) ~= 0 then a[2], a[1], a[3] = -(a[2] or 0), -(a[1] or 0), -(a[3] or 0) end
    if P.sideId(atk) == P.sideId(tgt) and type(tgt) == "number" and tgt < 2 then
      a[2], a[0] = -(a[2] or 0), -(a[0] or 0)
    end
    P.initPosToAttacker(vm, s, true)
    local x, y = P.coord(vm, tgt, P.X_2) + (a[2] or 0), P.coord(vm, tgt, P.Y_PIC_OFFSET) + (a[3] or 0)
    P.trySetRotScale(s, 0x100, 0x100, P.band(P.ArcTan2Neg(x - s.x, y - s.y) + 0xC000, 0xFFFF))
    s.data[0], s.data[2], s.data[4] = a[4] or 0, x, y
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- AnimRockPolishStreak: one of its 16 affine anims at random, on the attacker
  NEW.AnimRockPolishStreak = function(s, vm)
    P.initPosToAttacker(vm, s, true)
    P.startAffineAnim(s, P.Random() % 16)
    P.storeCb(s, P.destroy)
    s.callback = P.runStoredWhenAnimEnds
  end

  -- AnimMoveFeintSwipe: 64px right, then back, over arg 2 frames each
  local function feintStep(s)
    if s.data[5] == 0 then
      if P.translateLinear(s) then
        s.ox = 0
        s.x = s.x + 64
        s.data[5] = 1
        s.data[0] = s.data[6]
        s.data[1], s.data[2], s.data[3], s.data[4] = s.x, s.x - 64, s.y, s.y
        P.initLinear(s)
      end
    elseif P.translateLinear(s) then
      s.callback = P.destroy
    end
  end
  NEW.AnimMoveFeintSwipe = function(s, vm)
    local a = P.args(vm)
    if P.sideId(P.atk(vm)) ~= 0 then a[0] = -(a[0] or 0) end
    P.initPosToTarget(vm, s, true)
    s.data[0], s.data[6] = a[2] or 0, a[2] or 0
    s.data[1], s.data[2], s.data[3], s.data[4], s.data[5] = s.x, s.x + 64, s.y, s.y, 0
    P.initLinear(s)
    s.callback = feintStep
  end

  -- AnimStealthRock: arcs from the attacker to the target pair, then blinks out
  local function stealthRockBlink(s)
    if P.band(s.data[1], 1) ~= 0 then P.setInvisible(s, not P.isInvisible(s)) end
    s.data[1] = s.data[1] + 1
    if s.data[1] == 16 then P.destroy(s) end
  end
  local function stealthRockStep(s)
    if P.translateHArc(s) then
      s.data[0], s.data[1] = 30, 0
      s.callback = P.waitAnimForDuration
      P.storeCb(s, stealthRockBlink)
    end
  end
  NEW.AnimStealthRock = function(s, vm)
    local a = P.args(vm)
    P.initPosToAttacker(vm, s, true)
    local x, y = P.averagePositions(vm, P.tgt(vm), false)
    if P.sideId(P.atk(vm)) ~= 0 then a[2] = -(a[2] or 0) end
    s.data[0], s.data[2], s.data[4], s.data[5] = a[4] or 0, x + (a[2] or 0), y + (a[3] or 0), -50
    P.initArc(s)
    s.callback = stealthRockStep
  end

  -- AnimPluck: a particle thrown up from the target, slowing every 7 frames
  local function pluckParticle(s)
    if s.data[0] > 0 then
      local vy, vx = s.data[5], s.data[2]
      s.y = s.y - vy
      s.x = s.x + vx
      if s.data[0] % 7 == 0 then s.data[5] = vy - 1 end
      s.data[0] = s.data[0] - 1
    else
      s.callback = P.destroy
    end
  end
  NEW.AnimPluck = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    s.data[0], s.data[5], s.data[2] = a[2] or 0, a[3] or 0, a[4] or 0
    s.x = s.x + (a[0] or 0)
    s.y = s.y + (a[1] or 0)
    s.callback = pluckParticle
  end
  for name, fn in pairs(NEW) do CB[name] = wrap(fn) end

  -- tasks (anim_tasks.lua REGISTRY: fn(t, vm), result in args[7])
  local AnimTasks = require("src.core.game3.battle.anim_tasks")
  local TASK = {}
  -- AnimTask_CanBattlerSwitch: U-turn / Volt Switch fly the attacker off when
  -- it can switch out. The battle sends the replacement in its own way, so
  -- the animation always answers FALSE: the attacker stays on screen.
  TASK.CanBattlerSwitch = function(t, vm)
    vm.args[7] = 0
    AnimTasks.destroy(t)
  end

  local n = 0
  for name, fn in pairs(CB) do
    if AnimCallbacks[name] == nil then AnimCallbacks[name] = fn; n = n + 1 end
  end
  for name, fn in pairs(TASK) do
    if AnimTasks.REGISTRY[name] == nil then AnimTasks.REGISTRY[name] = fn; n = n + 1 end
  end
  return n
end
