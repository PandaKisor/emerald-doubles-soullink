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
  -- SpriteCB_SpriteOnMonForDuration: on battler arg 0 (its sprite position)
  -- for arg 3 frames, then a shake of arg 4 frames (AnimBrickBreakWall_Step)
  local function brickBreakWallStep(s)
    if s.data[0] == 0 then
      s.data[1] = s.data[1] - 1
      if s.data[1] == 0 then
        if s.data[2] == 0 then P.destroy(s) else s.data[0] = 1 end
      end
    else
      s.data[1] = s.data[1] + 1
      if s.data[1] > 1 then
        s.data[1] = 0
        s.data[3] = s.data[3] + 1
        s.ox = P.band(s.data[3], 1) ~= 0 and 2 or -2
      end
      s.data[2] = s.data[2] - 1
      if s.data[2] == 0 then P.destroy(s) end
    end
  end
  NEW.SpriteCB_SpriteOnMonForDuration = function(s, vm)
    local a = P.args(vm)
    local side = P.battlerSide(vm, a[0] or 0)
    if side == nil then return P.destroy(s) end
    s.x = P.coord(vm, side, P.X) + (a[1] or 0)
    s.y = P.coord(vm, side, P.Y) + (a[2] or 0)
    s.data[0], s.data[1], s.data[2], s.data[3] = 0, a[3] or 0, a[4] or 0, 0
    s.callback = brickBreakWallStep
  end

  -- AnimGunkShotParticles: from the attacker to the target over 30 frames,
  -- weaving by arg 3; the wave's phase comes from arg 7
  local function gunkShotStep(s)
    if P.translateLinear(s) then P.destroy(s) end
    s.oy = s.oy + P.Sin(P.rshift(P.band(s.data[6], 0xFFFF), 8), s.data[7])
    if P.rshift(P.band(s.data[6] + s.data[5], 0xFFFF), 8) > 127 then
      s.data[6] = 0
      s.data[7] = -s.data[7]
    else
      s.data[6] = s.data[6] + s.data[5]
    end
  end
  NEW.AnimGunkShotParticles = function(s, vm)
    local a = P.args(vm)
    P.initPosToAttacker(vm, s, true)
    local tgt = P.tgt(vm)
    s.data[0], s.data[1], s.data[2] = 30, s.x, P.coord(vm, tgt, P.X_2)
    s.data[3], s.data[4] = s.y, P.coord(vm, tgt, P.Y_PIC_OFFSET)
    P.initLinear(s)
    s.data[5] = math.floor(0xD200 / s.data[0])
    s.data[7] = a[3] or 0
    local ret = P.band(a[7] or 0, 0xFFFF)
    if ret > 127 then
      s.data[6] = (ret - 127) * 256
      s.data[7] = -s.data[7]
    else
      s.data[6] = ret * 256
    end
    s.callback = gunkShotStep
    gunkShotStep(s)
  end

  -- AnimLavaPlumeOrbitScatter: from the attacker, outward at angle arg 0
  local function lavaPlumeStep(s)
    s.ox = s.ox + s.data[0]
    s.oy = s.oy + s.data[1]
    local x, y = s.x + s.ox, s.y + s.oy
    if P.band(x + 16, 0xFFFF) > 272 or y > 160 or y < -16 then P.destroy(s) end
  end
  NEW.AnimLavaPlumeOrbitScatter = function(s, vm)
    local a, atk = P.args(vm), P.atk(vm)
    s.x, s.y = P.coord(vm, atk, P.X_2), P.coord(vm, atk, P.Y_PIC_OFFSET)
    s.data[0], s.data[1] = P.Sin(a[0] or 0, 10), P.Cos(a[0] or 0, 7)
    s.callback = lavaPlumeStep
  end

  -- AnimSpinningDracoMeteor: on the target, frame anim arg 2 for arg 3
  -- frames, then 20 frames with its affine anim held
  local function dracoFinish(s)
    P.startAffineAnim(s, 0)
    s.affineAnimPaused = true
    s.data[0] = 20
    s.callback = P.waitAnimForDuration
    P.storeCb(s, P.destroy)
  end
  NEW.AnimSpinningDracoMeteor = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    P.startAnim(s, a[2] or 0)
    s.data[0] = a[3] or 0
    s.callback = P.waitAnimForDuration
    P.storeCb(s, dracoFinish)
  end

  -- AvalancheAnim_Step: a rock thrown in an ellipse onto the target (pair,
  -- arg 3), then a second, shorter one (AvalancheAnim_Step2)
  local function avalancheStep2(s)
    s.x = s.x + s.data[5]
    s.data[0], s.data[1], s.data[2], s.data[3], s.data[4] = 192, s.data[5], 4, 32, -24
    P.storeCb(s, P.destroy)
    s.callback = P.translateInEllipse
    P.translateInEllipse(s)
  end
  NEW.AvalancheAnim_Step = function(s, vm)
    local a = P.args(vm)
    if (a[3] or 0) ~= 0 then s.x, s.y = P.averagePositions(vm, P.tgt(vm), false) end
    s.x = s.x + (a[0] or 0)
    s.y = s.y + 14
    P.startAnim(s, a[1] or 0)
    P.animate(s)
    s.data[0], s.data[1], s.data[2], s.data[3], s.data[4], s.data[5] = 0, 0, 4, 16, -70, a[2] or 0
    P.storeCb(s, avalancheStep2)
    s.callback = P.translateInEllipse
    P.translateInEllipse(s)
  end

  -- AnimFlyUpTarget (the Pledges): rises from half the target's height
  local G3 = require("src.core.game3.battle.anim_port.g3_pret")
  local function flyUpStep(s)
    if s.oy <= s.data[0] then return P.destroy(s) end
    s.oy = s.oy - s.data[1]
  end
  NEW.AnimFlyUpTarget = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    P.initPosToTarget(vm, s, true)
    local h = G3.coordAttr(vm, tgt, G3.ATTR_HEIGHT) or 64
    s.oy = s.oy + math.floor(h / 2) + (a[1] or 0)
    s.data[0], s.data[1] = a[2] or 0, a[3] or 0
    s.callback = flyUpStep
    flyUpStep(s)
  end

  -- AnimMoveAccupressure: slides onto the target's centre, then its affine anim
  local function accupressureStep(s)
    if s.data[5] == 0 then
      if P.translateLinear(s) then
        P.startAffineAnim(s, 1)
        s.data[5] = 1
      end
    elseif s.affineAnimEnded then
      P.destroy(s)
    end
  end
  NEW.AnimMoveAccupressure = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    P.initPosToTarget(vm, s, true)
    s.data[0], s.data[1], s.data[2] = a[2] or 0, s.x, P.coord(vm, tgt, P.X)
    s.data[3], s.data[4], s.data[5] = s.y, P.coord(vm, tgt, P.Y), 0
    P.initLinear(s)
    s.callback = accupressureStep
  end

  -- AnimPunishment: the same code as AnimForcePalm
  NEW.AnimPunishment = NEW.AnimForcePalm

  -- AnimDragonRushStep: the template's callback is the step itself, circling
  -- by data[0] (0 from the start, as on the GBA) until its anim ends
  NEW.AnimDragonRushStep = function(s)
    s.data[1] = P.band(s.data[1] + s.data[0], 0xFF)
    s.ox = P.Cos(s.data[1], 20)
    s.oy = P.Sin(s.data[1], 20)
    if s.animEnded then P.destroy(s) end
    s.data[2] = s.data[2] + 1
  end

  -- SpriteCB_SurroundingRing (Aurora Veil): rises 72px over the attacker in 13 frames
  NEW.SpriteCB_SurroundingRing = function(s, vm)
    local atk = P.atk(vm)
    s.x, s.y = P.coord(vm, atk, P.X), P.coord(vm, atk, P.Y) + 40
    s.data[0], s.data[2], s.data[4] = 13, s.x, s.y - 72
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- AnimMoveWorrySeed: an arc from the attacker onto the target's centre
  local function worrySeedStep(s)
    if P.translateHArc(s) then P.destroy(s) end
  end
  NEW.AnimMoveWorrySeed = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    P.initPosToAttacker(vm, s, true)
    s.data[2], s.data[4] = P.coord(vm, tgt, P.X), P.coord(vm, tgt, P.Y)
    s.data[0], s.data[5] = a[2] or 0, a[3] or 0
    P.initArc(s)
    s.callback = worrySeedStep
  end

  -- AnimMoveWringOut: circles the target arg 3 times (radius arg 4, arg 2
  -- steps a turn), then a quarter turn more
  local function wringOutStep(s)
    s.ox = P.Cos(s.data[3], s.data[2])
    s.oy = P.Sin(s.data[3], s.data[2])
    if s.data[1] > 0 then
      if s.data[3] + s.data[0] >= 256 then
        s.data[3] = (s.data[0] + s.data[3]) % 256
        s.data[1] = s.data[1] - 1
      else
        s.data[3] = s.data[3] + s.data[0]
      end
    elseif s.data[3] < 64 then
      s.data[3] = s.data[3] + s.data[0]
    else
      P.destroy(s)
    end
  end
  NEW.AnimMoveWringOut = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    if (a[5] or 0) == 1 then s.objBlend = true end
    s.data[0] = math.floor(256 / math.max(1, a[2] or 1))
    s.data[1], s.data[2], s.data[3] = a[3] or 0, a[4] or 0, 64
    s.callback = wringOutStep
  end

  -- AnimGunkShotImpact: the same code as AnimForcePalm
  NEW.AnimGunkShotImpact = NEW.AnimForcePalm

  -- AnimMoveSmallCloud (Worry Seed): drifts by args 3/4 from the target
  -- until its affine anim (arg 2 + 1) ends
  local function smallCloudStep(s)
    s.ox = s.ox + s.data[0]
    s.oy = s.oy + s.data[1]
    if s.affineAnimEnded then P.destroy(s) end
  end
  NEW.AnimMoveSmallCloud = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    s.data[0], s.data[1] = a[3] or 0, a[4] or 0
    s.callback = smallCloudStep
    P.startAffineAnim(s, (a[2] or 0) + 1)
  end

  -- SpriteCB_AnimSpriteOnSelectedMonPos (Precipice Blades): on battler arg 2
  -- (offset by args 0/1) until its anim or affine anim ends
  NEW.SpriteCB_AnimSpriteOnSelectedMonPos = function(s, vm)
    if s.data[0] == 0 then
      local a = P.args(vm)
      local side = P.battlerSide(vm, a[2] or 0)
      if side == nil then return P.destroy(s) end
      s.x, s.y = P.coord(vm, side, P.X), P.coord(vm, side, P.Y)
      P.setInitialXOffset(vm, s, a[0] or 0)
      s.oy = a[1] or 0
      s.data[0] = 1
    elseif s.animEnded or s.affineAnimEnded then
      P.destroy(s)
    end
  end

  -- AnimHappyHourCoinShower: Avalanche's ellipse throw, from the attacker
  -- (pair, arg 3); the second throw is Rock Slide's AnimFallingRock_Step
  NEW.AnimHappyHourCoinShower = function(s, vm)
    local a = P.args(vm)
    if (a[3] or 0) ~= 0 then s.x, s.y = P.averagePositions(vm, P.atk(vm), false) end
    s.x = s.x + (a[0] or 0)
    s.y = s.y + 14
    P.startAnim(s, a[1] or 0)
    P.animate(s)
    s.data[0], s.data[1], s.data[2], s.data[3], s.data[4], s.data[5] = 0, 0, 4, 16, -70, a[2] or 0
    P.storeCb(s, avalancheStep2)
    s.callback = P.translateInEllipse
    P.translateInEllipse(s)
  end

  -- AnimMovePowerSwapGuardSwap: an arc between attacker and target (arg 3
  -- picks the direction), frame anim arg 2
  local function swapStep(s)
    if P.translateHArc(s) then P.destroy(s) end
  end
  NEW.AnimMovePowerSwapGuardSwap = function(s, vm)
    local a = P.args(vm)
    P.startAnim(s, a[2] or 0)
    local to
    if (a[3] or 0) == 0 then
      P.initPosToAttacker(vm, s, true)
      to = P.tgt(vm)
    else
      P.initPosToTarget(vm, s, true)
      to = P.atk(vm)
    end
    s.data[2], s.data[4] = P.coord(vm, to, P.X), P.coord(vm, to, P.Y)
    s.data[0], s.data[5] = a[4] or 0, a[5] or 0
    P.initArc(s)
    s.callback = swapStep
  end

  -- AnimMoveTrumpCard: 80px left over arg 3 frames on a half sine
  local function trumpCardStep(s)
    if P.translateLinear(s) then
      P.destroy(s)
    else
      s.oy = P.Sin(s.data[5], -20)
      s.data[5] = s.data[5] - s.data[6]
    end
  end
  NEW.AnimMoveTrumpCard = function(s, vm)
    local a = P.args(vm)
    if P.sideId(P.atk(vm)) ~= 0 then a[0] = -(a[0] or 0) end
    P.initPosToTarget(vm, s, true)
    P.startAnim(s, a[2] or 0)
    s.data[0] = math.max(1, a[3] or 1)
    s.data[1], s.data[2], s.data[3], s.data[4] = s.x, s.x - 80, s.y, s.y
    s.data[5], s.data[6] = 128, math.floor(128 / s.data[0])
    P.initLinear(s)
    s.callback = trumpCardStep
  end

  -- AnimSkyDropBallUp: vanilla Fly's ball rising off the target; the
  -- attacker goes invisible (the script shows it again)
  local function flyBallUpStep(s)
    if s.data[0] > 0 then
      s.data[0] = s.data[0] - 1
    else
      s.data[2] = s.data[2] + s.data[1]
      s.oy = s.oy - P.rshift(P.band(s.data[2], 0xFFFF), 8)
    end
    if s.y + s.oy < -32 then P.destroy(s) end
  end
  NEW.AnimSkyDropBallUp = function(s, vm)
    local a = P.args(vm)
    P.initPosToTarget(vm, s, true)
    s.data[0], s.data[1] = a[2] or 0, a[3] or 0
    s.callback = flyBallUpStep
    local mon = P.present(P.atk(vm))
    if mon then mon.visible = false end
  end

  -- battle_anim_new.c GetProperCentredCoord / InitSpritePosToAnimTargetsCentre:
  -- every campaign battle is a double, so the centre of the battler and its
  -- partner (the battler alone when its partner isn't on the field)
  local AnimCoords = require("src.core.game3.battle.anim_coords")
  local function centred(vm, side, coordType)
    local v = P.coord(vm, side, coordType)
    local id = AnimCoords.idOf(side) or side
    local partner = type(id) == "number" and AnimCoords.partner(id)
    if partner and AnimCoords.spritePresent(nil, partner) then
      return P.cdiv(v + P.coord(vm, partner, coordType), 2)
    end
    return v
  end
  local function givenTarget(vm, s, side)  -- InitSpritePosToGivenTarget
    local a = P.args(vm)
    s.x, s.y = P.coord(vm, side, P.X), P.coord(vm, side, P.Y)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.oy = a[1] or 0
  end
  local function blinkStep(s)  -- AnimStringWrap_Step
    s.data[0] = s.data[0] + 1
    if s.data[0] == 3 then
      s.data[0] = 0
      P.setInvisible(s, not P.isInvisible(s))
    end
    s.data[1] = s.data[1] + 1
    if s.data[1] == 51 then P.destroy(s) end
  end
  local function spinFinish(s)  -- AnimSpinningKickOrPunchFinish
    P.startAffineAnim(s, 0)
    s.affineAnimPaused = true
    s.data[0] = 20
    s.callback = P.waitAnimForDuration
    P.storeCb(s, P.destroy)
  end

  -- SpriteCB_AcidLaunchSingleTarget (Apple Acid, Tar Shot): an arc from the
  -- attacker onto the target, offset by args 4/5
  NEW.SpriteCB_AcidLaunchSingleTarget = function(s, vm)
    local a = P.args(vm)
    if (a[3] or 0) == 0 then P.startAnim(s, 2) end
    P.initPosToTarget(vm, s, true)
    local x, y = s.x, s.y
    P.initPosToAttacker(vm, s, true)
    if P.sideId(P.atk(vm)) ~= 0 then a[4] = -(a[4] or 0) end
    s.data[0], s.data[2], s.data[4], s.data[5] = a[2] or 0, x + (a[4] or 0), y + (a[5] or 0), -30
    P.initArc(s)
    s.callback = swapStep  -- AnimAcidPoisonBubble_Step: the arc, then gone
  end

  -- SpriteCB_CentredElectricity (Breaking Swipe): vanilla's spark, centred
  -- on the target pair
  NEW.SpriteCB_CentredElectricity = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    s.x, s.y = centred(vm, tgt, P.X), centred(vm, tgt, P.Y)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.y = s.y + (a[1] or 0)
    P.addTile(s, (a[3] or 0) * 4)
    if a[3] == 1 then P.setHFlip(s, true) elseif a[3] == 2 then P.setVFlip(s, true) end
    s.data[0] = a[2] or 0
    s.callback = P.waitAnimForDuration
    P.storeCb(s, P.destroy)
  end

  -- SpriteCB_FallingObject (Prismatic Laser, Grav Apple): drops onto battler
  -- arg 3 at speed arg 2, then blinks out
  local function fallingObjectStep(s)
    if s.data[0] == 0 then
      s.oy = s.oy + s.data[3]
      if s.oy >= 0 then s.oy, s.data[0] = 0, 1 end
    else
      s.data[1] = s.data[1] + 1
      if s.data[1] > 0 then
        s.data[1] = 0
        P.setInvisible(s, not P.isInvisible(s))
        s.data[2] = s.data[2] + 1
        if s.data[2] == 10 then P.destroy(s) end
      end
    end
  end
  NEW.SpriteCB_FallingObject = function(s, vm)
    local a = P.args(vm)
    local side = P.battlerSide(vm, a[3] or 0)
    if side == nil then return P.destroy(s) end
    s.x = P.coord(vm, side, P.X)
    s.ox, s.y, s.oy = a[0] or 0, a[1] or 0, -(a[1] or 0)
    if P.sideId(P.tgt(vm)) == 0 then s.y, s.oy = s.y + 45, s.oy - 45 end
    s.data[3] = a[2] or 0
    s.callback = fallingObjectStep
  end

  -- SpriteCB_Geyser (Thousand Arrows): Mud Sport's rising dirt, from the attacker
  local function dirtRising(s)  -- AnimMudSportDirtRising
    s.data[1] = s.data[1] + 1
    if s.data[1] > 1 then
      s.data[1] = 0
      s.x = s.x + s.data[0]
    end
    s.y = s.y - 4
    if s.y < -4 then P.destroy(s) end
  end
  NEW.SpriteCB_Geyser = function(s, vm)
    local a, atk = P.args(vm), P.atk(vm)
    s.x = P.coord(vm, atk, P.X_2) + (a[1] or 0)
    s.y = P.coord(vm, atk, P.Y_PIC_OFFSET) + (a[2] or 0)
    s.data[0] = (a[1] or 0) > 0 and 1 or -1
    s.callback = dirtRising
  end

  -- SpriteCB_GrowingSuperpower (Meteor Assault): from one battler to the other in 16 frames
  local function linearThenStored(s)  -- AnimTranslateLinear_WaitEnd
    if P.translateLinear(s) then P.runStored(s) end
  end
  NEW.SpriteCB_GrowingSuperpower = function(s, vm)
    local a, atk, tgt = P.args(vm), P.atk(vm), P.tgt(vm)
    local to
    if (a[0] or 0) == 0 then
      s.x, s.y = P.coord(vm, atk, P.X_2), P.coord(vm, atk, P.Y_PIC_OFFSET)
      to = tgt
    else
      to = atk
    end
    if P.sideId(atk) == 1 then P.startAffineAnim(s, 1) end
    s.data[0], s.data[1], s.data[2] = 16, s.x, P.coord(vm, to, P.X_2)
    s.data[3], s.data[4] = s.y, P.coord(vm, to, P.Y_PIC_OFFSET)
    P.initLinear(s)
    P.storeCb(s, P.destroy)
    s.callback = linearThenStored
  end

  -- SpriteCB_LeftRightSlice (Fishious Rend): slices left by arg 0, then back
  local function sliceBack(s)
    s.ox = s.ox + s.data[1]
    if s.ox >= s.data[0] then P.destroy(s) end
  end
  local function sliceOut(s)
    s.ox = s.ox - s.data[1]
    if s.ox <= s.data[0] then
      s.data[0] = -s.data[0]
      s.callback = sliceBack
    end
  end
  NEW.SpriteCB_LeftRightSlice = function(s, vm)
    local a = P.args(vm)
    s.ox, s.data[0], s.data[1] = a[0] or 0, -(a[0] or 0), a[1] or 0
    s.callback = sliceOut
  end

  -- SpriteCB_LockingJaw (Jaw Lock): moves by args 3/4 (1/256 px) for arg 5
  -- frames, then holds until data[3] counts down to -arg 6
  local function lockingJawFinish(s)
    s.data[3] = s.data[3] - 1
    if s.data[3] <= s.data[6] then P.destroy(s) end
  end
  local function lockingJawStep(s)
    s.data[4] = s.data[4] + s.data[0]
    s.data[5] = s.data[5] + s.data[1]
    s.ox, s.oy = P.asr(s.data[4], 8), P.asr(s.data[5], 8)
    s.data[3] = s.data[3] + 1
    if s.data[3] == s.data[2] then s.callback = lockingJawFinish end
  end
  NEW.SpriteCB_LockingJaw = function(s, vm)
    local a = P.args(vm)
    s.x, s.y = s.x + (a[0] or 0), s.y + (a[1] or 0)
    P.startAffineAnim(s, a[2] or 0)
    s.data[0], s.data[1], s.data[2], s.data[6] = a[3] or 0, a[4] or 0, a[5] or 0, -(a[6] or 0)
    s.callback = lockingJawStep
  end

  -- SpriteCB_MindBlownBall: from its spot to the attacker over arg 0*2
  -- frames, a pause of arg 1, then onto the target pair's centre over arg 2
  local function mindBlownStep(s, vm)
    vm = vm or s._vm
    local d = s.data
    if d[0] == 0 then
      d[4], d[5] = d[4] + d[6], d[5] + d[7]
      s.x, s.y = P.asr(d[4], 4), P.asr(d[5], 4)
      d[1] = d[1] - 1
      if d[1] <= 0 then d[0] = 1 end
    elseif d[0] == 1 then
      d[2] = d[2] - 1
      if d[2] > 0 then return end
      local tgt = P.tgt(vm)
      d[1], d[2] = centred(vm, tgt, P.X_2), centred(vm, tgt, P.Y_PIC_OFFSET)
      d[4], d[5] = s.x * 16, s.y * 16
      d[6] = P.cdiv((d[1] - s.x) * 16, math.max(1, d[3]))
      d[7] = P.cdiv((d[2] - s.y) * 16, math.max(1, d[3]))
      d[0] = 2
    elseif d[0] == 2 then
      d[4], d[5] = d[4] + d[6], d[5] + d[7]
      s.x, s.y = P.asr(d[4], 4), P.asr(d[5], 4)
      d[3] = d[3] - 1
      if d[3] > 0 then return end
      local tgt = P.tgt(vm)
      s.x, s.y = centred(vm, tgt, P.X_2), centred(vm, tgt, P.Y_PIC_OFFSET)
      d[0] = 3
    else
      P.destroy(s)
    end
  end
  NEW.SpriteCB_MindBlownBall = function(s, vm)
    local a, atk = P.args(vm), P.atk(vm)
    local ox, oy = s.x, s.y
    s.x, s.y = P.coord(vm, atk, P.X_2), P.coord(vm, atk, P.Y_PIC_OFFSET)
    local d = s.data
    d[0], d[1], d[2], d[3] = 0, a[0] or 0, a[1] or 0, a[2] or 0
    d[4], d[5] = s.x * 16, s.y * 16
    local n = math.max(1, (a[0] or 0) * 2)
    d[6], d[7] = P.cdiv((ox - s.x) * 16, n), P.cdiv((oy - s.y) * 16, n)
    s.callback = function(sp) mindBlownStep(sp, vm) end
  end

  -- SpriteCB_MoongeistCharge: an arc round the attacker (vanilla's missile
  -- arc, turned along its path)
  local function missileArc(s)  -- AnimMissileArc_Step
    P.setInvisible(s, false)
    if P.translateHArc(s) then return P.destroy(s) end
    local saved = {}
    for i = 0, 7 do saved[i] = s.data[i] end
    local x0, y0, ox0, oy0 = s.x + s.ox, s.y + s.oy, s.ox, s.oy
    if not P.translateHArc(s) then
      local rot = P.band(P.ArcTan2Neg(s.x + s.ox - x0, s.y + s.oy - y0) + 0xC000, 0xFFFF)
      P.trySetRotScale(s, 0x100, 0x100, rot)
      for i = 0, 7 do s.data[i] = saved[i] end
      s.ox, s.oy = ox0, oy0
    end
  end
  NEW.SpriteCB_MoongeistCharge = function(s, vm)
    local a, atk = P.args(vm), P.atk(vm)
    local x, y = P.coord(vm, atk, P.X_2), P.coord(vm, atk, P.Y_PIC_OFFSET)
    s.x, s.y = x + (a[0] or 0), y + (a[1] or 0)
    s.data[0], s.data[2], s.data[4], s.data[5] = a[4] or 0, x + (a[2] or 0), y + (a[3] or 0), a[5] or 0
    P.initArc(s)
    s.callback = missileArc
  end

  -- SpriteCB_PhotonGeyserBeam: on battler arg 2, affine anim 1 after arg 5
  -- frames, gone after arg 3
  local function beamUpStep(s)
    local d1 = s.data[1]
    s.data[1] = d1 - 1
    if d1 == 0 then P.startAffineAnim(s, 1) end
    local d0 = s.data[0]
    s.data[0] = d0 - 1
    if d0 <= 0 then P.destroy(s) end
  end
  NEW.SpriteCB_PhotonGeyserBeam = function(s, vm)
    local a = P.args(vm)
    local side = P.battlerSide(vm, a[2] or 0)
    if side == nil then return P.destroy(s) end
    givenTarget(vm, s, side)
    P.startAnim(s, a[4] or 0)
    s.data[0], s.data[1] = a[3] or 0, a[5] or 0
    s.callback = beamUpStep
  end

  -- SpriteCB_PyroBallRockBounce: a rock bouncing at the attacker's feet
  -- (the donor keeps its timers in file statics; here, per rock)
  local function pyroStep(s, vm)
    local d = s.data
    local still = (P.args(vm)[2] or 0) ~= 0
    if s.oy > 0 then
      if still or d[7] ~= 0 then return P.destroy(s) end
      d[5], d[7] = 0, 1
    end
    s.oy = -6 * d[5] + math.floor(d[5] * d[5] / 4)
    if not still then s.ox = -d[6] end
    d[5] = d[5] + 1
    d[6] = d[6] + (d[7] ~= 0 and -1 or 1)
  end
  NEW.SpriteCB_PyroBallRockBounce = function(s, vm)
    P.initPosToAttacker(vm, s, false)
    s.y = s.y + 20
    if P.sideId(P.atk(vm)) == 0 then s.y = s.y + 20 end
    s.data[5], s.data[6], s.data[7] = 0, 0, 0
    s.callback = function(sp) pyroStep(sp, vm) end
  end

  -- SpriteCB_SearingShotRock: on battler arg 4, frame anim arg 2 for arg 3
  -- frames, then a held spin (AnimSpinningKickOrPunchFinish)
  NEW.SpriteCB_SearingShotRock = function(s, vm)
    local a = P.args(vm)
    local side = P.battlerSide(vm, a[4] or 0)
    if side == nil then return P.destroy(s) end
    givenTarget(vm, s, side)
    P.startAnim(s, a[2] or 0)
    s.data[0] = a[3] or 0
    s.callback = P.waitAnimForDuration
    P.storeCb(s, spinFinish)
  end

  -- SpriteCB_SunsteelStrikeRings: vanilla Fly's ball attack, flying in from
  -- the top corner onto the target over arg 0 frames
  local function flyBallAttackStep(s)
    s.data[0] = 1
    P.translateLinear(s)
    if P.rshift(P.band(s.data[3], 0xFFFF), 8) > 200 then
      s.x = s.x + s.ox
      s.ox = 0
      s.data[3] = P.band(s.data[3], 0xFF)
    end
    if s.x + s.ox < -32 or s.x + s.ox > 240 + 32 or s.y + s.oy > 160 then P.destroy(s) end
  end
  NEW.SpriteCB_SunsteelStrikeRings = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    if P.sideId(P.atk(vm)) ~= 0 then s.x, s.y = 272, -32 else s.x, s.y = -32, -32 end
    s.data[0], s.data[1], s.data[2] = a[0] or 0, s.x, P.coord(vm, tgt, P.X_2)
    s.data[3], s.data[4] = s.y, P.coord(vm, tgt, P.Y_PIC_OFFSET)
    P.initLinear(s)
    s.callback = flyBallAttackStep
  end

  -- SpriteCB_ToxicThreadWrap (Toxic Thread, Reflect Type): vanilla's string
  -- wrap, offset by args 0/1, blinking for 51 frames
  NEW.SpriteCB_ToxicThreadWrap = function(s, vm)
    local a = P.args(vm)
    s.x = s.x + (P.sideId(P.atk(vm)) ~= 0 and -(a[0] or 0) or (a[0] or 0))
    s.y = s.y + (a[1] or 0)
    if P.sideId(P.tgt(vm)) == 0 then s.y = s.y + 8 end
    s.callback = blinkStep
  end

  -- SpriteCB_TranslateAnimSpriteToTargetMonLocationDoubles (Clanging
  -- Scales): vanilla's TranslateAnimSpriteToTargetMonLocation, to battler arg 6
  NEW.SpriteCB_TranslateAnimSpriteToTargetMonLocationDoubles = function(s, vm)
    local a = P.args(vm)
    local respect = P.band(P.u16(a[5] or 0), 0xFF00) == 0
    local coordType = P.band(P.u16(a[5] or 0), 0xFF) == 0 and P.Y_PIC_OFFSET or P.Y
    P.initPosToAttacker(vm, s, respect)
    if P.sideId(P.atk(vm)) ~= 0 then a[2] = -(a[2] or 0) end
    local side = P.battlerSide(vm, a[6] or 1)
    if side == nil then return P.destroy(s) end
    s.data[0] = a[4] or 0
    s.data[2] = P.coord(vm, side, P.X_2) + (a[2] or 0)
    s.data[4] = P.coord(vm, side, coordType) + (a[3] or 0)
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- SpriteCB_WaterDroplet (Life Dew): drips from the top of the screen onto battler arg 2
  local function dropletDrop(s)
    s.oy = s.oy + 4
    if s.oy >= s.data[1] then
      s.data[0] = 19
      P.startAnim(s, 1)
      s.callback = P.waitAnimForDuration
      P.storeCb(s, P.destroy)
    end
  end
  local function dropletDrip(s)
    s.data[0] = 12
    P.startAnim(s, 0)
    s.callback = P.waitAnimForDuration
    P.storeCb(s, dropletDrop)
  end
  NEW.SpriteCB_WaterDroplet = function(s, vm)
    local a = P.args(vm)
    local side = P.battlerSide(vm, a[2] or 0)
    if side == nil then return P.destroy(s) end
    givenTarget(vm, s, side)
    s.data[1] = s.y
    s.ox, s.oy, s.y = a[0] or 0, 0, 15
    s.callback = dropletDrip
  end

  -- SpriteCB_AcidDripSingleTarget (Apple Acid, Tar Shot): drips down arg 4
  -- pixels from the target, offset by args 0-2
  NEW.SpriteCB_AcidDripSingleTarget = function(s, vm)
    local a = P.args(vm)
    if P.sideId(P.atk(vm)) ~= 0 then a[0] = -(a[0] or 0) end
    s.x, s.y = s.x + (a[0] or 0), s.y + (a[1] or 0)
    s.data[0], s.data[2] = a[4] or 0, s.x + (a[2] or 0)
    s.data[4] = s.y + s.data[0]
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- SpriteCB_RandomCentredHits (Mind Blown): a hit at a random spot round
  -- the attacker pair (arg 0 = 0) or the target pair
  NEW.SpriteCB_RandomCentredHits = function(s, vm)
    local a = P.args(vm)
    if a[1] == -1 then a[1] = P.band(P.Random(), 3) end
    P.startAffineAnim(s, a[1] or 0)
    local side = (a[0] or 0) == 0 and P.atk(vm) or P.tgt(vm)
    s.x, s.y = centred(vm, side, P.X), centred(vm, side, P.Y)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.y = s.y + (a[1] or 0)
    s.ox = s.ox + P.Random() % 48 - 24
    s.oy = s.oy + P.Random() % 24 - 12
    P.storeCb(s, P.destroy)
    s.callback = P.runStoredWhenAffineEnds
  end

  -- SpriteCB_PyroBallLaunch: a missile arc from the attacker's feet onto the target
  NEW.SpriteCB_PyroBallLaunch = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    P.initPosToAttacker(vm, s, false)
    s.y = s.y + 20
    if P.sideId(P.atk(vm)) == 0 then s.y = s.y + 20 else a[2] = -(a[2] or 0) end
    s.data[0] = a[4] or 0
    s.data[2] = P.coord(vm, tgt, P.X_2) + (a[2] or 0)
    s.data[4] = P.coord(vm, tgt, P.Y_PIC_OFFSET) + (a[3] or 0)
    s.data[5] = a[5] or 0
    P.initArc(s)
    s.callback = missileArc
  end

  -- AnimMoveTrumpCardParticle: thrown from the target, slowing every other frame
  local function trumpParticleStep(s)
    if s.data[0] > 0 then
      local vy, vx = s.data[2], s.data[1]
      s.y = s.y - vy
      s.x = s.x + vx
      if s.data[0] % 2 == 0 then
        if vx > 0 then vx = vx - 1 elseif vx < 0 then vx = vx + 1 end
        if vy > 0 then vy = vy - 1 elseif vy < 0 then vy = vy + 1 end
        s.data[1], s.data[2] = vx, vy
      end
      s.data[0] = s.data[0] - 1
    else
      s.callback = P.destroy
    end
  end
  NEW.AnimMoveTrumpCardParticle = function(s, vm)
    local a = P.args(vm)
    if P.sideId(P.atk(vm)) ~= 0 then a[0] = -(a[0] or 0) end
    P.initPosToTarget(vm, s, true)
    P.startAnim(s, a[2] or 0)
    P.startAffineAnim(s, a[6] or 0)
    s.data[0], s.data[1], s.data[2] = a[3] or 0, a[4] or 0, a[5] or 0
    s.callback = trumpParticleStep
  end

  -- SpriteCB_CoreEnforcerBeam: from the attacker to the target pair's centre
  -- (the donor's double-battle branch; every campaign battle is a double)
  NEW.SpriteCB_CoreEnforcerBeam = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    P.initPosToAttacker(vm, s, true)
    P.startAnim(s, a[3] or 0)
    s.data[0] = a[2] or 0
    s.data[2], s.data[4] = centred(vm, tgt, P.X_2), centred(vm, tgt, P.Y_PIC_OFFSET)
    s.callback = P.startLinear
    P.storeCb(s, P.destroy)
  end

  -- SpriteCB_MindBlownExplosion: moves in or out of the target pair's
  -- centre (arg 1) over arg 4 frames (vanilla's AnimNeedleArmSpike_Step)
  local function needleArmStep(s)
    if s.data[0] ~= 0 then
      s.data[1] = s.data[1] + s.data[3]
      s.data[2] = s.data[2] + s.data[4]
      s.x, s.y = P.asr(s.data[1], 4), P.asr(s.data[2], 4)
      s.data[0] = s.data[0] - 1
    else
      P.destroy(s)
    end
  end
  NEW.SpriteCB_MindBlownExplosion = function(s, vm)
    local a, tgt = P.args(vm), P.tgt(vm)
    if (a[4] or 0) == 0 then return P.destroy(s) end
    local cx, cy = P.band(centred(vm, tgt, P.X_2), 0xFF), P.band(centred(vm, tgt, P.Y_PIC_OFFSET), 0xFF)
    s.data[0] = a[4]
    if (a[1] or 0) == 0 then
      s.x, s.y, s.data[5], s.data[6] = (a[2] or 0) + cx, (a[3] or 0) + cy, cx, cy
    else
      s.x, s.y, s.data[5], s.data[6] = cx, cy, (a[2] or 0) + cx, (a[3] or 0) + cy
    end
    s.data[1], s.data[2] = s.x * 16, s.y * 16
    s.data[3] = P.cdiv((s.data[5] - s.x) * 16, a[4])
    s.data[4] = P.cdiv((s.data[6] - s.y) * 16, a[4])
    s.callback = needleArmStep
  end

  -- SpriteCB_CoreEnforcerHits: a flashing hit 20px below the attacker pair's
  -- (arg 2 = 0) or the target pair's centre, affine anim arg 3
  local function flashingHitSplat(s)
    P.setInvisible(s, not P.isInvisible(s))
    local d0 = s.data[0]
    s.data[0] = d0 + 1
    if d0 > 12 then P.destroy(s) end
  end
  NEW.SpriteCB_CoreEnforcerHits = function(s, vm)
    local a = P.args(vm)
    P.startAffineAnim(s, a[3] or 0)
    local side = (a[2] or 0) == 0 and P.atk(vm) or P.tgt(vm)
    s.x, s.y = centred(vm, side, P.X), centred(vm, side, P.Y)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.y = s.y + (a[1] or 0) + 20
    s.callback = flashingHitSplat
  end

  -- SpriteCB_SpriteToCentreOfSide (Core Enforcer): at the attacker pair's
  -- (arg 2 = 0) or target pair's centre until its anim or affine anim ends;
  -- arg 3 = 0 keeps the spot it was made at, as InitSpritePosTo*Centre does
  -- with respectMonPicOffsets
  NEW.SpriteCB_SpriteToCentreOfSide = function(s, vm)
    if s.data[0] == 0 then
      local a = P.args(vm)
      if (a[3] or 0) ~= 0 then
        local side = (a[2] or 0) == 0 and P.atk(vm) or P.tgt(vm)
        s.x, s.y = centred(vm, side, P.X), centred(vm, side, P.Y)
      end
      P.setInitialXOffset(vm, s, a[0] or 0)
      s.y = s.y + (a[1] or 0)
      s.data[0] = 1
    elseif s.animEnded or s.affineAnimEnded then
      P.destroy(s)
    end
  end

  for name, fn in pairs(NEW) do CB[name] = wrap(fn) end
  -- SpriteCB_CentredSpiderWeb (Core Enforcer): vanilla's web, centred on
  -- the target pair (offset by args 0/1)
  CB.SpriteCB_CentredSpiderWeb = function(s)
    AnimCallbacks.SpiderWeb(s)  -- vanilla's set-up: blend and fade-out step
    local vm = vmOf(s)
    local a, tgt = P.args(vm), P.tgt(vm)
    s.x, s.y = centred(vm, tgt, P.X), centred(vm, tgt, P.Y)
    P.setInitialXOffset(vm, s, a[0] or 0)
    s.y = s.y + (a[1] or 0)
  end
  -- AnimSolarbeamBigOrb: vanilla's AnimSolarBeamBigOrb, as the donor spells it
  CB.AnimSolarbeamBigOrb = AnimCallbacks.SolarBeamBigOrb
  -- AnimSolarbeamSmallOrb: vanilla's AnimSolarBeamSmallOrb, as the donor spells it
  CB.AnimSolarbeamSmallOrb = AnimCallbacks.SolarBeamSmallOrb
  -- AnimNightSlash: vanilla's slash (AnimSlashSlice)
  CB.AnimNightSlash = AnimCallbacks.SlashSlice

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

  -- AnimTask_PurpleFlamesOnTarget (Hex): vanilla's Grudge flames, on the
  -- target. Grudge reads the attacker only while it sets up, so the target
  -- stands in as attacker for that call.
  TASK.PurpleFlamesOnTarget = function(t, vm)
    local grudge = AnimTasks.REGISTRY.GrudgeFlames
    local atkId, atkSide = vm.attackerId, vm.attackerSide
    local tgtId, tgtSide = vm:targetId(), vm:targetSide()
    vm.attackerId = function() return tgtId end
    vm.attackerSide = function() return tgtSide end
    local ok, err = pcall(grudge, t, vm)
    vm.attackerId, vm.attackerSide = atkId, atkSide
    if not ok then error(err, 0) end
  end

  -- AnimTask_BlendNightSlash: the slash sprite's palette 6/16 towards red
  local G1 = require("src.core.game3.battle.anim_port.g1_pret")
  TASK.BlendNightSlash = function(t, vm)
    G1.Pal.blend("tag:SLASH", 6, 0x001F)
    G1.Pal.flush()
    AnimTasks.destroy(t)
  end

  -- AnimTask_SquishTarget: flattens the target and lets it spring back
  -- (battle_anim_new.c sSquishTargetAffineAnimCmds)
  local G2 = require("src.core.game3.battle.anim_port.g2_pret")
  local SQUISH = { G2.A(0, 64, 0, 16), G2.A(0, 0, 0, 64), G2.A(0, -64, 0, 16), G2.AEND }
  local function waitAffine(t)
    if not G2.RunAffineAnimFromTaskData(t) then G2.destroyTask(t) end
  end
  TASK.SquishTarget = G2.task(function(t)
    local m = G2.mon(G2.tgt())
    if not m then return G2.destroyTask(t) end
    G2.PrepareAffineAnimInTaskData(t, m, SQUISH)
    t.func = waitAffine
  end)

  -- Tasks that ask the battle for its state answer with the default, which
  -- plays the move's base animation: Techno Blast without a Drive, Terrain
  -- Pulse off terrain, Shell Side Arm as special
  local function answerZero(t, vm)
    vm.args[0] = 0
    AnimTasks.destroy(t)
  end
  TASK.TechnoBlast, TASK.TerrainPulse, TASK.ShellSideArm = answerZero, answerZero, answerZero

  -- AnimTask_SetAnimTargetToAttackerOpposite (Gravity): the battler opposite
  -- the attacker becomes the target (BATTLE_OPPOSITE); the next animation
  -- sets its own target again
  TASK.SetAnimTargetToAttackerOpposite = function(t, vm)
    local AnimCoords = require("src.core.game3.battle.anim_coords")
    local opposite = P.bxor(vm:attackerId(), 1)
    vm._tgtId, vm._targetSide = opposite, AnimCoords.sideOf(opposite)
    AnimTasks.destroy(t)
  end

  -- AnimTask_CreateSmallSolarbeamOrbs (Core Enforcer): vanilla's Solar Beam
  -- orbs under the donor's spelling
  TASK.CreateSmallSolarbeamOrbs = function(t, vm)
    return AnimTasks.REGISTRY.CreateSmallSolarBeamOrbs(t, vm)
  end

  -- AnimTask_CreateSmallSteelBeamOrbs: the same 15 orbs, 6 frames apart,
  -- with Steel Beam's sprite (its template comes from move_anims.lua)
  local S1 = require("src.core.game3.battle.anim_port.g1_sprite")
  local C1 = require("src.core.game3.battle.anim_port.g1_callbacks")
  local K1 = require("src.core.game3.battle.anim_port.g1_task_base")
  TASK.CreateSmallSteelBeamOrbs = K1.wrap(function(t, vm)
    t._fn = function(tt, v)
      local d = tt.data
      d[0] = d[0] - 1
      if d[0] == -1 then
        d[1] = d[1] + 1
        d[0] = 6
        local args = { [0] = 15, [1] = 0, [2] = 80, [3] = 0 }
        if v and v.args then v.args[0], v.args[1], v.args[2], v.args[3] = 15, 0, 80, 0 end
        S1.createAndAnimate(v, "gSteelBeamSmallOrbSpriteTemplate", 0, 0, P.subpriorityOf(P.tgt(v)) + 1,
          S1.inits[C1.SolarBeamSmallOrb], args)
      end
      if d[1] == 15 then K1.destroy(tt) end
    end
    t._fn(t, vm)
  end)

  -- AnimTask_CompressTargetHorizontally (Crush Grip): squeezes the target sideways
  local COMPRESS = { G2.A(64, 0, 0, 16), G2.A(0, 0, 0, 64), G2.A(-64, 0, 0, 16), G2.AEND }
  TASK.CompressTargetHorizontally = G2.task(function(t)
    local m = G2.mon(G2.tgt())
    if not m then return G2.destroyTask(t) end
    G2.PrepareAffineAnimInTaskData(t, m, COMPRESS)
    t.func = waitAffine
  end)

  -- AnimTask_RotateVertically (Topsy-Turvy): turns battler arg 0 upside
  -- down at speed arg 1, holds 75 frames, turns it back
  local function rotateStep(t)
    local d, m = t.data, t.g2.rotMon
    if d[0] == 0 then
      d[2] = math.min(math.abs(d[2] + d[3]), d[4])
      G2.setSpriteRotScale(m, 0x100, 0x100, d[2])
      if d[5] ~= 0 then G2.setYOffsetFromRotation(m) end
      if d[2] == d[4] then d[0] = 1 end
    elseif d[0] == 1 then
      d[6] = d[6] + 1
      if d[6] >= 75 then d[0] = 2 end
    elseif d[0] == 2 then
      d[2] = d[2] < d[3] and 0 or d[2] - d[3]
      G2.setSpriteRotScale(m, 0x100, 0x100, d[2])
      if d[5] ~= 0 then G2.setYOffsetFromRotation(m) end
      if d[2] == 0 then d[0] = 3 end
    else
      G2.resetSpriteRotScale(m)
      G2.destroyTask(t)
    end
  end
  TASK.RotateVertically = G2.task(function(t, vm)
    local a = G2.args()
    local side = P.battlerSide(vm, a[0] or 0)
    local m = side ~= nil and G2.mon(side)
    if not m then return G2.destroyTask(t) end
    t.g2.rotMon = m
    local player = P.sideId(side) == 0
    t.data[5] = player and 1 or 0
    t.data[4] = player and 0x1FFF or 0x7FFE
    t.data[2], t.data[3] = 0, a[1] or 0
    t.func = rotateStep
  end)

  -- AnimTask_CreateBestowItem: the item flies from the attacker to the
  -- target as vanilla's thrown projectile (the engine draws the item bag:
  -- it has no per-item icons in battle)
  TASK.CreateBestowItem = function(t, vm)
    local args = {}
    for i = 0, 7 do args[i] = vm.args[i] or 0 end
    S1.createAndAnimate(vm, "gItemStealSpriteTemplate", 0, 0, P.subpriorityOf(P.tgt(vm)) + 1,
      S1.inits[C1.ThrowProjectile], args)
    AnimTasks.destroy(t)
  end

  -- SoundTask_PlaySeChangingVolume (Heal Block): plays SE arg 0 at pan arg 1
  -- for as long as its volume ramp (args 2-5) lasts; the engine's sound has
  -- no per-effect volume, so the ramp only times the task
  TASK.SoundTask_PlaySeChangingVolume = function(t, vm)
    local a = vm.args
    P.se(a[0], a[1])
    local cur, step, target, delay = a[2] or 0, a[3] or 0, a[4] or 0, a[5] or 0
    if step == 0 then return AnimTasks.destroy(t) end
    local rising, frames = cur < target, 0
    t.func = function(tt)
      frames = frames + 1
      if frames > delay then
        frames = 0
        cur = math.max(0, math.min(256, cur + step))
        if (rising and cur >= target) or (not rising and cur <= target) then AnimTasks.destroy(tt) end
      end
    end
  end

  -- IncShockWaveProgressingBolt / IncShockWaveLightning (Parabolic Charge):
  -- vanilla's Shock Wave tasks, aimed at battler arg 0 instead of the
  -- target: the target stands in as that battler while each step runs
  local function atBattler(vanilla)
    return function(t, vm)
      local side = P.battlerSide(vm, vm.args[0] or 1)
      if side == nil then return AnimTasks.destroy(t) end
      local AnimCoords = require("src.core.game3.battle.anim_coords")
      local id = type(side) == "number" and side or AnimCoords.idOf(side)
      local function swapped(fn, tt, v)
        local a, b = v._tgtId, v._targetSide
        v._tgtId, v._targetSide = id, AnimCoords.sideOf(id)
        local ok, err = pcall(fn, tt, v)
        v._tgtId, v._targetSide = a, b
        if not ok then error(err, 0) end
      end
      local first = AnimTasks.REGISTRY[vanilla]
      swapped(first, t, vm)
      for _, key in ipairs({ "func", "fn", "_fn" }) do
        local step = t[key]
        if type(step) == "function" and step ~= first then
          t[key] = function(tt, v) return swapped(step, tt, v or vm) end
        end
      end
    end
  end
  TASK.IncShockWaveProgressingBolt = atBattler("ShockWaveProgressingBolt")
  TASK.IncShockWaveLightning = atBattler("ShockWaveLightning")

  local n = 0
  for name, fn in pairs(CB) do
    if AnimCallbacks[name] == nil then AnimCallbacks[name] = fn; n = n + 1 end
  end
  for name, fn in pairs(TASK) do
    if AnimTasks.REGISTRY[name] == nil then AnimTasks.REGISTRY[name] = fn; n = n + 1 end
  end
  return n
end
