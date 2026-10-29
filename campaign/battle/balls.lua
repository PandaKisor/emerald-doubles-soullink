-- The expanded balls in battle (user, 2026-10-28: "cherish balls dont work").
-- Gen 3's catch code knows balls 1-12 only (Catching.isBall), so the bag
-- refused every newer ball. Every item in the expanded POKé BALLS pocket that
-- the donor throws (ItemUseInBattle_PokeBall) is a ball here, with Gen 7's
-- bonus (x10, as Catching.ballMultiplier counts). Each bonus reads only the
-- battle's shared state: both co-op games resolve a throw and must agree, so
-- the Dusk Ball counts caves, not the time of day (each player's own clock).
-- Lure and Moon Ball stay plain: no fishing flag or evolution data in battle.
return function(mod, U, active)
  local Catching = require("src.core.game3.battle.catching")
  local State = require("src.core.game3.battle.state")
  local Pokemon = require("src.core.game3.pokemon")
  local ids = U.data.identity.namespaces.items
  local B = {}

  local function id(symbol) return ids["ITEM_" .. symbol] end
  B.BALLS = {}
  for num, row in pairs(U.data.items or {}) do
    local f = type(row) == "table" and row.sourceFields
    if row.pocket == "POKE_BALLS" and f and f.battleUseFunc == "ItemUseInBattle_PokeBall" then
      B.BALLS[tonumber(num)] = row.symbol
    end
  end

  local MAP_TYPE_UNDERGROUND = 4  -- pokeemerald include/constants/map_types.h
  local function inCave()
    local ok, Map = pcall(require, "src.core.game3.map")
    local def = ok and Map and Map.currentDef and Map.currentDef()
    return def ~= nil and tonumber(def.mapType) == MAP_TYPE_UNDERGROUND
  end
  -- the thrower's Pokémon: the co-op throw names its battler, else the player's
  local function thrower(st)
    local who = st and st.coopBall and tonumber(st.coopBall.battler) or 0
    local b = State.battler(st, who)
    return b and b.mon and b or State.battler(st, 0)
  end
  local function base(species, key)
    local s = Pokemon.stats(species)
    return s and tonumber(s[key] or s[key == "speed" and "spe" or key]) or 0
  end

  -- num -> function(foe, st) -> bonus x10
  B.BONUS = {
    QUICK_BALL = function(_, st) return (tonumber(st and st.turn) or 0) <= 1 and 50 or 10 end,
    DUSK_BALL = function() return inCave() and 30 or 10 end,
    FAST_BALL = function(foe) return base(foe.species, "speed") >= 100 and 40 or 10 end,
    LEVEL_BALL = function(foe, st)
      local me, them = thrower(st), tonumber(foe.mon and foe.mon.level) or 1
      local lv = tonumber(me and me.mon and me.mon.level) or 1
      if lv >= 4 * them then return 80 elseif lv >= 2 * them then return 40 elseif lv > them then return 20 end
      return 10
    end,
    LOVE_BALL = function(foe, st)
      local me = thrower(st)
      if not (me and me.species == foe.species) then return 10 end
      local a = Pokemon.gender(me.species, me.mon.personality)
      local b = Pokemon.gender(foe.species, foe.mon and foe.mon.personality)
      return (a ~= "U" and b ~= "U" and a ~= b) and 80 or 10
    end,
    -- Gen 7 adds to the catch rate by weight; as a bonus on Gen 3's formula
    -- that is 1x below 100 kg, then 1.2x / 1.3x / 1.4x (U.weight: tenths of kg)
    HEAVY_BALL = function(foe)
      local w = U.weight(foe)
      if w >= 3000 then return 14 elseif w >= 2000 then return 13 elseif w >= 1000 then return 12 end
      return 10
    end,
    SPORT_BALL = function() return 15 end,
    -- not an Ultra Beast (none are in the campaign): a tenth
    BEAST_BALL = function() return 1 end,
  }
  local bonusOf = {}
  for name, fn in pairs(B.BONUS) do
    local n = id(name)
    if n then bonusOf[n] = fn end
  end

  function B.isBall(itemId)
    local ItemsData = require("src.core.game3.items_data")
    local num = ItemsData.toNumericId(itemId) or tonumber(itemId)
    return num ~= nil and B.BALLS[num] ~= nil
  end

  if not Catching._campaignIsBall then
    Catching._campaignIsBall, Catching._campaignBallMultiplier = Catching.isBall, Catching.ballMultiplier
    Catching.isBall = function(itemId)
      if active() and B.isBall(itemId) then return true end
      return Catching._campaignIsBall(itemId)
    end
    Catching.ballMultiplier = function(itemId, foe, st, session)
      local ItemsData = require("src.core.game3.items_data")
      local num = ItemsData.toNumericId(itemId) or tonumber(itemId)
      if active() and num and num > 12 and B.BALLS[num] then
        local fn = bonusOf[num]
        local ok, mult = pcall(function() return fn and foe and fn(foe, st) or 10 end)
        return ok and tonumber(mult) or 10
      end
      return Catching._campaignBallMultiplier(itemId, foe, st, session)
    end
  end
  return B
end
