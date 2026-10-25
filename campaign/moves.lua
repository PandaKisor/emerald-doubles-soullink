-- Expanded Inclement moves in battle. Battle reads a move through
-- Moves.get; for an enabled move it gets the donor's numbers (power,
-- accuracy, PP, priority, type, category, secondary chance) with the native
-- Gen 3 effect that runs it, its target and contact/protect flags, and
-- Inclement's damage rules. Moves whose donor effect has no Gen 3
-- equivalent carry campaign hooks (campaign/battle/hits.lua and
-- statuses.lua) that the patched Inclement library calls. Moves left out
-- stay unknown to battle, and the learnset gate keeps them out of movesets.
--
--   list   campaign/move_list.lua: moves that run a native effect as is
--   specs  symbol -> spec from campaign/battle (hits and statuses)
--   own    campaign/move_anims.lua: Inclement's own animations, where they
--          convert (tools/anim_convert.py); the rest play list's stand-in
return function(data, list, specs, active, own)
  local Moves = require("src.core.game3.battle.moves")
  local E = require("src.core.game3.battle.effect_ids")
  local Anim = require("src.core.game3.battle.anim")
  local Effects = require("src.core.game3.battle.effects")
  local EffectCtx = require("src.core.game3.battle.effect_ctx")
  local ids = data.identity.namespaces.moves
  local TARGETS = { MOVE_TARGET_SELECTED = 0, MOVE_TARGET_DEPENDS = 1, MOVE_TARGET_BOTH = 8,
    MOVE_TARGET_USER = 16, MOVE_TARGET_FOES_AND_ALLY = 32, MOVE_TARGET_OPPONENTS_FIELD = 64 }
  local FLAGS = { FLAG_MAKES_CONTACT = 1, FLAG_PROTECT_AFFECTED = 2, FLAG_MAGIC_COAT_AFFECTED = 4,
    FLAG_SNATCH_AFFECTED = 8, FLAG_MIRROR_MOVE_AFFECTED = 16, FLAG_KINGS_ROCK_AFFECTED = 32 }

  -- No Gen 3 move lowers Special Attack on its own (Confide, Eerie Impulse):
  -- the effect ids exist without stat rows. Vanilla never reaches them.
  E.STAT_CHANGES[E.SPECIAL_ATTACK_DOWN] = E.STAT_CHANGES[E.SPECIAL_ATTACK_DOWN] or { self = false, stages = { spAtk = -1 } }
  E.STAT_CHANGES[E.SPECIAL_ATTACK_DOWN_2] = E.STAT_CHANGES[E.SPECIAL_ATTACK_DOWN_2] or { self = false, stages = { spAtk = -2 } }
  E.STATUS_SETUP[E.SPECIAL_ATTACK_DOWN] = E.STATUS_SETUP[E.SPECIAL_ATTACK_DOWN] or "EXP_STAT_FROM_EFFECT"
  E.STATUS_SETUP[E.SPECIAL_ATTACK_DOWN_2] = E.STATUS_SETUP[E.SPECIAL_ATTACK_DOWN_2] or "EXP_STAT_FROM_EFFECT"

  -- charge-turn text and effects for two-turn moves the engine doesn't know
  local CHARGE = {
    FREEZE_SHOCK = { text = "%s became cloaked in a freezing light!" },
    ICE_BURN = { text = "%s became cloaked in freezing air!" },
    METEOR_BEAM = { text = "%s is overflowing with space power!", stats = { spAtk = 1 } },
    GEOMANCY = { text = "%s is absorbing power!" },
    PHANTOM_FORCE = { text = "%s vanished instantly!", vanish = true },
    SHADOW_FORCE = { text = "%s vanished instantly!", vanish = true },
    SKY_DROP = { skyDrop = true },
  }
  local U = specs and specs.U

  local function flagsOf(row)
    local flags, set = 0, {}
    for _, flag in ipairs(row.sourceFlags) do
      flags = flags + (FLAGS[flag] or 0)
      set[flag] = true
    end
    return flags, set
  end

  local function hooks(out, symbol, spec)
    local pres = {}
    if spec.pre then pres[#pres + 1] = spec.pre end
    if spec.accuracy then
      pres[#pres + 1] = function(M) local acc = spec.accuracy(M); if acc then M.move.accuracy = acc end end
    end
    if spec.ignoreAbility then
      pres[#pres + 1] = function(M) M.adapter._campaignIgnoreAbility = M.target end
    end
    if spec.trapText then
      pres[#pres + 1] = function(M) M.adapter._campaignTrapText = spec.trapText end
    end
    if #pres > 0 then
      out.campaignPre = function(M, fail)
        for _, fn in ipairs(pres) do if fn(M, fail) then return true end end
        return false
      end
    end
    out.campaignCalc, out.campaignStats, out.campaignEffectiveness = spec.calc, spec.stats, spec.eff
    out.campaignAfter, out.campaignAfterFaint = spec.after, spec.afterFaint
    out.campaignBypassProtect, out.campaignIgnoreEvasion = spec.bypassProtect, spec.ignoreEvasion
    out.tripleKickStep = spec.tripleKickStep
    if spec.hits then out.hits = spec.hits elseif spec.multi then out.hits = { 2, 5 } end
    if symbol == "BULLDOZE" then out.campaignBulldoze = true end
    out.campaignGrassyGlide, out.campaignBeakBlast = spec.grassyGlide, spec.beakBlast
    local status = spec.status
    if spec.shield then
      -- Protect, plus the shield's contact punishment for this turn
      status = function(ctx, M)
        local handled = Effects.run("EXP_PROTECT_EFFECT", ctx.adapter, ctx.user, ctx.target, M.move, M.moveId, M)
        if ctx.user.expProtected then
          ctx.user.campaignShield, ctx.user.campaignShieldTurn = spec.shield, ctx.adapter._st.turn
        end
        return handled
      end
    end
    out.campaignStatus = status
    local charge = CHARGE[symbol]
    if charge then
      out.campaignCharge = function(M)
        if charge.skyDrop then return Moves._campaignField.skyDropCharge(M) end
        local ad, user = M.adapter, M.user
        ad:say(charge.text:format(ad:displayName(user)))
        if charge.vanish then require("src.core.game3.battle.engine").setSemiInvulnerable(user, "PHANTOM") end
        if charge.stats then U.changeStats(ad, user, charge.stats, { user = true }) end
      end
    end
  end

  -- id -> battle record template, built once and checked at load
  local records, anims, scripts = {}, {}, {}
  local function add(symbol, entry, spec)
    local id = assert(ids["MOVE_" .. symbol], "Unknown Inclement move " .. symbol)
    local row = assert(data.moves[id], symbol)
    local effectName = (spec and spec.base) or entry.effect or row.sourceEffect:gsub("^EFFECT_", "")
    if spec and not spec.base then effectName = "HIT" end
    local effect = assert(E[effectName], symbol .. ": no native effect " .. tostring(effectName))
    local target = TARGETS[row.sourceTarget]
    if spec and spec.target then target = TARGETS["MOVE_TARGET_" .. spec.target] end
    if target == nil and spec and spec.status then target = TARGETS.MOVE_TARGET_USER end
    assert(target ~= nil, symbol .. ": unsupported target " .. row.sourceTarget)
    local flags, set = flagsOf(row)
    -- the donor's drain moves heal argument% of the damage (50 when 0)
    local drain = effect == E.ABSORB and (row.argument or 0) > 0 and row.argument or nil
    local out = {}
    for key, value in pairs(row) do out[key] = value end
    out.id, out.effect, out.effectId = symbol, effect, E.STATUS_SETUP[effect]
    out.target, out.flags, out.highCrit, out.drainPercent = target, flags, set.FLAG_HIGH_CRIT or false, drain
    out.alwaysHitMinimized = set.FLAG_DMG_MINIMIZE or nil
    out.campaignThaw = set.FLAG_THAW_USER or nil
    out.damageRules = "inclement"
    if spec then
      if spec.power then out.power = spec.power end
      hooks(out, symbol, spec)
    end
    records[id] = out
    anims[id] = assert(ids["MOVE_" .. entry.anim], symbol .. ": unknown animation move " .. tostring(entry.anim))
    scripts[id] = own and own.moves[symbol] or nil
  end
  for symbol, entry in pairs(list) do
    local spec = specs and specs.bySymbol[symbol]
    add(symbol, entry, spec)
  end

  local bridge = Moves._campaignMoves
  if not bridge then
    bridge = {}
    Moves._campaignMoves = bridge
    local function id(value)
      if type(value) == "table" then value = value.id or value.move or value.moveId or value.num or value.name or value[1] end
      return tonumber(value) or bridge.data.moveByName[tostring(value):upper():gsub("[^%w]", "")]
    end
    local function record(value)
      if not bridge.active() then return nil end
      local n = id(value)
      return n and bridge.records[n]
    end
    local get, constName, numForName, scriptForMove = Moves.get, Moves.constName, Moves.numForName, Anim.scriptForMove
    Moves.get = function(value, ...)
      local row = record(value)
      if not row then return get(value, ...) end
      local out = {}
      for key, v in pairs(row) do out[key] = v end
      return out
    end
    Moves.constName = function(value, ...)
      local row = record(value)
      if row then return row.id end
      return constName(value, ...)
    end
    Moves.numForName = function(value, ...)
      local row = record(value)
      if row then return row.numId end
      return numForName(value, ...)
    end
    Anim.scriptForMove = function(value, ...)
      local n = bridge.active() and id(value)
      local script = n and bridge.scripts[n]
      local base = scriptForMove(n and bridge.anims[n] or value, ...)
      if not script then return base end
      -- Inclement's own animation (campaign/move_anims.lua); its subroutines
      -- join the ROM pack's labels once the pack has loaded
      local pack = Anim._pack
      if not (pack and pack.labels) then return base end
      if not pack.campaignLabels then
        for key, ops in pairs(bridge.labels) do pack.labels[key] = ops end
        pack.campaignLabels = true
      end
      return script
    end
    -- status moves with a campaign handler replace the native dispatch
    local runForMove = Effects.runForMove
    Effects.runForMove = function(ad, user, target, moveId, M)
      local move = (M and M.move) or Moves.get(moveId)
      if not (bridge.active() and move and move.campaignStatus) then
        -- Gen 3 status moves pass the same gate (Assault Vest, Throat Chop)
        local field = Moves._campaignField
        if bridge.active() and M and field and field.preMove(M) then M.failed = true; return true end
        local result = runForMove(ad, user, target, moveId, M)
        -- Light Clay: the holder's Reflect / Light Screen last 8 turns
        local field = Moves._campaignField
        if bridge.active() and user and field and field.items and field.items.longScreens(user) then
          local side = ad:ownSide(user)
          if side and side.expReflectTurns == 5 and tonumber(move.effect) == E.REFLECT then side.expReflectTurns = 8 end
          if side and side.expLightScreenTurns == 5 and tonumber(move.effect) == E.LIGHT_SCREEN then side.expLightScreenTurns = 8 end
        end
        return result
      end
      local field = Moves._campaignField
      if M and field and field.preMove(M) then M.failed = true; return true end
      local ctx = EffectCtx.push(ad, user, target, move, moveId, ad:rng(), M)
      local ok, err = pcall(move.campaignStatus, ctx, M)
      EffectCtx.pop()
      if not ok then error(err, 0) end
      return true
    end
  end
  bridge.data, bridge.active, bridge.records, bridge.anims = data, active, records, anims
  bridge.scripts, bridge.labels = scripts, own and own.labels or {}
  -- the donor sprite templates those animations use, beside vanilla's
  if own and own.templates and own.install then own.install(own.templates) end
  bridge.supported = {}
  for n in pairs(records) do bridge.supported[n] = true end
  return bridge
end
