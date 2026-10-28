-- Expanded damaging moves (donor effects with no Gen 3 equivalent). Each
-- spec runs on the native hit pipeline through hooks the campaign adds to
-- the port library (campaign* fields on the move record):
--   base     native effect the hit runs as (default HIT)
--   pre      M -> true when the move fails before hitting
--   calc     M, target -> extra damage options (power, moveType, forceCrit,
--            fixedDamage)
--   stats    attacker/defender stats and stages used by the damage formula
--   eff      attacker, defender, moveType, eff -> effectiveness
--   after    M, after a landed hit (before the faint check)
--   afterFaint M, after the target's faint check
-- Numbers follow the donor (1.13) (pokeemerald-1.13 battle_util.c and
-- battle_script_commands.c, Gen 7 configuration).
return function(U, F)
  local State = require("src.core.game3.battle.state")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local T = U.TYPE
  local S = {}

  local function chance(M, pct)
    local ad = M.adapter
    if F.abilities then pct = F.abilities.chance(M, pct)
    elseif ad:abilityOf(M.user) == "SERENE_GRACE" then pct = pct * 2 end
    return pct > 0 and ad:roll(0, 99) < pct
  end
  local function landed(M) return not M.noEffect and not M.failed end
  local function targetAlive(M) return M.target and U.alive(M.adapter, M.target) end
  local function fail(M, failFn) failFn(M); return true end
  local function double(M, cond) if cond then return { power = (tonumber(M.move.power) or 1) * 2 } end end
  local function selfStats(changes)
    return function(M) if landed(M) and U.alive(M.adapter, M.user) then U.changeStats(M.adapter, M.user, changes, { user = true }) end end
  end
  local function selfStatsChance(changes)
    return function(M)
      if landed(M) and U.alive(M.adapter, M.user) and chance(M, tonumber(M.move.secondaryChance) or 0) then
        U.changeStats(M.adapter, M.user, changes, { user = true })
      end
    end
  end
  local function targetStatsChance(changes)
    return function(M)
      if landed(M) and targetAlive(M) and not (M.target.substituteHP and M.target.substituteHP > 0)
          and chance(M, tonumber(M.move.secondaryChance) or 0) then
        U.changeStats(M.adapter, M.target, changes)
      end
    end
  end
  local function statusChance(kind, pct)
    return function(M)
      if landed(M) and targetAlive(M) and chance(M, pct or tonumber(M.move.secondaryChance) or 0) then
        Secondary.set(M, kind, false, false)
      end
    end
  end
  local function recoil(fraction)
    return function(M)
      local ad = M.adapter
      if not landed(M) or ad:isFainted(M.user) or ad:abilityOf(M.user) == "ROCK_HEAD"
          or (F.abilities and F.abilities.magicGuard(ad, M.user)) then return end
      ad:applyHpLoss(M.user, math.max(1, math.floor((M.hpDealt or 0) * fraction)))
      ad:sayText("STRINGID_PKMNHITWITHRECOIL", { atk = M.user })
      M.checkUserFaint = true
    end
  end
  local function chain(...)
    local fns = { ... }
    return function(M) for _, fn in ipairs(fns) do fn(M) end end
  end
  local STATUS_ARG = { [3] = "BURN", [5] = "PARALYSIS", [7] = "SLEEP", [16] = "BURN", [32] = "FREEZE", [64] = "PARALYSIS" }

  -- power formulas ----------------------------------------------------------
  S.ACROBATICS = { calc = function(M) return double(M, U.item(M.user) == 0) end }
  S.ASSURANCE = { calc = function(M, t) return double(M, F.hurtThisTurn(M.adapter, t)) end }
  S.BRINE = { calc = function(M, t) return double(M, M.adapter:hp(t) <= math.floor(M.adapter:maxHp(t) / 2)) end }
  S.HEX = { calc = function(M, t) return double(M, M.adapter:status(t) ~= nil) end }
  S.VENOSHOCK = { calc = function(M, t)
    local s = M.adapter:status(t); return double(M, s == "PSN" or s == "TOX") end }
  S.WAKE_UP_SLAP = {
    calc = function(M, t) return double(M, M.adapter:status(t) == "SLP") end,
    after = function(M)
      if landed(M) and targetAlive(M) and M.adapter:status(M.target) == "SLP" then
        M.adapter:clearStatus(M.target)
        M.adapter:sayText("STRINGID_PKMNWOKEUP", { atk = M.target })
      end
    end,
  }
  S.PAYBACK = { calc = function(M, t) return double(M, U.movedThisTurn(M.adapter, t)) end }
  S.BOLT_BEAK = { calc = function(M, t) return double(M, not U.movedThisTurn(M.adapter, t)) end }
  S.FISHIOUS_REND = S.BOLT_BEAK
  S.RETALIATE = { calc = function(M)
    local side = M.adapter:ownSide(M.user); return double(M, side and side.campaignRetaliate) end }
  S.STOMPING_TANTRUM = { calc = function(M) return double(M, M.user.campaignLastFailed) end }
  S.LASH_OUT = { calc = function(M) return double(M, F.statsChangedThisTurn(M.adapter, M.user, -1)) end }
  S.ROUND = { calc = function(M) return double(M, U.turn(M.adapter).round and U.turn(M.adapter).round[M.user.side]) end }
  local function fusion(other)
    return { calc = function(M)
      local last = F.field(M.st).lastMove
      return double(M, last == U.data.identity.namespaces.moves[other] and U.turn(M.adapter).lastMove == last)
    end }
  end
  S.FUSION_BOLT = fusion("MOVE_FUSION_FLARE")
  S.FUSION_FLARE = fusion("MOVE_FUSION_BOLT")
  S.WRING_OUT = { power = 1, calc = function(M, t)
    return { power = math.max(1, math.floor(120 * M.adapter:hp(t) / M.adapter:maxHp(t))) } end }
  S.CRUSH_GRIP = S.WRING_OUT
  S.ELECTRO_BALL = { calc = function(M, t)
    local ratio = math.floor(U.speed(M.adapter, M.user) / U.speed(M.adapter, t))
    return { power = ({ [0] = 40, 60, 80, 120 })[ratio] or 150 }
  end }
  S.GYRO_BALL = { calc = function(M, t)
    return { power = math.min(150, math.floor(25 * U.speed(M.adapter, t) / U.speed(M.adapter, M.user)) + 1) }
  end }
  local function heatCrash(M, t)
    local ratio = math.floor(U.weight(M.user) / U.weight(t))
    return { power = ({ [0] = 40, 40, 60, 80, 100 })[ratio] or 120 }
  end
  S.HEAT_CRASH = { calc = heatCrash }
  S.HEAVY_SLAM = S.HEAT_CRASH
  local function positiveStages(b)
    local n = 0
    for _, v in pairs(b.stages or {}) do if v > 0 then n = n + v end end
    return n
  end
  S.STORED_POWER = { calc = function(M) return { power = 20 + 20 * positiveStages(M.user) } end }
  S.POWER_TRIP = S.STORED_POWER
  S.PUNISHMENT = { calc = function(M, t) return { power = math.min(200, 60 + 20 * positiveStages(t)) } end }
  S.TRUMP_CARD = { power = 1, calc = function(M)
    local slot = M.slot
    local pp = slot and M.user.mon and M.user.mon.pp and M.user.mon.pp[slot] or 0
    return { power = ({ [0] = 200, 80, 60, 50 })[pp] or 40 }
  end }
  S.GRAV_APPLE = {
    calc = function(M) if (F.field(M.st).gravity or 0) > 0 then return { power = math.floor(M.move.power * 1.5) } end end,
    after = targetStatsChance({ defense = -1 }),
  }
  S.TERRAIN_PULSE = { calc = function(M)
    local terrain = F.terrain(M.st)
    if not terrain or not U.grounded(M.adapter, M.user) then return nil end
    local kind = ({ ELECTRIC = T.ELECTRIC, GRASSY = T.GRASS, MISTY = T.FAIRY, PSYCHIC = T.PSYCHIC })[terrain]
    return { power = M.move.power * 2, moveType = kind }
  end }
  S.RISING_VOLTAGE = { calc = function(M, t)
    return double(M, F.terrain(M.st) == "ELECTRIC" and U.grounded(M.adapter, t)) end }
  S.EXPANDING_FORCE = { calc = function(M)
    if F.terrain(M.st) == "PSYCHIC" and U.grounded(M.adapter, M.user) then return { power = math.floor(M.move.power * 1.5) } end
  end }
  S.MISTY_EXPLOSION = { calc = function(M)
    if F.terrain(M.st) == "MISTY" and U.grounded(M.adapter, M.user) then return { power = math.floor(M.move.power * 1.5) } end
  end }
  S.SOLAR_BLADE = { base = "SOLAR_BEAM" }
  S.NATURAL_GIFT = {
    pre = function(M, failFn)
      local item = U.item(M.user)
      if not U.isBerry(item) or (M.user.campaignEmbargo or 0) > 0 or (F.field(M.st).magicRoom or 0) > 0 then
        return fail(M, failFn)
      end
      local gift = U.naturalGift[U.itemRow(item).symbol]
      M.campaignGift = gift and { power = gift[2], type = T[gift[1]] } or { power = 80, type = T.NORMAL }
      U.removeItem(M.user)
      M.user.campaignAteBerry = true
    end,
    calc = function(M) local g = M.campaignGift; if g then return { power = g.power, moveType = g.type } end end,
  }
  S.FLING = {
    pre = function(M, failFn)
      local item = U.item(M.user)
      if item == 0 or (M.user.campaignEmbargo or 0) > 0 or (F.field(M.st).magicRoom or 0) > 0 then return fail(M, failFn) end
      -- The donor leaves Fling's power unprogrammed; the standard values
      local row = U.itemRow(item)
      M.campaignFlung = item
      M.campaignFlingPower = U.isBerry(item) and 10 or (row and row.symbol == "ITEM_IRON_BALL" and 130) or 30
      U.removeItem(M.user)
      M.adapter:say(U.name(M.adapter, M.user) .. " flung its " .. U.itemName(item) .. "!")
    end,
    calc = function(M) return { power = math.max(10, M.campaignFlingPower or 30) } end,
    after = function(M)
      if landed(M) and targetAlive(M) and M.campaignFlung and U.isBerry(M.campaignFlung) then
        U.eatBerry(M.adapter, M.target, M.campaignFlung)
      end
    end,
  }

  -- always critical, multi-hit, accuracy and target quirks -------------------
  local crit = { calc = function() return { forceCrit = true } end }
  S.FROST_BREATH, S.STORM_THROW, S.WICKED_BLOW, S.ZIPPY_ZAP = crit, crit, crit, crit
  S.SURGING_STRIKES = { hits = 3, calc = crit.calc }
  S.DOUBLE_IRON_BASH = { hits = 2 }
  S.DRAGON_DARTS = { hits = 2 }
  S.SCALE_SHOT = {
    multi = true,
    after = function(M)
      if landed(M) and U.alive(M.adapter, M.user) then U.changeStats(M.adapter, M.user, { speed = 1, defense = -1 }, { user = true }) end
    end,
  }
  S.TRIPLE_AXEL = { base = "TRIPLE_KICK", tripleKickStep = 20 }
  S.SNIPE_SHOT = { ignoreRedirect = true }
  S.HURRICANE = {
    base = "CONFUSE_HIT",
    accuracy = function(M)
      local w = require("src.core.game3.battle.rules").weather.effective(M.st, M.adapter)
      if w == "RAIN" then return 0 elseif w == "SUN" then return 50 end
    end,
  }
  S.BEHEMOTH_BASH, S.BEHEMOTH_BLADE, S.DYNAMAX_CANNON = {}, {}, {}
  S.FIRST_IMPRESSION = { pre = function(M, failFn)
    if M.st.turn ~= (M.user.campaignEnteredTurn or -1) and (M.user.isFirstTurn or 0) <= 0 then return fail(M, failFn) end
  end }
  S.SUCKER_PUNCH = { pre = function(M, failFn)
    local t = M.target
    local row = t and M.st.chosen and M.st.chosen[State.idOf(t)]
    local mv = row and row.kind == "move" and require("src.core.game3.battle.moves").get(row.move)
    if not mv or (tonumber(mv.power) or 0) <= 0 or U.movedThisTurn(M.adapter, t) then return fail(M, failFn) end
  end }
  S.LAST_RESORT = { pre = function(M, failFn)
    local mon, used, others = M.user.mon or {}, M.user.campaignUsed or {}, 0
    for i = 1, 4 do
      local mv = tonumber(mon.moves and mon.moves[i])
      if mv and mv ~= 0 and mv ~= M.mnum then
        others = others + 1
        if not used[mv] then return fail(M, failFn) end
      end
    end
    if others == 0 then return fail(M, failFn) end
  end }
  S.BELCH = { pre = function(M, failFn) if not M.user.campaignAteBerry then return fail(M, failFn) end end }
  S.POLTERGEIST = {
    pre = function(M, failFn)
      local item = M.target and U.item(M.target) or 0
      if item == 0 then return fail(M, failFn) end
      M.adapter:say(U.name(M.adapter, M.target) .. " is about to be attacked by its " .. U.itemName(item) .. "!")
    end,
  }
  S.STEEL_ROLLER = {
    pre = function(M, failFn) if not F.terrain(M.st) then return fail(M, failFn) end end,
    after = function(M) if landed(M) then F.clearTerrain(M.adapter) end end,
  }
  S.SYNCHRONOISE = { pre = function(M, failFn)
    local t1, t2, t3 = U.types(M.user)
    local t = M.target
    if not t or not ((t1 and U.hasType(t, t1)) or (t2 and U.hasType(t, t2)) or (t3 and U.hasType(t, t3))) then
      M.adapter:sayText("STRINGID_PKMNWASNTAFFECTED", { def = t })
      M.noEffect = true
      return true
    end
  end }
  S.FINAL_GAMBIT = {
    power = 1,
    calc = function(M) return { fixedDamage = M.adapter:hp(M.user) } end,
    after = function(M) if landed(M) then M.adapter:setHp(M.user, 0); M.checkUserFaint = true end end,
  }
  S.METAL_BURST = {
    power = 1,
    pre = function(M, failFn)
      local u = M.user
      local phys, spec = u.lastPhysicalDamageTaken or 0, u.lastSpecialDamageTaken or 0
      local by = phys >= spec and u.lastPhysicalById or u.lastSpecialById
      local taken = math.max(phys, spec)
      local foe = by and State.battler(M.st, by)
      if taken <= 0 or not foe or foe.side == u.side or not U.alive(M.adapter, foe) then return fail(M, failFn) end
      M.target, M.tname = foe, M.adapter:displayName(foe)
      M.campaignTaken = taken
    end,
    calc = function(M) return { fixedDamage = math.max(1, math.floor((M.campaignTaken or 0) * 3 / 2)) } end,
  }

  -- which stats the damage formula uses --------------------------------------
  local function useDefenseForSpecial(attacker, defender, atk, def, spa, spd, as, ds)
    return atk, def, spa, def, as, { spDef = ds.defense or 0, defense = ds.defense }
  end
  S.PSYSHOCK = { stats = useDefenseForSpecial }
  S.PSYSTRIKE, S.SECRET_SWORD = S.PSYSHOCK, S.PSYSHOCK
  local function ignoreTargetStages(attacker, defender, atk, def, spa, spd, as)
    return atk, def, spa, spd, as, {}
  end
  S.CHIP_AWAY = { stats = ignoreTargetStages, ignoreEvasion = true }
  S.SACRED_SWORD, S.DARKEST_LARIAT = S.CHIP_AWAY, S.CHIP_AWAY
  S.BODY_PRESS = { stats = function(attacker, defender, atk, def, spa, spd, as, ds)
    local own = attacker.mon and (attacker.mon.defense or attacker.mon.def) or def
    return own, def, spa, spd, { attack = as.defense or 0 }, ds
  end }
  S.FOUL_PLAY = { stats = function(attacker, defender, atk, def, spa, spd, as, ds)
    local theirs = defender.mon and (defender.mon.attack or defender.mon.atk) or atk
    return theirs, def, spa, spd, { attack = ds.attack or 0 }, ds
  end }
  S.PHOTON_GEYSER = { pre = function(M)
    -- physical when the user's Attack beats its Sp. Atk (stages included)
    local D = require("src.core.game3.battle.damage")
    local mon = M.user.mon or {}
    local a = D.applyStage(tonumber(mon.attack or mon.atk) or 0, U.stage(M.user, "attack"))
    local s = D.applyStage(tonumber(mon.spAtk or mon.spa) or 0, U.stage(M.user, "spAtk"))
    if a > s then M.move.category = "physical" end
  end }
  S.SHELL_SIDE_ARM = {
    pre = function(M)
      local mon, tm = M.user.mon or {}, M.target and M.target.mon or {}
      local phys = (tonumber(mon.attack or mon.atk) or 0) / math.max(1, tonumber(tm.defense or tm.def) or 1)
      local spec = (tonumber(mon.spAtk or mon.spa) or 0) / math.max(1, tonumber(tm.spDef or tm.spd) or 1)
      if phys > spec then M.move.category = "physical" end
    end,
    after = statusChance("POISON"),
  }
  S.MOONGEIST_BEAM, S.SUNSTEEL_STRIKE = { ignoreAbility = true }, { ignoreAbility = true }

  -- type effectiveness -------------------------------------------------------
  S.FREEZE_DRY = { base = "FREEZE_HIT", eff = function(_, d, moveType, eff)
    if U.hasType(d, T.WATER) then return eff * 4 end
    return eff
  end }
  S.FLYING_PRESS = { eff = function(_, d, _, eff) return eff * U.effectiveness(T.FLYING, d) end }
  S.THOUSAND_ARROWS = {
    eff = function(_, d, moveType, eff)
      if U.hasType(d, T.FLYING) and eff == 0 then return 1 end
      return eff
    end,
    after = function(M) if landed(M) and targetAlive(M) then S.SMACK_DOWN.after(M) end end,
  }

  -- after-hit effects --------------------------------------------------------
  S.CLANGING_SCALES = { after = selfStats({ defense = -1 }) }
  S.CLOSE_COMBAT = { after = selfStats({ defense = -1, spDef = -1 }) }
  S.DRAGON_ASCENT = S.CLOSE_COMBAT
  S.HAMMER_ARM = { after = selfStats({ speed = -1 }) }
  S.ICE_HAMMER = S.HAMMER_ARM
  S.V_CREATE = { after = selfStats({ defense = -1, spDef = -1, speed = -1 }) }
  S.HYPERSPACE_FURY = { bypassProtect = true, after = selfStats({ defense = -1 }) }
  S.HYPERSPACE_HOLE = { bypassProtect = true }
  S.FEINT = {
    bypassProtect = true,
    pre = function(M)
      local t = M.target
      if t and (t.expProtected or t.campaignShield) then
        t.expProtected, t.campaignShield = nil, nil
        M.campaignBrokeProtect = true
      end
    end,
    after = function(M)
      if M.campaignBrokeProtect then M.adapter:say(U.name(M.adapter, M.target) .. " fell for the feint!") end
    end,
  }
  S.DIAMOND_STORM = { after = selfStatsChance({ defense = 2 }) }
  S.FLAME_CHARGE = { after = selfStats({ speed = 1 }) }
  S.AURA_WHEEL = { after = selfStats({ speed = 1 }) }
  S.CHARGE_BEAM = { after = selfStatsChance({ spAtk = 1 }) }
  S.FIERY_DANCE = S.CHARGE_BEAM
  S.ACID_SPRAY = { after = targetStatsChance({ spDef = -2 }) }
  S.SEED_FLARE = S.ACID_SPRAY
  S.FELL_STINGER = { afterFaint = function(M)
    if landed(M) and M.target and M.adapter:isFainted(M.target) and U.alive(M.adapter, M.user) then
      U.changeStats(M.adapter, M.user, { attack = 3 }, { user = true })
    end
  end }
  S.CLEAR_SMOG = { after = function(M)
    if landed(M) and targetAlive(M) and not (M.target.substituteHP and M.target.substituteHP > 0) then
      for k in pairs(M.target.stages or {}) do M.target.stages[k] = 0 end
      M.adapter:say(U.name(M.adapter, M.target) .. "'s stat changes were removed!")
    end
  end }
  S.SPECTRAL_THIEF = { pre = function(M)
    local t = M.target
    if not t or (t.substituteHP or 0) > 0 then return end
    local stole = {}
    for k, v in pairs(t.stages or {}) do
      if v > 0 then stole[k] = v; t.stages[k] = 0 end
    end
    if next(stole) then
      M.adapter:say(U.name(M.adapter, M.user) .. " stole the target's boosted stats!")
      for k, v in pairs(stole) do M.user.stages[k] = math.min(6, (M.user.stages[k] or 0) + v) end
    end
  end }
  S.SMACK_DOWN = { after = function(M)
    local t = M.target
    if landed(M) and targetAlive(M) and not t.campaignSmackedDown
        and (U.hasType(t, T.FLYING) or M.adapter:abilityOf(t) == "LEVITATE" or (t.campaignMagnetRise or 0) > 0) then
      t.campaignSmackedDown, t.campaignMagnetRise, t.campaignTelekinesis = true, nil, nil
      if t.semiInvulnerable == "ON_AIR" then t.semiInvulnerable, t.onAir = nil, nil end
      M.adapter:say(U.name(M.adapter, t) .. " fell straight down!")
    end
  end }
  S.BUG_BITE = { after = function(M)
    local t, ad = M.target, M.adapter
    if not landed(M) or not t or (t.substituteHP or 0) > 0 or ad:abilityOf(t) == "STICKY_HOLD" then return end
    local item = U.item(t)
    if U.isBerry(item) then
      U.removeItem(t)
      ad:say(U.name(ad, M.user) .. " stole and ate its target's " .. U.itemName(item) .. "!")
      U.eatBerry(ad, M.user, item)
    end
  end }
  S.PLUCK = S.BUG_BITE
  S.INCINERATE = { after = function(M)
    local t, ad = M.target, M.adapter
    if landed(M) and t and (t.substituteHP or 0) <= 0 and U.isBerry(U.item(t)) then
      local item = U.removeItem(t)
      ad:say(U.name(ad, t) .. "'s " .. U.itemName(item) .. " was burned up!")
    end
  end }
  S.BURN_UP = {
    pre = function(M, failFn) if not U.hasType(M.user, T.FIRE) then return fail(M, failFn) end end,
    after = function(M)
      local u = M.user
      if not landed(M) then return end
      if u.type1 == T.FIRE then u.type1 = (u.type2 ~= T.FIRE and u.type2) or 9 end
      if u.type2 == T.FIRE then u.type2 = u.type1 end
      if u.campaignType3 == T.FIRE then u.campaignType3 = nil end
      M.adapter:say(U.name(M.adapter, u) .. " burned itself out!")
    end,
  }
  S.BURNING_JEALOUSY = { after = function(M)
    if landed(M) and targetAlive(M) and F.statsChangedThisTurn(M.adapter, M.target, 1) then
      Secondary.set(M, "BURN", false, true)
    end
  end }
  S.FLAME_BURST = { after = function(M)
    local ad = M.adapter
    local p = M.target and U.partner(ad, M.target)
    if landed(M) and p then
      ad:applyHpLoss(p, math.max(1, math.floor(ad:maxHp(p) / 16)))
      ad:say("The bursting flame hit " .. U.name(ad, p) .. "!")
    end
  end }
  S.MIND_BLOWN = { after = function(M)
    local ad = M.adapter
    if M.campaignMindBlown then return end
    M.campaignMindBlown = true
    if ad:abilityOf(M.user) ~= "DAMP" then
      ad:applyHpLoss(M.user, math.max(1, math.floor((ad:maxHp(M.user) + 1) / 2)))
      M.checkUserFaint = true
    end
  end }
  S.STEEL_BEAM = { after = function(M)
    local ad = M.adapter
    if M.campaignSteelBeam then return end
    M.campaignSteelBeam = true
    ad:applyHpLoss(M.user, math.max(1, math.floor((ad:maxHp(M.user) + 1) / 2)))
    M.checkUserFaint = true
  end }
  S.BRAVE_BIRD = { after = recoil(1 / 3) }
  S.WOOD_HAMMER = S.BRAVE_BIRD
  S.FLARE_BLITZ = { after = chain(statusChance("BURN"), recoil(1 / 3)) }
  S.HEAD_SMASH = { after = recoil(1 / 2) }
  S.LIGHT_OF_RUIN = S.HEAD_SMASH
  local function fang(kind)
    return { after = function(M)
      if not landed(M) or not targetAlive(M) then return end
      if chance(M, 10) then Secondary.set(M, kind, false, false) end
      if targetAlive(M) and chance(M, 10) then Secondary.set(M, "FLINCH", false, false) end
    end }
  end
  S.FIRE_FANG, S.ICE_FANG, S.THUNDER_FANG = fang("BURN"), fang("FREEZE"), fang("PARALYSIS")
  S.SCALD = { base = "THAW_HIT" }
  S.STEAM_ERUPTION, S.SCORCHING_SANDS = S.SCALD, S.SCALD
  S.RELIC_SONG = { after = statusChance("SLEEP") }
  S.SPARKLING_ARIA = { after = function(M)
    if landed(M) and targetAlive(M) and M.adapter:status(M.target) == "BRN" then
      M.adapter:clearStatus(M.target)
      M.adapter:say(U.name(M.adapter, M.target) .. "'s burn was healed!")
    end
  end }
  S.FREEZE_SHOCK = { base = "RAZOR_WIND", after = statusChance("PARALYSIS") }
  S.ICE_BURN = { base = "RAZOR_WIND", after = statusChance("BURN") }
  S.METEOR_BEAM = { base = "RAZOR_WIND", charge = { spAtk = 1 } }
  S.PHANTOM_FORCE = { base = "SEMI_INVULNERABLE", vanish = "PHANTOM", bypassProtect = true }
  S.SHADOW_FORCE = S.PHANTOM_FORCE
  S.THROAT_CHOP = { after = function(M) if landed(M) and targetAlive(M) then M.target.campaignThroatChop = 2 end end }
  S.JAW_LOCK = { after = function(M)
    if landed(M) and targetAlive(M) and U.alive(M.adapter, M.user) then
      U.trap(M.user, M.target); U.trap(M.target, M.user)
      M.adapter:say("Neither Pokémon can run away!")
    end
  end }
  local function noEscape(M)
    if landed(M) and targetAlive(M) and not M.target.expTrapped then
      U.trap(M.target, M.user)
      M.adapter:say(U.name(M.adapter, M.target) .. " can no longer escape!")
    end
  end
  S.ANCHOR_SHOT, S.SPIRIT_SHACKLE, S.THOUSAND_WAVES = { after = noEscape }, { after = noEscape }, { after = noEscape }
  S.CORE_ENFORCER = { after = function(M)
    if landed(M) and targetAlive(M) and U.movedThisTurn(M.adapter, M.target) then
      M.target.campaignAbilitySuppressed = true
      M.adapter:say(U.name(M.adapter, M.target) .. "'s Ability was suppressed!")
    end
  end }
  S.EERIE_SPELL = { after = function(M)
    local t = M.target
    if not landed(M) or not targetAlive(M) then return end
    local last = tonumber(t.lastMoveId or t.lastMove)
    local mon = t.mon or {}
    for i = 1, 4 do
      if last and tonumber(mon.moves and mon.moves[i]) == last and (mon.pp[i] or 0) > 0 then
        mon.pp[i] = math.max(0, mon.pp[i] - 3)
        M.adapter:say("It reduced the PP of " .. U.name(M.adapter, t) .. "'s move!")
        return
      end
    end
  end }
  S.POLLEN_PUFF = {
    pre = function(M)
      local t = M.target
      if t and t ~= M.user and t.side == M.user.side then
        if not U.healBlocked(t) and U.heal(M.adapter, t, M.adapter:maxHp(t) / 2) > 0 then
          M.adapter:say(U.name(M.adapter, t) .. "'s HP was restored.")
        else
          M.adapter:sayFail()
        end
        M.noEffect = true
        return true
      end
    end,
  }
  S.PLASMA_FISTS = { after = function(M) F.field(M.st).ionDeluge = true; M.adapter:say("A deluge of ions showers the battlefield!") end }
  -- the Let's Go partner moves
  S.BADDY_BAD = { after = function(M)
    local side = M.adapter:ownSide(M.user)
    if landed(M) and side and (side.expReflectTurns or 0) <= 0 then
      side.expReflectTurns = 5
      M.adapter:say("Reflect made " .. (M.user.side == "player" and "your team" or "the opposing team") .. " stronger against physical moves!")
    end
  end }
  S.GLITZY_GLOW = { after = function(M)
    local side = M.adapter:ownSide(M.user)
    if landed(M) and side and (side.expLightScreenTurns or 0) <= 0 then
      side.expLightScreenTurns = 5
      M.adapter:say("Light Screen made " .. (M.user.side == "player" and "your team" or "the opposing team") .. " stronger against special moves!")
    end
  end }
  S.FREEZY_FROST = { after = function(M)
    if not landed(M) then return end
    for _, b in ipairs(U.all(M.adapter)) do for k in pairs(b.stages or {}) do b.stages[k] = 0 end end
    M.adapter:sayText("STRINGID_STATCHANGESGONE")
  end }
  S.SAPPY_SEED = { after = function(M)
    local t = M.target
    if landed(M) and targetAlive(M) and not t.leechSeed and not U.hasType(t, T.GRASS) then
      t.expSeeded, t.leechSeed, t.expSeedSource = true, true, M.user
      M.adapter:sayText("STRINGID_PKMNSEEDED", { def = t })
    end
  end }
  S.SPARKLY_SWIRL = { after = function(M)
    if not landed(M) then return end
    local party = M.user.side == "player" and M.st.playerParty or M.st.foeParty
    for _, mon in ipairs(party or {}) do if (tonumber(mon.hp) or 0) > 0 then mon.status = nil end end
    for _, b in ipairs(U.all(M.adapter)) do if b.side == M.user.side and M.adapter:status(b) then M.adapter:clearStatus(b) end end
    M.adapter:sayText("STRINGID_PKMNSTATUSNORMAL", { atk = M.user })
  end }

  -- switching ---------------------------------------------------------------
  S.U_TURN = { afterFaint = function(M) if landed(M) then F.switchOut(M, M.user) end end }
  S.VOLT_SWITCH, S.FLIP_TURN = S.U_TURN, S.U_TURN
  S.DRAGON_TAIL = { afterFaint = function(M)
    if landed(M) and targetAlive(M) and (M.target.substituteHP or 0) <= 0 then F.dragOut(M, M.target) end
  end }
  S.CIRCLE_THROW = S.DRAGON_TAIL

  -- trapping moves keep the native TRAP effect, with the donor's text
  local TRAP_TEXT = {
    INFESTATION = "{def} has been afflicted with an infestation by {atk}!",
    MAGMA_STORM = "{def} became trapped by swirling magma!",
    SNAP_TRAP = "{def} got trapped by a snap trap!",
    THUNDER_CAGE = "{atk} trapped {def}!",
  }
  for symbol, text in pairs(TRAP_TEXT) do
    S[symbol] = { base = "TRAP", trapText = text }
  end

  S.BULLDOZE = { base = "SPEED_DOWN_HIT" }
  -- held plates, memories and drives set the type (Normal without one)
  local function itemType(kind)
    return { calc = function(M)
      local row = U.itemRow(U.item(M.user))
      local f = row and row.sourceFields
      if f and f.holdEffect == kind and f.secondaryId then
        return { moveType = T[f.secondaryId:gsub("^TYPE_", "")] }
      end
    end }
  end
  S.JUDGMENT = itemType("HOLD_EFFECT_PLATE")
  S.MULTI_ATTACK = itemType("HOLD_EFFECT_MEMORY")
  S.TECHNO_BLAST = itemType("HOLD_EFFECT_DRIVE")
  S.REVELATION_DANCE = { calc = function(M) local t1 = U.types(M.user); return { moveType = t1 } end }
  -- Grassy Glide's priority in Grassy Terrain is read by the turn-order hook
  S.GRASSY_GLIDE = { grassyGlide = true }
  -- The donor leaves these as "not done yet"; the campaign gives them their
  -- core behaviour: Beak Blast burns attackers that touch the heating user
  -- before it moves (field.lua), Shell Trap fires only after a physical hit
  S.BEAK_BLAST = { beakBlast = true }
  S.SHELL_TRAP = { pre = function(M, failFn)
    local u = M.user
    local by = u.lastPhysicalById and State.battler(M.st, u.lastPhysicalById)
    if not (F.hurtThisTurn(M.adapter, u) and (u.lastPhysicalDamageTaken or 0) > 0 and by and by.side ~= u.side) then
      M.adapter:say(U.name(M.adapter, u) .. "'s shell trap didn't work!")
      return fail(M, failFn)
    end
  end }

  S.SKY_DROP = {
    base = "SEMI_INVULNERABLE",
    -- the carried target is in the air too: the drop hits it there
    pre = function(M) M.ignoreOnAir = true end,
    afterFaint = function(M) F.skyDropRelease(M.target) end,
  }

  S.STATUS_ARG = STATUS_ARG
  return S
end
