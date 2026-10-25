-- Expanded status moves. Each spec's `status(ctx, M)` runs in place of the
-- native status-effect dispatch once the attack string and PP are done:
-- ctx is the native effect context (adapter, user, target), M the move
-- context. `target` remaps a donor target the native picker lacks (ALLY,
-- ALL_BATTLERS) onto one it has. Numbers follow Inclement 1.13 (Gen 7).
return function(U, F)
  local State = require("src.core.game3.battle.state")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local Engine = require("src.core.game3.battle.engine")
  local Moves = require("src.core.game3.battle.moves")
  local T = U.TYPE
  local S = {}

  local function failed(ctx, M)
    M.failed = true
    ctx.adapter:sayFail()
  end
  local function hits(ctx, M)
    -- protection, Psychic Terrain and accuracy for moves aimed at a foe
    if ctx.target and ctx.target ~= ctx.user and M.accuracyCheck then
      return M:accuracyCheck("normal", true)
    end
    return true
  end
  local function anim(M) if M.attackAnimation then M:attackAnimation() end end
  local function boost(changes)
    return { target = "USER", status = function(ctx, M)
      if not U.changeStats(ctx.adapter, ctx.user, changes, { user = true }) then M.failed = true return end
      anim(M)
    end }
  end
  local function lower(changes, opts)
    opts = opts or {}
    return { status = function(ctx, M)
      local ad = ctx.adapter
      local targets = { ctx.target }
      if opts.both then targets = U.foes(ad, ctx.user) end
      local any = false
      for _, t in ipairs(targets) do
        M.target = t
        if U.alive(ad, t) and (not opts.filter or opts.filter(ad, ctx.user, t)) and hits(ctx, M)
            and not ((t.substituteHP or 0) > 0) then
          anim(M)
          if U.changeStats(ad, t, changes) then any = true end
          if opts.extra then opts.extra(ad, ctx.user, t, M) end
        end
      end
      if not any and opts.failIfNone then failed(ctx, M) end
    end }
  end
  local function healFraction(ad, b, num, den)
    if U.healBlocked(b) or ad:hp(b) >= ad:maxHp(b) then return false end
    U.heal(ad, b, ad:maxHp(b) * num / den)
    ad:sayText("STRINGID_PKMNREGAINEDHEALTH", { def = b })
    return true
  end

  -- stat boosts -------------------------------------------------------------
  S.HONE_CLAWS = boost({ attack = 1, accuracy = 1 })
  S.WORK_UP = boost({ attack = 1, spAtk = 1 })
  S.COIL = boost({ attack = 1, defense = 1, accuracy = 1 })
  S.QUIVER_DANCE = boost({ spAtk = 1, spDef = 1, speed = 1 })
  S.SHIFT_GEAR = boost({ attack = 1, speed = 2 })
  S.COTTON_GUARD = boost({ defense = 3 })
  S.SHELL_SMASH = { target = "USER", status = function(ctx, M)
    anim(M)
    U.changeStats(ctx.adapter, ctx.user, { defense = -1, spDef = -1 }, { user = true, certain = true })
    U.changeStats(ctx.adapter, ctx.user, { attack = 2, spAtk = 2, speed = 2 }, { user = true })
  end }
  S.AUTOTOMIZE = { target = "USER", status = function(ctx, M)
    if not U.changeStats(ctx.adapter, ctx.user, { speed = 2 }, { user = true }) then M.failed = true return end
    anim(M)
    ctx.user.campaignAutotomize = (ctx.user.campaignAutotomize or 0) + 1
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " became nimble!")
  end }
  S.NO_RETREAT = { target = "USER", status = function(ctx, M)
    if ctx.user.campaignNoRetreat then return failed(ctx, M) end
    anim(M)
    U.changeStats(ctx.adapter, ctx.user, { attack = 1, defense = 1, spAtk = 1, spDef = 1, speed = 1 }, { user = true })
    ctx.user.campaignNoRetreat = true
    U.trap(ctx.user, ctx.user)
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " can no longer escape because it used No Retreat!")
  end }
  S.CLANGOROUS_SOUL = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    local cost = math.floor(ad:maxHp(u) / 3)
    if ad:hp(u) <= cost then return failed(ctx, M) end
    anim(M)
    ad:applyHpLoss(u, cost)
    U.changeStats(ad, u, { attack = 1, defense = 1, spAtk = 1, spDef = 1, speed = 1 }, { user = true })
  end }
  S.GEOMANCY = { target = "USER", charge = true, status = function(ctx, M)
    anim(M)
    U.changeStats(ctx.adapter, ctx.user, { spAtk = 2, spDef = 2, speed = 2 }, { user = true })
  end }
  S.ACUPRESSURE = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    local open = {}
    for _, stat in ipairs(U.STATS) do if U.stage(u, stat) < 6 then open[#open + 1] = stat end end
    if #open == 0 then return failed(ctx, M) end
    anim(M)
    Secondary.changeStat(ad, u, open[ad:roll(1, #open)], 2, { user = true, allowPtr = true })
  end }
  S.STUFF_CHEEKS = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    local berry = U.item(u)
    if not U.isBerry(berry) then return failed(ctx, M) end
    anim(M)
    U.removeItem(u)
    U.eatBerry(ad, u, berry)
    Secondary.changeStat(ad, u, "defense", 2, { user = true, allowPtr = true })
  end }
  local function plusMinus(changes)
    return { target = "USER", status = function(ctx, M)
      local ad, any = ctx.adapter, false
      for _, b in ipairs({ ctx.user, U.partner(ad, ctx.user) }) do
        local ab = b and ad:abilityOf(b)
        if ab == "PLUS" or ab == "MINUS" then
          if not any then anim(M) end
          any = true
          U.changeStats(ad, b, changes)
        end
      end
      if not any then failed(ctx, M) end
    end }
  end
  S.MAGNETIC_FLUX = plusMinus({ defense = 1, spDef = 1 })
  S.GEAR_UP = plusMinus({ attack = 1, spAtk = 1 })
  S.COACHING = { target = "USER", status = function(ctx, M)
    local p = U.partner(ctx.adapter, ctx.user)
    if not p then return failed(ctx, M) end
    anim(M)
    U.changeStats(ctx.adapter, p, { attack = 1, defense = 1 })
  end }
  S.AROMATIC_MIST = { target = "USER", status = function(ctx, M)
    local p = U.partner(ctx.adapter, ctx.user)
    if not p or not U.changeStats(ctx.adapter, p, { spDef = 1 }) then return failed(ctx, M) end
    anim(M)
  end }
  S.DECORATE = { status = function(ctx, M)
    if not U.changeStats(ctx.adapter, ctx.target, { attack = 2, spAtk = 2 }) then return failed(ctx, M) end
    anim(M)
  end }
  local function typeBoost(kind, changes)
    return { target = "USER", status = function(ctx, M)
      local ad, any = ctx.adapter, false
      for _, b in ipairs(U.all(ad)) do
        if U.hasType(b, T.GRASS) and (kind ~= "ROTOTILLER" or U.grounded(ad, b)) and not b.semiInvulnerable then
          if not any then anim(M) end
          any = true
          U.changeStats(ad, b, changes)
        end
      end
      if not any then failed(ctx, M) end
    end }
  end
  S.FLOWER_SHIELD = typeBoost("FLOWER_SHIELD", { defense = 1 })
  S.ROTOTILLER = typeBoost("ROTOTILLER", { attack = 1, spAtk = 1 })
  S.LASER_FOCUS = { target = "USER", status = function(ctx, M)
    anim(M)
    ctx.user.campaignLaserFocus = 2
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " concentrated intensely!")
  end }

  -- stat drops on the target -------------------------------------------------
  S.NOBLE_ROAR = lower({ attack = -1, spAtk = -1 })
  S.TEARFUL_LOOK = S.NOBLE_ROAR
  S.CAPTIVATE = lower({ spAtk = -2 }, { both = true, failIfNone = true, filter = function(ad, u, t)
    local P = require("src.core.game3.pokemon")
    local gu = P.gender(u.species or P.speciesOf(u.mon), u.mon and u.mon.personality)
    local gt = P.gender(t.species or P.speciesOf(t.mon), t.mon and t.mon.personality)
    return gu ~= nil and gt ~= nil and gu ~= "N" and gt ~= "N" and gu ~= gt
  end })
  S.VENOM_DRENCH = lower({ attack = -1, spAtk = -1, speed = -1 }, { both = true, failIfNone = true,
    filter = function(ad, _, t) local s = ad:status(t); return s == "PSN" or s == "TOX" end })
  S.TOXIC_THREAD = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    if not hits(ctx, M) or (t.substituteHP or 0) > 0 then return end
    anim(M)
    local poisoned = false
    if ad:canApplyStatus(t, "PSN", ctx.user) then
      ad:applyStatus(t, "PSN", ctx.user)
      ad:statusAnim(t, "PSN")
      ad:sayText("STRINGID_PKMNWASPOISONED", { eff = t })
      poisoned = true
    end
    if not U.changeStats(ad, t, { speed = -1 }) and not poisoned then M.failed = true end
  end }
  S.TAR_SHOT = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    if not hits(ctx, M) or (t.substituteHP or 0) > 0 then return end
    anim(M)
    U.changeStats(ad, t, { speed = -1 })
    if not t.campaignTarShot then
      t.campaignTarShot = true
      ad:say(U.name(ad, t) .. " became weaker to fire!")
    end
  end }
  S.STRENGTH_SAP = { status = function(ctx, M)
    local ad, u, t = ctx.adapter, ctx.user, ctx.target
    if not hits(ctx, M) or U.stage(t, "attack") <= -6 then return failed(ctx, M) end
    local D = require("src.core.game3.battle.damage")
    local atk = D.applyStage(tonumber(t.mon and (t.mon.attack or t.mon.atk)) or 0, U.stage(t, "attack"))
    anim(M)
    U.changeStats(ad, t, { attack = -1 })
    if not U.healBlocked(u) and U.heal(ad, u, atk) > 0 then ad:sayText("STRINGID_PKMNREGAINEDHEALTH", { def = u }) end
  end }
  S.PARTING_SHOT = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    if not hits(ctx, M) then return end
    anim(M)
    local ok = (t.substituteHP or 0) <= 0 and U.changeStats(ad, t, { attack = -1, spAtk = -1 })
    if ok then F.switchOut(M, ctx.user) end
  end }

  -- healing -------------------------------------------------------------------
  S.ROOST = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    if not healFraction(ad, u, 1, 2) then return failed(ctx, M) end
    anim(M)
    if U.hasType(u, T.FLYING) then u.campaignRoosting = ad._st.turn end
  end }
  S.SHORE_UP = { target = "USER", status = function(ctx, M)
    local w = require("src.core.game3.battle.rules").weather.effective(ctx.adapter._st, ctx.adapter)
    if not healFraction(ctx.adapter, ctx.user, w == "SAND" and 2 or 1, w == "SAND" and 3 or 2) then return failed(ctx, M) end
    anim(M)
  end }
  S.HEAL_PULSE = { status = function(ctx, M)
    local t = ctx.target
    if (t.substituteHP or 0) > 0 or not healFraction(ctx.adapter, t, 1, 2) then return failed(ctx, M) end
    anim(M)
  end }
  S.FLORAL_HEALING = { status = function(ctx, M)
    local grassy = F.terrain(ctx.adapter._st) == "GRASSY"
    if (ctx.target.substituteHP or 0) > 0 or not healFraction(ctx.adapter, ctx.target, grassy and 2 or 1, grassy and 3 or 2) then
      return failed(ctx, M)
    end
    anim(M)
  end }
  local function teamHeal(cure)
    return { target = "USER", status = function(ctx, M)
      local ad, any = ctx.adapter, false
      for _, b in ipairs({ ctx.user, U.partner(ad, ctx.user) }) do
        if b then
          if healFraction(ad, b, 1, 4) then any = true end
          if cure and ad:status(b) then ad:clearStatus(b); any = true end
        end
      end
      if not any then return failed(ctx, M) end
      anim(M)
    end }
  end
  S.LIFE_DEW = teamHeal(false)
  S.JUNGLE_HEALING = teamHeal(true)
  S.PURIFY = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    if not ad:status(t) then return failed(ctx, M) end
    anim(M)
    ad:clearStatus(t)
    ad:say(U.name(ad, t) .. "'s status returned to normal!")
    healFraction(ad, ctx.user, 1, 2)
  end }
  S.AQUA_RING = { target = "USER", status = function(ctx, M)
    if ctx.user.campaignAquaRing then return failed(ctx, M) end
    anim(M)
    ctx.user.campaignAquaRing = true
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " surrounded itself with a veil of water!")
  end }
  local function healingWish(kind)
    return { target = "USER", status = function(ctx, M)
      local ad, u = ctx.adapter, ctx.user
      local candidates = Engine.switchCandidates(ad._st, ad._st.double and State.idOf(u) or u.side)
      if #candidates == 0 then return failed(ctx, M) end
      anim(M)
      ad:ownSide(u).campaignHealingWish = kind
      ad:setHp(u, 0)
      M.checkUserFaint = true
    end }
  end
  S.HEALING_WISH = healingWish("wish")
  S.LUNAR_DANCE = healingWish("lunar")

  -- swaps and splits --------------------------------------------------------
  local function swapStages(stats)
    return { status = function(ctx, M)
      local u, t = ctx.user, ctx.target
      anim(M)
      for _, s in ipairs(stats) do u.stages[s], t.stages[s] = U.stage(t, s), U.stage(u, s) end
      ctx.adapter:say(U.name(ctx.adapter, u) .. " switched stat changes with the target!")
    end }
  end
  S.GUARD_SWAP = swapStages({ "defense", "spDef" })
  S.POWER_SWAP = swapStages({ "attack", "spAtk" })
  S.HEART_SWAP = swapStages(U.STATS)
  local function split(a, b, text)
    return { status = function(ctx, M)
      local um, tm = ctx.user.mon, ctx.target.mon
      if not um or not tm then return failed(ctx, M) end
      anim(M)
      for _, s in ipairs({ a, b }) do
        local avg = math.floor(((tonumber(um[s]) or 0) + (tonumber(tm[s]) or 0)) / 2)
        um[s], tm[s] = avg, avg
      end
      ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. text)
    end }
  end
  S.GUARD_SPLIT = split("defense", "spDef", " shared its guard with the target!")
  S.POWER_SPLIT = split("attack", "spAtk", " shared its power with the target!")
  S.SPEED_SWAP = { status = function(ctx, M)
    local um, tm = ctx.user.mon, ctx.target.mon
    anim(M)
    um.speed, tm.speed = tm.speed, um.speed
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " switched Speed with its target!")
  end }
  S.POWER_TRICK = { target = "USER", status = function(ctx, M)
    local m = ctx.user.mon
    anim(M)
    m.attack, m.defense = m.defense, m.attack
    ctx.user.campaignPowerTrick = not ctx.user.campaignPowerTrick
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " switched its Attack and Defense!")
  end }
  S.TOPSY_TURVY = { status = function(ctx, M)
    local t, any = ctx.target, false
    if not hits(ctx, M) then return end
    for k, v in pairs(t.stages or {}) do if v ~= 0 then t.stages[k] = -v; any = true end end
    if not any then return failed(ctx, M) end
    anim(M)
    ctx.adapter:say("All stat changes on " .. U.name(ctx.adapter, t) .. " were inverted!")
  end }
  S.PSYCHO_SHIFT = { status = function(ctx, M)
    local ad, u, t = ctx.adapter, ctx.user, ctx.target
    local s = ad:status(u)
    if not s or not hits(ctx, M) or not ad:canApplyStatus(t, s, u) then return failed(ctx, M) end
    anim(M)
    ad:applyStatus(t, s, u)
    ad:statusAnim(t, s)
    ad:clearStatus(u)
    ad:say(U.name(ad, u) .. " shifted its status to " .. U.name(ad, t) .. "!")
  end }

  -- typing ------------------------------------------------------------------
  S.SOAK = { status = function(ctx, M)
    local t = ctx.target
    if not hits(ctx, M) or (t.type1 == T.WATER and t.type2 == T.WATER) then return failed(ctx, M) end
    anim(M)
    t.type1, t.type2, t.campaignType3 = T.WATER, T.WATER, nil
    ctx.adapter:say(U.name(ctx.adapter, t) .. " transformed into the Water type!")
  end }
  S.MAGIC_POWDER = { status = function(ctx, M)
    local t = ctx.target
    if not hits(ctx, M) or U.hasType(t, T.GRASS) or ctx.adapter:abilityOf(t) == "OVERCOAT" then return failed(ctx, M) end
    anim(M)
    t.type1, t.type2, t.campaignType3 = T.PSYCHIC, T.PSYCHIC, nil
    ctx.adapter:say(U.name(ctx.adapter, t) .. " transformed into the Psychic type!")
  end }
  local function thirdType(kind, label)
    return { status = function(ctx, M)
      local t = ctx.target
      if not hits(ctx, M) or U.hasType(t, kind) then return failed(ctx, M) end
      anim(M)
      t.campaignType3 = kind
      ctx.adapter:say(label:format(U.name(ctx.adapter, t)))
    end }
  end
  S.TRICK_OR_TREAT = thirdType(T.GHOST, "Ghost type was added to %s!")
  S.FORESTS_CURSE = thirdType(T.GRASS, "Grass type was added to %s!")
  S.REFLECT_TYPE = { status = function(ctx, M)
    local u, t = ctx.user, ctx.target
    anim(M)
    u.type1, u.type2, u.campaignType3 = t.type1, t.type2, t.campaignType3
    ctx.adapter:say(U.name(ctx.adapter, u) .. "'s type became the same as " .. U.name(ctx.adapter, t) .. "'s type!")
  end }
  S.ELECTRIFY = { status = function(ctx, M)
    if not hits(ctx, M) or U.movedThisTurn(ctx.adapter, ctx.target) then return failed(ctx, M) end
    anim(M)
    ctx.target.campaignElectrify = true
    ctx.adapter:say(U.name(ctx.adapter, ctx.target) .. "'s moves have been electrified!")
  end }
  S.ION_DELUGE = { target = "USER", status = function(ctx, M)
    anim(M)
    F.field(ctx.adapter._st).ionDeluge = true
    ctx.adapter:say("A deluge of ions showers the battlefield!")
  end }

  -- abilities ---------------------------------------------------------------
  local function setAbility(name, text)
    return { status = function(ctx, M)
      local ad, t = ctx.adapter, ctx.target
      if not hits(ctx, M) or ad:abilityOf(t) == name then return failed(ctx, M) end
      anim(M)
      t.campaignAbility = name
      ad:say(text:format(U.name(ad, t)))
    end }
  end
  S.SIMPLE_BEAM = setAbility("SIMPLE", "%s acquired Simple!")
  S.WORRY_SEED = setAbility("INSOMNIA", "%s acquired Insomnia!")
  S.ENTRAINMENT = { status = function(ctx, M)
    local ad, u, t = ctx.adapter, ctx.user, ctx.target
    local ab = ad:abilityOf(u)
    if not ab or not hits(ctx, M) or ad:abilityOf(t) == ab then return failed(ctx, M) end
    anim(M)
    t.campaignAbility = ab
    ad:say(U.name(ad, t) .. " acquired " .. ab:gsub("_", " "):lower():gsub("(%a)(%w*)", function(a, b) return a:upper() .. b end) .. "!")
  end }
  S.GASTRO_ACID = { status = function(ctx, M)
    local t = ctx.target
    if not hits(ctx, M) or t.campaignAbilitySuppressed then return failed(ctx, M) end
    anim(M)
    t.campaignAbilitySuppressed = true
    ctx.adapter:say(U.name(ctx.adapter, t) .. "'s Ability was suppressed!")
  end }

  -- field and side effects -----------------------------------------------------
  local function terrain(kind)
    return { target = "USER", status = function(ctx, M)
      if not F.setTerrain(ctx.adapter, kind, ctx.user) then return failed(ctx, M) end
      anim(M)
    end }
  end
  S.ELECTRIC_TERRAIN, S.GRASSY_TERRAIN = terrain("ELECTRIC"), terrain("GRASSY")
  S.MISTY_TERRAIN, S.PSYCHIC_TERRAIN = terrain("MISTY"), terrain("PSYCHIC")
  local function room(key, on, off, turns)
    return { target = "USER", status = function(ctx, M)
      local f = F.field(ctx.adapter._st)
      anim(M)
      if (f[key] or 0) > 0 then
        f[key] = nil
        ctx.adapter:say(off)
      else
        f[key] = turns or 5
        ctx.adapter:say(on:format(U.name(ctx.adapter, ctx.user)))
        if key == "trickRoom" and F.items then F.items.trickRoomSet(ctx.adapter) end
      end
    end }
  end
  S.TRICK_ROOM = room("trickRoom", "%s twisted the dimensions!", "The twisted dimensions returned to normal!")
  S.MAGIC_ROOM = room("magicRoom", "It created a bizarre area in which Pokémon's held items lose their effects!",
    "Magic Room wore off, and held items' effects returned to normal!")
  S.WONDER_ROOM = room("wonderRoom", "It created a bizarre area in which Defense and Sp. Def stats are swapped!",
    "Wonder Room wore off, and Defense and Sp. Def stats returned to normal!")
  S.GRAVITY = { target = "USER", status = function(ctx, M)
    local ad = ctx.adapter
    local f = F.field(ad._st)
    if (f.gravity or 0) > 0 then return failed(ctx, M) end
    anim(M)
    f.gravity = 5
    ad:say("Gravity intensified!")
    for _, b in ipairs(U.all(ad)) do
      if b.semiInvulnerable == "ON_AIR" then
        Engine.setSemiInvulnerable(b, nil)
        b.twoTurnMove, b.expLockedMove = nil, nil
      end
      b.campaignMagnetRise, b.campaignTelekinesis = nil, nil
    end
  end }
  S.FAIRY_LOCK = { target = "USER", status = function(ctx, M)
    local f = F.field(ctx.adapter._st)
    if f.fairyLock then return failed(ctx, M) end
    anim(M)
    f.fairyLock = 2
    ctx.adapter:say("No one will be able to run away during the next turn!")
  end }
  local function sideTimer(key, turns, text, cond)
    return { target = "USER", status = function(ctx, M)
      local ad = ctx.adapter
      local side = ad:ownSide(ctx.user)
      if not side or (side[key] or 0) > 0 or (cond and not cond(ad)) then return failed(ctx, M) end
      anim(M)
      side[key] = (key == "campaignAuroraVeil" and F.items and F.items.longScreens(ctx.user)) and 8 or turns
      ad:say(text(ad, ctx.user))
    end }
  end
  S.TAILWIND = sideTimer("campaignTailwind", 4, function(ad, u)
    return u.side == "player" and "The tailwind blew from behind your team!" or "The tailwind blew from behind the opposing team!"
  end)
  S.LUCKY_CHANT = sideTimer("campaignLuckyChant", 5, function(ad, u)
    return "Lucky Chant shielded " .. (u.side == "player" and "your team" or "the opposing team") .. " from critical hits!"
  end)
  S.AURORA_VEIL = sideTimer("campaignAuroraVeil", 5, function(ad, u)
    return "Aurora Veil made " .. (u.side == "player" and "your team" or "the opposing team") .. " stronger against physical and special moves!"
  end, function(ad) return require("src.core.game3.battle.rules").weather.effective(ad._st, ad) == "HAIL" end)
  local function hazard(set, text)
    return { target = "USER", status = function(ctx, M)
      local ad = ctx.adapter
      local side = ad:foeSide(ctx.user)
      if not side or not set(side) then return failed(ctx, M) end
      anim(M)
      ad:say(text(ctx.user))
    end }
  end
  local function foeTeam(u) return u.side == "player" and "the opposing team" or "your team" end
  S.STEALTH_ROCK = hazard(function(side)
    if side.campaignStealthRock then return false end
    side.campaignStealthRock = true
    return true
  end, function(u) return "Pointed stones float in the air around " .. foeTeam(u) .. "!" end)
  S.TOXIC_SPIKES = hazard(function(side)
    if (side.campaignToxicSpikes or 0) >= 2 then return false end
    side.campaignToxicSpikes = (side.campaignToxicSpikes or 0) + 1
    return true
  end, function(u) return "Poison spikes were scattered on the ground all around " .. foeTeam(u) .. "!" end)
  S.STICKY_WEB = hazard(function(side)
    if side.campaignStickyWeb then return false end
    side.campaignStickyWeb = true
    return true
  end, function(u) return "A sticky web has been laid out on the ground around " .. foeTeam(u) .. "!" end)
  S.DEFOG = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    if hits(ctx, M) and (t.substituteHP or 0) <= 0 then U.changeStats(ad, t, { evasion = -1 }) end
    anim(M)
    local Hazards = require("src.core.game3.battle.effects.hazards")
    for _, side in ipairs({ ad:ownSide(ctx.user), ad:foeSide(ctx.user) }) do
      side.campaignStealthRock, side.campaignToxicSpikes, side.campaignStickyWeb = nil, nil, nil
      Hazards.clear(side)
    end
    local foe = ad:foeSide(ctx.user)
    foe.expReflectTurns, foe.expLightScreenTurns, foe.expSafeguardTurns, foe.expMistTurns = nil, nil, nil, nil
    foe.campaignAuroraVeil = nil
    F.clearTerrain(ad)
  end }
  local function guard(key, text)
    return { target = "USER", status = function(ctx, M)
      local ad = ctx.adapter
      local side = ad:ownSide(ctx.user)
      if key == "campaignMatBlock" and ctx.user.campaignEnteredTurn ~= ad._st.turn and (ctx.user.isFirstTurn or 0) <= 0 then
        return failed(ctx, M)
      end
      if Engine.turnOrderNum and Engine.turnOrderNum(ad._st, State.idOf(ctx.user)) == (ad._st.double and 3 or 1) then
        return failed(ctx, M)
      end
      anim(M)
      side[key] = ad._st.turn
      ad:say(text(ctx.user))
    end }
  end
  S.WIDE_GUARD = guard("campaignWideGuard", function(u)
    return "Wide Guard protected " .. (u.side == "player" and "your team" or "the opposing team") .. "!" end)
  S.CRAFTY_SHIELD = guard("campaignCraftyShield", function(u)
    return "Crafty Shield protected " .. (u.side == "player" and "your team" or "the opposing team") .. "!" end)
  S.MAT_BLOCK = guard("campaignMatBlock", function(u)
    return U.name(require("src.core.game3.battle")._adapter, u) .. " intends to flip up a mat and block incoming attacks!" end)

  -- shields: Protect plus a contact punishment (field.lua F.protected)
  local function shield(kind)
    return { base = "PROTECT", shield = kind }
  end
  S.SPIKY_SHIELD, S.KINGS_SHIELD = shield("SPIKY"), shield("KINGS")
  S.BANEFUL_BUNKER, S.OBSTRUCT = shield("BANEFUL"), shield("OBSTRUCT")

  -- battler conditions -------------------------------------------------------
  local function condition(key, turns, text, check)
    return { status = function(ctx, M)
      local ad, t = ctx.adapter, ctx.target
      if (t[key] or 0) > 0 or (check and not check(ad, t)) or not hits(ctx, M) then return failed(ctx, M) end
      anim(M)
      t[key] = turns
      ad:say(text:format(U.name(ad, t)))
    end }
  end
  S.MAGNET_RISE = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    if (u.campaignMagnetRise or 0) > 0 or u.campaignSmackedDown or u.expIngrain
        or (F.field(ad._st).gravity or 0) > 0 then return failed(ctx, M) end
    anim(M)
    u.campaignMagnetRise = 5
    ad:say(U.name(ad, u) .. " levitated with electromagnetism!")
  end }
  S.TELEKINESIS = condition("campaignTelekinesis", 3, "%s was hurled into the air!", function(ad)
    return (F.field(ad._st).gravity or 0) <= 0 end)
  S.HEAL_BLOCK = condition("campaignHealBlock", 5, "%s was prevented from healing!")
  S.EMBARGO = condition("campaignEmbargo", 5, "%s can't use items anymore!")
  S.MIRACLE_EYE = { status = function(ctx, M)
    local t = ctx.target
    if not hits(ctx, M) then return end
    anim(M)
    t.campaignMiracleEye, t.expIdentified = true, true
    t.stages.evasion = math.min(0, U.stage(t, "evasion"))
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " identified " .. U.name(ctx.adapter, t) .. "!")
  end }
  S.OCTOLOCK = { status = function(ctx, M)
    local t = ctx.target
    if t.campaignOctolock or not hits(ctx, M) then return failed(ctx, M) end
    anim(M)
    t.campaignOctolock = ctx.user
    U.trap(t, ctx.user)
    ctx.adapter:say(U.name(ctx.adapter, t) .. " can no longer escape because of Octolock!")
  end }
  S.POWDER = { status = function(ctx, M)
    if not hits(ctx, M) then return end
    anim(M)
    ctx.target.campaignPowder = true
    ctx.adapter:say(U.name(ctx.adapter, ctx.target) .. " is covered in powder!")
  end }
  S.SPOTLIGHT = { status = function(ctx, M)
    local ad, t = ctx.adapter, ctx.target
    local side = ad:ownSide(t)
    if not side or not ad._st.double then return failed(ctx, M) end
    anim(M)
    side.expFollowMe, side.expFollowMeId = t, State.idOf(t)
    ad:say(U.name(ad, t) .. " became the center of attention!")
  end }
  S.BESTOW = { status = function(ctx, M)
    local ad, u, t = ctx.adapter, ctx.user, ctx.target
    local item = U.item(u)
    if item == 0 or U.item(t) ~= 0 or (t.substituteHP or 0) > 0 then return failed(ctx, M) end
    anim(M)
    U.removeItem(u)
    U.setItem(t, item)
    ad:say(U.name(ad, t) .. " received " .. U.itemName(item) .. " from " .. U.name(ad, u) .. "!")
  end }
  S.CELEBRATE = { target = "USER", status = function(ctx, M)
    anim(M); ctx.adapter:say("Congratulations, " .. (ctx.adapter._st.playerName or "Trainer") .. "!") end }
  S.HAPPY_HOUR = { target = "USER", status = function(ctx, M) anim(M); ctx.adapter:say("Everyone is caught up in the happy atmosphere!") end }
  S.HOLD_HANDS = { target = "USER", status = function(ctx, M)
    if not U.partner(ctx.adapter, ctx.user) then return failed(ctx, M) end
    anim(M)
    ctx.adapter:say(U.name(ctx.adapter, ctx.user) .. " and its ally held hands. They're happy!")
  end }
  S.TEATIME = { target = "USER", status = function(ctx, M)
    local ad, any = ctx.adapter, false
    for _, b in ipairs(U.all(ad)) do
      local berry = U.item(b)
      if U.isBerry(berry) then
        any = true
        U.removeItem(b)
        U.eatBerry(ad, b, berry)
      end
    end
    if not any then return failed(ctx, M) end
    anim(M)
  end }
  S.CORROSIVE_GAS = { status = function(ctx, M)
    local ad, any = ctx.adapter, false
    for _, b in ipairs(U.all(ad)) do
      if b ~= ctx.user and U.item(b) ~= 0 and ad:abilityOf(b) ~= "STICKY_HOLD" then
        local item = U.removeItem(b)
        ad:say(U.name(ad, ctx.user) .. " corroded " .. U.name(ad, b) .. "'s " .. U.itemName(item) .. "!")
        any = true
      end
    end
    if not any then return failed(ctx, M) end
    anim(M)
  end }
  S.COURT_CHANGE = { target = "USER", status = function(ctx, M)
    local ad = ctx.adapter
    local a, b = ad._st.playerSide, ad._st.enemySide
    local KEYS = { "expReflectTurns", "expLightScreenTurns", "expMistTurns", "expSafeguardTurns", "campaignTailwind",
      "campaignAuroraVeil", "campaignLuckyChant", "campaignStealthRock", "campaignToxicSpikes", "campaignStickyWeb",
      "spikes", "hazards" }
    anim(M)
    for _, k in ipairs(KEYS) do a[k], b[k] = b[k], a[k] end
    ad:say(U.name(ad, ctx.user) .. " swapped the battle effects affecting each side of the field!")
  end }

  -- turn order --------------------------------------------------------------
  local function actionIndex(battler)
    local Battle = require("src.core.game3.battle")
    local actions, at = Battle._actions or {}, Battle._actionI or 1
    for i = at + 1, #actions do
      local a = actions[i]
      if a and (a.battler == State.idOf(battler) or a.user == battler) and not a.finished then return i, actions, at end
    end
  end
  S.AFTER_YOU = { status = function(ctx, M)
    local i, actions, at = actionIndex(ctx.target)
    if not i then return failed(ctx, M) end
    anim(M)
    table.insert(actions, at + 1, table.remove(actions, i))
    ctx.adapter:say(U.name(ctx.adapter, ctx.target) .. " took the kind offer!")
  end }
  S.QUASH = { status = function(ctx, M)
    local i, actions = actionIndex(ctx.target)
    if not i or not hits(ctx, M) then return failed(ctx, M) end
    anim(M)
    table.insert(actions, table.remove(actions, i))
    ctx.adapter:say(U.name(ctx.adapter, ctx.target) .. "'s move was postponed!")
  end }

  -- moves that call other moves ------------------------------------------------
  local CALL_BANNED = {}
  for _, name in ipairs({ "ASSIST", "COPYCAT", "ME_FIRST", "METRONOME", "MIRROR_MOVE", "SLEEP_TALK", "INSTRUCT",
    "COUNTER", "MIRROR_COAT", "METAL_BURST", "PROTECT", "DETECT", "ENDURE", "FOCUS_PUNCH", "STRUGGLE",
    "TRANSFORM", "SKETCH", "BIDE", "DYNAMAX_CANNON" }) do
    local id = U.data.identity.namespaces.moves["MOVE_" .. name]
    if id then CALL_BANNED[id] = true end
  end
  local function call(M, moveId, target, extra)
    local sub = {}
    for k, v in pairs(M.opts or {}) do sub[k] = v end
    sub.called, sub.anim, sub.calledBy, sub.noAttackString = true, M.anim, M.moveId, nil
    for k, v in pairs(extra or {}) do sub[k] = v end
    local st = M.st
    if not target then
      if st and st.double then target = State.battler(st, Engine.getMoveTarget(st, M.adapter, M.user, moveId))
      elseif tonumber(Moves.get(moveId).target) == 16 then target = M.user
      else target = M.adapter:foeOf(M.user) end
    end
    return Engine.resolveMove(M.user, target, moveId, nil, M.adapter, st, M.out, sub)
  end
  S.COPYCAT = { target = "USER", status = function(ctx, M)
    local last = F.field(ctx.adapter._st).lastMove
    if not last or CALL_BANNED[last] then return failed(ctx, M) end
    call(M, last)
  end }
  S.ME_FIRST = { status = function(ctx, M)
    local t = ctx.target
    local row = t and M.st.chosen and M.st.chosen[State.idOf(t)]
    local mv = row and row.kind == "move" and tonumber(Moves.numForName(row.move) or row.move)
    local def = mv and Moves.get(mv)
    if not def or (tonumber(def.power) or 0) <= 0 or CALL_BANNED[mv] or U.movedThisTurn(ctx.adapter, t) then
      return failed(ctx, M)
    end
    ctx.user.expHelpingHand = true
    call(M, mv, t)
    ctx.user.expHelpingHand = nil
  end }
  S.INSTRUCT = { status = function(ctx, M)
    local t = ctx.target
    local last = t and tonumber(t.lastMoveId or t.lastMove)
    if not last or CALL_BANNED[last] or t.twoTurnMove or not U.alive(ctx.adapter, t) then return failed(ctx, M) end
    anim(M)
    ctx.adapter:say(U.name(ctx.adapter, t) .. " followed " .. U.name(ctx.adapter, ctx.user) .. "'s instructions!")
    local sub = {}
    for k, v in pairs(M.opts or {}) do sub[k] = v end
    sub.called, sub.calledBy = true, M.moveId
    local target = M.st.double and State.battler(M.st, Engine.getMoveTarget(M.st, M.adapter, t, last)) or M.adapter:foeOf(t)
    Engine.resolveMove(t, target, last, nil, M.adapter, M.st, M.out, sub)
  end }
  S.ALLY_SWITCH = { target = "USER", status = function(ctx, M)
    local ad, u = ctx.adapter, ctx.user
    local p = U.partner(ad, u)
    -- a co-op team battle keeps each player's Pokémon in their own position
    if not p or ad._st.coopTeam or ad._st.multi then return failed(ctx, M) end
    anim(M)
    local text = U.name(ad, u) .. " and " .. U.name(ad, p) .. " switched places!"
    F.swapPositions(ad, u, p, text)
    ad:say(text)
  end }

  return S
end
