-- Shared helpers for the campaign's expanded moves: battler queries, text,
-- stat changes, healing, typing and held berries, all through the native
-- battle adapter so animations, events and link hashing see the same changes.
return function(data)
  local State = require("src.core.game3.battle.state")
  local Secondary = require("src.core.game3.battle.effects.secondary")
  local Types = require("src.core.game3.battle.types")
  local U = { data = data }

  U.TYPE = { NORMAL = 0, FIGHTING = 1, FLYING = 2, POISON = 3, GROUND = 4, ROCK = 5, BUG = 6, GHOST = 7,
    STEEL = 8, FIRE = 10, WATER = 11, GRASS = 12, ELECTRIC = 13, PSYCHIC = 14, ICE = 15, DRAGON = 16,
    DARK = 17, FAIRY = 18 }
  U.STATS = { "attack", "defense", "speed", "spAtk", "spDef", "accuracy", "evasion" }
  U.STAT_NAMES = { attack = "Attack", defense = "Defense", speed = "Speed", spAtk = "Sp. Atk",
    spDef = "Sp. Def", accuracy = "accuracy", evasion = "evasiveness" }

  function U.st(ad) return ad._st end
  function U.name(ad, b) return ad:displayName(b) end
  function U.say(ad, text) ad:say(text) end
  function U.alive(ad, b) return b ~= nil and b.mon ~= nil and ad:hp(b) > 0 end
  function U.id(b) return State.idOf(b) end

  function U.partner(ad, b)
    local st = ad._st
    if not (st and st.double) then return nil end
    local p = State.battler(st, (State.idOf(b) + 2) % 4)
    if p and State.isPresent(st, State.idOf(p)) and U.alive(ad, p) then return p end
    return nil
  end

  function U.foes(ad, b)
    local st, out = ad._st, {}
    for _, id in ipairs(st and st.double and { 0, 1, 2, 3 } or { 0, 1 }) do
      local f = State.battler(st, id)
      if f and f.side ~= b.side and State.isPresent(st, id) and U.alive(ad, f) then out[#out + 1] = f end
    end
    return out
  end

  function U.all(ad)
    local out = {}
    for _, b in ipairs(ad:activeBattlers() or {}) do if U.alive(ad, b) then out[#out + 1] = b end end
    return out
  end

  -- types, including a third type added by Trick-or-Treat or Forest's Curse
  function U.types(b)
    local t1, t2 = b.type1, b.type2
    if b.expTransform then t1, t2 = b.expTransform.type1 or t1, b.expTransform.type2 or t2 end
    t1, t2 = tonumber(t1), tonumber(t2)
    -- Roost: no Flying type for the rest of the turn
    local st = b.campaignRoosting and require("src.core.game3.battle")._st
    if st and b.campaignRoosting == st.turn then
      if t1 == U.TYPE.FLYING then t1 = (t2 ~= U.TYPE.FLYING and t2) or U.TYPE.NORMAL end
      if t2 == U.TYPE.FLYING then t2 = t1 end
    end
    return t1, t2, b.campaignType3
  end
  function U.hasType(b, t)
    local t1, t2, t3 = U.types(b)
    return t1 == t or t2 == t or t3 == t
  end

  -- grounded: not Flying, Levitate, Magnet Rise or Telekinesis, unless held
  -- down by Gravity, Smack Down or Ingrain
  function U.grounded(ad, b)
    local st = ad._st
    if st.campaignField and (st.campaignField.gravity or 0) > 0 then return true end
    if b.campaignSmackedDown or b.expIngrain then return true end
    if U.hasType(b, U.TYPE.FLYING) or ad:abilityOf(b) == "LEVITATE" then return false end
    if (b.campaignMagnetRise or 0) > 0 or (b.campaignTelekinesis or 0) > 0 then return false end
    return true
  end

  function U.stage(b, stat) return (b.stages and b.stages[stat]) or 0 end

  -- several stat changes with one animation, as the donor's multi-stat moves
  function U.changeStats(ad, b, changes, opts)
    opts = opts or {}
    local stats, any = {}, false
    for _, stat in ipairs(U.STATS) do
      local d = changes[stat]
      if d and d ~= 0 then
        stats[#stats + 1] = stat
        local cur = U.stage(b, stat)
        if (d > 0 and cur < 6) or (d < 0 and cur > -6) then any = true end
      end
    end
    if #stats == 0 then return false end
    if not any then
      local up = changes[stats[1]] > 0
      for _, stat in ipairs(stats) do
        Secondary.changeStat(ad, b, stat, changes[stat], { user = opts.user, certain = true })
      end
      return false, up
    end
    if not opts.noAnim then
      local delta = changes[stats[1]]
      Secondary.multiStatAnim(ad, b, stats, delta, { cantPrevent = opts.certain })
    end
    for _, stat in ipairs(stats) do
      local cur = U.stage(b, stat)
      local d = changes[stat]
      Secondary.changeStat(ad, b, stat, d, { user = opts.user, certain = opts.certain, allowPtr = true,
        noAnim = true, noMsg = (d > 0 and cur >= 6) or (d < 0 and cur <= -6) })
    end
    return true
  end

  function U.heal(ad, b, amount)
    amount = math.floor(amount)
    local room = ad:maxHp(b) - ad:hp(b)
    if room <= 0 then return 0 end
    if amount < 1 then amount = 1 end
    if amount > room then amount = room end
    ad:heal(b, amount)
    return amount
  end

  function U.healBlocked(b) return (b.campaignHealBlock or 0) > 0 end

  -- effectiveness of one attacking type against a battler's current typing
  function U.effectiveness(moveType, b)
    local t1, t2, t3 = U.types(b)
    local e = Types.effectiveness(moveType, t1, t2 or t1)
    if t3 and t3 ~= t1 and t3 ~= t2 then e = e * Types.effectiveness(moveType, t3, t3) end
    return e
  end

  function U.flagsFor(eff)
    return { immune = eff == 0, super = eff > 1, notVery = eff > 0 and eff < 1 }
  end

  -- held items and berries (Inclement item data)
  function U.item(b) return tonumber(b.item or (b.mon and (b.mon.item or b.mon.heldItem))) or 0 end
  function U.itemRow(id) return data.items[tonumber(id) or 0] end
  function U.isBerry(id)
    local row = U.itemRow(id)
    return row ~= nil and row.pocket == "BERRY_POUCH"
  end
  function U.itemName(id)
    local row = U.itemRow(id)
    return row and row.name or "item"
  end
  function U.setItem(b, id)
    b.item = id ~= 0 and id or 0
    Secondary.persistItem(b, id ~= 0 and id or nil)
  end
  function U.removeItem(b)
    local id = U.item(b)
    U.setItem(b, 0)
    return id
  end

  local STATUS_CURE = { HOLD_EFFECT_CURE_PAR = "PAR", HOLD_EFFECT_CURE_SLP = "SLP", HOLD_EFFECT_CURE_PSN = "PSN",
    HOLD_EFFECT_CURE_BRN = "BRN", HOLD_EFFECT_CURE_FRZ = "FRZ" }
  local STAT_BERRY = { HOLD_EFFECT_ATTACK_UP = "attack", HOLD_EFFECT_DEFENSE_UP = "defense",
    HOLD_EFFECT_SPEED_UP = "speed", HOLD_EFFECT_SP_ATTACK_UP = "spAtk", HOLD_EFFECT_SP_DEFENSE_UP = "spDef" }
  -- `eater` gets the berry's effect at once (Bug Bite, Pluck, Stuff Cheeks)
  function U.eatBerry(ad, eater, berry)
    local row = U.itemRow(berry)
    local f = row and row.sourceFields or {}
    local he, param = f.holdEffect, tonumber(f.holdEffectParam) or 0
    ad:playAnim("general", "HELD_ITEM_EFFECT", eater, eater)
    if he == "HOLD_EFFECT_RESTORE_HP" then
      if U.heal(ad, eater, param) > 0 then U.say(ad, U.name(ad, eater) .. " restored its health!") end
    elseif he == "HOLD_EFFECT_RESTORE_PCT_HP" then
      if U.heal(ad, eater, ad:maxHp(eater) * param / 100) > 0 then U.say(ad, U.name(ad, eater) .. " restored its health!") end
    elseif he and he:match("^HOLD_EFFECT_CONFUSE_") then
      U.heal(ad, eater, ad:maxHp(eater) / math.max(1, param))
    elseif STATUS_CURE[he] then
      if ad:status(eater) == STATUS_CURE[he] or (he == "HOLD_EFFECT_CURE_PSN" and ad:status(eater) == "TOX") then
        ad:clearStatus(eater)
        U.say(ad, U.name(ad, eater) .. " was cured!")
      end
    elseif he == "HOLD_EFFECT_CURE_STATUS" then
      if ad:status(eater) then ad:clearStatus(eater) end
      eater.confusionTurns = nil
      U.say(ad, U.name(ad, eater) .. " was cured!")
    elseif he == "HOLD_EFFECT_CURE_CONFUSION" then
      eater.confusionTurns = nil
    elseif STAT_BERRY[he] then
      Secondary.changeStat(ad, eater, STAT_BERRY[he], 1, { user = true, allowPtr = true })
    end
    eater.campaignAteBerry = true
  end

  function U.weight(b)
    local Pokemon = require("src.core.game3.pokemon")
    local entry = Pokemon.dexEntry(b.species or Pokemon.speciesOf(b.mon))
    local w = entry and tonumber(entry.weight) or 1
    if (b.campaignAutotomize or 0) > 0 then w = math.max(1, w - 1000 * b.campaignAutotomize) end
    local field = require("src.core.game3.battle.moves")._campaignField
    if field and field.abilities then w = field.abilities.weight(b, w) end
    return math.max(1, w)
  end

  function U.speed(ad, b)
    local Engine = require("src.core.game3.battle.engine")
    local s = Engine.speedOf(b, ad._st, ad)
    local side = ad:ownSide(b)
    if side and (side.campaignTailwind or 0) > 0 then s = s * 2 end
    local field = require("src.core.game3.battle.moves")._campaignField
    if field and field.items then s = field.items.speed(b, s) end
    return math.max(1, s)
  end

  -- a move's donor flags (FLAG_SOUND, FLAG_POWDER, ...), for Gen 3 moves too
  function U.moveFlag(move, flag)
    local row = move and data.moves[tonumber(move.numId) or 0]
    for _, f in ipairs((row and row.sourceFlags) or move.sourceFlags or {}) do
      if f == flag then return true end
    end
    return false
  end

  -- current turn bookkeeping (field.lua)
  function U.turn(ad) return ad._st.campaignTurn or {} end
  function U.movedThisTurn(ad, b) return U.turn(ad).moved and U.turn(ad).moved[State.idOf(b)] or false end

  return U
end
