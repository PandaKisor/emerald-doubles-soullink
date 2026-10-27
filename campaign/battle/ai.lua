-- Trainer AI for the campaign's doubles: picks each foe's move and target by
-- scoring every usable move against every target with the real damage
-- formula (Inclement types, items and abilities included), instead of Gen 3's
-- ROM scripts, which know neither the expanded moves nor doubles.
--   * damage: share of the target's HP, KOs first, accuracy, priority when
--     it matters; spread moves count every foe hit and pay for hitting the
--     partner; immunities and absorbing abilities are avoided (or used, when
--     the partner absorbs its own team's spread move)
--   * the two foes coordinate: the second picks knowing the first's plan, so
--     it finishes what the first leaves and doesn't overkill
--   * status moves by role: Protect when threatened, Fake Out, speed control
--     (Tailwind, Trick Room, paralysis), sleep and burns, setup when safe,
--     healing, screens, weather/terrain for the team, hazards, Helping Hand,
--     redirection, Taunt/Encore/Haze when they pay off
--   * switching: a foe leaves a lost matchup (no real damage to deal while
--     it can be knocked out) or a Perish count, for the party member that
--     matches up best; replacements after a faint are picked the same way.
--     Linked co-op battles keep replacements but make no voluntary switches.
--   * AI partners on the player's side (Steven's multi battle) use it too
--   * trainer items (the trainer's ROM bag): a heal is spent when a foe could
--     knock the Pokémon out this turn and the heal lets it live through that
--     hit, or when it is nearly fainted and safe (not at Gen 3's fixed "below
--     a quarter"); cures and X items are Gen 3's picks, declined on a Pokémon
--     that drops this turn; burns are cured for physical attackers, poison
--     while there's HP worth saving, X items on a safe turn only
-- Wild Pokémon keep Gen 3's random moves.
-- Every choice draws only from the battle's AI RNG and walks tables in fixed
-- order, so linked co-op games pick the same action.
return function(mod, U, F)
  local Ai = require("src.core.game3.battle.ai")
  local State = require("src.core.game3.battle.state")
  local Moves = require("src.core.game3.battle.moves")
  local Damage = require("src.core.game3.battle.damage")
  local Engine = require("src.core.game3.battle.engine")
  local Rules = require("src.core.game3.battle.rules")
  local E = require("src.core.game3.battle.effect_ids")
  local T = U.TYPE
  local AI = {}
  local data = U.data
  local MOVE_ID = data.identity.namespaces.moves
  local TARGET = { SELECTED = 0, DEPENDS = 1, RANDOM = 4, BOTH = 8, USER = 16, FOES_AND_ALLY = 32, OPPONENTS_FIELD = 64 }

  local function AB() return F.abilities end
  local function key(ad, b) return AB() and AB().key(ad, b) end
  local function alive(ad, b) return U.alive(ad, b) end
  local function hpOf(ad, b) return ad:hp(b) end
  local function frac(ad, b) return ad:hp(b) / math.max(1, ad:maxHp(b)) end
  local function sym(rec) return tostring(rec and rec.id or ""):upper() end
  local function damaging(rec) return (tonumber(rec and rec.power) or 0) > 0 end
  local function eff(rec) return tonumber(rec and rec.effect) end
  local function isA(rec, ...)
    local e = eff(rec)
    for _, n in ipairs({ ... }) do if E[n] and e == E[n] then return true end end
    return false
  end
  local function named(rec, ...)
    local s = sym(rec)
    for _, n in ipairs({ ... }) do if s == n then return true end end
    return false
  end

  -- the move's type as the user would use it (-ate abilities, Normalize, ...)
  local function moveTypeOf(ad, user, rec)
    local probe = { adapter = ad, user = user, move = rec, mnum = tonumber(rec.numId), moveType = tonumber(rec.type), opts = {} }
    local ate = user.campaignAteBoost
    if AB() then AB().moveType(probe) end
    local boosted = user.campaignAteBoost
    user.campaignAteBoost = ate
    return tonumber(probe.moveType) or tonumber(rec.type) or 0, boosted
  end

  -- abilities that take a move of this type instead of being hit by it
  local ABSORB = { VOLT_ABSORB = T.ELECTRIC, MOTOR_DRIVE = T.ELECTRIC, LIGHTNING_ROD = T.ELECTRIC,
    WATER_ABSORB = T.WATER, STORM_DRAIN = T.WATER, DRY_SKIN = T.WATER, SAP_SIPPER = T.GRASS, FLASH_FIRE = T.FIRE }
  local function absorbs(ad, user, target, mt)
    local k = key(ad, target)
    if not k or not ABSORB[k] or ABSORB[k] ~= mt then return false end
    local uk = key(ad, user)
    return not (uk == "MOLD_BREAKER" or uk == "TERAVOLT" or uk == "TURBOBLAZE")
  end
  local function moldBreaks(ad, user)
    local uk = key(ad, user)
    return uk == "MOLD_BREAKER" or uk == "TERAVOLT" or uk == "TURBOBLAZE"
  end

  -- would this move be stopped outright (Bulletproof, Telepathy, Prankster
  -- into Dark, Psychic Terrain, Queenly Majesty, powder into Grass, ...)
  local function blocked(ad, user, target, rec)
    if not F.blocked then return false end
    local M = { move = rec, user = user, target = target, adapter = ad, moveName = "", st = ad._st, opts = {} }
    local prevMold = ad._campaignMold
    if moldBreaks(ad, user) then ad._campaignMold = user end
    local ok, why = pcall(F.blocked, M)
    ad._campaignMold = prevMold
    return ok and why ~= nil
  end

  local function hitsOf(ad, user, rec)
    local h = rec.hits
    local skill = key(ad, user) == "SKILL_LINK"
    if type(h) == "table" then return skill and h[2] or (h[1] + h[2]) / 2 + 0.1 end
    if type(h) == "number" then return h end
    if isA(rec, "MULTI_HIT") then return skill and 5 or 3.1 end
    if isA(rec, "DOUBLE_HIT", "TWINEEDLE") then return 2 end
    if isA(rec, "TRIPLE_KICK") then return 2.5 end
    return 1
  end

  -- expected damage of one use (average roll, no crit)
  local function estimate(ad, st, user, target, rec, spread)
    if not damaging(rec) or not alive(ad, target) then return 0 end
    local mt, boosted = moveTypeOf(ad, user, rec)
    if absorbs(ad, user, target, mt) then return 0, "absorb" end
    if blocked(ad, user, target, rec) then return 0, "blocked" end
    if mt == T.GROUND and ad:abilityOf(target) == "LEVITATE" and not moldBreaks(ad, user) then return 0, "immune" end
    local side = ad:ownSide(target)
    local saveGem, saveAte, saveMold = user.campaignGemUsed, user.campaignAteBoost, ad._campaignMold
    user.campaignAteBoost = boosted
    if moldBreaks(ad, user) then ad._campaignMold = user end
    local ok, dmg, info = pcall(Damage.calc, user, target, rec, {
      adapter = ad, weather = Rules.weather.effective(st, ad), forceRoll = 92, forceCrit = false,
      magnitudeRoll = 50, psywaveRoll = 5, moveType = mt ~= tonumber(rec.type) and mt or nil,
      reflect = side and ((side.expReflectTurns or 0) > 0 or (side.campaignAuroraVeil or 0) > 0),
      lightScreen = side and ((side.expLightScreenTurns or 0) > 0 or (side.campaignAuroraVeil or 0) > 0),
      doubleScreens = st.double, spread = spread, rng = function(lo) return lo or 0 end,
    })
    user.campaignGemUsed, user.campaignAteBoost, ad._campaignMold = saveGem, saveAte, saveMold
    if not ok or type(dmg) ~= "number" then return 0, "error" end
    info = info or {}
    if info.failed or (info.effectiveness or 1) == 0 then return 0, "immune" end
    if ad:abilityOf(target) == "WONDER_GUARD" and (info.effectiveness or 1) <= 1 and not moldBreaks(ad, user) then return 0, "immune" end
    return dmg * hitsOf(ad, user, rec), nil, info
  end
  AI.estimate = estimate

  local function accuracy(ad, user, target, rec)
    local acc = tonumber(rec.accuracy) or 100
    if acc <= 0 or acc > 100 then return 1 end
    if key(ad, user) == "NO_GUARD" or (target and key(ad, target) == "NO_GUARD") then return 1 end
    local buff = U.stage(user, "accuracy") - (target and U.stage(target, "evasion") or 0)
    if buff < -6 then buff = -6 elseif buff > 6 then buff = 6 end
    local ratio = Rules.ACCURACY_STAGE and Rules.ACCURACY_STAGE[buff]
    if ratio then acc = acc * ratio[1] / ratio[2] end
    if key(ad, user) == "COMPOUND_EYES" then acc = acc * 1.3 end
    if key(ad, user) == "HUSTLE" and rec.category == "physical" then acc = acc * 0.8 end
    return math.min(1, acc / 100)
  end

  -- does `a` using `rec` act before `b` (assumed using an ordinary move)
  local function movesFirst(ad, st, a, rec, b)
    local pa = AB() and AB().priority(ad, a, rec) or (tonumber(rec.priority) or 0)
    if pa ~= 0 then return pa > 0 end
    local sa, sb = U.speed(ad, a), U.speed(ad, b)
    local tr = st.campaignField and (st.campaignField.trickRoom or 0) > 0
    if tr then return sa < sb end
    return sa > sb
  end

  local function usableMoves(ad, b)
    local mon = b.mon or {}
    local okL, bad = pcall(Engine.moveLimitations, b, ad)
    bad = okL and bad or {}
    -- Choice items and Gorilla Tactics hold the user to its first move
    local held = U.held and U.held(b)
    local locked = b.choicedMove and (held == "CHOICE_BAND" or held == "CHOICE_SCARF" or held == "CHOICE_SPECS"
      or key(ad, b) == "GORILLA_TACTICS") and b.choicedMove
    local out = {}
    for i = 1, 4 do
      local mv = mon.moves and mon.moves[i]
      local rec = mv and mv ~= 0 and Moves.get(mv)
      if rec and not bad[i] and (not locked or tonumber(rec.numId) == tonumber(locked)) then
        out[#out + 1] = { slot = i, move = mv, rec = rec }
      end
    end
    return out
  end

  -- the most damage any foe of `b` could do to it this turn, and whether one
  -- of them would knock it out before it moves
  local function threat(ad, st, b, myRec)
    local worst, koFirst, ko = 0, false, false
    for _, f in ipairs(U.foes(ad, b)) do
      for _, m in ipairs(usableMoves(ad, f)) do
        if damaging(m.rec) and tonumber(m.rec.target) ~= TARGET.USER then
          local d = estimate(ad, st, f, b, m.rec, false)
          d = d * accuracy(ad, f, b, m.rec)
          if d > worst then worst = d end
          if d >= hpOf(ad, b) then
            ko = true
            if not myRec or not movesFirst(ad, st, b, myRec, f) then koFirst = true end
          end
        end
      end
    end
    return worst, ko, koFirst
  end

  -- this turn's plans of the AI-run battlers (coordination) -----------------------
  local function plans(st)
    if not st.campaignAiPlan or st.campaignAiPlan.turn ~= st.turn then st.campaignAiPlan = { turn = st.turn, damage = {}, moves = {} } end
    return st.campaignAiPlan
  end

  -- damaging moves --------------------------------------------------------------------
  -- how dangerous a target is to the AI's side this turn: the largest share of
  -- an AI-side Pokémon's HP it can take, and whether it knocks one out first
  local function danger(ad, st, target, plan)
    plan.danger = plan.danger or {}
    local tid = State.idOf(target)
    local c = plan.danger[tid]
    if c then return c[1], c[2] end
    local worst, koFirst = 0, false
    for _, mine in ipairs(U.foes(ad, target)) do
      for _, m in ipairs(usableMoves(ad, target)) do
        if damaging(m.rec) and tonumber(m.rec.target) ~= TARGET.USER then
          local d = estimate(ad, st, target, mine, m.rec, false) * accuracy(ad, target, mine, m.rec)
          local share = d / math.max(1, hpOf(ad, mine))
          if share > worst then worst = share end
          if d >= hpOf(ad, mine) and movesFirst(ad, st, target, m.rec, mine) then koFirst = true end
        end
      end
    end
    plan.danger[tid] = { worst, koFirst }
    return worst, koFirst
  end
  AI.danger = danger
  local SELF_KO = { EXPLOSION = true, MEMENTO = true }
  local function hitScore(ad, st, user, target, rec, spread, plan)
    local d, why = estimate(ad, st, user, target, rec, spread)
    if d <= 0 then return why == "absorb" and -60 or -30, 0 end
    local hp = hpOf(ad, target)
    local planned = plan.damage[State.idOf(target)] or 0
    local acc = accuracy(ad, user, target, rec)
    -- read-ahead: a threatened target with Protect that didn't protect last
    -- turn may protect now
    if (target.expProtectStreak or 0) == 0 and d >= hp - planned then
      for _, m in ipairs(usableMoves(ad, target)) do
        local ts = sym(m.rec)
        if eff(m.rec) == E.PROTECT or ts == "KINGS_SHIELD" or ts == "SPIKY_SHIELD" or ts == "BANEFUL_BUNKER" or ts == "OBSTRUCT" then
          acc = acc * 0.8
          break
        end
      end
    end
    local score
    if planned >= hp then
      -- the partner is already knocking it out
      score = math.min(100, d / math.max(1, hp) * 100) * 0.2
    else
      local left = hp - planned
      score = math.min(100, d / math.max(1, left) * 100) * acc
      if d >= left then
        score = score + 45 * acc
        if movesFirst(ad, st, user, rec, target) then score = score + 15 end
        if planned > 0 then score = score + 10 end
        local pr = AB() and AB().priority(ad, user, rec) or 0
        if pr > 0 and not movesFirst(ad, st, user, { priority = 0, numId = rec.numId }, target) then score = score + 20 end
      end
      -- focus the foe that hurts the team most, most of all one that would
      -- knock out an AI Pokémon before it moves
      if score > 0 then
        local share, first = danger(ad, st, target, plan)
        score = score + math.min(1, share) * 15 + (first and 12 or 0)
      end
    end
    return score, d * acc
  end

  local function damagingScore(ad, st, user, rec, tid, plan)
    local tgt = tonumber(rec.target) or 0
    local foes = U.foes(ad, user)
    local partner = U.partner(ad, user)
    local s, detail, expect = 0, nil, {}
    if tgt == TARGET.BOTH or tgt == TARGET.FOES_AND_ALLY or tgt == TARGET.OPPONENTS_FIELD then
      local spread = st.double and #foes > 1 and tgt == TARGET.BOTH
      for _, f in ipairs(foes) do
        local sc, d = hitScore(ad, st, user, f, rec, spread, plan)
        s = s + sc
        expect[State.idOf(f)] = d
      end
      if tgt == TARGET.FOES_AND_ALLY and partner then
        local d, why = estimate(ad, st, user, partner, rec, false)
        if why == "absorb" then
          s = s + 15
        elseif d > 0 then
          local pct = d / math.max(1, hpOf(ad, partner)) * 100
          s = s - pct * 1.5
          if d >= hpOf(ad, partner) then s = s - 150 end
        end
      end
      detail = "spread"
    else
      local target = State.battler(st, tid)
      if not target or target.side == user.side then return -100 end
      s, expect[tid] = hitScore(ad, st, user, target, rec, false, plan)
    end
    -- move-specific adjustments
    local e = eff(rec)
    if e == E.FAKE_OUT then
      local target = State.battler(st, tid)
      if (user.isFirstTurn or 0) > 0 and target and key(ad, target) ~= "INNER_FOCUS" and s > -30 then s = s + 70
      else s = -100 end
    elseif SELF_KO[sym(rec)] or e == E.EXPLOSION then
      if frac(ad, user) > 0.3 then s = s - 80 end
    elseif e == E.RECHARGE then
      s = s - 25
    elseif e == E.FOCUS_PUNCH then
      s = s - 40
    elseif (e == E.SOLAR_BEAM or e == E.SKULL_BASH or e == E.SKY_ATTACK or e == E.RAZOR_WIND)
        and not (U.held and U.held(user) == "POWER_HERB")
        and not (e == E.SOLAR_BEAM and Rules.weather.effective(st, ad) == "SUN") then
      s = s - 30
    elseif e == E.SPEED_DOWN_HIT and st.double and tgt == TARGET.BOTH then
      s = s + 10
    end
    if named(rec, "ICY_WIND", "ELECTROWEB", "SNARL", "STRUGGLE_BUG", "BREAKING_SWIPE") then s = s + 8 end
    return s, expect
  end

  -- status moves ------------------------------------------------------------------------
  local PROTECTS = { PROTECT = true, DETECT = true, KINGS_SHIELD = true, SPIKY_SHIELD = true, BANEFUL_BUNKER = true,
    OBSTRUCT = true }
  local HEALS = { RESTORE_HP = true, SOFTBOILED = true, MORNING_SUN = true, SYNTHESIS = true, MOONLIGHT = true }
  local WEATHER = { RAIN_DANCE = "RAIN", SUNNY_DAY = "SUN", SANDSTORM = "SAND", HAIL = "HAIL" }
  local WEATHER_FANS = {
    RAIN = { abilities = { SWIFT_SWIM = 1, RAIN_DISH = 1, DRY_SKIN = 1, HYDRATION = 1 }, type = T.WATER },
    SUN = { abilities = { CHLOROPHYLL = 1, SOLAR_POWER = 1, FLOWER_GIFT = 1, LEAF_GUARD = 1 }, type = T.FIRE },
    SAND = { abilities = { SAND_RUSH = 1, SAND_FORCE = 1, SAND_VEIL = 1 }, type = T.ROCK },
    HAIL = { abilities = { SLUSH_RUSH = 1, ICE_BODY = 1, SNOW_CLOAK = 1 }, type = T.ICE },
  }
  local TERRAINS = { ELECTRIC_TERRAIN = "ELECTRIC", GRASSY_TERRAIN = "GRASSY", MISTY_TERRAIN = "MISTY", PSYCHIC_TERRAIN = "PSYCHIC" }
  local TERRAIN_TYPE = { ELECTRIC = T.ELECTRIC, GRASSY = T.GRASS, PSYCHIC = T.PSYCHIC, MISTY = T.FAIRY }
  local HAZARDS = { SPIKES = "spikes", TOXIC_SPIKES = "campaignToxicSpikes", STEALTH_ROCK = "campaignStealthRock",
    STICKY_WEB = "campaignStickyWeb" }

  local function hasAttack(ad, b)
    for _, m in ipairs(usableMoves(ad, b)) do if damaging(m.rec) then return true end end
    return false
  end
  local function teamUses(ad, b, fans)
    for _, x in ipairs({ b, U.partner(ad, b) }) do
      if x then
        if fans.abilities[key(ad, x) or ""] then return true end
        for _, m in ipairs(usableMoves(ad, x)) do
          if damaging(m.rec) and tonumber(m.rec.type) == fans.type then return true end
        end
      end
    end
    return false
  end
  local function boostsSum(b)
    local n = 0
    for _, s in ipairs({ "attack", "defense", "speed", "spAtk", "spDef", "accuracy", "evasion" }) do n = n + math.max(0, U.stage(b, s)) end
    return n
  end
  local function canStatus(ad, target, kind, user)
    if not target or ad:status(target) then return false end
    local ok, r = pcall(ad.canApplyStatus, ad, target, kind, user)
    if not ok or r == false then return false end
    local side = ad:ownSide(target)
    if side and (side.expSafeguardTurns or 0) > 0 then return false end
    return true
  end
  local function physicalAttacker(b)
    local m = b.mon or {}
    return (tonumber(m.attack) or 0) >= (tonumber(m.spAtk) or 0)
  end

  local function nativeStatusScore(ad, st, user, rec, tid, plan, ctx)
    local s = sym(rec)
    local e = eff(rec)
    local target = tid and State.battler(st, tid)
    local foeTarget = target and target.side ~= user.side and alive(ad, target)
    local partner = U.partner(ad, user)
    local userSide = ad:ownSide(user)
    local foeSide = ad:foeSide(user)
    if foeTarget and blocked(ad, user, target, rec) then return -40 end
    local acc = foeTarget and accuracy(ad, user, target, rec) or 1
    -- Protect and its kin
    if PROTECTS[s] or e == E.PROTECT then
      if (user.expProtectStreak or 0) > 0 or (plan.moves[State.idOf(user)] == "protect") then return -60 end
      local sc = 8
      if ctx.koFirst and partner and hasAttack(ad, partner) then sc = sc + 55 end
      if (key(ad, user) == "SPEED_BOOST" or key(ad, user) == "MOODY") and (user.isFirstTurn or 0) > 0 then sc = sc + 30 end
      for _, f in ipairs(U.foes(ad, user)) do
        for _, m in ipairs(usableMoves(ad, f)) do
          if eff(m.rec) == E.FAKE_OUT and (f.isFirstTurn or 0) > 0 then sc = sc + 25 end
        end
      end
      return sc
    end
    if e == E.ENDURE then return (ctx.koFirst and frac(ad, user) > 0.9) and 20 or -20 end
    -- self stat boosts
    local change = E.STAT_CHANGES and E.STAT_CHANGES[e]
    if change and change.self or isA(rec, "BELLY_DRUM") then
      if ctx.ko or frac(ad, user) < 0.6 then return 0 end
      local gain, offense = 0, false
      for stat, d in pairs(change and change.stages or { attack = 6 }) do
        if d > 0 and U.stage(user, stat) < 4 then
          gain = gain + d
          if stat == "attack" or stat == "spAtk" or stat == "speed" then offense = true end
        end
      end
      if gain == 0 then return -20 end
      if isA(rec, "BELLY_DRUM") and frac(ad, user) <= 0.55 then return -50 end
      local sc = 25 + gain * 8
      if offense and not hasAttack(ad, user) then sc = 5 end
      if not offense then sc = sc - 10 end
      if key(ad, user) == "CONTRARY" then sc = -40 end
      return sc
    end
    -- lowering a foe's stats
    if change and not change.self then
      if not foeTarget then return 0 end
      if key(ad, target) == "CONTRARY" or key(ad, target) == "DEFIANT" or key(ad, target) == "COMPETITIVE"
          or key(ad, target) == "CLEAR_BODY" or key(ad, target) == "MIRROR_ARMOR" then return -30 end
      local sc = 12
      if tonumber(rec.target) == TARGET.BOTH then sc = sc + 10 end
      for stat in pairs(change.stages or {}) do
        if stat == "speed" and not movesFirst(ad, st, user, { priority = 0 }, target) then sc = sc + 15 end
      end
      return sc * acc
    end
    -- speed control
    if s == "TAILWIND" then
      return (userSide and (userSide.campaignTailwind or 0) > 0) and -50 or 60
    end
    if s == "TRICK_ROOM" then
      if plan.moves.trickRoom then return -80 end
      local tr = st.campaignField and (st.campaignField.trickRoom or 0) > 0
      local mine, theirs = 0, 0
      for _, x in ipairs({ user, partner }) do if x then mine = mine + U.speed(ad, x) end end
      for _, f in ipairs(U.foes(ad, user)) do theirs = theirs + U.speed(ad, f) end
      local slower = mine < theirs
      if tr then return slower and -80 or 50 end
      return slower and 80 or -40
    end
    if e == E.PARALYZE then
      if not foeTarget or not canStatus(ad, target, "PAR", user) then return -30 end
      if s == "THUNDER_WAVE" and U.effectiveness(T.ELECTRIC, target) == 0 then return -30 end
      local faster = not movesFirst(ad, st, user, { priority = 0 }, target)
      return (faster and 55 or 30) * acc
    end
    if e == E.SLEEP or e == E.YAWN then
      if not foeTarget or not canStatus(ad, target, "SLP", user) or target.expYawnTurns then return -30 end
      for _, f in ipairs(U.foes(ad, user)) do if ad:status(f) == "SLP" and e ~= E.YAWN then return 15 * acc end end
      return (e == E.YAWN and 35 or 70) * acc
    end
    if e == E.WILL_O_WISP then
      if not foeTarget or not canStatus(ad, target, "BRN", user) then return -30 end
      return (physicalAttacker(target) and 60 or 25) * acc
    end
    if e == E.TOXIC or e == E.POISON then
      if not foeTarget or not canStatus(ad, target, e == E.TOXIC and "TOX" or "PSN", user) then return -30 end
      return (frac(ad, target) > 0.6 and 40 or 20) * acc
    end
    if e == E.CONFUSE or e == E.SWAGGER or e == E.FLATTER or e == E.TEETER_DANCE then
      if not foeTarget or (target.confusionTurns or 0) > 0 or key(ad, target) == "OWN_TEMPO" then return -20 end
      return 18 * acc
    end
    if e == E.LEECH_SEED then
      if not foeTarget or target.expSeeded or U.hasType(target, T.GRASS) then return -30 end
      return 35 * acc
    end
    if e == E.SUBSTITUTE then
      return ((user.substituteHP or 0) <= 0 and frac(ad, user) > 0.5 and not ctx.ko) and 30 or -40
    end
    -- healing
    if HEALS[s] or HEALS[s:gsub("^MOVE_", "")] or isA(rec, "RESTORE_HP", "SOFTBOILED", "MORNING_SUN", "SYNTHESIS", "MOONLIGHT")
        or named(rec, "ROOST", "SLACK_OFF", "MILK_DRINK", "HEAL_ORDER", "SHORE_UP", "RECOVER") then
      local f = frac(ad, user)
      if U.healBlocked(user) then return -50 end
      if f < 0.3 then return 90 elseif f < 0.5 then return 70 elseif f < 0.7 then return 30 end
      return -30
    end
    if e == E.REST then
      local f = frac(ad, user)
      return (f < 0.35 and not ad:status(user)) and 60 or ((ad:status(user) and f < 0.6) and 45 or -40)
    end
    if e == E.WISH then return (frac(ad, user) < 0.6 or (partner and frac(ad, partner) < 0.5)) and 40 or 0 end
    -- screens
    if e == E.REFLECT then return (userSide and (userSide.expReflectTurns or 0) > 0) and -50 or 45 end
    if e == E.LIGHT_SCREEN then return (userSide and (userSide.expLightScreenTurns or 0) > 0) and -50 or 45 end
    if s == "AURORA_VEIL" then
      if Rules.weather.effective(st, ad) ~= "HAIL" or (userSide and (userSide.campaignAuroraVeil or 0) > 0) then return -50 end
      return 65
    end
    -- weather and terrain for the team
    local w = WEATHER[s] or (e == E.RAIN_DANCE and "RAIN") or (e == E.SUNNY_DAY and "SUN") or (e == E.SANDSTORM and "SAND")
      or (e == E.HAIL and "HAIL")
    if w then
      if Rules.weather.kind(st.weather) == w then return -50 end
      return teamUses(ad, user, WEATHER_FANS[w]) and 55 or 10
    end
    if TERRAINS[s] then
      if F.terrain(st) == TERRAINS[s] then return -50 end
      return teamUses(ad, user, { abilities = {}, type = TERRAIN_TYPE[TERRAINS[s]] }) and 45 or 10
    end
    -- hazards
    if HAZARDS[s] then
      if not foeSide then return 0 end
      local have = foeSide[HAZARDS[s]]
      if s == "SPIKES" then have = (foeSide.hazards and #foeSide.hazards > 0) or nil end
      if have then return -40 end
      local left = 0
      for _, mon in ipairs(user.side == "enemy" and (st.playerParty or {}) or (st.foeParty or {})) do
        if (tonumber(mon.hp) or 0) > 0 then left = left + 1 end
      end
      return left >= 3 and 45 or 5
    end
    -- support
    if e == E.HELPING_HAND then
      if not partner or plan.moves[State.idOf(partner)] == "protect" then return -60 end
      return (hasAttack(ad, partner) and ctx.bestDamage < 45) and 45 or 10
    end
    if e == E.FOLLOW_ME or s == "RAGE_POWDER" then
      if not partner then return -60 end
      if frac(ad, partner) < 0.4 or plan.moves[State.idOf(partner)] == "setup" then return 55 end
      return 12
    end
    if e == E.TAUNT then
      if not foeTarget or (target.expTauntedTurns or 0) > 0 then return -30 end
      local statusMoves = 0
      for _, m in ipairs(usableMoves(ad, target)) do if not damaging(m.rec) then statusMoves = statusMoves + 1 end end
      return statusMoves >= 2 and 45 or 5
    end
    if e == E.ENCORE then
      if not foeTarget or (target.expEncoreTurns or 0) > 0 then return -30 end
      local last = target.lastMoveId and Moves.get(target.lastMoveId)
      return (last and not damaging(last)) and 50 or -10
    end
    if e == E.HAZE or s == "CLEAR_SMOG" then
      local foes = 0
      for _, f in ipairs(U.foes(ad, user)) do foes = foes + boostsSum(f) end
      return foes >= 2 and 60 or -30
    end
    if s == "WIDE_GUARD" then
      for _, f in ipairs(U.foes(ad, user)) do
        for _, m in ipairs(usableMoves(ad, f)) do
          if damaging(m.rec) and (tonumber(m.rec.target) == TARGET.BOTH or tonumber(m.rec.target) == TARGET.FOES_AND_ALLY) then return 35 end
        end
      end
      return -20
    end
    if e == E.MEMENTO then return frac(ad, user) < 0.25 and 45 or -50 end
    if e == E.DESTINY_BOND then return (ctx.koFirst and frac(ad, user) < 0.5) and 40 or -20 end
    if e == E.PERISH_SONG or e == E.BATON_PASS or e == E.TRANSFORM or e == E.SKETCH then return 0 end
    if e == E.SPLASH or e == E.TELEPORT then return -80 end
    return 15
  end

  -- self-boosting campaign moves (their effect runs through hooks, so the
  -- native effect id doesn't say what they raise)
  local SELF_BOOST = {
    HONE_CLAWS = { attack = 1, accuracy = 1 }, WORK_UP = { attack = 1, spAtk = 1 }, COIL = { attack = 1, defense = 1 },
    QUIVER_DANCE = { spAtk = 1, spDef = 1, speed = 1 }, SHIFT_GEAR = { attack = 1, speed = 2 }, COTTON_GUARD = { defense = 3 },
    SHELL_SMASH = { attack = 2, spAtk = 2, speed = 2 }, AUTOTOMIZE = { speed = 2 }, GEOMANCY = { spAtk = 2, spDef = 2, speed = 2 },
    NO_RETREAT = { attack = 1, defense = 1, spAtk = 1, spDef = 1, speed = 1 },
    CLANGOROUS_SOUL = { attack = 1, defense = 1, spAtk = 1, spDef = 1, speed = 1 },
    STUFF_CHEEKS = { defense = 2 }, ACUPRESSURE = { attack = 1 },
  }
  local function boostScore(ad, user, stages, ctx)
    if ctx.ko or frac(ad, user) < 0.6 then return 0 end
    local gain, offense = 0, false
    for _, stat in ipairs(U.STATS) do
      local d = stages[stat]
      if d and d > 0 and U.stage(user, stat) < 4 then
        gain = gain + d
        if stat == "attack" or stat == "spAtk" or stat == "speed" then offense = true end
      end
    end
    if gain == 0 then return -20 end
    local sc = 25 + gain * 8
    if offense and not hasAttack(ad, user) then sc = 5 end
    if not offense then sc = sc - 10 end
    if key(ad, user) == "CONTRARY" then sc = -40 end
    return sc
  end
  local function hasMoveType(ad, b, t)
    for _, m in ipairs(usableMoves(ad, b)) do if damaging(m.rec) and tonumber(m.rec.type) == t then return true end end
    return false
  end
  local function foesHaveType(ad, user, t)
    for _, f in ipairs(U.foes(ad, user)) do if hasMoveType(ad, f, t) then return true end end
    return false
  end
  local function teamStatused(st, user)
    local n = 0
    for _, mon in ipairs(user.side == "enemy" and (st.foeParty or {}) or (st.playerParty or {})) do
      if (tonumber(mon.hp) or 0) > 0 and mon.status and mon.status ~= 0 then n = n + 1 end
    end
    return n
  end
  local genderOf = require("src.core.game3.battle.abilities").genderOf
  local JUNK = { CHOICE_BAND = 1, CHOICE_SCARF = 1, CHOICE_SPECS = 1, TOXIC_ORB = 1, FLAME_ORB = 1, IRON_BALL = 1,
    LAGGING_TAIL = 1, STICKY_BARB = 1, RING_TARGET = 1 }
  local function heal(c)
    local f = frac(c.ad, c.user)
    if U.healBlocked(c.user) then return -50 end
    if f < 0.3 then return 90 elseif f < 0.5 then return 70 elseif f < 0.7 then return 30 end
    return -30
  end
  local function allyHeal(c)
    local p = c.target and c.target.side == c.user.side and c.target ~= c.user and c.target or c.partner
    if not p or U.healBlocked(p) then return -40 end
    local f = frac(c.ad, p)
    return f < 0.4 and 70 or (f < 0.6 and 35 or -30)
  end
  local function boostedTarget(c) return c.foeTarget and boostsSum(c.target) >= 2 end
  local function trick(c)
    local held = U.held and U.held(c.user)
    return (c.foeTarget and held and JUNK[held]) and 45 or -20
  end
  local function foresight(c)
    return (c.foeTarget and U.hasType(c.target, T.GHOST) and not c.target.expIdentified
      and (hasMoveType(c.ad, c.user, T.NORMAL) or hasMoveType(c.ad, c.user, T.FIGHTING))) and 30 or -20
  end
  local function const(n) return function() return n end end
  -- rules by move, for status moves the effect id can't describe
  local RULES = {
    -- healing
    ROOST = heal, SHORE_UP = heal, LIFE_DEW = heal, JUNGLE_HEALING = heal,
    STRENGTH_SAP = function(c) return c.foeTarget and (heal(c) + (physicalAttacker(c.target) and 15 or 0)) or -30 end,
    HEAL_PULSE = allyHeal, FLORAL_HEALING = allyHeal,
    PURIFY = function(c) return (c.foeTarget and c.ad:status(c.target) and frac(c.ad, c.user) < 0.6) and 50 or -20 end,
    AQUA_RING = function(c) return c.user.campaignAquaRing and -40 or 20 end,
    HEALING_WISH = function(c) return (frac(c.ad, c.user) < 0.25 and c.backups > 0) and 45 or -50 end,
    LUNAR_DANCE = function(c) return (frac(c.ad, c.user) < 0.25 and c.backups > 0) and 45 or -50 end,
    -- weakening foes
    NOBLE_ROAR = const(15), TEARFUL_LOOK = const(15), CAPTIVATE = const(5),
    VENOM_DRENCH = function(c)
      for _, f in ipairs(U.foes(c.ad, c.user)) do local s = c.ad:status(f) if s == "PSN" or s == "TOX" then return 45 end end
      return -20
    end,
    TOXIC_THREAD = function(c) return (c.foeTarget and canStatus(c.ad, c.target, "PSN", c.user)) and 35 or 5 end,
    TAR_SHOT = function(c)
      local fire = hasMoveType(c.ad, c.user, T.FIRE) or (c.partner and hasMoveType(c.ad, c.partner, T.FIRE))
      return (c.foeTarget and not c.target.campaignTarShot and fire) and 35 or 0
    end,
    PARTING_SHOT = function(c) return (c.ctx.ko and c.backups > 0) and 45 or 10 end,
    TOPSY_TURVY = function(c) return boostedTarget(c) and 55 or -30 end,
    PSYCHO_SHIFT = function(c) return (c.ad:status(c.user) and c.foeTarget and not c.ad:status(c.target)) and 50 or -40 end,
    GASTRO_ACID = function(c) return (c.foeTarget and not c.target.campaignAbilitySuppressed) and 20 or -30 end,
    WORRY_SEED = const(10), SIMPLE_BEAM = const(10), ENTRAINMENT = const(10),
    SOAK = function(c) return (c.foeTarget and not U.hasType(c.target, T.WATER)) and 15 or -30 end,
    TRICK_OR_TREAT = const(10), FORESTS_CURSE = const(10), MAGIC_POWDER = const(10),
    HEAL_BLOCK = const(10), EMBARGO = const(10), MIRACLE_EYE = const(5), TELEKINESIS = const(5),
    OCTOLOCK = function(c) return (c.foeTarget and not c.target.campaignOctolock) and 35 or -30 end,
    SPOTLIGHT = const(5), QUASH = const(10),
    POWDER = function(c) return (c.foeTarget and hasMoveType(c.ad, c.target, T.FIRE)) and 30 or -20 end,
    CORROSIVE_GAS = function(c) return (c.foeTarget and U.item(c.target) ~= 0) and 20 or -20 end,
    -- field
    GRAVITY = const(10), MAGIC_ROOM = const(5), WONDER_ROOM = const(5), FAIRY_LOCK = const(5),
    ION_DELUGE = const(5), ELECTRIFY = const(5), COURT_CHANGE = const(10), CRAFTY_SHIELD = const(10),
    LUCKY_CHANT = function(c) return (c.userSide and (c.userSide.campaignLuckyChant or 0) > 0) and -40 or 15 end,
    DEFOG = function(c)
      local side = c.userSide
      local mine = side and (side.campaignStealthRock or (side.campaignToxicSpikes or 0) > 0 or side.campaignStickyWeb
        or (side.hazards and #side.hazards > 0))
      return mine and 45 or -20
    end,
    MAT_BLOCK = function(c) return ((c.user.isFirstTurn or 0) > 0 and c.partner) and 40 or -60 end,
    MAGNET_RISE = function(c) return ((c.user.campaignMagnetRise or 0) <= 0 and foesHaveType(c.ad, c.user, T.GROUND)) and 35 or -20 end,
    -- support for the partner
    DECORATE = function(c) return (c.partner and hasAttack(c.ad, c.partner)) and 35 or -40 end,
    COACHING = function(c) return (c.partner and physicalAttacker(c.partner)) and 35 or -40 end,
    AROMATIC_MIST = function(c) return c.partner and 15 or -40 end,
    AFTER_YOU = function(c)
      local p = c.partner
      return (p and hasAttack(c.ad, p) and U.speed(c.ad, p) < U.speed(c.ad, c.user)) and 30 or 0
    end,
    INSTRUCT = function(c) return c.partner and 15 or -40 end,
    ALLY_SWITCH = function(c) return c.partner and 10 or -60 end,
    BESTOW = const(0), LASER_FOCUS = const(20), MAGNETIC_FLUX = const(0), GEAR_UP = const(0),
    FLOWER_SHIELD = const(5), ROTOTILLER = const(5), COPYCAT = const(15), ME_FIRST = const(10),
    GUARD_SWAP = const(5), POWER_SWAP = const(5), HEART_SWAP = function(c) return boostedTarget(c) and 45 or 0 end,
    GUARD_SPLIT = const(10), POWER_SPLIT = const(10), SPEED_SWAP = const(10), POWER_TRICK = const(5),
    REFLECT_TYPE = const(5), TEATIME = const(5),
    CELEBRATE = const(-80), HAPPY_HOUR = const(-80), HOLD_HANDS = const(-80),
    -- Gen 3 effects with no rule of their own
    BATON_PASS = function(c) return (boostsSum(c.user) >= 2 and c.backups > 0) and 45 or -20 end,
    TRICK = trick, SWITCHEROO = trick,
    PSYCH_UP = function(c) return boostedTarget(c) and 50 or -30 end,
    PAIN_SPLIT = function(c) return (c.foeTarget and c.ad:hp(c.target) > c.ad:hp(c.user) * 1.5) and 45 or -20 end,
    REFRESH = function(c) return c.ad:status(c.user) and 40 or -40 end,
    HEAL_BELL = function(c) return teamStatused(c.st, c.user) >= 1 and 45 or -40 end,
    AROMATHERAPY = function(c) return teamStatused(c.st, c.user) >= 1 and 45 or -40 end,
    NIGHTMARE = function(c) return (c.foeTarget and c.ad:status(c.target) == "SLP" and not c.target.expNightmare) and 35 or -30 end,
    ROAR = function(c) return boostedTarget(c) and 45 or 0 end,
    WHIRLWIND = function(c) return boostedTarget(c) and 45 or 0 end,
    DISABLE = function(c)
      local last = c.foeTarget and c.target.lastMoveId and Moves.get(c.target.lastMoveId)
      return (last and damaging(last) and not c.target.expDisabledMove) and 30 or -10
    end,
    CHARGE = function(c) return (hasMoveType(c.ad, c.user, T.ELECTRIC) and not c.user.expCharged) and 25 or -20 end,
    CURSE = function(c)
      if U.hasType(c.user, T.GHOST) then return (c.foeTarget and not c.target.expCursed and frac(c.ad, c.user) > 0.6) and 30 or -30 end
      return boostScore(c.ad, c.user, { attack = 1, defense = 1 }, c.ctx)
    end,
    SAFEGUARD = function(c) return (c.userSide and (c.userSide.expSafeguardTurns or 0) > 0) and -40 or 15 end,
    ATTRACT = function(c)
      if not c.foeTarget or c.target.expInfatuated then return -30 end
      local a, b = genderOf(c.user), genderOf(c.target)
      return (a ~= "U" and b ~= "U" and a ~= b) and 25 or -40
    end,
    STOCKPILE = function(c) return ((c.user.expStockpile or 0) < 3 and frac(c.ad, c.user) > 0.6) and 20 or -20 end,
    SWALLOW = function(c) return ((c.user.expStockpile or 0) > 0 and frac(c.ad, c.user) < 0.5) and 50 or -40 end,
    INGRAIN = function(c) return c.user.expIngrain and -40 or 15 end,
    FORESIGHT = foresight, ODOR_SLEUTH = foresight,
    MINIMIZE = function(c) return boostScore(c.ad, c.user, { evasion = 2 }, c.ctx) - 10 end,
    DEFENSE_CURL = const(5), MUD_SPORT = const(5), WATER_SPORT = const(5), MAGIC_COAT = const(10), SNATCH = const(5),
    IMPRISON = const(5), GRUDGE = const(5), MEAN_LOOK = const(5), BLOCK = const(5), LOCK_ON = const(5),
    MIND_READER = const(5), SKETCH = const(0), CONVERSION = const(5), CONVERSION_2 = const(5), CAMOUFLAGE = const(5),
    MIMIC = const(5), SKILL_SWAP = const(10), ROLE_PLAY = const(10),
    RECYCLE = function(c) return (U.item(c.user) == 0 and c.user.expUsedHeldItem) and 30 or -30 end,
    FOCUS_ENERGY = function(c) return (c.user.focusEnergy or c.user.expFocusEnergy) and -30 or 10 end,
    MIST = const(5), PERISH_SONG = function(c) return c.backups > 0 and 10 or -40 end,
    TORMENT = const(10), SPITE = const(5), TRANSFORM = const(10),
  }
  AI.RULES, AI.SELF_BOOST = RULES, SELF_BOOST

  local function statusScore(ad, st, user, rec, tid, plan, ctx)
    local s = sym(rec)
    if SELF_BOOST[s] then return boostScore(ad, user, SELF_BOOST[s], ctx) end
    local rule = RULES[s]
    if not rule then return nativeStatusScore(ad, st, user, rec, tid, plan, ctx) end
    local target = tid and State.battler(st, tid)
    local foeTarget = target and target.side ~= user.side and alive(ad, target) or false
    if foeTarget and blocked(ad, user, target, rec) then return -40 end
    local okC, cands = pcall(Engine.switchCandidates, st, st.double and State.idOf(user) or user.side)
    return rule({ ad = ad, st = st, user = user, target = target, foeTarget = foeTarget, partner = U.partner(ad, user),
      ctx = ctx, userSide = ad:ownSide(user), backups = okC and #cands or 0, plan = plan })
  end

  -- targets a move could be aimed at
  local ALLY_TARGET = { HEAL_PULSE = true, FLORAL_HEALING = true, DECORATE = true, INSTRUCT = true, AFTER_YOU = true }
  local function targetsFor(ad, st, user, rec)
    local tgt = tonumber(rec.target) or 0
    if ALLY_TARGET[sym(rec)] then
      local p = U.partner(ad, user)
      return { p and State.idOf(p) or false }
    end
    if tgt == TARGET.USER or tgt == TARGET.BOTH or tgt == TARGET.FOES_AND_ALLY or tgt == TARGET.OPPONENTS_FIELD then
      return { false }
    end
    local out = {}
    for _, f in ipairs(U.foes(ad, user)) do out[#out + 1] = State.idOf(f) end
    if #out == 0 then out[1] = false end
    return out
  end
  -- the target byte the action carries
  local function actionTarget(st, user, rec, tid)
    local tgt = tonumber(rec.target) or 0
    local id = State.idOf(user)
    if tgt == TARGET.USER then return id end
    if tid then return tid end
    local foeLeft = (id % 2 == 1) and 0 or 1
    if st.double and State.isAbsent(st, foeLeft) then foeLeft = foeLeft + 2 end
    return st.double and foeLeft or State.OPPOSITE(id)
  end

  local function roll(rng, lo, hi)
    if type(rng) == "function" then
      local ok, v = pcall(rng, lo, hi)
      if ok and type(v) == "number" then return lo + (math.floor(v) - lo) % (hi - lo + 1) end
    end
    return lo
  end

  local hedge -- set after the switching helpers (below)
  function AI.choose(st, id, opts)
    local ad = require("src.core.game3.battle")._adapter
    local user = State.battler(st, id)
    if not ad or not user or not alive(ad, user) then return nil end
    local moves = usableMoves(ad, user)
    if #moves == 0 then return nil end
    local plan = plans(st)
    local rng = (opts and opts.rng) or st.rng or ad:rng()
    local _, ko, koFirst = threat(ad, st, user, nil)
    local ctx = { ko = ko, koFirst = koFirst, bestDamage = 0 }
    -- damaging moves first: their best score informs support moves
    local options = {}
    for _, m in ipairs(moves) do
      if damaging(m.rec) then
        for _, tid in ipairs(targetsFor(ad, st, user, m.rec)) do
          local score, expect = damagingScore(ad, st, user, m.rec, tid or nil, plan)
          if score > ctx.bestDamage then ctx.bestDamage = score end
          options[#options + 1] = { m = m, tid = tid or nil, score = score, expect = expect }
        end
      end
    end
    for _, m in ipairs(moves) do
      if not damaging(m.rec) then
        for _, tid in ipairs(targetsFor(ad, st, user, m.rec)) do
          options[#options + 1] = { m = m, tid = tid or nil, score = statusScore(ad, st, user, m.rec, tid or nil, plan, ctx) }
        end
      end
    end
    -- a little spread so near-equal choices vary
    local best, bestScore
    for _, o in ipairs(options) do
      o.final = o.score + roll(rng, 0, 6)
      if not bestScore or o.final > bestScore then best, bestScore = o, o.final end
    end
    if not best then return nil end
    if hedge then
      local okH, alt = pcall(hedge, ad, st, user, options, best)
      if okH and alt then best = alt end
    end
    -- record the plan for the partner's turn
    for tid, d in pairs(best.expect or {}) do plan.damage[tid] = (plan.damage[tid] or 0) + d end
    local rec = best.m.rec
    local s = sym(rec)
    if PROTECTS[s] or eff(rec) == E.PROTECT then plan.moves[id] = "protect"
    elseif s == "TRICK_ROOM" then plan.moves.trickRoom = true
    elseif E.STAT_CHANGES and E.STAT_CHANGES[eff(rec)] and E.STAT_CHANGES[eff(rec)].self then plan.moves[id] = "setup" end
    AI.picks = (AI.picks or 0) + 1
    if AI.debug then
      local parts = {}
      for _, o in ipairs(options) do
        parts[#parts + 1] = ("%s->%s=%.0f"):format(sym(o.m.rec), tostring(o.tid), o.score)
      end
      print(("[g3_campaign/ai] %d %s picks %s->%s | %s"):format(id, tostring(user.species), s, tostring(best.tid),
        table.concat(parts, " ")))
    end
    return { kind = "move", move = best.m.move, slot = best.m.slot, user = user.side == "player" and "player" or "enemy",
      battler = id, target = actionTarget(st, user, rec, best.tid), scores = { 0, 0, 0, 0 } }
  end

  -- switching ------------------------------------------------------------------------------
  -- how a Pokémon (in battle, or a stand-in for a party member) fares
  -- against the foes on the field: best share of a foe's HP it can take,
  -- worst share of its own HP a foe can take
  local function standIn(st, side, slot, id)
    local party = side == "player" and st.playerParty or st.foeParty
    local mon = party and party[slot]
    if not mon or (tonumber(mon.hp) or 0) <= 0 then return nil end
    local ok, b = pcall(State.makeBattler, mon, side, { partyIndex = slot, id = id, st = st })
    return ok and b or nil
  end
  local function matchup(ad, st, b)
    local offense, defense = 0, 0
    local hp = math.max(1, tonumber(b.mon and b.mon.hp) or 1)
    for _, f in ipairs(U.foes(ad, b)) do
      for _, m in ipairs(usableMoves(ad, b)) do
        if damaging(m.rec) then
          local d = estimate(ad, st, b, f, m.rec, false) * accuracy(ad, b, f, m.rec)
          offense = math.max(offense, math.min(100, d / math.max(1, ad:hp(f)) * 100))
        end
      end
      for _, m in ipairs(usableMoves(ad, f)) do
        if damaging(m.rec) and tonumber(m.rec.target) ~= TARGET.USER then
          local d = estimate(ad, st, f, b, m.rec, false) * accuracy(ad, f, b, m.rec)
          defense = math.max(defense, math.min(100, d / hp * 100))
        end
      end
    end
    return offense - defense * 0.8, offense, defense
  end
  AI.matchup = matchup
  local function trapped(ad, b)
    if b.expTrapped or b.escapePrevention or (b.expTrapTurns or 0) > 0 or b.expIngrain then return true end
    local ok, holder = pcall(require("src.core.game3.battle.abilities").escapeBlocker, ad, b)
    return ok and holder ~= nil
  end
  -- a player Pokémon in a matchup it is losing may switch out: don't spend
  -- the turn on a move its bench is immune to when another move does nearly
  -- as well and still lands on that bench Pokémon
  hedge = function(ad, st, user, options, best)
    local rec = best.m.rec
    local target = best.tid and State.battler(st, best.tid)
    if not (damaging(rec) and target and target.side ~= user.side and alive(ad, target)) then return nil end
    if (tonumber(rec.target) or 0) ~= TARGET.SELECTED or trapped(ad, target) then return nil end
    local share = danger(ad, st, target, plans(st))
    local hit = (best.expect and best.expect[best.tid]) or 0
    if share >= 0.3 or hit < hpOf(ad, target) * 0.5 then return nil end
    local ok, cands = pcall(Engine.switchCandidates, st, st.double and best.tid or target.side)
    if not ok then return nil end
    local immune = {}
    for _, slot in ipairs(cands or {}) do
      local view = standIn(st, target.side, slot, best.tid)
      if view and estimate(ad, st, user, view, rec, false) <= 0 then immune[#immune + 1] = view end
    end
    if #immune == 0 then return nil end
    local pick
    for _, o in ipairs(options) do
      if o ~= best and o.m.move ~= best.m.move and damaging(o.m.rec) and o.score >= best.score * 0.7
          and (not pick or o.score > pick.score) then
        local lands = true
        for _, view in ipairs(immune) do
          if estimate(ad, st, user, view, o.m.rec, false) <= 0 then lands = false break end
        end
        if lands then pick = o end
      end
    end
    return pick
  end
  -- the best party member to send in at position id (nil: none)
  local function bestReplacement(ad, st, id)
    local b = State.battler(st, id)
    local side = b and b.side or State.sideOf(id)
    local ok, cands = pcall(Engine.switchCandidates, st, st.double and id or side)
    if not ok then return nil end
    local best, bestScore
    for _, slot in ipairs(cands or {}) do
      local taken = false
      for other, pend in pairs(st.monToSwitchInto or {}) do if other ~= id and pend == slot then taken = true end end
      local view = not taken and standIn(st, side, slot, id)
      if view then
        local score = matchup(ad, st, view)
        if not bestScore or score > bestScore then best, bestScore = slot, score end
      end
    end
    return best, bestScore
  end
  AI.bestReplacement = bestReplacement
  local function campaignSeat(st, id)
    if not F.active() or not st or st.wild then return false end
    local b = State.battler(st, id)
    if not b then return false end
    if b.side == "enemy" then return true end
    local Kinds = require("src.core.game3.battle.kinds")
    return Kinds.controllerOf(st, id) == "aiPartner"
  end
  local AiSwitch = require("src.core.game3.battle.ai_switch")
  local trySwitch = AiSwitch.trySwitch
  AiSwitch.trySwitch = function(st, ad, id, rng, ...)
    if not campaignSeat(st, id) then return trySwitch(st, ad, id, rng, ...) end
    -- linked co-op battles: no voluntary switches. A foe seat's switch
    -- crosses the link as a slot in that seat's own party while the host
    -- picks from the combined party, which deadlocks the two games
    -- (replacements after a faint have their own path and stay)
    if st.link or st.coopTeam then return nil end
    ad = ad or require("src.core.game3.battle")._adapter
    local b = State.battler(st, id)
    if not ad or not b or not alive(ad, b) or trapped(ad, b) then return nil end
    if b.expLockedMove or b.expMustRecharge or b.twoTurnMove then return nil end
    -- a fresh switch-in stays at least a turn
    if b.campaignEnteredTurn and st.turn and st.turn - b.campaignEnteredTurn < 1 then return nil end
    local ok, pick, pickScore = pcall(bestReplacement, ad, st, id)
    if not ok or not pick then return nil end
    if b.expPerishTurns == 1 then return pick end
    local score, offense = matchup(ad, st, b)
    local _, ko = threat(ad, st, b, nil)
    local lost = offense < 25 and ko
    local drained = (U.stage(b, "attack") <= -2 and physicalAttacker(b)) or (U.stage(b, "spAtk") <= -2 and not physicalAttacker(b))
    if (lost and pickScore > score + 40) or (drained and pickScore > score + 20) then
      if roll(rng or st.rng, 0, 99) < 85 then return pick end
    end
    return nil
  end
  local mostSuitable = Engine.mostSuitableMon
  Engine.mostSuitableMon = function(st, ad, side, ...)
    local id = (type(side) == "number") and side or State.idOf(side)
    if id ~= nil and campaignSeat(st, id) then
      if st.monToSwitchInto and st.monToSwitchInto[id] then return st.monToSwitchInto[id] end
      local ok, pick = pcall(bestReplacement, ad or require("src.core.game3.battle")._adapter, st, id)
      if ok and pick then return pick end
    end
    return mostSuitable(st, ad, side, ...)
  end

  -- trainer items ---------------------------------------------------------------------
  local AiItems = require("src.core.game3.battle.ai_items")
  local KIND = AiItems.TYPE
  local shouldUseItem = AiItems.shouldUseItem
  -- Inclement's item rows (full/inventory.lua answers ItemsData.info) carry no
  -- Gen 3 effect bytes, so on the campaign the ROM's effect table was never
  -- reached and trainers never used their bag. Healing, cure and X items keep
  -- their vanilla ids: read their effect from the ROM's own item table.
  local effect = AiItems.effect
  AiItems.effect = function(item)
    local e = effect(item)
    if e or not F.active() then return e end
    local ItemsData = require("src.core.game3.items_data")
    local native = ItemsData._inclementInventory and ItemsData._inclementInventory.originals.info
    if not native then return nil end
    local current = ItemsData.info
    ItemsData.info = native
    local ok, out = pcall(effect, item)
    ItemsData.info = current
    return ok and out or nil
  end
  -- HP the item would restore (Full Restore and HEAL_HP_FULL: everything)
  local function healAmount(ad, b, item, kind)
    local maxHp = ad:maxHp(b)
    if kind == KIND.FULL_RESTORE then return maxHp end
    local e = AiItems.effect(item)
    local p = e and AiItems.hpParam(e) or 0
    if p == AiItems.HEAL_HP_FULL then return maxHp end
    if p == AiItems.HEAL_HP_HALF then return math.floor(maxHp / 2) end
    if p == AiItems.HEAL_HP_LVL_UP then return 0 end
    return p
  end
  -- a heal is worth it when it lets the Pokémon live through the hit that
  -- would knock it out this turn, or when it is nearly fainted and safe
  local function healWorth(ad, st, b, item, kind)
    local hp, maxHp = hpOf(ad, b), math.max(1, ad:maxHp(b))
    if hp >= maxHp then return false end
    local after = math.min(maxHp, hp + healAmount(ad, b, item, kind))
    local worst, ko = threat(ad, st, b, nil)
    if ko then return after > worst end
    return hp / maxHp < 0.2 and after - hp >= maxHp * 0.25
  end
  -- the other items Gen 3's AI picks: never on a Pokémon that drops this turn
  function AI.itemWorth(ad, st, id, use)
    local b = State.battler(st, id)
    if not (ad and b and alive(ad, b)) then return true end
    local kind, item = use.aiItemType, use.item
    if kind == KIND.FULL_RESTORE or kind == KIND.HEAL_HP then return healWorth(ad, st, b, item, kind) end
    local hp, maxHp = hpOf(ad, b), math.max(1, ad:maxHp(b))
    local worst, ko = threat(ad, st, b, nil)
    if ko then return false end
    if kind == KIND.CURE_CONDITION then
      local s = AiItems.statusName(b)
      if s == "SLP" or s == "FRZ" or s == "PAR" then return true end
      if s == "BRN" then return physicalAttacker(b) or hp / maxHp > 0.5 end
      if s == "TOX" then return hp / maxHp > 0.35 end
      if s == "PSN" then return hp / maxHp > 0.5 end
      return (tonumber(b.confusionTurns) or 0) > 0
    end
    if kind == KIND.X_STAT or kind == KIND.GUARD_SPECS then return hp / maxHp > 0.5 and worst < hp * 0.6 end
    return true
  end
  local function pick(st, id, ...)
    local ad = require("src.core.game3.battle")._adapter
    local b = State.battler(st, id)
    if not (ad and b and alive(ad, b)) then return shouldUseItem(st, id, ...) end
    local bag = AiItems.history(st).items
    -- heals: the campaign's own rule, whatever Gen 3's HP threshold says
    for i = 1, 4 do
      local item = bag[i] or 0
      local e = item ~= 0 and AiItems.effect(item) or nil
      local kind = e and AiItems.itemType(item, e)
      if (kind == KIND.FULL_RESTORE or kind == KIND.HEAL_HP) and healWorth(ad, st, b, item, kind) then
        bag[i] = 0
        st.aiItemType, st.aiItemFlags = st.aiItemType or {}, st.aiItemFlags or {}
        st.aiItemType[id], st.aiItemFlags[id] = kind, 0
        return { item = item, aiItemType = kind, aiItemFlags = 0 }
      end
    end
    -- cures and X items: Gen 3 picks, the campaign may decline. Gen 3 takes
    -- the item out of the bag as it picks it: put it back when declined
    local before = { bag[1], bag[2], bag[3], bag[4] }
    local use = shouldUseItem(st, id, ...)
    if use and AI.itemWorth(ad, st, id, use) then return use end
    for i = 1, 4 do bag[i] = before[i] end
    return nil
  end
  AiItems.shouldUseItem = function(st, id, ...)
    if not campaignSeat(st, id) then return shouldUseItem(st, id, ...) end
    local ok, use = pcall(pick, st, id, ...)
    if not ok then print("[g3_campaign/ai] item: " .. tostring(use)) return nil end
    return use
  end

  local choose = Ai.chooseAction
  Ai.chooseAction = function(st, id, opts, ...)
    local act = choose(st, id, opts, ...)
    if not F.active() or not st or st.wild or not act or act.kind ~= "move" then return act end
    local b = State.battler(st, id)
    if not b or not campaignSeat(st, id) or b.expLockedMove or b.expMustRecharge or b.twoTurnMove
        or (b.expEncoreTurns or 0) > 0 then
      return act
    end
    local ok, mine = pcall(AI.choose, st, id, opts)
    if ok and mine then return mine end
    if not ok then print("[g3_campaign/ai] " .. tostring(mine)) end
    return act
  end

  return AI
end
