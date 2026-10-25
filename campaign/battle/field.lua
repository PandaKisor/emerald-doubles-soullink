-- Battle-wide systems the expanded moves rely on, installed once onto the
-- live battle modules and inert outside the campaign cart:
--   turn bookkeeping   who moved, was hurt or had stats changed this turn
--   switch-ins         Stealth Rock, Toxic Spikes, Sticky Web, Healing Wish
--   field timers       terrains, Trick Room, Gravity, Magic/Wonder Room,
--                      Tailwind, Lucky Chant, Aurora Veil, per-battler timers
--   turn order         Tailwind and Trick Room (mod hook battle.turn_order)
--   hooks              protection, type effectiveness and power, read by the
--                      patched Inclement library (hit/damage/accuracy)
return function(mod, U, active)
  local State = require("src.core.game3.battle.state")
  local Engine = require("src.core.game3.battle.engine")
  local Moves = require("src.core.game3.battle.moves")
  local Residuals = require("src.core.game3.battle.residuals")
  local Rules = require("src.core.game3.battle.rules")
  local Adapter = require("src.core.game3.battle.adapter")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local T = U.TYPE
  local F = {}
  local bridge = Moves._campaignField
  if bridge then bridge.U, bridge.active = U, active; return bridge end
  bridge = F
  Moves._campaignField = F
  F.U, F.active = U, active

  local function field(st)
    st.campaignField = st.campaignField or {}
    return st.campaignField
  end
  F.field = field

  -- turn bookkeeping ------------------------------------------------------
  local function faintedCount(st, side)
    local party = side == "player" and st.playerParty or st.foeParty
    local n = 0
    for _, mon in ipairs(party or {}) do if (tonumber(mon.hp) or 0) <= 0 then n = n + 1 end end
    return n
  end
  local plan = Engine.planTurnActions
  Engine.planTurnActions = function(st, adapter, chosen, ...)
    if F.active() and st then
      local turn = { moved = {}, hpStart = {}, stagesStart = {}, round = {} }
      for id = 0, 3 do
        local b = State.battler(st, id)
        if b and b.mon then
          turn.hpStart[id] = tonumber(b.mon.hp) or 0
          local s = {}
          for k, v in pairs(b.stages or {}) do s[k] = v end
          turn.stagesStart[id] = s
        end
      end
      for _, sideKey in ipairs({ "player", "enemy" }) do
        local side = sideKey == "player" and st.playerSide or st.enemySide
        if side then
          local n = faintedCount(st, sideKey)
          side.campaignRetaliate = side.campaignFainted ~= nil and n > side.campaignFainted
          side.campaignFainted = n
        end
      end
      st.campaignTurn = turn
      for id, act in pairs(chosen or {}) do
        local b = State.battler(st, id)
        local rec = b and act and (act.kind == nil or act.kind == "move") and act.move and Moves.get(act.move)
        if rec and rec.campaignBeakBlast then b.campaignBeakBlast = true end
      end
    end
    return plan(st, adapter, chosen, ...)
  end

  -- Beak Blast: contact with the heating user burns the attacker
  local moveEnd = Engine.moveEndEffects
  Engine.moveEndEffects = function(M, ...)
    if F.active() and M and M.target and M.user and M.target ~= M.user and not M.noEffect
        and M.target.campaignBeakBlast and not U.movedThisTurn(M.adapter, M.target)
        and U.hasContact(M.move) and not M.adapter:status(M.user) and not U.hasType(M.user, T.FIRE) then
      M.adapter:applyStatus(M.user, "BRN", M.target)
      M.adapter:statusAnim(M.user, "BRN")
      M.adapter:sayText("STRINGID_PKMNWASBURNED", { eff = M.user })
    end
    return moveEnd(M, ...)
  end

  local bookkeeping = Engine.moveEndBookkeeping
  Engine.moveEndBookkeeping = function(M, ...)
    local result = bookkeeping(M, ...)
    if F.active() and M and M.st and M.user then
      local turn = M.st.campaignTurn
      local user = M.user
      if turn then
        turn.moved[State.idOf(user)] = true
        turn.lastMove = M.mnum
        if M.mnum == U.data.identity.namespaces.moves.MOVE_ROUND then turn.round[user.side] = true end
      end
      user.campaignLastFailed = (M.failed or M.noEffect or (M.anim and M.anim.missed)) and true or false
      M.adapter._campaignIgnoreAbility, M.adapter._campaignTrapText = nil, nil
      user.campaignUsed = user.campaignUsed or {}
      user.campaignUsed[M.mnum or 0] = true
      field(M.st).lastMove = M.opts and M.opts.calledBy and M.mnum or M.mnum
    end
    return result
  end

  -- was this battler hurt / did its stats fall or rise this turn
  function F.hurtThisTurn(ad, b)
    local turn = ad._st.campaignTurn
    local start = turn and turn.hpStart[State.idOf(b)]
    return start ~= nil and ad:hp(b) < start
  end
  function F.statsChangedThisTurn(ad, b, dir)
    local turn = ad._st.campaignTurn
    local start = turn and turn.stagesStart[State.idOf(b)]
    if not start then return false end
    for k, v in pairs(b.stages or {}) do
      local s = start[k] or 0
      if (dir > 0 and v > s) or (dir < 0 and v < s) then return true end
    end
    return false
  end

  -- switch-ins ------------------------------------------------------------
  local KEEP = { campaignHealingWish = true }
  local function resetVolatiles(b)
    for k in pairs(b) do
      if type(k) == "string" and k:match("^campaign") and not KEEP[k] then b[k] = nil end
    end
  end
  F.resetVolatiles = resetVolatiles

  local function hazards(st, ad, b)
    local side = ad:ownSide(b)
    if not side then return false end
    -- Heavy-Duty Boots (and Magic Guard): no entry hazards
    local boots = (F.items and F.items.hazardImmune(b)) or (F.abilities and F.abilities.magicGuard(ad, b))
    local grounded = U.grounded(ad, b)
    if side.campaignHealingWish then
      local kind = side.campaignHealingWish
      side.campaignHealingWish = nil
      U.heal(ad, b, ad:maxHp(b))
      if ad:status(b) then ad:clearStatus(b) end
      if kind == "lunar" and b.mon then
        for i = 1, 4 do if b.mon.maxPp and b.mon.pp then b.mon.pp[i] = b.mon.maxPp[i] or b.mon.pp[i] end end
      end
      U.say(ad, "The healing wish came true for " .. U.name(ad, b) .. "!")
    end
    if side.campaignStealthRock and not boots then
      local eff = U.effectiveness(T.ROCK, b)
      if eff > 0 then
        ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) * eff / 8)))
        U.say(ad, "Pointed stones dug into " .. U.name(ad, b) .. "!")
        if ad:isFainted(b) then return true end
      end
    end
    if (side.campaignToxicSpikes or 0) > 0 and grounded and not boots then
      if U.hasType(b, T.POISON) then
        side.campaignToxicSpikes = nil
        U.say(ad, "The poison spikes disappeared from around " .. U.name(ad, b) .. "'s feet!")
      elseif not U.hasType(b, T.STEEL) and not ad:status(b) and not (b.substituteHP and b.substituteHP > 0)
          and not (F.terrain(st) == "MISTY") then
        local kind = side.campaignToxicSpikes >= 2 and "TOX" or "PSN"
        if ad:canApplyStatus(b, kind) ~= false then
          ad:applyStatus(b, kind)
          ad:statusAnim(b, kind)
          U.say(ad, U.name(ad, b) .. (kind == "TOX" and " was badly poisoned!" or " was poisoned!"))
        end
      end
    end
    if side.campaignStickyWeb and grounded and not boots then
      U.say(ad, U.name(ad, b) .. " was caught in a sticky web!")
      Secondary.changeStat(ad, b, "speed", -1, { allowPtr = true })
    end
    return false
  end

  local switchIn = Engine.switchInEffects
  Engine.switchInEffects = function(st, ad, b, opts, ...)
    if F.active() and b and ad and not (st and st.over) then
      if b.campaignLastSeenMon ~= b.mon then
        resetVolatiles(b)
        b.campaignLastSeenMon = b.mon
        b.campaignEnteredTurn = st and st.turn
      end
      if opts and opts.spikes and not ad:isFainted(b) and hazards(st, ad, b) then
        local sequencing = require("src.core.game3.battle.profile").rule(st, "sequencingPolicy")
        if sequencing and sequencing.spikesFaint then sequencing.spikesFaint(ad, b) end
        return true
      end
      if opts and opts.spikes and ((F.items and F.items.hazardImmune(b)) or (F.abilities and F.abilities.magicGuard(ad, b))) then
        local copy = {}
        for k, v in pairs(opts) do copy[k] = v end
        copy.spikes = nil
        opts = copy
      end
      local did = switchIn(st, ad, b, opts, ...)
      if F.items then F.items.switchIn(ad, b) end
      return did
    end
    return switchIn(st, ad, b, opts, ...)
  end

  -- terrains and field effects ---------------------------------------------
  function F.terrain(st)
    local f = st and st.campaignField
    return f and f.terrain and (f.terrainTurns or 0) > 0 and f.terrain or nil
  end
  F.TERRAIN_NAME = { ELECTRIC = "electric", GRASSY = "grassy", MISTY = "misty", PSYCHIC = "psychic" }

  function F.setTerrain(ad, kind, setter)
    local f = field(ad._st)
    if f.terrain == kind and (f.terrainTurns or 0) > 0 then return false end
    f.terrain, f.terrainTurns = kind, (setter and F.items and F.items.longTerrain(setter)) and 8 or 5
    local text = {
      ELECTRIC = "An electric current ran across the battlefield!",
      GRASSY = "Grass grew to cover the battlefield!",
      MISTY = "Mist swirled around the battlefield!",
      PSYCHIC = "The battlefield got weird!",
    }
    U.say(ad, text[kind])
    -- terrain seeds on the field react at once
    if F.items then for _, b in ipairs(U.all(ad)) do F.items.seed(ad, b) end end
    return true
  end
  function F.clearTerrain(ad)
    local f = field(ad._st)
    if not F.terrain(ad._st) then return false end
    local kind = f.terrain
    f.terrain, f.terrainTurns = nil, nil
    U.say(ad, "The " .. F.TERRAIN_NAME[kind] .. " terrain disappeared from the battlefield.")
    return true
  end

  local function tick(ad, holder, key, text)
    if (holder[key] or 0) > 0 then
      holder[key] = holder[key] - 1
      if holder[key] <= 0 then
        holder[key] = nil
        if text then U.say(ad, text) end
        return true
      end
    end
    return false
  end

  Residuals.register("campaign_field", function(ctx)
    local ad = ctx.adapter
    if not F.active() then return end
    local st = ad._st
    local f = field(st)
    for _, key in ipairs({ "player", "enemy" }) do
      local side = key == "player" and st.playerSide or st.enemySide
      if side then
        local whose = key == "player" and "Your team's" or "The opposing team's"
        tick(ad, side, "campaignTailwind", whose .. " tailwind petered out!")
        tick(ad, side, "campaignLuckyChant", whose .. " Lucky Chant wore off!")
        tick(ad, side, "campaignAuroraVeil", whose .. " Aurora Veil wore off!")
      end
    end
    tick(ad, f, "trickRoom", "The twisted dimensions returned to normal!")
    tick(ad, f, "gravity", "Gravity returned to normal!")
    tick(ad, f, "magicRoom", "Magic Room wore off, and held items' effects returned to normal!")
    tick(ad, f, "wonderRoom", "Wonder Room wore off, and Defense and Sp. Def stats returned to normal!")
    if f.terrain and tick(ad, f, "terrainTurns") then
      U.say(ad, "The " .. F.TERRAIN_NAME[f.terrain] .. " terrain disappeared from the battlefield.")
      f.terrain = nil
    end
    f.fairyLock = f.fairyLock and f.fairyLock > 1 and f.fairyLock - 1 or nil
    f.ionDeluge = nil
  end)

  Residuals.register("campaign_battler", function(ctx)
    local ad, b = ctx.adapter, ctx.target or ctx.user
    if not F.active() or not b or ad:isFainted(b) then return end
    local st = ad._st
    if F.terrain(st) == "GRASSY" and U.grounded(ad, b) and ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
      U.heal(ad, b, ad:maxHp(b) / 16)
      U.say(ad, U.name(ad, b) .. " restored a little HP using its Grassy Terrain!")
    end
    if b.campaignAquaRing and ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
      U.heal(ad, b, ad:maxHp(b) / 16)
      U.say(ad, "A veil of water restored " .. U.name(ad, b) .. "'s HP!")
    end
    if b.campaignOctolock then
      local by = b.campaignOctolock
      if by and U.alive(ad, by) then
        U.changeStats(ad, b, { defense = -1, spDef = -1 })
      else
        b.campaignOctolock = nil
      end
    end
    tick(ad, b, "campaignMagnetRise", U.name(ad, b) .. "'s electromagnetism wore off!")
    tick(ad, b, "campaignTelekinesis", U.name(ad, b) .. " was freed from the telekinesis!")
    tick(ad, b, "campaignHealBlock", U.name(ad, b) .. "'s Heal Block wore off!")
    tick(ad, b, "campaignEmbargo", U.name(ad, b) .. " can use items again!")
    tick(ad, b, "campaignThroatChop")
    tick(ad, b, "campaignLaserFocus")
    b.campaignElectrify, b.campaignPowder, b.campaignQuashed, b.campaignBeakBlast = nil, nil, nil, nil
  end)

  local function insertAfter(list, after, name)
    for _, v in ipairs(list) do if v == name then return end end
    for i, v in ipairs(list) do
      if v == after then table.insert(list, i + 1, name); return end
    end
    table.insert(list, name)
  end
  insertAfter(Rules.FIELD_PHASES_ORDER, "safeguard", "campaign_field")
  insertAfter(Rules.BATTLER_PHASES_ORDER, "ingrain", "campaign_battler")

  -- turn order: Tailwind doubles speed, Trick Room reverses it ---------------
  mod.hooks:wrap("battle.turn_order", function(next, a, aMove, b, bMove, ctx)
    local st = ctx and ctx.battle
    if not F.active() or not st or not a or not b then return next(a, aMove, b, bMove, ctx) end
    local f = st.campaignField or {}
    local tailwind = function(x)
      local side = x.side == "player" and st.playerSide or st.enemySide
      return side and (side.campaignTailwind or 0) > 0
    end
    local ad = require("src.core.game3.battle")._adapter
    local function glide(x, mv)
      local rec = mv and Moves.get(mv.num or mv.index or mv.id)
      return rec and rec.campaignGrassyGlide and F.terrain(st) == "GRASSY" and ad and U.grounded(ad, x)
    end
    local ga, gb = glide(a, aMove), glide(b, bMove)
    local items = F.items and (F.items.affectsOrder(a) or F.items.affectsOrder(b))
    local AB = F.abilities
    local abilities = AB and ad and (AB.affectsOrder(ad, a, aMove) or AB.affectsOrder(ad, b, bMove))
    if (f.trickRoom or 0) <= 0 and not tailwind(a) and not tailwind(b) and not ga and not gb and not items
        and not abilities then
      return next(a, aMove, b, bMove, ctx)
    end
    -- the hook receives Gen3Compat move views
    local pa = (ga and 1) or (aMove and tonumber(aMove.priority)) or 0
    local pb = (gb and 1) or (bMove and tonumber(bMove.priority)) or 0
    if AB and ad then
      pa = pa + (aMove and AB.priorityBonus(ad, a, aMove) or 0)
      pb = pb + (bMove and AB.priorityBonus(ad, b, bMove) or 0)
    end
    if pa ~= pb then return pa > pb end
    if F.items then
      local ba, bb = F.items.orderBias(ad, a), F.items.orderBias(ad, b)
      if ba ~= bb then return ba > bb end
    end
    if AB and ad then
      local ba, bb = AB.orderBias(ad, a, aMove), AB.orderBias(ad, b, bMove)
      if ba ~= bb then return ba > bb end
    end
    local sa, sb = U.speed(ad, a), U.speed(ad, b)
    if sa == sb then return next(a, aMove, b, bMove, ctx) end
    if (f.trickRoom or 0) > 0 then return sa < sb end
    return sa > sb
  end)

  -- protection, read by the patched accuracy check --------------------------
  -- Returns true when the move is stopped. Shields punish contact; King's
  -- Shield and Obstruct let status moves through; Feint-style moves bypass.
  function F.protected(M)
    local move, user, target, ad = M.move, M.user, M.target, M.adapter
    if move.campaignBypassProtect then return false end
    if not target then return true end
    if F.abilities and F.abilities.unprotected(M) then return false end
    local shield = target.campaignShieldTurn == ad._st.turn and target.campaignShield or nil
    local status = (tonumber(move.power) or 0) <= 0
    if status and (shield == "KINGS" or shield == "OBSTRUCT") then return false end
    if shield and U.hasContact(move) and user ~= target and not ad:isFainted(user) then
      if shield == "SPIKY" and F.abilities and F.abilities.magicGuard(ad, user) then
        -- Magic Guard: no harm from the spikes
      elseif shield == "SPIKY" then
        ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 8)))
        U.say(ad, U.name(ad, user) .. " was hurt by " .. U.name(ad, target) .. "'s Spiky Shield!")
        M.checkUserFaint = true
      elseif shield == "KINGS" then
        Secondary.changeStat(ad, user, "attack", -1, { allowPtr = true, certain = true })
      elseif shield == "OBSTRUCT" then
        Secondary.changeStat(ad, user, "defense", -2, { allowPtr = true, certain = true })
      elseif shield == "BANEFUL" and not ad:status(user) and not U.hasType(user, T.POISON)
          and not U.hasType(user, T.STEEL) then
        ad:applyStatus(user, "PSN")
        ad:statusAnim(user, "PSN")
        U.say(ad, U.name(ad, user) .. " was poisoned!")
      end
    end
    return true
  end
  function U.hasContact(move) return math.floor((tonumber(move.flags) or 0) % 2) == 1 end

  -- side guards and Psychic Terrain, before protection
  function F.blocked(M)
    local move, user, target, ad = M.move, M.user, M.target, M.adapter
    if not target or target == user or not F.active() then return nil end
    local side = ad:ownSide(target)
    local tgt = tonumber(move.target) or 0
    if side and side.campaignWideGuard == ad._st.turn and (tgt == 8 or tgt == 32) and target.side ~= user.side then
      return target.side == "player" and "Wide Guard protected your team!" or "Wide Guard protected the opposing team!"
    end
    if side and side.campaignCraftyShield == ad._st.turn and (tonumber(move.power) or 0) <= 0 and target.side ~= user.side then
      return "Crafty Shield protected " .. U.name(ad, target) .. "!"
    end
    if side and side.campaignMatBlock == ad._st.turn and (tonumber(move.power) or 0) > 0 and target.side ~= user.side then
      return U.name(ad, target) .. " was protected by the mat!"
    end
    if U.moveFlag(move, "FLAG_POWDER") and (U.hasType(target, T.GRASS) or (F.items and F.items.powderImmune(target))) then
      return "It doesn't affect " .. U.name(ad, target) .. "..."
    end
    local priority = F.abilities and F.abilities.priority(ad, user, move) or (tonumber(move.priority) or 0)
    if F.terrain(ad._st) == "PSYCHIC" and priority > 0 and target.side ~= user.side
        and U.grounded(ad, target) then
      return U.name(ad, target) .. " is protected by the Psychic Terrain!"
    end
    if F.abilities then return F.abilities.blocked(M) end
    return nil
  end

  -- type effectiveness for every move -------------------------------------
  function F.effectiveness(attacker, defender, move, moveType, flags, eff)
    if not F.active() then return flags, eff end
    local ad = require("src.core.game3.battle")._adapter
    local changed = false
    if defender.campaignType3 then eff = U.effectiveness(moveType, defender); changed = true end
    if move.campaignEffectiveness then eff = move.campaignEffectiveness(attacker, defender, moveType, eff); changed = true end
    if moveType == T.GROUND and ad and defender.side then
      if U.grounded(ad, defender) and U.hasType(defender, T.FLYING) then
        -- held down: Ground hits it as if it were not Flying
        local t1, t2 = U.types(defender)
        local types = {}
        for _, t in ipairs({ t1, t2, defender.campaignType3 }) do if t and t ~= T.FLYING then types[#types + 1] = t end end
        local Types = require("src.core.game3.battle.types")
        eff = 1
        for _, t in ipairs(types) do eff = eff * Types.effectiveness(moveType, t, t) end
        changed = true
      elseif (defender.campaignMagnetRise or 0) > 0 or (defender.campaignTelekinesis or 0) > 0 then
        if not (U.grounded(ad, defender)) then eff = 0; changed = true end
      end
    end
    if defender.campaignTarShot and moveType == T.FIRE then eff = eff * 2; changed = true end
    if F.abilities and ad then
      local abEff = F.abilities.effectiveness(ad, attacker, defender, move, moveType, eff)
      if abEff ~= eff then eff, changed = abEff, true end
    end
    if F.items then
      local Types = require("src.core.game3.battle.types")
      local itemEff = F.items.effectiveness(ad, attacker, defender, move, moveType, eff, Types.effectiveness)
      if itemEff ~= eff then eff, changed = itemEff, true end
    end
    if changed then return U.flagsFor(eff), eff end
    return flags, eff
  end

  -- base power for every move: terrains, and the moves' own formulas ---------
  local function mul(power, factor) return math.max(1, math.floor(power * factor)) end
  function F.power(attacker, defender, move, moveType, power, opts)
    if not F.active() then return power end
    local ad = opts and opts.adapter or require("src.core.game3.battle")._adapter
    local st = ad and ad._st
    local terrain = st and F.terrain(st)
    if F.abilities then power = F.abilities.power(attacker, defender, move, moveType, power, opts) end
    if terrain and ad then
      if terrain == "ELECTRIC" and moveType == T.ELECTRIC and U.grounded(ad, attacker) then power = mul(power, 1.3)
      elseif terrain == "GRASSY" and moveType == T.GRASS and U.grounded(ad, attacker) then power = mul(power, 1.3)
      elseif terrain == "PSYCHIC" and moveType == T.PSYCHIC and U.grounded(ad, attacker) then power = mul(power, 1.3)
      elseif terrain == "MISTY" and moveType == T.DRAGON and U.grounded(ad, defender) then power = mul(power, 0.5) end
      if terrain == "GRASSY" then
        local E = require("src.core.game3.battle.effect_ids")
        local eff = tonumber(move.effect)
        if eff == E.EARTHQUAKE or eff == E.MAGNITUDE or move.campaignBulldoze then power = mul(power, 0.5) end
      end
    end
    if attacker.campaignChargedFire and moveType == T.FIRE then power = mul(power, 1.5) end
    if F.items then power = F.items.power(attacker, defender, move, moveType, power) end
    return power
  end

  -- status conditions blocked by terrain ------------------------------------
  local new = Adapter.new
  Adapter.new = function(...)
    local a = new(...)
    local can = a.canApplyStatus
    function a:canApplyStatus(b, status, ...)
      if F.active() and b and self._st then
        local terrain = F.terrain(self._st)
        if terrain and U.grounded(self, b) then
          if terrain == "MISTY" then return false end
          if terrain == "ELECTRIC" and status == "SLP" then return false end
        end
        if b.side and status == "SLP" then
          local side = self:ownSide(b)
          if side and side.campaignSweetVeil then return false end
        end
      end
      return can(self, b, status, ...)
    end
    return a
  end

  -- link battles with the co-op partner ---------------------------------------
  -- versus battles keep each side's real levels (Union Room rules force 50)
  -- and show the partner as their Emerald player character
  local LB = require("src.core.game3.link.battle")
  LB.keepLevels = function() return F.active() end
  LB.playerPic = function(gender)
    if not F.active() then return nil end
    local C = require("src.core.game3.constants").of("emerald")
    local byName = C.trainer_classes and C.trainer_classes.byName or {}
    return byName[tonumber(gender) == 1 and "TRAINER_PIC_MAY" or "TRAINER_PIC_BRENDAN"]
  end

  -- the link wire format carries Inclement's content (patched Protocol)
  local Protocol = require("src.link.Protocol")
  local function maxId(t, filter)
    local m = 0
    for id, row in pairs(t) do if id > m and (not filter or filter(row)) then m = id end end
    return m
  end
  Protocol.campaign = {
    active = function() return F.active() end,
    species = maxId(U.data.species), moves = maxId(U.data.moves), items = maxId(U.data.items),
    balls = maxId(U.data.items, function(row) return row.pocket == "POKE_BALLS" end),
    abilitySlots = 2,
    nature = function(mon)
      local Pokemon = require("src.core.game3.pokemon")
      return Pokemon.natureOf and Pokemon.natureOf(mon) or nil
    end,
  }

  -- Ally Switch: the two Pokémon on a side trade positions. Each position's
  -- battler table stays (positions are what moves target); its contents
  -- move, and the turn's queued actions follow their Pokémon.
  -- The battle logic runs ahead of the animations, so each position keeps
  -- showing its old Pokémon (a stand-in) until the "switched places" line
  -- plays; then sprites and healthboxes trade places too.
  local KEEP_POSITION = { id = true, side = true }
  local DISPLAY = { "displayHp", "displayMaxHp", "displayLevel", "displayStatus", "displayExp", "substitute" }
  local pendingSwaps = {}
  function F.swapPositions(ad, a, b, text)
    local Anim = require("src.core.game3.battle.anim")
    local Battle = require("src.core.game3.battle")
    local snapA, snapB = {}, {}
    for k, v in pairs(a) do snapA[k] = v end
    for k, v in pairs(b) do snapB[k] = v end
    local hold = {}
    for k, v in pairs(a) do if not KEEP_POSITION[k] then hold[k] = v; a[k] = nil end end
    for k, v in pairs(b) do if not KEEP_POSITION[k] then a[k] = v; b[k] = nil end end
    for k, v in pairs(hold) do b[k] = v end
    local ida, idb = State.idOf(a), State.idOf(b)
    -- (_actionI already points past the running action: it is the next one)
    local actions, at = Battle._actions or {}, Battle._actionI or 1
    for i = at, #actions do
      local row = actions[i]
      if row and row.battler == ida then row.battler, row.user = idb, b
      elseif row and row.battler == idb then row.battler, row.user = ida, a end
    end
    if text then
      Anim.setShown(ida, snapA)
      Anim.setShown(idb, snapB)
      pendingSwaps[#pendingSwaps + 1] = { text = text, a = ida, b = idb }
    end
  end
  -- the swap line reaches the screen: positions show their new Pokémon
  local Ui = require("src.core.game3.battle.ui")
  local push = Ui.push
  Ui.push = function(text, ...)
    local sw = pendingSwaps[1]
    if sw and text == sw.text then
      table.remove(pendingSwaps, 1)
      local Anim = require("src.core.game3.battle.anim")
      local pa, pb = Anim.present(sw.a), Anim.present(sw.b)
      Anim.setShown(sw.a, nil)
      Anim.setShown(sw.b, nil)
      if pa and pb then
        for _, k in ipairs(DISPLAY) do pa[k], pb[k] = pb[k], pa[k] end
      end
    end
    return push(text, ...)
  end
  function F.resetSwaps() pendingSwaps = {} end
  local BattleMod = require("src.core.game3.battle")
  local battleReset = BattleMod.reset
  BattleMod.reset = function(...)
    pendingSwaps = {}
    return battleReset(...)
  end

  -- Sky Drop: the user carries the target into the air for a turn; the
  -- target can't act until it is dropped (the hit) or released
  function F.skyDropCharge(M)
    local ad, user, target = M.adapter, M.user, M.target
    local ok = target and target ~= user and target.side ~= user.side and U.alive(ad, target)
      and not ((target.substituteHP or 0) > 0) and U.weight(target) < 2000
      and (field(M.st).gravity or 0) <= 0 and not target.semiInvulnerable
    if not ok then
      user.twoTurnMove, user.twoTurnTarget, user.expLockedMove, user.expLockedSlot = nil, nil, nil, nil
      M.failed = true
      ad:sayFail()
      return
    end
    Engine.setSemiInvulnerable(user, "ON_AIR")
    Engine.setSemiInvulnerable(target, "ON_AIR")
    target.campaignSkyDropped = user
    ad:say(U.name(ad, user) .. " took " .. U.name(ad, target) .. " into the sky!")
  end
  function F.skyDropRelease(target)
    if target and target.campaignSkyDropped then
      target.campaignSkyDropped = nil
      Engine.setSemiInvulnerable(target, nil)
    end
  end
  local resolve = Engine.resolveMove
  Engine.resolveMove = function(user, target, moveId, slot, adapter, st, out, opts, ...)
    local held = F.active() and user and st and State.occupant(st, user)
    local by = held and held.campaignSkyDropped
    if by and not (opts and opts.called) then
      if U.alive(adapter, by) and by.semiInvulnerable == "ON_AIR" then
        out = out or {}
        out._anim = { moveId = moveId, user = held, target = target, hits = {}, heals = {}, faints = {},
          missed = false, statusOnly = true, msgs = {}, events = {} }
        adapter:say(U.name(adapter, held) .. " is being held in the sky!")
        return out
      end
      F.skyDropRelease(held)
    end
    return resolve(user, target, moveId, slot, adapter, st, out, opts, ...)
  end

  -- Low Kick and Grass Knot: weight as the campaign counts it (Heavy and
  -- Light Metal, Autotomize, forms)
  -- (the Inclement damage rules keep their own copy of the formula table)
  local Damage = require("src.core.game3.battle.damage")
  local function weighed(tbl)
    if not tbl or tbl._campaignLowKick then return end
    tbl._campaignLowKick = true
    local lowKick = tbl.lowKickPower
    tbl.lowKickPower = function(dMon, defender, ...)
      if F.active() and type(defender) == "table" and defender.mon then
        local wt = U.weight(defender)
        for _, row in ipairs({ { 100, 20 }, { 250, 40 }, { 500, 60 }, { 1000, 80 }, { 2000, 100 } }) do
          if row[1] > wt then return row[2] end
        end
        return 120
      end
      return lowKick(dMon, defender, ...)
    end
  end
  weighed(Damage)
  weighed(Damage._inclementBattleTest and Damage._inclementBattleTest.implementation)

  -- forced switching -------------------------------------------------------
  -- U-turn, Volt Switch, Flip Turn, Parting Shot: the Baton Pass switch
  -- (party prompt for the player and link partner, AI pick for trainers)
  -- without passing stat changes.
  function F.switchOut(M, user)
    local ad, st = M.adapter, M.st
    if st.over or ad:isFainted(user) then return false end
    local side = st.double and State.idOf(user) or user.side
    local candidates = Engine.switchCandidates(st, side)
    if #candidates == 0 then return false end
    local pick
    if type(st.batonPassChooser) == "function" then
      local ok, v = pcall(st.batonPassChooser, user.side, candidates)
      if ok then pick = tonumber(v) end
    elseif (st.link or user.side == "player") and st.interactiveChoices and coroutine.running() then
      pick = tonumber(coroutine.yield({ kind = "baton_pass", side = user.side, battler = user.id, candidates = candidates }))
    elseif user.side == "enemy" then
      pick = Engine.mostSuitableMon(st, ad, st.double and user.id or "enemy")
    end
    local slot = candidates[1]
    for _, c in ipairs(candidates) do if c == pick then slot = pick end end
    local nb = Engine.performSwitch(st, ad, side, slot, { reason = "u_turn" })
    if not nb then return false end
    M.user = nb
    local SwitchSeq = require("src.core.game3.battle.switch_seq")
    local BattleText = require("src.core.game3.battle.battle_text")
    local fill = SwitchSeq.switchInFill(st, nb)
    local text = BattleText.get(BattleText.SWITCHINMON, fill)
    ad:pushEvent({ kind = "msg", text = text, wait = 0, id = BattleText.key(BattleText.SWITCHINMON, fill) })
    ad._say(text)
    Engine.switchInEffects(st, ad, nb, { spikes = true, deferIntimidate = true })
    return true
  end

  -- Dragon Tail, Circle Throw: a random replacement in trainer battles; a
  -- wild Pokémon is not driven off (the campaign's wild battles are doubles)
  function F.dragOut(M, target)
    local ad, st = M.adapter, M.st
    if st.over or st.wild or ad:isFainted(target) or target.expIngrain
        or ad:abilityOf(target) == "SUCTION_CUPS" then return false end
    local side = st.double and State.idOf(target) or target.side
    local candidates = Engine.switchCandidates(st, side)
    if #candidates == 0 then return false end
    local nb = Engine.performSwitch(st, ad, side, candidates[ad:roll(1, #candidates)], { reason = "roar" })
    if not nb then return false end
    M.target = nb
    ad:sayText("STRINGID_PKMNWASDRAGGEDOUT", { def = nb })
    Engine.switchInEffects(st, ad, nb, { spikes = true, deferIntimidate = true })
    return true
  end

  -- escape prevention uses Mean Look's fields, which fleeing and switching read
  function U.trap(b, by)
    b.expTrapped, b.escapePrevention, b.expTrappedBy = true, true, by
  end

  -- abilities, items and battle text through the adapter ---------------------
  local function wrapAdapter(a)
    local abilityOf, sayText, setWeather = a.abilityOf, a.sayText, a.setWeather
    -- weather rocks lengthen the weather their holder sets
    function a:setWeather(kind, turns, ...)
      if F.active() and F.items and (turns == nil or turns > 0) then
        local ctx = require("src.core.game3.battle.effect_ctx").current()
        turns = F.items.weatherTurns(ctx and ctx.user, kind, turns or 5)
      end
      return setWeather(self, kind, turns, ...)
    end
    function a:abilityOf(b, ...)
      if F.active() and b then
        if self._campaignIgnoreAbility == b or b.campaignAbilitySuppressed then return nil end
        if b.campaignAbility then return b.campaignAbility end
      end
      return abilityOf(self, b, ...)
    end
    function a:sayText(id, fill, ...)
      if id == nil and self._campaignTrapText and fill then
        local text = self._campaignTrapText
        self._campaignTrapText = nil
        local def = fill.def and self:displayName(fill.def) or ""
        local atk = fill.atk and self:displayName(fill.atk) or ""
        return self:say((text:gsub("{def}", def):gsub("{atk}", atk)))
      end
      return sayText(self, id, fill, ...)
    end
  end
  local newAdapter = Adapter.new
  Adapter.new = function(...)
    local a = newAdapter(...)
    wrapAdapter(a)
    return a
  end

  local HeldItems = require("src.core.game3.battle.held_items")
  local itemsOf = HeldItems.of
  HeldItems.of = function(b, ...)
    if F.active() and b then
      local Battle = require("src.core.game3.battle")
      local st = Battle._st
      if (st and st.campaignField and (st.campaignField.magicRoom or 0) > 0) or (b.campaignEmbargo or 0) > 0
          or (F.abilities and F.abilities.klutz(b)) then
        return 0, 0, HeldItems.itemOf(b)
      end
    end
    return itemsOf(b, ...)
  end

  -- extra damage options for every hit (Lucky Chant, Laser Focus)
  function F.calcExtra(M, target, extra)
    if not F.active() then return end
    local side = target and M.adapter:ownSide(target)
    if side and (side.campaignLuckyChant or 0) > 0 then extra.forceCrit = false end
    if (M.user.campaignLaserFocus or 0) > 0 and extra.forceCrit == nil then extra.forceCrit = true end
  end

  -- before any move: Throat Chop silences sound moves
  function F.preMove(M)
    if not F.active() then return false end
    if F.items and (tonumber(M.move.power) or 0) <= 0 and F.items.blocksStatus(M.user) and not (M.opts and M.opts.called) then
      M.adapter:say(U.name(M.adapter, M.user) .. " can't use status moves while holding an Assault Vest!")
      return true
    end
    if (M.user.campaignThroatChop or 0) <= 0 then return false end
    if U.moveFlag(M.move, "FLAG_SOUND") then
      M.adapter:say("The effects of Throat Chop prevent " .. U.name(M.adapter, M.user) .. " from using certain moves!")
      return true
    end
    return false
  end

  return F
end
