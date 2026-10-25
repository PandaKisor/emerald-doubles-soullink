-- Abilities in battle with Inclement's data (pokeemerald-1.13 battle_util.c,
-- battle_main.c and battle_script_commands.c, Gen 7/8 configuration).
--   * Gen 3 abilities keep their native handlers; where Inclement changed
--     one (pinch abilities, Rough Skin, Intimidate, Flash Fire under the
--     Inclement damage rules), the change is made here.
--   * The new abilities run through the hooks field.lua and the patched
--     Inclement library expose (power, stats, stages, final damage,
--     effectiveness, accuracy, protection, move type, turn order, after a
--     hit, after a faint), plus wrappers on the live battle modules: the
--     adapter's ability and status checks, stat changes, switch-in and
--     switch-out, end of turn, absorbing moves, crits and speed.
-- Form-changing abilities (Zen Mode, Stance Change, Schooling, Disguise, ...)
-- switch the battler to the form's species for the battle: sprite, typing
-- and stats follow; the party Pokémon is untouched. Mega-only abilities
-- (Parental Bond, Primal weathers) stay inert, and so do Dancer and the
-- out-of-battle ones (Ball Fetch, Honey Gather).
return function(mod, U, F)
  local State = require("src.core.game3.battle.state")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local Abilities = require("src.core.game3.battle.abilities")
  local Residuals = require("src.core.game3.battle.residuals")
  local Rules = require("src.core.game3.battle.rules")
  local Engine = require("src.core.game3.battle.engine")
  local Moves = require("src.core.game3.battle.moves")
  local Adapter = require("src.core.game3.battle.adapter")
  local HeldItems = require("src.core.game3.battle.held_items")
  local EffectCtx = require("src.core.game3.battle.effect_ctx")
  local E = require("src.core.game3.battle.effect_ids")
  local T = U.TYPE
  local A = {}
  local data = U.data

  -- names --------------------------------------------------------------------
  -- abilityOf gives a Gen 3 constant (CLEAR_BODY) or an upper-cased donor name
  -- (DRAGON'S_MAW); both map to the donor symbol without ABILITY_.
  local function squash(s) return (tostring(s):upper():gsub("[^%w]", "")) end
  local KEY, NAME, ID = {}, {}, {}
  for id, row in pairs(data.abilities) do
    local sym = tostring(row.symbol or ""):gsub("^ABILITY_", "")
    if sym ~= "" and sym ~= "NONE" then
      KEY[squash(sym)] = sym
      if not KEY[squash(row.name)] then KEY[squash(row.name)] = sym end
      NAME[sym], ID[sym] = row.name, id
    end
  end
  local AS_ONE = { [ID.AS_ONE_ICE_RIDER or -1] = "AS_ONE_ICE_RIDER", [ID.AS_ONE_SHADOW_RIDER or -1] = "AS_ONE_SHADOW_RIDER" }
  local function battle() return require("src.core.game3.battle") end
  local function adapterOf(ad) return ad or battle()._adapter end

  function A.key(ad, b)
    ad = adapterOf(ad)
    if not ad or not b then return nil end
    local name = ad:abilityOf(b)
    if not name then return nil end
    local key = KEY[squash(name)]
    if key == "AS_ONE_ICE_RIDER" or key == "AS_ONE_SHADOW_RIDER" then
      local id = tonumber(b.ability or (b.mon and (b.mon.ability or b.mon.abilityId)))
      key = AS_ONE[id] or key
    end
    return key or name
  end
  local key = A.key
  function A.has(ad, b, name) return key(ad, b) == name end
  -- the donor's names are cut to 12 characters ("LightningRod"); the
  -- abilities' own battle lines use full names built from the symbol
  local FULL = { SOUL_HEART = "Soul-Heart", DRAGONS_MAW = "Dragon's Maw", AS_ONE_ICE_RIDER = "As One",
    AS_ONE_SHADOW_RIDER = "As One", RKS_SYSTEM = "RKS System", POWER_OF_ALCHEMY = "Power of Alchemy" }
  function A.name(sym)
    if not sym then return "" end
    if FULL[sym] then return FULL[sym] end
    if not NAME[sym] then return sym end
    return (sym:lower():gsub("_", " "):gsub("(%a)([%w']*)", function(a, b) return a:upper() .. b end))
  end
  -- the ability as abilityOf reports it, for b.campaignAbility (Mummy, ...)
  local function abilityString(sym) return (NAME[sym] or sym):upper():gsub("%s+", "_") end

  -- Gen 3's ability ids only know Gen 3 names: battle text fills and Trace
  -- look up the expanded ones here
  local nativeId = Abilities.id
  Abilities.id = function(ab)
    if F.active() then
      local sym = KEY[squash(ab)]
      if sym and ID[sym] and ID[sym] > 77 then return ID[sym] end
    end
    return nativeId(ab)
  end
  local H = require("src.core.game3.battle.effects._helpers")
  local helperId = H.abilityId
  H.abilityId = function(name)
    if F.active() and type(name) == "string" then
      local sym = KEY[squash(name)]
      if sym and ID[sym] and ID[sym] > 77 then return ID[sym] end
    end
    return helperId(name)
  end

  local function alive(ad, b) return U.alive(ad, b) end
  local function partnerOf(ad, b) return U.partner(ad, b) end
  local function onSide(ad, b, name)
    if alive(ad, b) and key(ad, b) == name then return b end
    local p = partnerOf(ad, b)
    if p and key(ad, p) == name then return p end
    return nil
  end
  local function onField(ad, name)
    for _, b in ipairs(U.all(ad)) do if key(ad, b) == name then return b end end
    return nil
  end
  local function foeHas(ad, b, name)
    for _, f in ipairs(U.foes(ad, b)) do if key(ad, f) == name then return f end end
    return nil
  end
  A.onSide, A.onField = onSide, onField
  local function say(ad, text) ad:say(text) end
  local function nm(ad, b) return U.name(ad, b) end
  local function weather(ad) return ad and Rules.weather.effective(ad._st, ad) or nil end
  local function statusOf(ad, b)
    if ad then return ad:status(b) end
    local s = b and (b.status or (b.mon and b.mon.status))
    return s ~= 0 and s or nil
  end
  local function physical(move) return move and move.category == "physical" end
  local function special(move) return move and move.category == "special" end
  local function damaging(move) return (tonumber(move and move.power) or 0) > 0 end
  local function flag(move, f) return move ~= nil and U.moveFlag(move, f) end
  local function moveRecord(ref)
    if type(ref) == "table" and ref.effect ~= nil then return ref end
    if type(ref) == "table" then ref = ref.num or ref.index or ref.id end
    return ref and Moves.get(ref)
  end
  local function hp(ad, b) return ad and ad:hp(b) or tonumber(b.mon and b.mon.hp) or 0 end
  local function maxHp(ad, b) return ad and ad:maxHp(b) or math.max(1, tonumber(b.mon and b.mon.maxHp) or 1) end
  local function fullHp(ad, b) return hp(ad, b) >= maxHp(ad, b) end
  local function mul(n, f) return math.floor(n * f) end
  A.contact = function(ad, user, move)
    if not U.hasContact(move) then return false end
    if user and key(ad, user) == "LONG_REACH" then return false end
    if user and F.items and U.held and U.held(user) == "PROTECTIVE_PADS" then return false end
    return true
  end
  local contact = A.contact

  -- a stat change an ability makes, with its own line of text
  local RISE = { [1] = "rose", [2] = "rose sharply", [3] = "rose drastically" }
  local FALL = { [1] = "fell", [2] = "harshly fell", [3] = "severely fell" }
  local function boost(ad, b, stat, delta, sym, opts)
    opts = opts or {}
    if not alive(ad, b) then return false end
    local before = U.stage(b, stat)
    local r = Secondary.changeStat(ad, b, stat, delta, { user = opts.user ~= false, allowPtr = true, noMsg = true,
      certain = opts.certain, campaignSource = opts.source })
    if r ~= "worked" then
      if not opts.quiet and r == "wont" then
        say(ad, nm(ad, b) .. "'s " .. U.STAT_NAMES[stat] .. (delta > 0 and " won't go any higher!" or " won't go any lower!"))
      end
      return false
    end
    local moved = math.abs(U.stage(b, stat) - before)
    local words = (U.stage(b, stat) > before) and RISE or FALL
    local who = sym and (nm(ad, b) .. "'s " .. A.name(sym)) or nm(ad, b) .. "'s"
    if sym then
      say(ad, ("%s %s its %s!"):format(who, U.stage(b, stat) > before and "raised" or "lowered", U.STAT_NAMES[stat]))
    else
      say(ad, ("%s %s %s!"):format(who, U.STAT_NAMES[stat], words[math.min(3, moved)] or "rose"))
    end
    return true
  end
  A.boost = boost

  -- the battler whose move or effect is running right now
  local function source(ad)
    local ctx = EffectCtx.current and EffectCtx.current()
    if ctx and ctx.user then return ctx.user end
    return ad and ad._campaignStatSource or (ad and ad._campaignMoveUser)
  end

  -- ability suppression: Neutralizing Gas and Mold Breaker ----------------------
  local BREAKABLE = {}
  for _, s in ipairs({ "BATTLE_ARMOR", "CLEAR_BODY", "DAMP", "DRY_SKIN", "FILTER", "FLASH_FIRE", "FLOWER_GIFT",
      "HEATPROOF", "HYPER_CUTTER", "IMMUNITY", "INNER_FOCUS", "INSOMNIA", "KEEN_EYE", "LEAF_GUARD", "LEVITATE",
      "LIGHTNING_ROD", "LIMBER", "MAGMA_ARMOR", "MARVEL_SCALE", "MOTOR_DRIVE", "OBLIVIOUS", "OWN_TEMPO",
      "SAND_VEIL", "SHELL_ARMOR", "SHIELD_DUST", "SIMPLE", "SNOW_CLOAK", "SOLID_ROCK", "SOUNDPROOF",
      "STICKY_HOLD", "STORM_DRAIN", "STURDY", "SUCTION_CUPS", "TANGLED_FEET", "THICK_FAT", "UNAWARE",
      "VITAL_SPIRIT", "VOLT_ABSORB", "WATER_ABSORB", "WATER_VEIL", "WHITE_SMOKE", "WONDER_GUARD", "BIG_PECKS",
      "CONTRARY", "FRIEND_GUARD", "HEAVY_METAL", "LIGHT_METAL", "MAGIC_BOUNCE", "MULTISCALE", "SAP_SIPPER",
      "TELEPATHY", "WONDER_SKIN", "AROMA_VEIL", "BULLETPROOF", "FLOWER_VEIL", "FUR_COAT", "OVERCOAT",
      "SWEET_VEIL", "DAZZLING", "DISGUISE", "FLUFFY", "QUEENLY_MAJESTY", "WATER_BUBBLE", "MIRROR_ARMOR",
      "PUNK_ROCK", "ICE_SCALES", "ICE_FACE", "PASTEL_VEIL" }) do BREAKABLE[s] = true end
  local GAS_PROOF = { NEUTRALIZING_GAS = true, MULTITYPE = true, ZEN_MODE = true, STANCE_CHANGE = true,
    SCHOOLING = true, COMATOSE = true, SHIELDS_DOWN = true, DISGUISE = true, RKS_SYSTEM = true,
    BATTLE_BOND = true, POWER_CONSTRUCT = true, ICE_FACE = true, GULP_MISSILE = true,
    AS_ONE_ICE_RIDER = true, AS_ONE_SHADOW_RIDER = true }
  local MOLD = { MOLD_BREAKER = true, TERAVOLT = true, TURBOBLAZE = true }
  A.BREAKABLE = BREAKABLE
  local function wrapAdapter(a)
    local sayText = a.sayText
    function a:sayText(id, fill, ...)
      local r = sayText(self, id, fill, ...)
      if F.active() and self._st and type(fill) == "table" then
        if id == "STRINGID_ATTACKERFAINTED" or id == "STRINGID_TARGETFAINTED" then
          local gone = fill.atk or fill.def
          if gone and gone.campaignSoulSeen ~= gone.mon then
            gone.campaignSoulSeen = gone.mon
            for _, o in ipairs(U.all(self)) do
              if o ~= gone and key(self, o) == "SOUL_HEART" then boost(self, o, "spAtk", 1, "SOUL_HEART") end
            end
          end
        elseif id == "STRINGID_PKMNFLINCHED" and fill.atk and key(self, fill.atk) == "STEADFAST" then
          boost(self, fill.atk, "speed", 1, "STEADFAST")
        end
      end
      return r
    end
    local inner = a.abilityOf
    local function raw(self, b) local name = inner(self, b); return name and (KEY[squash(name)] or name), name end
    function a:abilityOf(b, ...)
      local name = inner(self, b, ...)
      if not name or not F.active() or not b then return name end
      local sym = KEY[squash(name)] or name
      if self._campaignGasCheck ~= true and not GAS_PROOF[sym] then
        self._campaignGasCheck = true
        local gas = false
        for _, o in ipairs(self:activeBattlers() or {}) do
          if o ~= b and o.mon and (tonumber(o.mon.hp) or 0) > 0 and raw(self, o) == "NEUTRALIZING_GAS" then gas = true break end
        end
        self._campaignGasCheck = nil
        if gas then return nil end
      end
      local mold = self._campaignMold
      if mold and mold ~= b and BREAKABLE[sym] then return nil end
      return name
    end
  end
  local newAdapter = Adapter.new
  Adapter.new = function(...)
    local a = newAdapter(...)
    wrapAdapter(a)
    return a
  end

  -- the move in progress: Mold Breaker, the move's user (stat sources), type
  -- changes (-ate abilities, Normalize, Liquid Voice), Protean
  local resolve = Engine.resolveMove
  Engine.resolveMove = function(user, target, moveId, slot, adapter, st, out, opts, ...)
    if not F.active() or not adapter or not user then return resolve(user, target, moveId, slot, adapter, st, out, opts, ...) end
    local who = st and State.occupant(st, user) or user
    local prevMold, prevUser = adapter._campaignMold, adapter._campaignMoveUser
    adapter._campaignMold = MOLD[key(adapter, who) or ""] and who or nil
    adapter._campaignMoveUser = who
    local results = { pcall(resolve, user, target, moveId, slot, adapter, st, out, opts, ...) }
    adapter._campaignMold, adapter._campaignMoveUser = prevMold, prevUser
    if who then who.campaignAteBoost = nil end
    if not results[1] then error(results[2], 0) end
    return unpack(results, 2, table.maxn(results))
  end

  local ATE = { PIXILATE = T.FAIRY, REFRIGERATE = T.ICE, AERILATE = T.FLYING, GALVANIZE = T.ELECTRIC }
  -- moves whose type is decided by their own effect
  local OWN_TYPE = { [E.HIDDEN_POWER] = true, [E.WEATHER_BALL] = true }
  -- called by the patched Hit.run once the move's base type is known
  function A.moveType(M)
    local ad, user, move = M.adapter, M.user, M.move
    user.campaignAteBoost = nil
    local k = key(ad, user)
    local t = tonumber(M.moveType or move.type)
    if OWN_TYPE[tonumber(move.effect)] or move.campaignOwnType or tonumber(M.mnum) == 165 then return end
    local new
    if ATE[k] and t == T.NORMAL then new = ATE[k]; user.campaignAteBoost = true
    elseif k == "NORMALIZE" then new = T.NORMAL; user.campaignAteBoost = true
    elseif k == "LIQUID_VOICE" and flag(move, "FLAG_SOUND") then new = T.WATER
    elseif k == "SAND_SONG" and flag(move, "FLAG_SOUND") then new = T.GROUND end
    if new and new ~= t then M.moveType, M.campaignMoveType = new, new end
  end

  -- Protean / Libero: the user becomes the type of the move it is about to use
  local function protean(M)
    local ad, user = M.adapter, M.user
    local k = key(ad, user)
    if k ~= "PROTEAN" and k ~= "LIBERO" then return end
    if M.opts and M.opts.called then return end
    local t = tonumber(M.moveType or M.move.type)
    if not t or t == 9 then return end
    local t1, t2, t3 = U.types(user)
    if t1 == t and (t2 == nil or t2 == t) and not t3 then return end
    user.type1, user.type2, user.campaignType3 = t, t, nil
    if user.expTransform then user.expTransform.type1, user.expTransform.type2 = t, t end
    local Types = require("src.core.game3.battle.types")
    say(ad, nm(ad, user) .. "'s " .. A.name(k) .. " transformed it into the " .. Types.name(t) .. " type!")
  end

  -- priority -----------------------------------------------------------------------
  local TRIAGE = {}
  for _, n in ipairs({ "RESTORE_HP", "REST", "MORNING_SUN", "MOONLIGHT", "SYNTHESIS", "SOFTBOILED", "ABSORB",
      "SWALLOW", "WISH", "HEAL_PULSE", "HEALING_WISH", "ROOST", "DREAM_EATER" }) do
    if E[n] then TRIAGE[E[n]] = true end
  end
  local TRIAGE_SOURCE = { EFFECT_HEAL_PULSE = true, EFFECT_HEALING_WISH = true, EFFECT_ROOST = true,
    EFFECT_RESTORE_HP = true, EFFECT_ABSORB = true }
  local function triaged(move)
    if TRIAGE[tonumber(move.effect)] then return true end
    local row = data.moves[tonumber(move.numId) or 0]
    return row ~= nil and TRIAGE_SOURCE[row.sourceEffect] == true
  end
  -- the ability's change to a move's priority bracket
  function A.priorityBonus(ad, b, move)
    move = moveRecord(move)
    if not move or not b then return 0 end
    local k = key(ad, b)
    if k == "PRANKSTER" and not damaging(move) then return 1 end
    if k == "GALE_WINGS" and tonumber(move.type) == T.FLYING then return 1 end
    if k == "TRIAGE" and triaged(move) then return 3 end
    if k == "BLITZ_BOXER" and flag(move, "FLAG_IRON_FIST_BOOST") then return 1 end
    return 0
  end
  function A.priority(ad, b, move)
    move = moveRecord(move)
    return (tonumber(move and move.priority) or 0) + A.priorityBonus(ad, b, move)
  end
  -- -1: last in its bracket (Stall), 1: first (Quick Draw's 30%)
  function A.orderBias(ad, b, move)
    local k = key(ad, b)
    if k == "STALL" then return -1 end
    if k == "QUICK_DRAW" then
      local st = ad and ad._st
      move = moveRecord(move)
      if st and move and damaging(move) then
        if b.campaignQuickDrawTurn ~= st.turn then
          b.campaignQuickDrawTurn, b.campaignQuickDraw = st.turn, ad:roll(0, 99) < 30
          if b.campaignQuickDraw then say(ad, nm(ad, b) .. "'s Quick Draw made it act faster!") end
        end
        if b.campaignQuickDraw then return 1 end
      end
    end
    return 0
  end
  function A.affectsOrder(ad, b, move)
    local k = key(ad, b)
    return k == "STALL" or k == "QUICK_DRAW" or k == "SAND_RUSH" or k == "SLUSH_RUSH" or k == "SURGE_SURFER"
      or k == "QUICK_FEET" or k == "UNBURDEN" or k == "SLOW_START" or A.priorityBonus(ad, b, move) ~= 0
  end

  -- speed ----------------------------------------------------------------------------
  local speedOf = Engine.speedOf
  Engine.speedOf = function(b, st, ad, ...)
    local s = speedOf(b, st, ad, ...)
    if not F.active() or not b or not ad or s >= 0xFFFFFFFF then return s end
    local k = key(ad, b)
    local w = weather(ad)
    if (k == "SAND_RUSH" and w == "SAND") or (k == "SLUSH_RUSH" and w == "HAIL")
        or (k == "SURGE_SURFER" and F.terrain(ad._st) == "ELECTRIC") then
      s = s * 2
    elseif k == "QUICK_FEET" and statusOf(ad, b) then
      s = mul(s, 1.5)
      if statusOf(ad, b) == "PAR" then s = s * 2 end
    elseif k == "UNBURDEN" and b.campaignHadItem and U.item(b) == 0 then
      s = s * 2
    elseif k == "SLOW_START" and (b.campaignSlowStart or 0) > 0 then
      s = math.floor(s / 2)
    end
    return math.max(1, s)
  end

  -- base power (field.lua F.power, before terrain) ---------------------------------
  local POWER = {
    TECHNICIAN = function(c) return c.power <= 60 and 1.5 end,
    FLARE_BOOST = function(c) return c.status == "BRN" and special(c.move) and 1.5 end,
    TOXIC_BOOST = function(c) return (c.status == "PSN" or c.status == "TOX") and physical(c.move) and 1.5 end,
    RECKLESS = function(c) return flag(c.move, "FLAG_RECKLESS_BOOST") and 1.2 end,
    IRON_FIST = function(c) return flag(c.move, "FLAG_IRON_FIST_BOOST") and 1.2 end,
    POWER_FISTS = function(c) return flag(c.move, "FLAG_IRON_FIST_BOOST") and 1.2 end,
    KEEN_EDGE = function(c) return flag(c.move, "FLAG_KEEN_EDGE_BOOST") and 1.3 end,
    SHEER_FORCE = function(c) return flag(c.move, "FLAG_SHEER_FORCE_BOOST") and 1.3 end,
    SAND_FORCE = function(c)
      return (c.type == T.STEEL or c.type == T.ROCK or c.type == T.GROUND) and weather(c.ad) == "SAND" and 1.3
    end,
    RIVALRY = function(c)
      local ga, gd = Abilities.genderOf(c.attacker), Abilities.genderOf(c.defender)
      if ga == "U" or gd == "U" then return nil end
      return ga == gd and 1.25 or 0.75
    end,
    ANALYTIC = function(c)
      if not c.ad then return nil end
      for _, o in ipairs(U.all(c.ad)) do
        if o ~= c.attacker and not U.movedThisTurn(c.ad, o) then return nil end
      end
      return 1.3
    end,
    TOUGH_CLAWS = function(c) return contact(c.ad, c.attacker, c.move) and 1.3 end,
    STRONG_JAW = function(c) return flag(c.move, "FLAG_STRONG_JAW_BOOST") and 1.5 end,
    MEGA_LAUNCHER = function(c) return flag(c.move, "FLAG_MEGA_LAUNCHER_BOOST") and 1.5 end,
    WATER_BUBBLE = function(c) return c.type == T.WATER and 2 end,
    STEELWORKER = function(c) return c.type == T.STEEL and 1.5 end,
    PUNK_ROCK = function(c) return flag(c.move, "FLAG_SOUND") and 1.3 end,
    STEELY_SPIRIT = function(c) return c.type == T.STEEL and 1.5 end,
    TRANSISTOR = function(c) return c.type == T.ELECTRIC and 1.5 end,
    DRAGONS_MAW = function(c) return c.type == T.DRAGON and 1.5 end,
    -- the donor's Liquid Voice falls through into Gorilla Tactics
    LIQUID_VOICE = function(c)
      local f = flag(c.move, "FLAG_SOUND") and 1.2 or 1
      if physical(c.move) then f = f * 1.5 end
      return f ~= 1 and f
    end,
    GORILLA_TACTICS = function(c) return physical(c.move) and 1.5 end,
  }
  for sym in pairs(ATE) do POWER[sym] = function(c) return c.attacker.campaignAteBoost and 1.2 end end
  POWER.NORMALIZE = function(c) return c.attacker.campaignAteBoost and c.type == T.NORMAL and 1.2 end
  function A.power(attacker, defender, move, moveType, power, opts)
    if not F.active() or power <= 0 then return power end
    local ad = adapterOf(opts and opts.adapter)
    local c = { ad = ad, attacker = attacker, defender = defender, move = move, type = moveType, power = power,
      status = statusOf(ad, attacker) }
    local m = 1
    local fn = POWER[key(ad, attacker) or ""]
    local f = fn and fn(c)
    if f then m = m * f end
    if ad then
      if (moveType == T.DARK and onField(ad, "DARK_AURA")) or (moveType == T.FAIRY and onField(ad, "FAIRY_AURA")) then
        m = m * (onField(ad, "AURA_BREAK") and 0.75 or 1.33)
      end
      local p = partnerOf(ad, attacker)
      local pk = p and key(ad, p)
      if pk == "BATTERY" and special(move) then m = m * 1.3
      elseif pk == "POWER_SPOT" then m = m * 1.3
      elseif pk == "STEELY_SPIRIT" and moveType == T.STEEL then m = m * 1.5 end
    end
    local dk = key(ad, defender)
    if (dk == "HEATPROOF" or dk == "WATER_BUBBLE") and moveType == T.FIRE then m = m * 0.5
    elseif dk == "DRY_SKIN" and moveType == T.FIRE then m = m * 1.25
    elseif dk == "FLUFFY" then
      if contact(ad, attacker, move) then m = m * 0.5 end
      if moveType == T.FIRE then m = m * 2 end
    end
    if m == 1 then return power end
    return math.max(1, math.floor(power * m))
  end

  -- attack and defense stats (patched damage formula, after held items) -------------
  local PINCH = { OVERGROW = T.GRASS, BLAZE = T.FIRE, TORRENT = T.WATER, SWARM = T.BUG, VENGEANCE = T.GHOST }
  local function cherrim(b)
    local sp = data.identity.namespaces.species
    return b.species == sp.SPECIES_CHERRIM or b.species == sp.SPECIES_CHERRIM_SUNSHINE
  end
  function A.stats(attacker, defender, move, moveType, isPhysical, atk, def, spa, spd, adapter)
    if not F.active() then return atk, def, spa, spd end
    local ad = adapterOf(adapter)
    local k, dk = key(ad, attacker), key(ad, defender)
    local w = weather(ad)
    local function both(f) atk, spa = mul(atk, f), mul(spa, f) end
    local function used(f) if isPhysical then atk = mul(atk, f) else spa = mul(spa, f) end end
    if k == "SLOW_START" and (attacker.campaignSlowStart or 0) > 0 then both(0.5)
    elseif k == "SOLAR_POWER" and not isPhysical and w == "SUN" then spa = mul(spa, 1.5)
    elseif k == "DEFEATIST" and hp(ad, attacker) <= math.floor(maxHp(ad, attacker) / 2) then both(0.5)
    elseif PINCH[k] and moveType == PINCH[k] then
      -- Inclement: 1.2x outside a pinch; the native formula adds 1.5x in one
      -- (Vengeance is new and gets both here)
      local pinch = hp(ad, attacker) <= math.floor(maxHp(ad, attacker) / 3)
      if k == "VENGEANCE" then used(pinch and 1.5 or 1.2)
      elseif not pinch then used(1.2) end
    elseif k == "FLOWER_GIFT" and cherrim(attacker) and w == "SUN" and isPhysical then atk = mul(atk, 1.5)
    elseif k == "STAKEOUT" and ad and defender.campaignEnteredTurn == ad._st.turn and (ad._st.turn or 0) > 0 then used(2)
    elseif k == "WHITEOUT" and moveType == T.ICE and w == "HAIL" then used(1.5)
    end
    -- Flash Fire's boost (the Inclement rules skip the native one)
    if attacker.expFlashFire and moveType == T.FIRE then used(1.5) end
    if ad then
      local p = partnerOf(ad, attacker)
      if p and key(ad, p) == "FLOWER_GIFT" and cherrim(p) and w == "SUN" and isPhysical then atk = mul(atk, 1.5) end
    end
    -- the defender's abilities against the attack stat
    if dk == "THICK_FAT" and isPhysical and (moveType == T.FIRE or moveType == T.ICE) then atk = mul(atk, 0.5)
    elseif dk == "ICE_SCALES" and not isPhysical then spa = mul(spa, 0.5) end
    -- the defender's own stats
    if dk == "FUR_COAT" then def = def * 2
    elseif dk == "GRASS_PELT" and F.terrain(ad and ad._st) == "GRASSY" then def = mul(def, 1.5)
    elseif dk == "PUNK_ROCK" and flag(move, "FLAG_SOUND") then def, spd = def * 2, spd * 2
    elseif dk == "FLOWER_GIFT" and cherrim(defender) and w == "SUN" then spd = mul(spd, 1.5) end
    if ad then
      local p = partnerOf(ad, defender)
      if p and key(ad, p) == "FLOWER_GIFT" and cherrim(p) and w == "SUN" then spd = mul(spd, 1.5) end
    end
    return math.max(1, atk), math.max(1, def), math.max(1, spa), math.max(1, spd)
  end

  -- Unaware: the other side's stat stages don't count
  function A.stages(attacker, defender, move, aStages, dStages, adapter)
    if not F.active() then return aStages, dStages end
    local ad = adapterOf(adapter)
    if key(ad, defender) == "UNAWARE" then
      local s = {}
      for k, v in pairs(aStages) do s[k] = v end
      s.attack, s.spAtk = 0, 0
      aStages = s
    end
    if key(ad, attacker) == "UNAWARE" then
      local s = {}
      for k, v in pairs(dStages) do s[k] = v end
      s.defense, s.spDef = 0, 0
      dStages = s
    end
    return aStages, dStages
  end

  -- final damage (patched damage formula, after held items) ---------------------------
  function A.finalDamage(attacker, defender, move, moveType, eff, dmg, crit, opts)
    if not F.active() or dmg <= 0 then return dmg end
    local ad = adapterOf(opts and opts.adapter)
    local m = 1
    local k, dk = key(ad, attacker), key(ad, defender)
    if k == "TINTED_LENS" and eff > 0 and eff < 1 then m = m * 2
    elseif k == "SNIPER" and crit then m = m * 1.5
    elseif k == "NEUROFORCE" and eff >= 2 then m = m * 1.25 end
    if (dk == "MULTISCALE" or dk == "SHADOW_SHIELD") and fullHp(ad, defender) then m = m * 0.5
    elseif (dk == "FILTER" or dk == "SOLID_ROCK" or dk == "PRISM_ARMOR") and eff >= 2 then m = m * 0.75
    elseif dk == "ICE_SCALES" and special(move) then m = m * 0.5
    elseif dk == "PRISM_SCALES" and special(move) then m = m * 0.7 end
    if ad then
      local p = partnerOf(ad, defender)
      if p and key(ad, p) == "FRIEND_GUARD" then m = m * 0.75 end
    end
    if m == 1 then return dmg end
    return math.max(1, math.floor(dmg * m))
  end

  -- damage options per hit: Infiltrator skips screens, a changed move type
  function A.calcOpts(M, o)
    if M.campaignMoveType then o.moveType = M.campaignMoveType end
    if key(M.adapter, M.user) == "INFILTRATOR" then o.reflect, o.lightScreen = false, false end
  end
  -- Infiltrator and sound moves pass through a Substitute
  function A.ignoresSub(M)
    if not F.active() or not M.user then return false end
    return key(M.adapter, M.user) == "INFILTRATOR" or flag(M.move, "FLAG_SOUND")
  end

  -- type effectiveness (field.lua F.effectiveness) -------------------------------------
  function A.effectiveness(ad, attacker, defender, move, moveType, eff)
    if eff == 0 and key(ad, attacker) == "SCRAPPY" and (moveType == T.NORMAL or moveType == T.FIGHTING)
        and U.hasType(defender, T.GHOST) then
      local Types = require("src.core.game3.battle.types")
      local t1, t2, t3 = U.types(defender)
      local out = 1
      for _, t in ipairs({ t1, t2 ~= t1 and t2 or nil, t3 }) do
        if t and t ~= T.GHOST then out = out * Types.effectiveness(moveType, t, t) end
      end
      return out
    end
    return eff
  end

  -- moves stopped by an ability (field.lua F.blocked, before protection) ----------------
  local AROMA = {}
  for _, n in ipairs({ "TAUNT", "ENCORE", "DISABLE", "TORMENT", "ATTRACT" }) do if E[n] then AROMA[E[n]] = true end end
  function A.blocked(M)
    local move, user, target, ad = M.move, M.user, M.target, M.adapter
    local tk = key(ad, target)
    local foe = target.side ~= user.side
    if tk == "SOUNDPROOF" and flag(move, "FLAG_SOUND") and target ~= user then
      return nm(ad, target) .. "'s Soundproof blocks " .. (M.moveName or "the move") .. "!"
    end
    if tk == "BULLETPROOF" and flag(move, "FLAG_BALLISTIC") then
      return nm(ad, target) .. "'s Bulletproof blocks " .. (M.moveName or "the move") .. "!"
    end
    if tk == "OVERCOAT" and flag(move, "FLAG_POWDER") then
      return "It doesn't affect " .. nm(ad, target) .. "..."
    end
    if tk == "TELEPATHY" and not foe and damaging(move) then
      return nm(ad, target) .. " avoids attacks by its ally Pokémon!"
    end
    if foe and A.priority(ad, user, move) > 0 then
      local guard = onSide(ad, target, "QUEENLY_MAJESTY") or onSide(ad, target, "DAZZLING")
      if guard then return nm(ad, user) .. " cannot use " .. (M.moveName or "the move") .. "!" end
    end
    if foe and not damaging(move) and key(ad, user) == "PRANKSTER" and U.hasType(target, T.DARK) then
      return "It doesn't affect " .. nm(ad, target) .. "..."
    end
    if foe and AROMA[tonumber(move.effect)] and onSide(ad, target, "AROMA_VEIL") then
      return nm(ad, target) .. " is protected by an aromatic veil!"
    end
    return nil
  end
  -- Unseen Fist: contact moves go through protection
  function A.unprotected(M) return key(M.adapter, M.user) == "UNSEEN_FIST" and contact(M.adapter, M.user, M.move) end

  -- moves that never miss, and accuracy ---------------------------------------------
  function A.noGuard(M)
    if not F.active() then return false end
    return key(M.adapter, M.user) == "NO_GUARD" or (M.target and key(M.adapter, M.target) == "NO_GUARD") or false
  end
  function A.accStages(M, acc, eva)
    if not F.active() then return acc, eva end
    local uk, tk = key(M.adapter, M.user), M.target and key(M.adapter, M.target)
    if (uk == "KEEN_EYE" or uk == "UNAWARE") and eva > 0 then eva = 0 end
    if tk == "UNAWARE" then acc = 0 end
    return acc, eva
  end
  function A.accuracy(M, calc)
    if not F.active() then return calc end
    local ad, user, target = M.adapter, M.user, M.target
    local tk = target and key(ad, target)
    if tk == "WONDER_SKIN" and not damaging(M.move) and target.side ~= user.side and calc > 50 then calc = 50 end
    if tk == "TANGLED_FEET" and (target.confusionTurns or 0) > 0 then calc = mul(calc, 0.5) end
    if tk == "SNOW_CLOAK" and weather(ad) == "HAIL" then calc = mul(calc, 0.8) end
    if onSide(ad, user, "VICTORY_STAR") then calc = mul(calc, 1.1) end
    return calc
  end

  -- secondary effects: Sheer Force removes them, Pyromancy quintuples burns -----------
  local withChance = Secondary.withChance
  Secondary.withChance = function(M, eff, certainFlag, affectsUser, ...)
    if F.active() and M and M.user and not certainFlag then
      local k = key(M.adapter, M.user)
      if k == "SHEER_FORCE" and flag(M.move, "FLAG_SHEER_FORCE_BOOST") then return false end
      if k == "PYROMANCY" and tonumber(M.moveType or M.move.type) == T.FIRE and eff == "BURN" and not M.noEffect then
        local chance = (tonumber(M.move.secondaryChance) or 0) * 5
        if M.adapter:roll(0, 99) < chance then return Secondary.set(M, eff, false, chance >= 100, affectsUser) end
        return false
      end
    end
    return withChance(M, eff, certainFlag, affectsUser, ...)
  end
  -- the campaign moves' own chance roll (hits.lua)
  function A.chance(M, pct)
    local k = key(M.adapter, M.user)
    if k == "SHEER_FORCE" and flag(M.move, "FLAG_SHEER_FORCE_BOOST") then return 0 end
    if k == "SERENE_GRACE" then return pct * 2 end
    return pct
  end
  function A.sheerForced(M) return key(M.adapter, M.user) == "SHEER_FORCE" and flag(M.move, "FLAG_SHEER_FORCE_BOOST") end

  -- indirect damage: Magic Guard ----------------------------------------------------------
  function A.magicGuard(ad, b) return F.active() and b ~= nil and key(ad, b) == "MAGIC_GUARD" end
  function A.noRecoil(ad, b)
    local k = key(ad, b)
    return k == "ROCK_HEAD" or k == "MAGIC_GUARD"
  end
  local set = Secondary.set
  local corrode
  Secondary.set = function(M, eff, ...)
    if F.active() and M and M.user and (eff == "RECOIL_25" or eff == "RECOIL_33") and A.magicGuard(M.adapter, M.user) then
      return false
    end
    if F.active() and M and M.user and M.target and corrode and key(M.adapter, M.user) == "CORROSION" then
      return corrode(M.adapter, M.target, set, M, eff, ...)
    end
    return set(M, eff, ...)
  end
  -- poison and burn: Magic Guard takes none, Poison Heal heals, Heatproof halves burns
  local Status = require("src.core.game3.battle.status")
  local tickChip = Status.tickChip
  Status.tickChip = function(b, ad, ...)
    if F.active() and b and ad and not ad:isFainted(b) then
      local s = ad:status(b)
      local k = key(ad, b)
      if s and k == "MAGIC_GUARD" then return {} end
      if (s == "PSN" or s == "TOX") and k == "POISON_HEAL" then
        if s == "TOX" then b.toxicCounter = math.min(15, (b.toxicCounter or 0) + 1) end
        if ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
          U.heal(ad, b, ad:maxHp(b) / 8)
          say(ad, nm(ad, b) .. "'s Poison Heal restored its HP a little!")
        end
        return {}
      end
      if s == "BRN" and (k == "HEATPROOF" or k == "WATER_BUBBLE") then
        if k == "WATER_BUBBLE" then ad:clearStatus(b); return {} end
        ad:sayText("STRINGID_PKMNHURTBYBURN", { atk = b })
        ad:playAnim("status", "BURN", b, b)
        ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 16)))
        return {}
      end
    end
    return tickChip(b, ad, ...)
  end
  -- Leech Seed, Nightmare, Curse and binding skip a Magic Guard holder: their
  -- marks are set aside for those phases and put back afterwards
  local HIDE = { "expSeeded", "expNightmare", "expCursed", "expTrapTurns" }
  Residuals.register("campaign_guard_on", function(ctx)
    local ad, b = ctx.adapter, ctx.target
    if not F.active() or not b or not A.magicGuard(ad, b) then return end
    b.campaignGuarded = {}
    for _, f in ipairs(HIDE) do b.campaignGuarded[f], b[f] = b[f], nil end
  end)
  Residuals.register("campaign_guard_off", function(ctx)
    local b = ctx.target
    if not b or not b.campaignGuarded then return end
    for _, f in ipairs(HIDE) do b[f] = b.campaignGuarded[f] end
    b.campaignGuarded = nil
    -- binding still counts down
    if (b.expTrapTurns or 0) > 0 then
      b.expTrapTurns = b.expTrapTurns - 1
      if b.expTrapTurns <= 0 then b.expTrapTurns, b.expTrapMove, b.expTrapSource, b.wrapped = nil, nil, nil, nil end
    end
  end)
  -- weather chip: abilities that ride out sand or hail (Magic Guard,
  -- Overcoat, Sand Rush/Force, Ice Body, Snow Cloak, Slush Rush) are hidden
  -- from it the way the native check hides Dig and Dive
  local SAND_SAFE = { MAGIC_GUARD = true, OVERCOAT = true, SAND_RUSH = true, SAND_FORCE = true }
  local HAIL_SAFE = { MAGIC_GUARD = true, OVERCOAT = true, ICE_BODY = true, SNOW_CLOAK = true, SLUSH_RUSH = true }
  local Handlers = require("src.core.game3.battle.residual_handlers")
  local tickWeather = Handlers.tickWeather
  Handlers.tickWeather = function(ad, ...)
    if not F.active() or not ad then return tickWeather(ad, ...) end
    local kind = Rules.weather.kind(ad._st.weather)
    local hidden = {}
    for _, b in ipairs(U.all(ad)) do
      local k = key(ad, b)
      local safe = (kind == "SAND" and SAND_SAFE[k]) or (kind == "HAIL" and HAIL_SAFE[k])
        or (F.items and U.held and U.held(b) == "SAFETY_GOGGLES")
      if safe and not b.semiInvulnerable then hidden[#hidden + 1] = b; b.semiInvulnerable = "UNDERWATER" end
    end
    local ok, err = pcall(tickWeather, ad, ...)
    for _, b in ipairs(hidden) do b.semiInvulnerable = nil end
    if not ok then error(err, 0) end
  end

  -- status conditions ---------------------------------------------------------------------
  local function guardedStatus(ad, b, status)
    local k = key(ad, b)
    local w = weather(ad)
    if k == "COMATOSE" then return "COMATOSE" end
    if k == "LEAF_GUARD" and w == "SUN" then return k end
    if (k == "WATER_BUBBLE" or k == "WATER_VEIL") and status == "BRN" then return k end
    if k == "SHIELDS_DOWN" and A.formOf and not (A.formOf(b) or ""):find("CORE", 1, true) then return k end
    if U.hasType(b, T.GRASS) and onSide(ad, b, "FLOWER_VEIL") then return "FLOWER_VEIL" end
    if status == "SLP" and onSide(ad, b, "SWEET_VEIL") then return "SWEET_VEIL" end
    if (status == "PSN" or status == "TOX") and onSide(ad, b, "PASTEL_VEIL") then return "PASTEL_VEIL" end
    return nil
  end
  A.guardedStatus = guardedStatus
  -- Corrosion poisons Steel and Poison types: their poison immunity is hidden
  -- from the native check while it looks
  local function corroding(ad, b, status, src)
    if status ~= "PSN" and status ~= "TOX" then return false end
    src = src or source(ad)
    return src ~= nil and src ~= b and key(ad, src) == "CORROSION"
      and (U.hasType(b, T.POISON) or U.hasType(b, T.STEEL))
  end
  local withoutPoisonTypes
  function withoutPoisonTypes(ad, b, fn, ...)
    local hasType, helperType = ad.hasType, H.hasType
    ad.hasType = function(self, x, t, ...)
      if x == b and (t == T.POISON or t == T.STEEL) then return false end
      return hasType(self, x, t, ...)
    end
    H.hasType = function(ctx, x, t, ...)
      if x == b and (t == T.POISON or t == T.STEEL or t == "POISON" or t == "STEEL") then return false end
      return helperType(ctx, x, t, ...)
    end
    local r = { pcall(fn, ...) }
    ad.hasType, H.hasType = hasType, helperType
    if not r[1] then error(r[2], 0) end
    return unpack(r, 2, table.maxn(r))
  end
  corrode = withoutPoisonTypes
  local function statusName(s) s = tostring(s or ""):upper(); return (s == "POISON" and "PSN") or (s == "BURN" and "BRN")
    or (s == "PARALYSIS" and "PAR") or (s == "SLEEP" and "SLP") or (s == "FREEZE" and "FRZ") or (s == "TOXIC" and "TOX") or s end
  local function wrapStatus(a)
    local can, apply = a.canApplyStatus, a.applyStatus
    function a:canApplyStatus(b, status, src, ...)
      if F.active() and b and self._st then
        local s = statusName(status)
        if guardedStatus(self, b, s) then return false, "ability" end
        if corroding(self, b, s, src) then return withoutPoisonTypes(self, b, can, self, b, status, src, ...) end
      end
      return can(self, b, status, src, ...)
    end
    function a:applyStatus(b, status, src, ...)
      if F.active() and b and self._st then
        local s = statusName(status)
        if corroding(self, b, s, src) then return withoutPoisonTypes(self, b, apply, self, b, status, src, ...) end
      end
      return apply(self, b, status, src, ...)
    end
  end
  local newStatusAdapter = Adapter.new
  Adapter.new = function(...)
    local a = newStatusAdapter(...)
    wrapStatus(a)
    return a
  end
  -- the poison moves and secondary effects check types themselves
  local Effects = require("src.core.game3.battle.effects")
  local runForMove = Effects.runForMove
  Effects.runForMove = function(ad, user, target, moveId, ctx, ...)
    if F.active() and ad and user and target and target ~= user and key(ad, user) == "CORROSION"
        and (U.hasType(target, T.POISON) or U.hasType(target, T.STEEL)) then
      return withoutPoisonTypes(ad, target, runForMove, ad, user, target, moveId, ctx, ...)
    end
    return runForMove(ad, user, target, moveId, ctx, ...)
  end
  -- contact statuses and Synchronize skip canApplyStatus
  local applyAbility = Abilities.applyStatus
  Abilities.applyStatus = function(ad, holder, victim, status, ...)
    if F.active() and victim and guardedStatus(ad, victim, statusName(status)) then return false end
    return applyAbility(ad, holder, victim, status, ...)
  end
  -- Comatose counts as asleep for Hex, Dream Eater, Wake-Up Slap and Bad Dreams
  function A.asleep(ad, b) return ad:status(b) == "SLP" or key(ad, b) == "COMATOSE" end

  -- stat changes: Contrary, Simple, Clear Body's kin, Mirror Armor, Defiant ----------------
  local changeStat = Secondary.changeStat
  local function sideOf(b) return b and b.side end
  Secondary.changeStat = function(ad, b, stat, delta, flags, ...)
    if not F.active() or not ad or not b or not b.stages or delta == 0 then return changeStat(ad, b, stat, delta, flags, ...) end
    flags = flags or {}
    local k = key(ad, b)
    if k == "CONTRARY" then delta = -delta
    elseif k == "SIMPLE" then delta = delta * 2 end
    local src = flags.campaignSource or source(ad)
    local byFoe = delta < 0 and not flags.user and src ~= nil and src ~= b and sideOf(src) ~= sideOf(b)
    if byFoe and not flags.certain then
      local blocker
      if k == "FULL_METAL_BODY" then blocker = k
      elseif k == "BIG_PECKS" and stat == "defense" then blocker = k
      elseif U.hasType(b, T.GRASS) and onSide(ad, b, "FLOWER_VEIL") then blocker = "FLOWER_VEIL" end
      if blocker then
        if flags.allowPtr and not b._statLoweredMsg then
          b._statLoweredMsg = true
          say(ad, nm(ad, b) .. "'s " .. A.name(blocker) .. " prevents its stats from being lowered!")
        end
        return "blocked"
      end
      if k == "MIRROR_ARMOR" and not b.campaignMirroring then
        b.campaignMirroring = true
        say(ad, nm(ad, b) .. "'s Mirror Armor reflected the stat change!")
        local copy = {}
        for kk, v in pairs(flags) do copy[kk] = v end
        copy.campaignSource, copy.user = b, false
        local r = alive(ad, src) and Secondary.changeStat(ad, src, stat, delta, copy, ...) or "blocked"
        b.campaignMirroring = nil
        return r == "worked" and "blocked" or r
      end
    end
    local result = changeStat(ad, b, stat, delta, flags, ...)
    if result == "worked" and byFoe and alive(ad, b) then
      if k == "DEFIANT" then boost(ad, b, "attack", 2, k)
      elseif k == "COMPETITIVE" then boost(ad, b, "spAtk", 2, k) end
    end
    return result
  end

  -- Intimidate, with Inclement's (Gen 8) blockers and the abilities it sets off
  local INTIMIDATE_PROOF = { INNER_FOCUS = true, OBLIVIOUS = true, OWN_TEMPO = true, SCRAPPY = true }
  local runIntimidate = Abilities.runIntimidate
  Abilities.runIntimidate = function(ad, ...)
    if not F.active() or not ad then return runIntimidate(ad, ...) end
    for _, b in ipairs(ad:activeBattlers()) do
      if b.expIntimidatePending and ad:abilityOf(b) == "INTIMIDATE" then
        b.expIntimidatePending = nil
        if not Abilities.ghostBlocks(ad._st, "INTIMIDATE") then
          for _, foe in ipairs(U.foes(ad, b)) do
            local fk = key(ad, foe)
            if (foe.substituteHP or 0) > 0 then
              -- a Substitute takes it
            elseif INTIMIDATE_PROOF[fk] or fk == "CLEAR_BODY" or fk == "WHITE_SMOKE" or fk == "HYPER_CUTTER"
                or fk == "FULL_METAL_BODY" then
              say(ad, nm(ad, foe) .. "'s " .. A.name(fk) .. " prevents it from losing Attack!")
            else
              local before = U.stage(foe, "attack")
              local r = Secondary.changeStat(ad, foe, "attack", -1, { allowPtr = true, noMsg = true, campaignSource = b })
              if r == "worked" then
                say(ad, nm(ad, b) .. "'s Intimidate " .. (U.stage(foe, "attack") > before and "raised " or "cuts ")
                  .. nm(ad, foe) .. "'s Attack!")
              elseif r == "wont" then
                say(ad, nm(ad, foe) .. "'s Attack won't go any lower!")
              end
            end
            if alive(ad, foe) and fk == "RATTLED" then boost(ad, foe, "speed", 1, fk) end
          end
        end
        return true
      end
    end
    return false
  end

  -- absorbing moves: Sap Sipper, Motor Drive, Lightning Rod, Storm Drain, Dry Skin -------
  local ABSORB = { SAP_SIPPER = { T.GRASS, "attack" }, MOTOR_DRIVE = { T.ELECTRIC, "speed" },
    LIGHTNING_ROD = { T.ELECTRIC, "spAtk" }, STORM_DRAIN = { T.WATER, "spAtk" }, DRY_SKIN = { T.WATER } }
  -- (the native check marks the move context once and writes M.absorbed over
  -- the context's absorbed() method: a spread move would check one target
  -- and crash on the next; both are kept per target here)
  local absorb = Abilities.absorb
  Abilities.absorb = function(M, ...)
    local ad, user, target = M.adapter, M.user, M.target
    if not F.active() then return absorb(M, ...) end
    if M.campaignAbsorbTarget ~= target then M.absorbChecked, M.campaignAbsorbTarget = nil, target end
    if not M.absorbChecked and target and target ~= user then
      local k = key(ad, target)
      local row = ABSORB[k]
      local mt = tonumber(M.moveType or (M.move and M.move.type)) or -1
      if row and mt == row[1] and tonumber(M.move.target) ~= 16 then
        M.absorbChecked = true
        M:attackString()
        M.noEffect = true
        M.anim.missed = true
        if row[2] then
          if not boost(ad, target, row[2], 1, k, { quiet = true }) then
            say(ad, nm(ad, target) .. "'s " .. A.name(k) .. " made " .. (M.moveName or "the move") .. " ineffective!")
          end
        elseif ad:hp(target) >= ad:maxHp(target) or U.healBlocked(target) then
          say(ad, nm(ad, target) .. "'s " .. A.name(k) .. " made " .. (M.moveName or "the move") .. " useless!")
        else
          U.heal(ad, target, ad:maxHp(target) / 4)
          say(ad, nm(ad, target) .. " restored HP using its " .. A.name(k) .. "!")
        end
        return true
      end
    end
    local r = absorb(M, ...)
    if rawget(M, "absorbed") == true then M.absorbed = nil end
    return r
  end

  -- Storm Drain draws single-target Water moves; Stalwart and Propeller Tail
  -- ignore redirection
  local resolveTarget = Engine.resolveTarget
  Engine.resolveTarget = function(st, ad, attacker, moveId, chosenId, info, ...)
    local result = resolveTarget(st, ad, attacker, moveId, chosenId, info, ...)
    if not F.active() or not (st and st.double and ad and attacker) then return result end
    local mv = Moves.get(moveId)
    local ak = key(ad, attacker)
    if (ak == "STALWART" or ak == "PROPELLER_TAIL") and chosenId ~= nil and result ~= chosenId
        and tonumber(mv and mv.target) == 0 and State.isPresent(st, chosenId) then
      local was = State.battler(st, result)
      if was then was.expLightningRodRedirected = nil end
      return chosenId
    end
    if mv and tonumber(mv.target) == 0 and tonumber(mv.type) == T.WATER and ak ~= "STALWART" and ak ~= "PROPELLER_TAIL" then
      local aid = State.idOf(attacker)
      local cur = State.battler(st, result)
      if cur and key(ad, cur) ~= "STORM_DRAIN" then
        for id = 0, 3 do
          local b = State.battler(st, id)
          if b and id % 2 ~= aid % 2 and id ~= result and State.isPresent(st, id) and alive(ad, b) and key(ad, b) == "STORM_DRAIN" then
            b.campaignDrewIn = true
            return id
          end
        end
      end
    end
    return result
  end

  -- per target, before the move: Magic Bounce, Storm Drain's line, Protean -----------------
  local forEach = Engine.forEachTarget
  Engine.forEachTarget = function(M, body, ...)
    if not F.active() or not M or not M.user then return forEach(M, body, ...) end
    local wrapped = function(...)
      local target = M.target
      local bounced
      if target and target ~= M.user and not (M.opts and M.opts.bounced) and not target.expMagicCoat
          and key(M.adapter, target) == "MAGIC_BOUNCE" and math.floor((tonumber(M.move.flags) or 0) / 4) % 2 == 1 then
        target.expMagicCoat, bounced = true, target
      end
      if target and target.campaignDrewIn then
        target.campaignDrewIn = nil
        say(M.adapter, nm(M.adapter, target) .. "'s Storm Drain took the attack!")
      end
      local r = { pcall(body, ...) }
      if bounced then bounced.expMagicCoat = nil end
      if not r[1] then error(r[2], 0) end
      return unpack(r, 2, table.maxn(r))
    end
    if not M.campaignProtean then
      M.campaignProtean = true
      A.stanceChange(M)
      -- the type the move will have (after -ate abilities) decides Protean's type
      local probe = { adapter = M.adapter, user = M.user, move = M.move, mnum = M.mnum, moveType = tonumber(M.move.type), opts = M.opts }
      A.moveType(probe)
      M.user.campaignAteBoost = nil
      protean(probe)
    end
    return forEach(M, wrapped, ...)
  end

  -- Aegislash: Blade to attack, Shield for King's Shield
  local KINGS_SHIELD = data.identity.namespaces.moves.MOVE_KINGS_SHIELD
  function A.stanceChange(M)
    local ad, user = M.adapter, M.user
    if key(ad, user) ~= "STANCE_CHANGE" then return end
    local f = A.formOf(user)
    if f == "AEGISLASH" and damaging(M.move) then
      A.changeForm(ad, user, "AEGISLASH_BLADE", "Changed to Blade Forme!")
    elseif f == "AEGISLASH_BLADE" and tonumber(M.mnum) == KINGS_SHIELD then
      A.changeForm(ad, user, "AEGISLASH", "Changed to Shield Forme!")
    end
  end

  -- crits: Super Luck, Merciless; who took one (Anger Point) ------------------------------
  mod.hooks:wrap("battle.crit", function(next, c)
    if not F.active() or not c or not c.attacker then return next(c) end
    local ad = adapterOf()
    local crit
    local k = key(ad, c.attacker)
    local s = c.target and statusOf(ad, c.target)
    if k == "MERCILESS" and (s == "PSN" or s == "TOX") then
      crit = true
    elseif k == "SUPER_LUCK" then
      local rec = c.moveNum and Moves.get(c.moveNum)
      local stage = Rules.crit.stage(c.attacker, rec, rec and rec.highCrit) + 1
      local den = ({ [0] = 24, [1] = 8, [2] = 2 })[stage] or 1
      local roll = 0
      if den > 1 then
        local ok, v = pcall(c.rng, 0, den - 1)
        roll = ok and tonumber(v) and v % den or 1
      end
      crit = roll == 0
    else
      crit = next(c)
    end
    if crit and c.target then c.target.campaignCritBy = c.attacker end
    return crit
  end)

  -- battle forms ----------------------------------------------------------------------------
  local SP = data.identity.namespaces.species
  local function formOf(b)
    local id = tonumber(b.species or (b.mon and b.mon.species))
    local row = id and data.species[id]
    return row and tostring(row.symbol):gsub("^SPECIES_", "") or nil
  end
  A.formOf = formOf
  local STAT_KEYS = { { "attack", "atk" }, { "defense", "def" }, { "speed", "spe" }, { "spAtk", "spa" }, { "spDef", "spd" } }
  -- the battler becomes `sym` for the rest of its time in battle
  function A.changeForm(ad, b, sym, text)
    local id = SP["SPECIES_" .. sym]
    if not id or tonumber(b.species) == id or not b.mon then return false end
    local P = require("src.core.game3.pokemon")
    local Damage = require("src.core.game3.battle.damage")
    local mon = State.partyMon(b)
    local oldId = tonumber(b.species) or P.speciesOf(mon)
    local old = P.calcStats(oldId, mon.level, mon.ivs, mon.evs, mon.personality)
    local new = P.calcStats(id, mon.level, mon.ivs, mon.evs, mon.personality)
    local proxy = State.ensureBattleMoves(b)
    for _, pair in ipairs(STAT_KEYS) do
      local cur = Damage.monStat(proxy, pair[1], 1)
      local v = math.max(1, math.floor(cur * new[pair[1]] / math.max(1, old[pair[1]]) + 0.5))
      rawset(proxy, pair[1], v)
      rawset(proxy, pair[2], v)
    end
    b.species = id
    local types = data.species[id] and data.species[id].types
    if types then b.type1, b.type2, b.campaignType3 = types[1], types[2] or types[1], nil end
    if text then say(ad, text) end
    pcall(function() require("src.core.game3.battle.anim").syncDisplayFromState(ad._st) end)
    return true
  end
  local changeForm = A.changeForm
  -- Minior: Meteor while above half HP, Core below
  local function minior(b)
    local f = formOf(b) or ""
    local color = f:match("^MINIOR_METEOR_(%u+)$") or f:match("^MINIOR_CORE_(%u+)$") or "RED"
    return color, f:find("CORE", 1, true) ~= nil
  end
  -- Disguise and Ice Face stay broken for the rest of the battle, even
  -- across switches (kept per party Pokémon)
  function A.markBroken(ad, b, on)
    local st = ad._st
    st.campaignBroken = st.campaignBroken or setmetatable({}, { __mode = "k" })
    st.campaignBroken[State.partyMon(b) or b.mon] = (on ~= false) or nil
  end
  local function broken(ad, b)
    local st = ad._st
    return st.campaignBroken and st.campaignBroken[State.partyMon(b) or b.mon] or false
  end
  -- HP-driven forms, checked on entry and at the end of each turn
  function A.hpForms(ad, b)
    local k0, f0 = key(ad, b), formOf(b)
    if k0 == "DISGUISE" and f0 == "MIMIKYU" and broken(ad, b) then return changeForm(ad, b, "MIMIKYU_BUSTED", nil) end
    if k0 == "ICE_FACE" and f0 == "EISCUE" and broken(ad, b) and weather(ad) ~= "HAIL" then
      return changeForm(ad, b, "EISCUE_NOICE_FACE", nil)
    end
    local k = key(ad, b)
    local f = formOf(b) or ""
    local frac = ad:hp(b) / math.max(1, ad:maxHp(b))
    if k == "ZEN_MODE" and f:find("^DARMANITAN") then
      local galar = f:find("GALARIAN", 1, true) and "_GALARIAN" or ""
      if frac <= 0.5 and not f:find("ZEN", 1, true) then
        return changeForm(ad, b, "DARMANITAN_ZEN_MODE" .. galar, nm(ad, b) .. " triggered Zen Mode!")
      elseif frac > 0.5 and f:find("ZEN", 1, true) then
        return changeForm(ad, b, "DARMANITAN" .. galar, nm(ad, b) .. "'s Zen Mode ended!")
      end
    elseif k == "SCHOOLING" and f:find("^WISHIWASHI") then
      local mon = State.partyMon(b)
      if (tonumber(mon.level) or 1) >= 20 and frac > 0.25 then
        return changeForm(ad, b, "WISHIWASHI_SCHOOL", nm(ad, b) .. " formed a school!")
      elseif f == "WISHIWASHI_SCHOOL" and frac <= 0.25 then
        return changeForm(ad, b, "WISHIWASHI", nm(ad, b) .. " stopped schooling!")
      end
    elseif k == "SHIELDS_DOWN" and f:find("^MINIOR") then
      local color, core = minior(b)
      if frac <= 0.5 and not core then
        return changeForm(ad, b, "MINIOR_CORE_" .. color, "Shields Down activated!")
      elseif frac > 0.5 and core then
        return changeForm(ad, b, color == "RED" and "MINIOR" or ("MINIOR_METEOR_" .. color), nm(ad, b) .. "'s shell is back!")
      end
    elseif k == "POWER_CONSTRUCT" and f:find("^ZYGARDE") and f ~= "ZYGARDE_COMPLETE" and frac <= 0.5 then
      say(ad, "You sense the presence of many!")
      local before = ad:maxHp(b)
      local done = changeForm(ad, b, "ZYGARDE_COMPLETE", nm(ad, b) .. " transformed into its Complete Forme!")
      if done then
        -- Complete Forme's max HP for the battle; the HP gained comes with it
        local P = require("src.core.game3.pokemon")
        local mon = State.partyMon(b)
        local stats = P.calcStats(b.species, mon.level, mon.ivs, mon.evs, mon.personality, mon.nature)
        local gain = math.max(0, (stats.maxHp or before) - before)
        if gain > 0 then
          rawset(State.ensureBattleMoves(b), "maxHp", before + gain)
          b.mon.hp = ad:hp(b) + gain
        end
      end
      return done
    elseif k == "FLOWER_GIFT" and f:find("^CHERRIM") then
      local sun = weather(ad) == "SUN"
      if sun and f ~= "CHERRIM_SUNSHINE" then return changeForm(ad, b, "CHERRIM_SUNSHINE", nm(ad, b) .. " transformed!")
      elseif not sun and f == "CHERRIM_SUNSHINE" then return changeForm(ad, b, "CHERRIM", nm(ad, b) .. " transformed!") end
    elseif k == "ICE_FACE" and f == "EISCUE_NOICE_FACE" and weather(ad) == "HAIL" then
      A.markBroken(ad, b, false)
      return changeForm(ad, b, "EISCUE", nm(ad, b) .. "'s Ice Face was restored!")
    end
    return false
  end

  -- switch-in ----------------------------------------------------------------------------
  local function itemNameOf(b) return U.itemName(U.item(b)) end
  local function strongestMove(ad, foe)
    local best, bestPow
    for _, m in ipairs((foe.mon and foe.mon.moves) or {}) do
      local rec = m and m ~= 0 and Moves.get(m)
      if rec then
        local p = tonumber(rec.power) or 0
        local eff = tonumber(rec.effect)
        if eff == E.OHKO then p = 150 elseif p == 1 then p = 80 end
        if (eff == E.COUNTER or eff == E.MIRROR_COAT) then p = 120 end
        if not bestPow or p > bestPow then best, bestPow = rec, p end
      end
    end
    return best
  end
  local function moveName(rec)
    local row = rec and data.moves[tonumber(rec.numId) or 0]
    return row and row.name or (rec and rec.id) or "a move"
  end
  local function terrainSurge(ad, b, kind) return F.setTerrain(ad, kind, b) end
  local SWITCH = {
    MOLD_BREAKER = function(ad, b) say(ad, nm(ad, b) .. " breaks the mold!") end,
    TERAVOLT = function(ad, b) say(ad, nm(ad, b) .. " is radiating a bursting aura!") end,
    TURBOBLAZE = function(ad, b) say(ad, nm(ad, b) .. " is radiating a blazing aura!") end,
    PRESSURE = function(ad, b) say(ad, nm(ad, b) .. " is exerting its pressure!") end,
    UNNERVE = function(ad, b) say(ad, (b.side == "player" and "The opposing team" or "Your team") .. " is too nervous to eat Berries!") end,
    AS_ONE_ICE_RIDER = function(ad, b)
      say(ad, nm(ad, b) .. " has two Abilities!")
      say(ad, (b.side == "player" and "The opposing team" or "Your team") .. " is too nervous to eat Berries!")
    end,
    DARK_AURA = function(ad, b) say(ad, nm(ad, b) .. " is radiating a dark aura!") end,
    FAIRY_AURA = function(ad, b) say(ad, nm(ad, b) .. " is radiating a fairy aura!") end,
    AURA_BREAK = function(ad, b) say(ad, nm(ad, b) .. " reversed all other Pokémon's auras!") end,
    COMATOSE = function(ad, b) say(ad, nm(ad, b) .. " is drowsing!") end,
    NEUTRALIZING_GAS = function(ad, b) say(ad, "Neutralizing gas filled the area!") end,
    SLOW_START = function(ad, b)
      b.campaignSlowStart = 5
      say(ad, nm(ad, b) .. " can't get it going!")
    end,
    SNOW_WARNING = function(ad, b)
      local st = ad._st
      if Rules.weather.kind(st.weather) == "HAIL" then return false end
      st.weather, st.weatherTurns = "HAIL", 0
      say(ad, nm(ad, b) .. "'s Snow Warning whipped up a hailstorm!")
      ad:playAnim("general", "HAIL_CONTINUES", nil, nil)
    end,
    ELECTRIC_SURGE = function(ad, b) return terrainSurge(ad, b, "ELECTRIC") end,
    GRASSY_SURGE = function(ad, b) return terrainSurge(ad, b, "GRASSY") end,
    MISTY_SURGE = function(ad, b) return terrainSurge(ad, b, "MISTY") end,
    PSYCHIC_SURGE = function(ad, b) return terrainSurge(ad, b, "PSYCHIC") end,
    DOWNLOAD = function(ad, b)
      local Damage = require("src.core.game3.battle.damage")
      local def, spd = 0, 0
      for _, f in ipairs(U.foes(ad, b)) do
        def = def + Damage.applyStage(Damage.monStat(f.mon, "defense", 50), U.stage(f, "defense"))
        spd = spd + Damage.applyStage(Damage.monStat(f.mon, "spDef", 50), U.stage(f, "spDef"))
      end
      return boost(ad, b, def < spd and "attack" or "spAtk", 1, "DOWNLOAD")
    end,
    INTREPID_SWORD = function(ad, b) return boost(ad, b, "attack", 1, "INTREPID_SWORD") end,
    DAUNTLESS_SHIELD = function(ad, b) return boost(ad, b, "defense", 1, "DAUNTLESS_SHIELD") end,
    FRISK = function(ad, b)
      local any = false
      for _, f in ipairs(U.foes(ad, b)) do
        if U.item(f) ~= 0 then
          say(ad, nm(ad, b) .. " frisked " .. nm(ad, f) .. " and found its " .. itemNameOf(f) .. "!")
          any = true
        end
      end
      return any
    end,
    ANTICIPATION = function(ad, b)
      for _, f in ipairs(U.foes(ad, b)) do
        for _, m in ipairs((f.mon and f.mon.moves) or {}) do
          local rec = m and m ~= 0 and Moves.get(m)
          if rec and (tonumber(rec.effect) == E.OHKO
              or (damaging(rec) and U.effectiveness(tonumber(rec.type) or 0, b) >= 2)) then
            say(ad, nm(ad, b) .. " shuddered!")
            return true
          end
        end
      end
      return false
    end,
    FOREWARN = function(ad, b)
      local pick, pickFoe, pickPow
      for _, f in ipairs(U.foes(ad, b)) do
        local rec = strongestMove(ad, f)
        local p = rec and (tonumber(rec.power) or 0) or -1
        if rec and (not pickPow or p > pickPow) then pick, pickFoe, pickPow = rec, f, p end
      end
      if not pick then return false end
      say(ad, nm(ad, b) .. "'s Forewarn alerted it to " .. nm(ad, pickFoe) .. "'s " .. moveName(pick) .. "!")
      return true
    end,
    SCREEN_CLEANER = function(ad, b)
      local any = false
      for _, side in ipairs({ ad._st.playerSide, ad._st.enemySide }) do
        if side and ((side.expReflectTurns or 0) > 0 or (side.expLightScreenTurns or 0) > 0 or (side.campaignAuroraVeil or 0) > 0) then
          side.expReflectTurns, side.expLightScreenTurns, side.campaignAuroraVeil = nil, nil, nil
          any = true
        end
      end
      if any then say(ad, nm(ad, b) .. "'s Screen Cleaner removed the effects of screens from the battlefield!") end
      return any
    end,
    CURIOUS_MEDICINE = function(ad, b)
      local p = partnerOf(ad, b)
      if not p then return false end
      local any = false
      for s, v in pairs(p.stages or {}) do if v ~= 0 then p.stages[s] = 0; any = true end end
      if any then say(ad, nm(ad, p) .. "'s stat changes were removed!") end
      return any
    end,
    PASTEL_VEIL = function(ad, b)
      local p = partnerOf(ad, b)
      local s = p and ad:status(p)
      if s == "PSN" or s == "TOX" then
        ad:clearStatus(p)
        say(ad, nm(ad, p) .. " was cured of its poisoning!")
        return true
      end
      return false
    end,
    IMPOSTER = function(ad, b)
      local st = ad._st
      local foe = st.double and State.battler(st, (State.idOf(b) + 1) % 4) or ad:foeOf(b)
      if not foe or not alive(ad, foe) or foe.transformed or b.transformed or (foe.substituteHP or 0) > 0
          or foe.semiInvulnerable then return false end
      local Effects = require("src.core.game3.battle.effects")
      Effects.run("EXP_TRANSFORM_EFFECT", ad, b, foe, Moves.get(144), 144)
      return true
    end,
    MIMICRY = function(ad, b) return A.mimicry(ad, b) end,
  }
  SWITCH.AS_ONE_SHADOW_RIDER = SWITCH.AS_ONE_ICE_RIDER
  local TERRAIN_TYPE = { ELECTRIC = T.ELECTRIC, GRASSY = T.GRASS, MISTY = T.FAIRY, PSYCHIC = T.PSYCHIC }
  function A.mimicry(ad, b)
    local t = TERRAIN_TYPE[F.terrain(ad._st) or ""]
    if not t or key(ad, b) ~= "MIMICRY" then return false end
    b.type1, b.type2, b.campaignType3 = t, t, nil
    local Types = require("src.core.game3.battle.types")
    say(ad, nm(ad, b) .. "'s type changed to " .. Types.name(t) .. "!")
    return true
  end
  -- the type Arceus' plate and Silvally's memory give
  local function heldType(b)
    local row = U.itemRow(U.item(b))
    local f = row and row.sourceFields
    local he = f and f.holdEffect
    if he == "HOLD_EFFECT_PLATE" or he == "HOLD_EFFECT_MEMORY" then
      local t = f.secondaryId or f.holdEffectParam
      return type(t) == "string" and T[t:gsub("^TYPE_", "")] or tonumber(t)
    end
    return nil
  end
  -- Illusion: on entry the battler takes the look and name of the last
  -- conscious Pokémon in its party; a damaging hit breaks it
  local function illusionView(ad, b)
    local party = b.side == "player" and ad._st.playerParty or ad._st.foeParty
    for i = #(party or {}), 1, -1 do
      local mon = party[i]
      if mon ~= State.partyMon(b) and mon ~= b.mon and (tonumber(mon.hp) or 0) > 0 and not mon.isEgg then
        local ok, view = pcall(State.makeBattler, mon, b.side, { partyIndex = i, id = State.idOf(b), st = ad._st })
        if ok then return view end
      end
    end
    return nil
  end
  local Anim = require("src.core.game3.battle.anim")
  local shownBattler = Anim.shownBattler
  Anim.shownBattler = function(side, battler, ...)
    local r = shownBattler(side, battler, ...)
    if r == battler and battler and F.active() then
      -- (campaignIllusionShown keeps the disguise on screen until its
      -- "wore off" line plays: the logic runs ahead of the animations)
      local view = battler.campaignIllusion or battler.campaignIllusionShown
      if view then return view end
    end
    return r
  end
  local revealing = {}
  local Ui = require("src.core.game3.battle.ui")
  local uiPush = Ui.push
  Ui.push = function(text, ...)
    local b = revealing[text]
    if b then revealing[text] = nil; b.campaignIllusionShown = nil end
    return uiPush(text, ...)
  end
  local displayName = State.displayName
  State.displayName = function(b, ...)
    if b and b.campaignIllusion and F.active() then return displayName(b.campaignIllusion, ...) end
    return displayName(b, ...)
  end
  function A.breakIllusion(ad, b)
    if b and b.campaignIllusion then
      b.campaignIllusionShown, b.campaignIllusion = b.campaignIllusion, nil
      local text = nm(ad, b) .. "'s illusion wore off!"
      revealing[text] = b
      say(ad, text)
    end
  end
  SWITCH.ILLUSION = function(ad, b)
    b.campaignIllusion = illusionView(ad, b)
    return false
  end
  local switchIn = Abilities.switchIn
  Abilities.switchIn = function(ad, b, ...)
    local did = switchIn(ad, b, ...)
    if not F.active() or not b or not ad or ad:isFainted(b) then return did end
    if b.campaignEnteredMon ~= b.mon then
      b.campaignEnteredMon = b.mon
      b.campaignHadItem = U.item(b) ~= 0 or nil
      local k = key(ad, b)
      if k == "MULTITYPE" or k == "RKS_SYSTEM" then
        local t = heldType(b)
        if t then b.type1, b.type2 = t, t end
      end
      local fn = SWITCH[k]
      if fn and fn(ad, b) ~= false then did = true end
      if A.hpForms(ad, b) then did = true end
    end
    return did
  end

  -- switching out: Regenerator ---------------------------------------------------------
  local switchOut = Abilities.switchOut
  Abilities.switchOut = function(ad, b, ...)
    local did = switchOut(ad, b, ...)
    if F.active() and b and ad and not ad:isFainted(b) and key(ad, b) == "REGENERATOR" and not U.healBlocked(b) then
      local max = ad:maxHp(b)
      local amt = math.min(max - ad:hp(b), math.floor(max / 3))
      if amt > 0 then
        ad:heal(b, amt)
        local pm = State.partyMon and State.partyMon(b)
        if pm and pm ~= b.mon then pm.hp = math.min(tonumber(pm.maxHp) or max, (tonumber(pm.hp) or 0) + amt) end
        did = true
      end
    end
    return did
  end

  -- held items: Klutz, Unnerve, Cheek Pouch, Harvest's berry, Symbiosis -------------------
  -- Heavy Metal doubles weight, Light Metal halves it (util.lua U.weight)
  function A.gluttony(b) return F.active() and key(nil, b) == "GLUTTONY" end
  function A.ripen(b) return F.active() and key(nil, b) == "RIPEN" end
  function A.weight(b, w)
    local k = key(nil, b)
    if k == "HEAVY_METAL" then return w * 2 end
    if k == "LIGHT_METAL" then return math.max(1, math.floor(w / 2)) end
    return w
  end
  function A.klutz(b) return F.active() and b ~= nil and key(nil, b) == "KLUTZ" end
  function A.unnerved(ad, b)
    for _, f in ipairs(U.foes(ad, b)) do
      local k = key(ad, f)
      if k == "UNNERVE" or k == "AS_ONE_ICE_RIDER" or k == "AS_ONE_SHADOW_RIDER" then return true end
    end
    return false
  end
  local normal = HeldItems.normal
  HeldItems.normal = function(ad, b, moveTurn, ...)
    if not F.active() or not b or not ad then return normal(ad, b, moveTurn, ...) end
    local item = U.item(b)
    local berry = item ~= 0 and U.isBerry(item)
    if berry and A.unnerved(ad, b) then return false end
    local result
    local bk = berry and key(ad, b)
    if bk == "GLUTTONY" or bk == "RIPEN" then
      -- Gluttony: quarter-HP pinch berries work at half; Ripen doubles the
      -- HP a berry restores
      local effectOf = HeldItems.effectOf
      HeldItems.effectOf = function(it, ...)
        local code, param = effectOf(it, ...)
        if it == item then
          if bk == "GLUTTONY" and param == 4 then param = 2
          elseif bk == "RIPEN" and code == HeldItems.HOLD.RESTORE_HP then param = param * 2 end
        end
        return code, param
      end
      local ok, r = pcall(normal, ad, b, moveTurn, ...)
      HeldItems.effectOf = effectOf
      if not ok then error(r, 0) end
      result = r
    else
      result = normal(ad, b, moveTurn, ...)
    end
    if berry and U.item(b) == 0 and bk == "RIPEN" then
      local row = U.itemRow(item)
      local he = row and row.sourceFields and row.sourceFields.holdEffect
      local STAT = { HOLD_EFFECT_ATTACK_UP = "attack", HOLD_EFFECT_DEFENSE_UP = "defense", HOLD_EFFECT_SPEED_UP = "speed",
        HOLD_EFFECT_SP_ATTACK_UP = "spAtk", HOLD_EFFECT_SP_DEFENSE_UP = "spDef" }
      if he and STAT[he] then boost(ad, b, STAT[he], 1, "RIPEN") end
    end
    if berry and U.item(b) == 0 then A.ateBerry(ad, b, item)
    elseif item ~= 0 and U.item(b) == 0 then A.symbiosis(ad, b) end
    return result
  end
  -- after a berry is eaten (or used up some other way)
  function A.ateBerry(ad, b, item)
    b.campaignLastBerry = item
    if not alive(ad, b) then return end
    if key(ad, b) == "CHEEK_POUCH" and not U.healBlocked(b) and U.heal(ad, b, ad:maxHp(b) / 3) > 0 then
      say(ad, nm(ad, b) .. "'s Cheek Pouch restored its HP!")
    end
    A.symbiosis(ad, b)
  end
  function A.symbiosis(ad, b)
    local p = partnerOf(ad, b)
    if p and U.item(b) == 0 and key(ad, p) == "SYMBIOSIS" and U.item(p) ~= 0 then
      local item = U.removeItem(p)
      U.setItem(b, item)
      say(ad, nm(ad, p) .. " shared its " .. U.itemName(item) .. " with " .. nm(ad, b) .. "!")
    end
  end

  -- end of turn ----------------------------------------------------------------------------
  local function cure(ad, b, why)
    if not ad:status(b) then return false end
    ad:clearStatus(b)
    b.expNightmare = nil
    say(ad, nm(ad, b) .. "'s " .. A.name(why) .. " cured its status condition!")
    return true
  end
  local EOT = {
    HARVEST = function(ad, b)
      local berry = b.campaignLastBerry or (b.expUsedHeldItem and U.isBerry(b.expUsedHeldItem) and b.expUsedHeldItem)
      if U.item(b) ~= 0 or not berry then return end
      if weather(ad) == "SUN" or ad:roll(0, 1) == 0 then
        U.setItem(b, berry)
        b.campaignLastBerry, b.expUsedHeldItem = nil, nil
        say(ad, nm(ad, b) .. " harvested one " .. U.itemName(berry) .. "!")
        HeldItems.normal(ad, b, false)
      end
    end,
    DRY_SKIN = function(ad, b)
      local w = weather(ad)
      if w == "SUN" then
        ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 8)))
        say(ad, nm(ad, b) .. "'s Dry Skin takes its toll!")
      elseif w == "RAIN" and ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
        U.heal(ad, b, ad:maxHp(b) / 8)
        say(ad, nm(ad, b) .. "'s Dry Skin restored its HP a little!")
      end
    end,
    SOLAR_POWER = function(ad, b)
      if weather(ad) == "SUN" then
        ad:applyHpLoss(b, math.max(1, math.floor(ad:maxHp(b) / 8)))
        say(ad, nm(ad, b) .. "'s Solar Power takes its toll!")
      end
    end,
    HYDRATION = function(ad, b) if weather(ad) == "RAIN" then cure(ad, b, "HYDRATION") end end,
    ICE_BODY = function(ad, b)
      if weather(ad) == "HAIL" and ad:hp(b) < ad:maxHp(b) and not U.healBlocked(b) then
        U.heal(ad, b, ad:maxHp(b) / 16)
        say(ad, nm(ad, b) .. "'s Ice Body restored its HP a little!")
      end
    end,
    HEALER = function(ad, b)
      local p = partnerOf(ad, b)
      if p and ad:status(p) and ad:roll(0, 99) < 30 then
        ad:clearStatus(p)
        say(ad, nm(ad, b) .. "'s Healer cured " .. nm(ad, p) .. "'s status condition!")
      end
    end,
    MOODY = function(ad, b)
      if b.campaignEnteredTurn == ad._st.turn then return end
      local stats = { "attack", "defense", "spAtk", "spDef", "speed" }
      local up, down = {}, {}
      for _, s in ipairs(stats) do
        if U.stage(b, s) < 6 then up[#up + 1] = s end
        if U.stage(b, s) > -6 then down[#down + 1] = s end
      end
      local raised
      if #up > 0 then
        raised = up[ad:roll(1, #up)]
        boost(ad, b, raised, 2, nil)
      end
      local left = {}
      for _, s in ipairs(down) do if s ~= raised then left[#left + 1] = s end end
      if #left > 0 then boost(ad, b, left[ad:roll(1, #left)], -1, nil) end
    end,
    BAD_DREAMS = function(ad, b)
      for _, f in ipairs(U.foes(ad, b)) do
        if A.asleep(ad, f) and not A.magicGuard(ad, f) then
          ad:applyHpLoss(f, math.max(1, math.floor(ad:maxHp(f) / 8)))
          say(ad, nm(ad, f) .. " is tormented!")
        end
      end
    end,
    SLOW_START = function(ad, b)
      if (b.campaignSlowStart or 0) > 0 then
        b.campaignSlowStart = b.campaignSlowStart - 1
        if b.campaignSlowStart == 0 then say(ad, nm(ad, b) .. " finally got its act together!") end
      end
    end,
  }
  EOT.HUNGER_SWITCH = function(ad, b)
    local f = formOf(b)
    if f == "MORPEKO" then changeForm(ad, b, "MORPEKO_HANGRY", nm(ad, b) .. " transformed!")
    elseif f == "MORPEKO_HANGRY" then changeForm(ad, b, "MORPEKO", nm(ad, b) .. " transformed!") end
  end
  Residuals.register("campaign_abilities", function(ctx)
    local ad, b = ctx.adapter, ctx.target or ctx.user
    if not F.active() or not b or ad:isFainted(b) then return end
    local fn = EOT[key(ad, b)]
    if fn then fn(ad, b) end
    if not ad:isFainted(b) then A.hpForms(ad, b) end
  end)
  local function insertAfter(list, after, name)
    for _, v in ipairs(list) do if v == name then return end end
    for i, v in ipairs(list) do
      if v == after then table.insert(list, i + 1, name); return end
    end
    table.insert(list, name)
  end
  local function insertBefore(list, before, name)
    for _, v in ipairs(list) do if v == name then return end end
    for i, v in ipairs(list) do
      if v == before then table.insert(list, i, name); return end
    end
    table.insert(list, name)
  end
  insertAfter(Rules.BATTLER_PHASES_ORDER, "abilities_eot", "campaign_abilities")
  insertBefore(Rules.BATTLER_PHASES_ORDER, "leech_seed", "campaign_guard_on")
  insertAfter(Rules.BATTLER_PHASES_ORDER, "partial_trap_chip", "campaign_guard_off")

  -- contact abilities the donor changed: Rough Skin takes 1/8; Long Reach and
  -- Protective Pads make no contact -----------------------------------------------------
  local onDamage = Abilities.onDamage
  Abilities.onDamage = function(M, ...)
    if not F.active() or not M or not M.user or not M.target then return onDamage(M, ...) end
    local ad, user, target = M.adapter, M.user, M.target
    local tk = key(ad, target)
    local touching = contact(ad, user, M.move)
    if (tk == "ROUGH_SKIN" or tk == "IRON_BARBS") then
      if touching and M.targetDamaged and not M.noEffect and target ~= user and alive(ad, user) and not A.magicGuard(ad, user) then
        ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 8)))
        say(ad, nm(ad, user) .. " was hurt by " .. nm(ad, target) .. "'s " .. A.name(tk) .. "!")
        M:tryFaintUser()
        return true
      end
      return false
    end
    if not touching and U.hasContact(M.move) then
      local move = M.move
      M.move = setmetatable({ flags = (tonumber(move.flags) or 0) - 1 }, { __index = move })
      local r = { pcall(onDamage, M, ...) }
      M.move = move
      if not r[1] then error(r[2], 0) end
      return r[2]
    end
    return onDamage(M, ...)
  end

  -- after a hit (hit.lua, beside the held items) ---------------------------------------------
  local function switchAway(M, b)
    local fake = setmetatable({ user = b }, { __index = M })
    return F.switchOut(fake, b)
  end
  local function trade(ad, a, b)
    local ka, kb = ad:abilityOf(a), ad:abilityOf(b)
    a.campaignAbility, b.campaignAbility = kb, ka
  end
  local NO_MUMMY = { MUMMY = true, BATTLE_BOND = true, COMATOSE = true, DISGUISE = true, MULTITYPE = true,
    POWER_CONSTRUCT = true, RKS_SYSTEM = true, SCHOOLING = true, SHIELDS_DOWN = true, STANCE_CHANGE = true,
    ZEN_MODE = true, ICE_FACE = true, GULP_MISSILE = true, AS_ONE_ICE_RIDER = true, AS_ONE_SHADOW_RIDER = true }
  local NO_WANDER = { DISGUISE = true, FLOWER_GIFT = true, GULP_MISSILE = true, HUNGER_SWITCH = true, ICE_FACE = true,
    ILLUSION = true, IMPOSTER = true, RECEIVER = true, RKS_SYSTEM = true, SCHOOLING = true, STANCE_CHANGE = true,
    WONDER_GUARD = true, ZEN_MODE = true, MULTITYPE = true, COMATOSE = true }
  local SURF, DIVE = data.identity.namespaces.moves.MOVE_SURF, data.identity.namespaces.moves.MOVE_DIVE
  local function gulp(M)
    local ad, user = M.adapter, M.user
    if key(ad, user) ~= "GULP_MISSILE" or formOf(user) ~= "CRAMORANT" then return end
    local n = tonumber(M.mnum)
    if n ~= SURF and n ~= DIVE then return end
    if ad:hp(user) > ad:maxHp(user) / 2 then changeForm(ad, user, "CRAMORANT_GULPING", nil)
    else changeForm(ad, user, "CRAMORANT_GORGING", nil) end
  end
  local function spitUp(M)
    local ad, user, target = M.adapter, M.user, M.target
    local f = formOf(target)
    if key(ad, target) ~= "GULP_MISSILE" or (f ~= "CRAMORANT_GULPING" and f ~= "CRAMORANT_GORGING") then return end
    changeForm(ad, target, "CRAMORANT", nil)
    if not alive(ad, user) then return end
    if not A.magicGuard(ad, user) then
      ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 4)))
      say(ad, nm(ad, user) .. " was hit by " .. nm(ad, target) .. "'s Gulp Missile!")
      M.checkUserFaint = true
    end
    if alive(ad, user) then
      if f == "CRAMORANT_GULPING" then
        Secondary.changeStat(ad, user, "defense", -1, { allowPtr = true, campaignSource = target })
      elseif ad:canApplyStatus(user, "PAR", target) then
        ad:applyStatus(user, "PAR", target)
        ad:statusAnim(user, "PAR")
        ad:sayText("STRINGID_PKMNWASPARALYZED", { eff = user })
      end
    end
  end
  function A.afterHit(M)
    if not F.active() then return end
    local ad, user, target = M.adapter, M.user, M.target
    if target and target.campaignIllusion and (M.hpDealt or 0) > 0 and not M.hitSubstitute then A.breakIllusion(ad, target) end
    if user and alive(ad, user) then gulp(M) end
    if target and target ~= user and not M.noEffect and (M.hpDealt or 0) > 0 and not M.hitSubstitute then spitUp(M) end
    if not target or target == user or M.noEffect or M.failed then return end
    local dealt = (M.hpDealt or 0) > 0 and not M.hitSubstitute
    if not dealt then return end
    local mt = tonumber(M.moveType or M.move.type)
    local touching = contact(ad, user, M.move)
    local tk, uk = key(ad, target), key(ad, user)
    local crit = target.campaignCritBy == user
    target.campaignCritBy = nil
    local before = ad:hp(target) + (M.hpDealt or 0)
    local half = ad:maxHp(target) / 2
    local crossed = before > half and ad:hp(target) < half
    local sheer = A.sheerForced(M)
    if alive(ad, target) then
      if tk == "JUSTIFIED" and mt == T.DARK then boost(ad, target, "attack", 1, tk)
      elseif tk == "RATTLED" and (mt == T.DARK or mt == T.BUG or mt == T.GHOST) then boost(ad, target, "speed", 1, tk)
      elseif tk == "WATER_COMPACTION" and mt == T.WATER then boost(ad, target, "defense", 2, tk)
      elseif tk == "STAMINA" then boost(ad, target, "defense", 1, tk)
      elseif tk == "STEAM_ENGINE" and (mt == T.FIRE or mt == T.WATER) then boost(ad, target, "speed", 6, tk)
      elseif tk == "WEAK_ARMOR" and physical(M.move) then
        boost(ad, target, "defense", -1, tk)
        boost(ad, target, "speed", 2, tk)
      elseif tk == "BERSERK" and crossed and not sheer then boost(ad, target, "spAtk", 1, tk)
      elseif tk == "ANGER_POINT" and crit and U.stage(target, "attack") < 6 then
        target.stages.attack = 6
        ad:playAnim("general", "STATS_CHANGE", target, target, Secondary.statAnimArg("attack", 2))
        say(ad, nm(ad, target) .. "'s Anger Point maxed its Attack!")
      elseif tk == "COTTON_DOWN" then
        say(ad, nm(ad, target) .. "'s Cotton Down scattered cotton!")
        for _, o in ipairs(U.all(ad)) do
          if o ~= target then Secondary.changeStat(ad, o, "speed", -1, { allowPtr = true, campaignSource = target }) end
        end
      elseif tk == "SAND_SPIT" and Rules.weather.kind(ad._st.weather) ~= "SAND" then
        ad._st.weather, ad._st.weatherTurns = "SAND", 0
        say(ad, nm(ad, target) .. "'s Sand Spit whipped up a sandstorm!")
        ad:playAnim("general", "SANDSTORM_CONTINUES", nil, nil)
      elseif tk == "CURSED_BODY" and alive(ad, user) and not user.expDisabledMove and ad:roll(0, 2) == 0
          and not onSide(ad, user, "AROMA_VEIL") and M.mnum and not (M.opts and M.opts.called) then
        user.expDisabledMove, user.expDisableTurns = M.mnum, 4
        say(ad, nm(ad, user) .. "'s " .. (M.moveName or "move") .. " was disabled by " .. nm(ad, target) .. "'s Cursed Body!")
      end
      if touching and alive(ad, user) then
        if (tk == "GOOEY" or tk == "TANGLING_HAIR") then
          say(ad, nm(ad, target) .. "'s " .. A.name(tk) .. "!")
          Secondary.changeStat(ad, user, "speed", -1, { allowPtr = true, campaignSource = target })
        elseif tk == "MUMMY" and not NO_MUMMY[uk] then
          user.campaignAbility = abilityString("MUMMY")
          say(ad, nm(ad, user) .. "'s Ability became Mummy!")
        elseif tk == "WANDERING_SPIRIT" and not NO_WANDER[uk] then
          trade(ad, user, target)
          say(ad, nm(ad, user) .. " swapped Abilities with its target!")
        elseif tk == "PERISH_BODY" and not user.expPerishTurns then
          say(ad, "Both Pokémon will faint in three turns!")
          user.expPerishTurns, user.perishSong = 3, true
          if not target.expPerishTurns then target.expPerishTurns, target.perishSong = 3, true end
        elseif tk == "PICKPOCKET" and U.item(target) == 0 and U.item(user) ~= 0 and key(ad, user) ~= "STICKY_HOLD" then
          local item = U.removeItem(user)
          U.setItem(target, item)
          say(ad, nm(ad, target) .. " stole " .. nm(ad, user) .. "'s " .. U.itemName(item) .. "!")
        end
      end
      if (tk == "EMERGENCY_EXIT" or tk == "WIMP_OUT") and crossed and not sheer and not M.st.over then
        if ad._st.wild and target.side == "enemy" then
          -- a wild Pokémon doesn't run from a double
        elseif #Engine.switchCandidates(M.st, M.st.double and State.idOf(target) or target.side) > 0 then
          say(ad, nm(ad, target) .. "'s " .. A.name(tk) .. " made it retreat!")
          switchAway(M, target)
        end
      end
    end
    -- the attacker's own abilities
    if alive(ad, user) and alive(ad, target) then
      if uk == "POISON_TOUCH" and touching and not ad:status(target) and ad:roll(0, 2) == 0
          and ad:canApplyStatus(target, "PSN", user) ~= false then
        ad:applyStatus(target, "PSN", user)
        ad:statusAnim(target, "PSN")
        say(ad, nm(ad, target) .. " was poisoned by " .. nm(ad, user) .. "'s Poison Touch!")
      elseif uk == "STENCH" and ad:roll(0, 9) == 0 and not U.movedThisTurn(ad, target)
          and key(ad, target) ~= "INNER_FOCUS" then
        target.flinched = true
      elseif uk == "MAGICIAN" and U.item(user) == 0 and U.item(target) ~= 0 and key(ad, target) ~= "STICKY_HOLD" then
        local item = U.removeItem(target)
        U.setItem(user, item)
        say(ad, nm(ad, user) .. " stole " .. nm(ad, target) .. "'s " .. U.itemName(item) .. "!")
      end
    end
  end

  -- after the target's faint check -----------------------------------------------------------
  local function bestStat(b)
    local Damage = require("src.core.game3.battle.damage")
    local best, val = "attack", -1
    for _, s in ipairs({ "attack", "defense", "spAtk", "spDef", "speed" }) do
      local v = Damage.applyStage(Damage.monStat(b.mon, s, 0), U.stage(b, s))
      if v > val then best, val = s, v end
    end
    return best
  end
  local KO_BOOST = { MOXIE = "attack", CHILLING_NEIGH = "attack", GRIM_NEIGH = "spAtk",
    AS_ONE_ICE_RIDER = "attack", AS_ONE_SHADOW_RIDER = "spAtk" }
  local COPY_BANNED = { RECEIVER = true, POWER_OF_ALCHEMY = true, TRACE = true, FORECAST = true, FLOWER_GIFT = true,
    MULTITYPE = true, ILLUSION = true, WONDER_GUARD = true, ZEN_MODE = true, IMPOSTER = true, STANCE_CHANGE = true,
    POWER_CONSTRUCT = true, SCHOOLING = true, COMATOSE = true, SHIELDS_DOWN = true, DISGUISE = true,
    RKS_SYSTEM = true, BATTLE_BOND = true, NEUTRALIZING_GAS = true, ICE_FACE = true, GULP_MISSILE = true,
    HUNGER_SWITCH = true, AS_ONE_ICE_RIDER = true, AS_ONE_SHADOW_RIDER = true }
  function A.afterFaint(M)
    if not F.active() then return end
    local ad, user, target = M.adapter, M.user, M.target
    if not target or target == user or not ad:isFainted(target) or target.campaignFaintSeen == target.mon then return end
    target.campaignFaintSeen = target.mon
    local tk, uk = key(ad, target), key(ad, user)
    -- the fallen Pokémon's abilities
    if alive(ad, user) then
      if tk == "AFTERMATH" and contact(ad, user, M.move) and not onField(ad, "DAMP") and not A.magicGuard(ad, user) then
        ad:applyHpLoss(user, math.max(1, math.floor(ad:maxHp(user) / 4)))
        say(ad, nm(ad, user) .. " was caught in the aftermath!")
        M.checkUserFaint = true
      elseif tk == "INNARDS_OUT" and (M.hpDealt or 0) > 0 and not A.magicGuard(ad, user) then
        ad:applyHpLoss(user, M.hpDealt)
        say(ad, nm(ad, user) .. " was hurt by " .. nm(ad, target) .. "'s Innards Out!")
        M.checkUserFaint = true
      end
    end
    -- the attacker's
    if alive(ad, user) then
      if KO_BOOST[uk] then boost(ad, user, KO_BOOST[uk], 1, uk)
      elseif uk == "BEAST_BOOST" then boost(ad, user, bestStat(user), 1, uk)
      elseif uk == "BATTLE_BOND" and formOf(user) == "GRENINJA_BATTLE_BOND" then
        say(ad, nm(ad, user) .. " became fully charged due to its bond with its Trainer!")
        changeForm(ad, user, "GRENINJA_ASH", nm(ad, user) .. " became Ash-Greninja!")
      elseif uk == "RAMPAGE" and user.expMustRecharge then
        user.expMustRecharge, user.expRechargeTurns, user.recharge = nil, nil, nil
      end
    end
    -- everyone else's: Receiver (Soul-Heart answers the faint message)
    for _, o in ipairs(U.all(ad)) do
      local ok = key(ad, o)
      if (ok == "RECEIVER" or ok == "POWER_OF_ALCHEMY") and o.side == target.side and tk and not COPY_BANNED[tk] then
        o.campaignAbility = ad:abilityOf(target)
        say(ad, nm(ad, o) .. " took on " .. nm(ad, target) .. "'s " .. A.name(tk) .. "!")
      end
    end
  end

  -- Dancer: after another Pokémon's dance move, each Dancer on the field
  -- dances along (a called move: no PP, and the copy isn't copied again).
  -- Petal Dance stays out: a called rampage would lock the dancer in.
  local RAMPAGE_EFFECT = E.RAMPAGE
  local bookkeeping = Engine.moveEndBookkeeping
  Engine.moveEndBookkeeping = function(M, ...)
    local result = bookkeeping(M, ...)
    if not F.active() or not M or not M.user or not M.adapter or not M.st or M.st.over then return result end
    if (M.opts and (M.opts.campaignDancer or M.opts.called)) or M.failed or M.campaignDanced then return result end
    if not flag(M.move, "FLAG_DANCE") or tonumber(M.move.effect) == RAMPAGE_EFFECT then return result end
    M.campaignDanced = true
    local ad, st = M.adapter, M.st
    local dancers = {}
    for _, b in ipairs(U.all(ad)) do
      if b ~= M.user and key(ad, b) == "DANCER" then dancers[#dancers + 1] = b end
    end
    for _, d in ipairs(dancers) do
      if alive(ad, d) and not st.over then
        local target
        local tgt = tonumber(M.move.target) or 0
        if tgt == 16 then
          target = d
        elseif M.target and M.target.side ~= d.side and alive(ad, M.target) then
          target = M.target
        else
          local tid = Engine.getMoveTarget and Engine.getMoveTarget(st, ad, d, M.moveId)
          target = tid and State.battler(st, tid) or nil
        end
        say(ad, nm(ad, d) .. "'s Dancer copied the dance!")
        local ok, err = pcall(Engine.resolveMove, d, target, M.moveId, nil, ad, st, M.out,
          { called = true, anim = M.anim, calledBy = M.moveId, campaignDancer = true })
        if not ok then print("[g3_campaign] Dancer: " .. tostring(err)) end
      end
    end
    return result
  end

  -- a hit about to land: Disguise and Ice Face soak it up once (no form art:
  -- the sprite stays), Sturdy holds on from full HP (Gen 5+)
  function A.decoy(M, target, dmg)
    if not F.active() or not target or dmg <= 0 or target == M.user or (target.substituteHP or 0) > 0 then return dmg end
    local ad = M.adapter
    local k = key(ad, target)
    if k == "DISGUISE" and formOf(target) == "MIMIKYU" and damaging(M.move) then
      A.markBroken(ad, target)
      say(ad, "Its disguise served it as a decoy!")
      changeForm(ad, target, "MIMIKYU_BUSTED", nm(ad, target) .. "'s disguise was busted!")
      return math.min(dmg, math.max(1, math.floor(ad:maxHp(target) / 8)))
    end
    if k == "ICE_FACE" and formOf(target) == "EISCUE" and physical(M.move) then
      A.markBroken(ad, target)
      say(ad, nm(ad, target) .. "'s Ice Face took the hit!")
      changeForm(ad, target, "EISCUE_NOICE_FACE", nil)
      return 0
    end
    if k == "STURDY" and fullHp(ad, target) and dmg >= ad:hp(target) then
      target.campaignSturdy = true
      return ad:hp(target) - 1
    end
    return dmg
  end
  -- after the hit's text: Sturdy's line
  function A.afterDamage(M, target)
    if target and target.campaignSturdy then
      target.campaignSturdy = nil
      say(M.adapter, nm(M.adapter, target) .. " endured the hit!")
    end
  end

  -- after the battle no party Pokémon keeps more HP than its own maximum
  -- (Power Construct's extra HP lasts only for the battle)
  local BattleMod = require("src.core.game3.battle")
  local reset = BattleMod.reset
  BattleMod.reset = function(...)
    local st = BattleMod._st
    if st and F.active() then
      for _, party in ipairs({ st.playerParty or {}, st.foeParty or {} }) do
        for _, mon in ipairs(party) do
          local max = tonumber(rawget(mon, "maxHp") or mon.maxHp)
          if max and (tonumber(mon.hp) or 0) > max then mon.hp = max end
        end
      end
    end
    return reset(...)
  end

  return A
end
