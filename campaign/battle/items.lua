-- Held items in battle with Inclement's data (pokeemerald-1.13 items.h,
-- battle_util.c, Gen 7 configuration).
--   * Items whose donor hold effect exists in Gen 3 run the native handler
--     with the donor's parameter (HeldItems.effectOf): Leftovers, the type
--     boosts at 20%, Quick Claw, pinch berries...
--   * The rest are handled here, through the hooks field.lua and the patched
--     Inclement library expose: stats and damage, speed order, accuracy,
--     after-hit triggers for attacker and target, end of turn, switch-ins
--     and field durations.
-- Mega Stones and Z-Crystals stay inert: Mega Evolution and Z-Moves are
-- battle systems of their own.
return function(mod, U, F)
  local State = require("src.core.game3.battle.state")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local HeldItems = require("src.core.game3.battle.held_items")
  local Residuals = require("src.core.game3.battle.residuals")
  local Engine = require("src.core.game3.battle.engine")
  local Moves = require("src.core.game3.battle.moves")
  local H = HeldItems.HOLD
  local T = U.TYPE
  local I = {}
  local data = U.data

  -- the donor hold effect a battler's item has right now (nil under Magic
  -- Room, Embargo, or with no item)
  local function rowOf(item) return data.items[tonumber(item) or 0] end
  function I.held(b)
    if not b then return nil end
    local item = U.item(b)
    if item == 0 then return nil end
    local st = require("src.core.game3.battle")._st
    if (st and st.campaignField and (st.campaignField.magicRoom or 0) > 0) or (b.campaignEmbargo or 0) > 0 then return nil end
    if F.abilities and F.abilities.klutz(b) then return nil end
    local row = rowOf(item)
    local f = row and row.sourceFields
    if not f or not f.holdEffect then return nil end
    -- the donor's parameter is a number, a type (resist berries) or a terrain (seeds)
    local raw = f.holdEffectParam
    return f.holdEffect:gsub("^HOLD_EFFECT_", ""), tonumber(raw) or 0, f.secondaryId or raw, row
  end
  U.held = I.held
  local function has(b, name) return (I.held(b)) == name end
  local function consume(ad, b)
    local item = U.item(b)
    U.setItem(b, 0)
    b.expUsedHeldItem = item
    -- Symbiosis: the partner passes its item over
    if F.abilities and ad then F.abilities.symbiosis(ad, b) end
    return item
  end
  local function pinchAt(b, param)
    local d = param > 0 and param or 4
    if d == 4 and F.abilities and F.abilities.gluttony(b) then d = 2 end
    return d
  end
  local function itemName(b) return U.itemName(U.item(b)) end
  local function typeOf(secondary) return type(secondary) == "string" and T[secondary:gsub("^TYPE_", "")] end

  -- native handlers with the donor's numbers ------------------------------------
  -- names that differ between the donor and Gen 3
  local NATIVE_ALIAS = { LEEK = "STICK", UPGRADE = "UP_GRADE", MENTAL_HERB = "CURE_ATTRACT" }
  -- donor effects that must not run the same-named Gen 3 handler
  local NOT_NATIVE = { SOUL_DEW = true, LIGHT_BALL = true }
  local effectOf = HeldItems.effectOf
  -- Ripen: while HeldItems.normal runs for a Ripen holder (ripening, below),
  -- a confusion berry heals twice as much (its parameter is the divisor)
  local ripening = false
  HeldItems.effectOf = function(item, ...)
    if F.active() then
      local row = rowOf(item)
      local f = row and row.sourceFields
      if f and f.holdEffect then
        local name = f.holdEffect:gsub("^HOLD_EFFECT_", "")
        local code = not NOT_NATIVE[name] and H[NATIVE_ALIAS[name] or name]
        if code then
          local native, nativeParam = effectOf(item, ...)
          local param = tonumber(f.holdEffectParam) or (native == code and nativeParam) or 0
          if ripening and code >= H.CONFUSE_SPICY and code <= H.CONFUSE_SOUR and param > 1 then
            param = math.max(1, param / 2)  -- the handler floors maxHp / param
          end
          return code, param
        end
        return 0, 0
      end
    end
    return effectOf(item, ...)
  end
  -- Choice Scarf and Specs keep the Choice lock (the engine checks Choice Band)
  local hasNative = HeldItems.has
  HeldItems.has = function(b, he, ...)
    if he == H.CHOICE_BAND and F.active() then
      local name = I.held(b)
      if name == "CHOICE_SCARF" or name == "CHOICE_SPECS" then return true end
      -- Gorilla Tactics locks its move the same way
      if F.abilities and F.abilities.has(nil, b, "GORILLA_TACTICS") then return true end
    end
    return hasNative(b, he, ...)
  end

  -- stats used by the damage formula ------------------------------------------
  local function evolves(b)
    local P = require("src.core.game3.pokemon")
    local sp = b.species or P.speciesOf(b.mon)
    local evo = P.evolutions and P.evolutions(sp)
    if type(evo) == "table" and #evo > 0 then return true end
    -- Inclement's level and item evolutions (full/level_evolution.lua, evolution_items.lua)
    local level = require("src.core.game3.evolution")._inclementLevelEvolution
    if level and level.model and level.model.rules and #(level.model.rules[sp] or {}) > 0 then return true end
    local items = require("src.core.game3.item_use")._inclementEvolutionItems
    local rules = items and items.model and (items.model.rules or items.model.evolutions)
    return type(rules) == "table" and type(rules[sp]) == "table" and next(rules[sp]) ~= nil
  end
  local function species(b, name) return b.species == U.data.identity.namespaces.species["SPECIES_" .. name] end
  function I.stats(attacker, defender, move, atk, def, spa, spd)
    local a = I.held(attacker)
    if a == "CHOICE_SPECS" then spa = math.floor(spa * 1.5)
    elseif a == "LIGHT_BALL" and species(attacker, "PIKACHU") then atk, spa = atk * 2, spa * 2
    end
    local d = I.held(defender)
    if d == "ASSAULT_VEST" then spd = math.floor(spd * 1.5)
    elseif d == "EVIOLITE" and evolves(defender) then def, spd = math.floor(def * 1.5), math.floor(spd * 1.5)
    end
    return atk, def, spa, spd
  end

  -- base power ---------------------------------------------------------------
  local ORB = { ADAMANT_ORB = { "DIALGA", T.STEEL, T.DRAGON }, LUSTROUS_ORB = { "PALKIA", T.WATER, T.DRAGON },
    GRISEOUS_ORB = { "GIRATINA", T.GHOST, T.DRAGON }, SOUL_DEW = { "LATIAS", T.PSYCHIC, T.DRAGON } }
  function I.power(attacker, defender, move, moveType, power)
    local name, param, secondary = I.held(attacker)
    local mul = 1
    if name == "MUSCLE_BAND" and move.category == "physical" then mul = 1.1
    elseif name == "WISE_GLASSES" and move.category == "special" then mul = 1.1
    elseif name == "PLATE" and typeOf(secondary) == moveType then mul = 1.2
    elseif ORB[name] then
      local o = ORB[name]
      local ok = species(attacker, o[1]) or (name == "SOUL_DEW" and species(attacker, "LATIOS"))
      if ok and (moveType == o[2] or moveType == o[3]) then mul = 1.2 end
    elseif name == "METRONOME" then
      mul = 1 + 0.2 * math.min(5, attacker.inclementSameMoveTurns or 0)
    elseif name == "GEMS" and typeOf(secondary) == moveType and (tonumber(move.power) or 0) > 1 then
      attacker.campaignGemUsed = U.item(attacker)
      mul = 1.3
    end
    if mul ~= 1 then power = math.max(1, math.floor(power * mul)) end
    return power
  end

  -- final damage ---------------------------------------------------------------
  -- pure: AI estimates call this too; resist berries are eaten after the hit
  function I.finalDamage(attacker, defender, move, moveType, eff, dmg)
    if not F.active() or dmg <= 0 then return dmg end
    local a = I.held(attacker)
    if a == "LIFE_ORB" then dmg = math.floor(dmg * 1.3)
    elseif a == "EXPERT_BELT" and eff > 1 then dmg = math.floor(dmg * 1.2) end
    local d, _, secondary = I.held(defender)
    if d == "RESIST_BERRY" and typeOf(secondary) == moveType and (eff > 1 or moveType == T.NORMAL) then
      -- Ripen doubles the berry's effect
      dmg = math.floor(dmg / ((F.abilities and F.abilities.has(nil, defender, "RIPEN")) and 4 or 2))
    end
    return math.max(1, dmg)
  end

  -- type effectiveness: Air Balloon, Ring Target, Iron Ball ---------------------
  function I.effectiveness(ad, attacker, defender, move, moveType, eff, typeEff)
    local d = I.held(defender)
    local gravity = ad and ad._st.campaignField and (ad._st.campaignField.gravity or 0) > 0
    if moveType == T.GROUND and d == "AIR_BALLOON" and not gravity then return 0 end
    if moveType == T.GROUND and d == "IRON_BALL" and eff == 0 and U.hasType(defender, T.FLYING) then
      local t1, t2, t3 = U.types(defender)
      local out = 1
      for _, t in ipairs({ t1, t2 ~= t1 and t2 or nil, t3 }) do
        if t and t ~= T.FLYING then out = out * typeEff(moveType, t, t) end
      end
      return out
    end
    if d == "RING_TARGET" and eff == 0 then
      local t1, t2, t3 = U.types(defender)
      local out = 1
      for _, t in ipairs({ t1, t2 ~= t1 and t2 or nil, t3 }) do
        local e = t and typeEff(moveType, t, t)
        if e and e ~= 0 then out = out * e end
      end
      return out
    end
    return eff
  end

  -- speed and order ------------------------------------------------------------
  function I.speed(b, s)
    local name = I.held(b)
    if name == "CHOICE_SCARF" then return math.floor(s * 1.5) end
    if name == "IRON_BALL" or name == "POWER_ITEM" then return math.floor(s / 2) end
    if name == "QUICK_POWDER" and species(b, "DITTO") then return s * 2 end
    return s
  end
  -- -1: moves last in its priority bracket (Lagging Tail), 1: first (Custap)
  function I.orderBias(ad, b)
    local name, param = I.held(b)
    if name == "LAGGING_TAIL" then return -1 end
    if name == "CUSTAP_BERRY" and ad and ad:hp(b) <= math.floor(ad:maxHp(b) / pinchAt(b, param)) then
      if not b.campaignCustapUsed then
        b.campaignCustapUsed = true
        consume(ad, b)
        U.say(ad, U.name(ad, b) .. " can act faster than normal, thanks to its Custap Berry!")
      end
      return 1
    end
    if b.campaignCustapUsed then return 1 end
    return 0
  end
  function I.affectsOrder(b)
    local name = I.held(b)
    return name == "CHOICE_SCARF" or name == "IRON_BALL" or name == "POWER_ITEM" or name == "QUICK_POWDER"
      or name == "LAGGING_TAIL" or name == "CUSTAP_BERRY" or b.campaignCustapUsed
  end

  -- accuracy --------------------------------------------------------------------
  function I.accuracy(M, acc)
    local name = I.held(M.user)
    if name == "WIDE_LENS" then acc = acc * 1.1
    elseif name == "ZOOM_LENS" and M.target and U.movedThisTurn(M.adapter, M.target) then acc = acc * 1.2 end
    if M.user.campaignMicle then
      M.user.campaignMicle = nil
      acc = acc * 1.2
    end
    return math.floor(acc)
  end

  -- after a hit -----------------------------------------------------------------
  local function statItem(ad, b, changes, text)
    if U.changeStats(ad, b, changes) then
      U.say(ad, text or ("The " .. itemName(b) .. " was used up..."))
    end
  end
  local TYPE_STAT_ITEMS = {
    ABSORB_BULB = { T.WATER, { spAtk = 1 } }, CELL_BATTERY = { T.ELECTRIC, { attack = 1 } },
    LUMINOUS_MOSS = { T.WATER, { spDef = 1 } }, SNOWBALL = { T.ICE, { attack = 1 } },
  }
  function I.afterHit(M)
    if not F.active() then return end
    local ad, user, target = M.adapter, M.user, M.target
    if not target or target == user or M.noEffect or M.failed then return end
    local dealt = (M.hpDealt or 0) > 0
    local contact = U.hasContact(M.move) and I.held(user) ~= "PROTECTIVE_PADS"
    local moveType = tonumber(M.moveType or M.move.type)
    local physical = M.move.category == "physical"
    -- the attacker's item
    local a = I.held(user)
    if user.campaignGemUsed and user.campaignGemUsed == U.item(user) then
      U.say(ad, "The " .. itemName(user) .. " strengthened " .. U.name(ad, user) .. "'s power!")
      consume(ad, user)
    end
    user.campaignGemUsed = nil
    if a == "LIFE_ORB" and dealt and not ad:isFainted(user) and ad:abilityOf(user) ~= "MAGIC_GUARD"
        and not (F.abilities and F.abilities.sheerForced(M)) then
      ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 10)))
      U.say(ad, U.name(ad, user) .. " lost some of its HP!")
      M.checkUserFaint = true
    elseif a == "THROAT_SPRAY" and not ad:isFainted(user) and U.moveFlag(M.move, "FLAG_SOUND") then
      consume(ad, user)
      Secondary.changeStat(ad, user, "spAtk", 1, { user = true, allowPtr = true })
    end
    if not dealt or ad:isFainted(target) then
      -- (Rocky Helmet and Jaboca/Rowap still answer a knockout below)
      if not dealt then return end
    end
    -- the target's item
    local d, param = I.held(target)
    local eff = M.anim and M.anim.effectiveness or 1
    if d == "RESIST_BERRY" then
      local _, _, secondary = I.held(target)
      if typeOf(secondary) == moveType and (eff > 1 or moveType == T.NORMAL) then
        U.say(ad, "The " .. itemName(target) .. " weakened the damage to " .. U.name(ad, target) .. "!")
        consume(ad, target)
        target.campaignAteBerry = true
      end
    elseif d == "ROCKY_HELMET" and contact and not ad:isFainted(user) and ad:abilityOf(user) ~= "MAGIC_GUARD" then
      ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 6)))
      U.say(ad, U.name(ad, user) .. " was hurt by " .. U.name(ad, target) .. "'s Rocky Helmet!")
      M.checkUserFaint = true
    elseif (d == "JABOCA_BERRY" and physical) or (d == "ROWAP_BERRY" and not physical) then
      if not ad:isFainted(user) then
        consume(ad, target)
        ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 8)))
        U.say(ad, U.name(ad, user) .. " was hurt by " .. U.name(ad, target) .. "'s berry!")
        M.checkUserFaint = true
      end
    end
    if ad:isFainted(target) then return end
    if d == "AIR_BALLOON" then
      consume(ad, target)
      U.say(ad, U.name(ad, target) .. "'s Air Balloon popped!")
    elseif d == "WEAKNESS_POLICY" and eff > 1 then
      consume(ad, target)
      statItem(ad, target, { attack = 2, spAtk = 2 }, "The Weakness Policy sharply raised " .. U.name(ad, target) .. "'s Attack and Sp. Atk!")
    elseif TYPE_STAT_ITEMS[d] and TYPE_STAT_ITEMS[d][1] == moveType then
      consume(ad, target)
      statItem(ad, target, TYPE_STAT_ITEMS[d][2])
    elseif (d == "KEE_BERRY" and physical) or (d == "MARANGA_BERRY" and not physical) then
      consume(ad, target)
      statItem(ad, target, physical and { defense = 1 } or { spDef = 1 })
    elseif d == "RESTORE_PCT_HP" then
      I.pinch(ad, target)
    elseif d == "MICLE_BERRY" or d == "CUSTAP_BERRY" then
      I.pinch(ad, target)
    end
    -- Grip Claw: the attacker's binding move holds for 7 turns
    if a == "GRIP_CLAW" and target.expTrapSource == user and (target.expTrapTurns or 0) > 0 then
      target.expTrapTurns = 7
    end
  end

  -- after the faint check: items that send someone out
  function I.afterFaint(M)
    if not F.active() then return end
    local ad, user, target = M.adapter, M.user, M.target
    if not target or target == user or M.noEffect or M.failed or (M.hpDealt or 0) <= 0 then return end
    if ad:isFainted(target) or M.st.over then return end
    local d = I.held(target)
    if d == "RED_CARD" and not ad:isFainted(user) and user.side ~= target.side then
      consume(ad, target)
      U.say(ad, U.name(ad, target) .. " held up its Red Card against " .. U.name(ad, user) .. "!")
      local fake = setmetatable({ target = user }, { __index = M })
      F.dragOut(fake, user)
    elseif d == "EJECT_BUTTON" then
      consume(ad, target)
      U.say(ad, U.name(ad, target) .. " is switched out with the Eject Button!")
      local fake = setmetatable({ user = target }, { __index = M })
      F.switchOut(fake, target)
    end
  end

  -- a miss: Blunder Policy
  function I.afterMiss(M)
    local ad, user = M.adapter, M.user
    if F.active() and has(user, "BLUNDER_POLICY") and not ad:isFainted(user) then
      consume(ad, user)
      Secondary.changeStat(ad, user, "speed", 2, { user = true, allowPtr = true })
    end
  end

  -- pinch berries the native handler doesn't know ------------------------------
  function I.pinch(ad, b)
    local name, param = I.held(b)
    if not name or ad:isFainted(b) then return false end
    local hp, max = ad:hp(b), ad:maxHp(b)
    if name == "RESTORE_PCT_HP" and hp <= math.floor(max / 2) and not U.healBlocked(b) then
      local item = itemName(b)
      consume(ad, b)
      ad:playAnim("general", "HELD_ITEM_EFFECT", b, b)
      local ripe = F.abilities and F.abilities.ripen(b) and 2 or 1
      U.heal(ad, b, max * (param > 0 and param or 25) * ripe / 100)
      U.say(ad, U.name(ad, b) .. " restored its health using its " .. item .. "!")
      b.campaignAteBerry = true
      return true
    elseif name == "MICLE_BERRY" and hp <= math.floor(max / pinchAt(b, 4)) then
      consume(ad, b)
      b.campaignMicle, b.campaignAteBerry = true, true
      U.say(ad, U.name(ad, b) .. " boosted the accuracy of its next move using its Micle Berry!")
      return true
    end
    return false
  end
  local normal = HeldItems.normal
  HeldItems.normal = function(ad, b, moveTurn, ...)
    if F.active() and b and ad:hp(b) > 0 and I.pinch(ad, b) then return true end
    ripening = F.active() and b and F.abilities and F.abilities.ripen(b) and true or false
    local ok, r = pcall(normal, ad, b, moveTurn, ...)
    ripening = false
    if not ok then error(r, 0) end
    return r
  end

  -- Focus Sash: survives a knockout from full HP --------------------------------
  local rollFocusBand = HeldItems.rollFocusBand
  HeldItems.rollFocusBand = function(ad, target, ...)
    if F.active() and has(target, "FOCUS_SASH") and ad:hp(target) >= ad:maxHp(target) then
      target.expFocusBanded = true
      target.campaignSash = true
      return true
    end
    return rollFocusBand(ad, target, ...)
  end
  local focusMessage = HeldItems.focusBandMessage
  HeldItems.focusBandMessage = function(ad, target, ...)
    if target and target.campaignSash then
      target.campaignSash = nil
      U.say(ad, U.name(ad, target) .. " hung on using its Focus Sash!")
      consume(ad, target)
      return
    end
    return focusMessage(ad, target, ...)
  end

  -- end of turn ------------------------------------------------------------------
  Residuals.register("campaign_items", function(ctx)
    local ad, b = ctx.adapter, ctx.target or ctx.user
    if not F.active() or not b or ad:isFainted(b) then return end
    local name = I.held(b)
    if name == "BLACK_SLUDGE" then
      if U.hasType(b, T.POISON) then
        if ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
          U.heal(ad, b, ad:maxHp(b) / 16)
          U.say(ad, U.name(ad, b) .. " restored a little HP using its Black Sludge!")
        end
      elseif ad:abilityOf(b) ~= "MAGIC_GUARD" then
        ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 8)))
        U.say(ad, U.name(ad, b) .. " was hurt by its Black Sludge!")
      end
    elseif (name == "FLAME_ORB" or name == "TOXIC_ORB") and not ad:status(b) then
      local kind = name == "FLAME_ORB" and "BRN" or "TOX"
      if ad:canApplyStatus(b, kind, b, { ignoreSafeguard = true }) then
        ad:applyStatus(b, kind, b, { ignoreSafeguard = true })
        ad:statusAnim(b, kind)
        ad:sayText(kind == "BRN" and "STRINGID_PKMNWASBURNED" or "STRINGID_PKMNBADLYPOISONED", { eff = b })
      end
    elseif name == "STICKY_BARB" and ad:abilityOf(b) ~= "MAGIC_GUARD" then
      ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 8)))
      U.say(ad, U.name(ad, b) .. " was hurt by its Sticky Barb!")
    end
    -- Binding Band: a binding move holds on for 1/6 instead of 1/8
    if (b.expTrapTurns or 0) > 0 and b.expTrapSource and I.held(b.expTrapSource) == "BINDING_BAND" then
      ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 24)))
    end
  end)
  local Rules = require("src.core.game3.battle.rules")
  local listed = false
  for _, v in ipairs(Rules.BATTLER_PHASES_ORDER) do if v == "campaign_items" then listed = true end end
  if not listed then
    for i, v in ipairs(Rules.BATTLER_PHASES_ORDER) do
      if v == "held_items" then table.insert(Rules.BATTLER_PHASES_ORDER, i + 1, "campaign_items"); break end
    end
  end

  -- switch-ins: Air Balloon, terrain seeds ----------------------------------------
  local SEEDS = { ELECTRIC = "defense", GRASSY = "defense", MISTY = "spDef", PSYCHIC = "spDef" }
  function I.seed(ad, b)
    local name, _, param = I.held(b)
    local terrain = F.terrain(ad._st)
    if name ~= "SEEDS" or not terrain then return end
    local stat = SEEDS[terrain]
    -- the seed's parameter names its terrain (HOLD_EFFECT_PARAM_GRASSY_TERRAIN)
    if stat and param == "HOLD_EFFECT_PARAM_" .. terrain .. "_TERRAIN" and U.stage(b, stat) < 6 then
      local s = { stat }
      consume(ad, b)
      Secondary.changeStat(ad, b, s[1], 1, { user = true, allowPtr = true })
    end
  end
  function I.switchIn(ad, b)
    if not F.active() or ad:isFainted(b) then return end
    if has(b, "AIR_BALLOON") then U.say(ad, U.name(ad, b) .. " floats in the air with its Air Balloon!") end
    I.seed(ad, b)
  end

  -- durations: weather rocks, Light Clay, Terrain Extender --------------------------
  local ROCK = { RAIN = "DAMP_ROCK", RAINY = "DAMP_ROCK", SUN = "HEAT_ROCK", SUNNY = "HEAT_ROCK",
    SAND = "SMOOTH_ROCK", SANDSTORM = "SMOOTH_ROCK", HAIL = "ICY_ROCK" }
  function I.weatherTurns(setter, kind, turns)
    if setter and ROCK[kind] and has(setter, ROCK[kind]) then return 8 end
    return turns
  end
  function I.longScreens(b) return has(b, "LIGHT_CLAY") end
  function I.longTerrain(b) return has(b, "TERRAIN_EXTENDER") end

  -- moves: Power Herb, Big Root, Grip Claw, Assault Vest, powder ----------------------
  mod.hooks:wrap("battle.charge_required", function(next, c)
    local user = c and c.user
    if F.active() and user and has(user, "POWER_HERB") then
      local ad = require("src.core.game3.battle")._adapter
      consume(ad, user)
      U.say(ad, U.name(ad, user) .. " became fully charged due to its Power Herb!")
      return false
    end
    return next(c)
  end)
  function I.drainBoost(b) return has(b, "BIG_ROOT") and 1.3 or 1 end
  function I.trapTurns(b) return has(b, "GRIP_CLAW") and 7 or nil end
  function I.blocksStatus(b) return has(b, "ASSAULT_VEST") end
  function I.powderImmune(b) return has(b, "SAFETY_GOGGLES") end
  function I.hazardImmune(b) return has(b, "HEAVY_DUTY_BOOTS") end
  function I.trickRoomSet(ad)
    for _, b in ipairs(U.all(ad)) do
      if has(b, "ROOM_SERVICE") and U.stage(b, "speed") > -6 then
        consume(ad, b)
        Secondary.changeStat(ad, b, "speed", -1, { allowPtr = true })
      end
    end
  end

  -- Eject Pack: a stat drop sends the holder out once the move is over
  local changeStat = Secondary.changeStat
  Secondary.changeStat = function(ad, battler, stat, delta, flags, ...)
    local result = changeStat(ad, battler, stat, delta, flags, ...)
    if F.active() and result == "worked" and delta < 0 and battler and has(battler, "EJECT_PACK") then
      battler.campaignEjectPack = true
    end
    return result
  end
  function I.ejectPack(M)
    for _, b in ipairs(U.all(M.adapter)) do
      if b.campaignEjectPack and not M.st.over then
        b.campaignEjectPack = nil
        if has(b, "EJECT_PACK") then
          consume(M.adapter, b)
          U.say(M.adapter, U.name(M.adapter, b) .. " is switched out by the Eject Pack!")
          local fake = setmetatable({ user = b }, { __index = M })
          F.switchOut(fake, b)
        end
      end
    end
  end

  -- Choice Scarf, Choice Specs and Gorilla Tactics lock the move menu like
  -- Choice Band (the native check only knows Choice Band)
  local limits = Engine.moveLimitations
  Engine.moveLimitations = function(b, ad, ...)
    local bad = limits(b, ad, ...)
    if F.active() and b and b.choicedMove and type(bad) == "table" then
      local name = I.held(b)
      local gorilla = F.abilities and F.abilities.has(ad, b, "GORILLA_TACTICS")
      if name == "CHOICE_SCARF" or name == "CHOICE_SPECS" or gorilla then
        local mon = b.mon or {}
        local H2 = require("src.core.game3.battle.effects._helpers")
        local any = false
        for i = 1, 4 do
          local mv = mon.moves and mon.moves[i]
          if mv and mv ~= 0 and H2.moveNum(mv) ~= tonumber(b.choicedMove) then bad[i] = true end
          if not bad[i] then any = true end
        end
        if not any then
          -- the locked move is gone (PP, Disable): the lock lets go
          for i = 1, 4 do
            local mv = mon.moves and mon.moves[i]
            bad[i] = not mv or mv == 0 or tonumber(mon.pp and mon.pp[i]) == 0 or nil
          end
        end
      end
    end
    return bad
  end

  -- Utility Umbrella (pokeemerald-1.13 IsBattlerWeatherAffected): sun and
  -- rain don't reach the holder. The donor checks the attacker's item for
  -- the damage modifier, Weather Ball and Solar Beam, the target's for
  -- Thunder and Hurricane, and the holder's for its abilities and healing
  local WRules = require("src.core.game3.battle.rules")
  function I.umbrella(b) return type(b) == "table" and has(b, "UTILITY_UMBRELLA") end
  local function sunOrRain(st)
    local kind = st and WRules.weather.kind(st.weather)
    return kind == "SUN" or kind == "RAIN"
  end
  -- the weather as b feels it
  function I.weatherFor(ad, b)
    local w = ad and WRules.weather.effective(ad._st, ad) or nil
    if (w == "SUN" or w == "RAIN") and b and I.umbrella(b) then return nil end
    return w
  end
  -- runs fn with sun or rain hidden while b (holding the umbrella) is involved
  function I.underUmbrella(st, b, fn, ...)
    if not (F.active() and st and b and I.umbrella(b) and sunOrRain(st)) then return fn(...) end
    local saved = st.weather
    st.weather = nil
    local out = { pcall(fn, ...) }
    st.weather = saved
    if not out[1] then error(out[2], 0) end
    return unpack(out, 2, table.maxn(out))
  end
  local Damage = require("src.core.game3.battle.damage")
  local calc = Damage.calc
  Damage.calc = function(attacker, defender, moveId, opts, ...)
    if F.active() and type(opts) == "table" and attacker and I.umbrella(attacker) then
      local kind = opts.weatherKind or WRules.weather.kind(opts.weather)
      if kind == "SUN" or kind == "RAIN" then
        local o = {}
        for k, v in pairs(opts) do o[k] = v end
        o.weatherKind, o.weather = nil, nil
        opts = o
      end
    end
    return calc(attacker, defender, moveId, opts, ...)
  end
  -- Thunder / Hurricane accuracy: the target's umbrella (both accuracy paths
  -- are the move context's accuracyCheck)
  local newContext = Engine.newContext
  Engine.newContext = function(...)
    local ctx = newContext(...)
    local mt = type(ctx) == "table" and getmetatable(ctx)
    if mt and mt.accuracyCheck and not mt._campaignUmbrella then
      mt._campaignUmbrella = true
      local check = mt.accuracyCheck
      mt.accuracyCheck = function(self, ...)
        local st = self.st or (self.adapter and self.adapter._st)
        return I.underUmbrella(st, self.target, check, self, ...)
      end
    end
    return ctx
  end
  -- the holder's healing moves and Solar Beam
  local E = require("src.core.game3.battle.effect_ids")
  local WEATHER_MOVES = { [E.MORNING_SUN] = true, [E.SYNTHESIS] = true, [E.MOONLIGHT] = true, [E.SOLAR_BEAM] = true }
  local resolveMove = Engine.resolveMove
  Engine.resolveMove = function(user, target, moveId, slot, adapter, st, ...)
    -- (user is the battler's slot; State.occupant gives the battler)
    local b = F.active() and user and st and State.occupant(st, user)
    local mv = type(b) == "table" and I.umbrella(b) and Moves.get(moveId)
    if mv and WEATHER_MOVES[tonumber(mv.effect)] then
      return I.underUmbrella(st, b, resolveMove, user, target, moveId, slot, adapter, st, ...)
    end
    return resolveMove(user, target, moveId, slot, adapter, st, ...)
  end
  -- Rain Dish (a native ability)
  local Abilities = require("src.core.game3.battle.abilities")
  local endTurn = Abilities.endTurn
  Abilities.endTurn = function(ad, b, ...)
    return I.underUmbrella(ad and ad._st, b, endTurn, ad, b, ...)
  end

  -- Shed Shell (CanBattlerEscape): the holder can always be switched out,
  -- whatever traps it, Ingrain included
  local canSwitch = Engine.canSwitch
  Engine.canSwitch = function(st, ad, battler, ...)
    if F.active() and battler and has(battler, "SHED_SHELL") then return true end
    return canSwitch(st, ad, battler, ...)
  end

  -- Adrenaline Orb (BattleScript_TryAdrenalineOrb): Intimidate aimed at the
  -- holder raises its Speed instead of going to waste (abilities.lua calls this)
  function I.intimidated(ad, b)
    if not has(b, "ADRENALINE_ORB") or ad:isFainted(b) or U.stage(b, "speed") >= 6 then return end
    local name = itemName(b)
    if Secondary.changeStat(ad, b, "speed", 1, { allowPtr = true, certain = true, noMsg = true }) == "worked" then
      consume(ad, b)
      ad:playAnim("general", "HELD_ITEM_EFFECT", b, b)
      U.say(ad, "Using " .. name .. ", the Speed of " .. U.name(ad, b) .. " rose!")
    end
  end

  -- Destiny Knot: when Attract or Cute Charm makes the holder fall in love,
  -- the other one falls in love with it too (the knot stays)
  local function canFallFor(ad, b, other)
    if b.expInfatuated or ad:isFainted(b) or ad:abilityOf(b) == "OBLIVIOUS" then return false end
    if F.abilities and F.abilities.has(ad, b, "AROMA_VEIL") then return false end
    local mb, mo = ad:mon(b), ad:mon(other)
    local gb, go = mb and mb.gender, mo and mo.gender
    return gb and go and gb ~= "U" and go ~= "U" and gb ~= go
  end
  local moveEndKnot = Engine.moveEndEffects
  Engine.moveEndEffects = function(M, ...)
    if F.active() and M and M.adapter then
      local ad = M.adapter
      for _, b in ipairs({ M.user, M.target }) do
        local source = b and b.expInfatuated and b.expInfatuatedWith
        if source and b.campaignKnotFrom ~= source and has(b, "DESTINY_KNOT") and canFallFor(ad, source, b) then
          b.campaignKnotFrom = source
          source.expInfatuated = true
          source.expInfatuatedBy = b.side
          source.expInfatuatedWith = b
          ad:playAnim("general", "HELD_ITEM_EFFECT", b, b)
          U.say(ad, U.name(ad, source) .. " fell in love because of the Destiny Knot!")
        end
      end
    end
    return moveEndKnot(M, ...)
  end

  return I
end
