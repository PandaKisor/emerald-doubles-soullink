-- The expanded balls work (user, 2026-10-28: "cherish balls dont work"):
-- campaign/battle/balls.lua makes every expanded POKé BALLS-pocket ball
-- throwable, with its Gen 7 bonus from the battle's shared state.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local Catching = require('src.core.game3.battle.catching')
-- the cart's own battle modules (native/swap.lua), as the battle uses them
for name, m in pairs(F.loader.exports.g3_campaign.nativeModules or {}) do package.loaded[name] = package.loaded[name] or m end
local Coop = require('src.core.game3.battle.coop')
local State = require('src.core.game3.battle.state')
local Bag = require('src.core.game3.bag')
local item = function(n) return assert(F.ids.items['ITEM_' .. n], n) end

for _, n in ipairs({ 'HEAL_BALL', 'QUICK_BALL', 'CHERISH_BALL', 'FAST_BALL', 'LEVEL_BALL', 'LURE_BALL', 'HEAVY_BALL',
    'LOVE_BALL', 'FRIEND_BALL', 'MOON_BALL', 'SPORT_BALL', 'PARK_BALL', 'DREAM_BALL', 'BEAST_BALL', 'DUSK_BALL' }) do
  T.check(Catching.isBall(item(n)), n .. ' is a ball in battle')
end
T.check(not Catching.isBall(item('POTION')), 'a Potion is not')

local foe = { species = F.species('ZIGZAGOON'), level = 3 }
local st = F.battle({ playerParty = { F.mon('TREECKO', 40, { 'POUND' }), F.mon('TORCHIC', 40, { 'SCRATCH' }) },
  foe = foe, wildPartner = { species = F.species('ZIGZAGOON'), level = 3 }, wild = true, double = true })
local wild = State.battler(st, 1)
T.check(wild and wild.mon, 'a wild double to throw at')
st.turn = 1
T.eq(Catching.ballMultiplier(item('QUICK_BALL'), wild, st), 50, 'Quick Ball: 5x on the first turn')
st.turn = 3
T.eq(Catching.ballMultiplier(item('QUICK_BALL'), wild, st), 10, 'and 1x later')
T.eq(Catching.ballMultiplier(item('LEVEL_BALL'), wild, st), 80, 'Level Ball: 8x at four times the level')
T.eq(Catching.ballMultiplier(item('FAST_BALL'), wild, st), 10, 'Fast Ball: 1x on a slow Pokémon')
T.eq(Catching.ballMultiplier(item('BEAST_BALL'), wild, st), 1, 'Beast Ball: a tenth outside Ultra Beasts')
T.eq(Catching.ballMultiplier(item('CHERISH_BALL'), wild, st), 10, 'Cherish Ball: 1x')
T.eq(Catching.ballMultiplier(item('ULTRA_BALL'), wild, st), Catching.BALL_BONUS[2] or 20, 'the Gen 3 balls are unchanged')

-- a real catch: the roll accepts the ball and the caught Pokémon keeps it
local s = require('src.core.game3.runtime').getSession()
wild.mon.hp = 1
local caught = Catching.tryCatch(item('CHERISH_BALL'), wild, st, s, function(lo) return lo or 0 end)
T.check(caught, 'a Cherish Ball catches')
local res = Catching.storeCaught(s, wild, item('CHERISH_BALL'))
T.check(res and res.success, 'the catch is stored')
T.eq(res and res.mon and tonumber(res.mon.pokeball), item('CHERISH_BALL'), 'the caught Pokémon keeps its Cherish Ball')
-- the bag's in-battle check takes it
local BattleItems = require('src.core.game3.battle.items')
T.check(BattleItems.isBall(item('CHERISH_BALL')), 'the battle bag offers it as a ball')
T.finish('campaign expanded balls')
