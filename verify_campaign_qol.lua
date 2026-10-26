-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T, C, R = F.T, F.campaign.candy, F.campaign.repel
local Bag = require('src.core.game3.bag')
local Use = require('src.core.game3.item_use')
local Runtime = require('src.core.game3.runtime')
local Sem = require('src.core.game3.field_semantics')
local Steps = require('src.core.game3.step_events')
local MR = require('src.mods.Runtime')
local SD = require('src.core.SaveData')
local s = F.session()
s.party = { F.mon('TREECKO', 5, {'POUND'}) }
Runtime.session = s
local cap = 8
Runtime._game = { phase = 'field', mods = { exports = { g3_coop = { levelCap = function() return cap end } } } }
T.check(C.grant(s), 'existing save with an empty bag receives candy')
T.check(C.grant(s), 'grant can be repeated')
T.eq(Bag.get(s.bag, C.id), 1, 'one reusable candy, no duplicate stacks')
for i = 6, 8 do
  T.check(Use.useField(s, s.bag, C.id, 1), 'candy raises level to ' .. i)
  T.eq(s.party[1].level, i, 'one level per use')
  T.eq(Bag.get(s.bag, C.id), 1, 'candy stays in the bag')
end
T.check(not Use.useField(s, s.bag, C.id, 1), 'campaign candy respects the co-op cap')
T.eq(s.party[1].level, 8, 'cannot exceed cap')
cap = nil
T.check(Use.useField(s, s.bag, C.id, 1), 'caps off permits more leveling')
T.eq(s.party[1].level, 9, 'caps off reaches next level')
s.party[1] = F.mon('TREECKO', 100, {'POUND'})
T.check(not Use.useField(s, s.bag, C.id, 1), 'level 100 cannot grow')
s.party[1] = F.mon('TREECKO', 5, {'POUND'}, {isEgg = true, egg = true})
T.check(not Use.useField(s, s.bag, C.id, 1), 'eggs cannot use candy')

-- Drive the actual party-item controller through its asynchronous prompts.
-- Only rendering/audio and the evolution scene presentation are replaced.
s.party[1] = F.mon('TREECKO', 15, {'POUND'})
local mon, pending, evolved = s.party[1], {}, nil
local menu = { _session = s, _bag = s.bag, _item = C.id, _party = s.party, cursor = 1, open = true }
menu.showMessage = function(_, done) if done then pending[#pending + 1] = done end end
menu.showStatGrowth = function(_, _, _, done) pending[#pending + 1] = done end
menu.reloadSprites = function() end
menu.close = function() menu.open = false end
local Audio = require('src.core.game3.audio')
local fanfare = Audio.playFanfare
Audio.playFanfare = function() end
local EvoScene = require('src.ui.game3.evolution_scene')
local startEvo = EvoScene.start
EvoScene.start = function(_, target, opts) evolved = target; opts.onDone() end
cap = 15
Use.inclementPartyItem(menu, mon, function() end)
T.eq(mon.level, 15, 'party controller also stops at the co-op cap')
T.eq(Bag.get(s.bag, C.id), 1, 'refused UI use keeps the candy')
while #pending > 0 do table.remove(pending, 1)() end
menu.open, cap = true, nil
T.check(Use.inclementPartyItem(menu, mon, function() end), 'party controller handles candy')
T.eq(Bag.get(s.bag, C.id), 1, 'UI use keeps even the last candy')
while #pending > 0 do table.remove(pending, 1)() end
T.eq(evolved, F.species('GROVYLE'), 'normal evolution prompt is reached')
T.eq(menu.mode, 'use', 'party picker stays open for another use')
Audio.playFanfare, EvoScene.start = fanfare, startEvo
local learned = Use._inclementRestoratives.candyMoves(mon)
T.eq(#learned, 0, 'level-up moves have been learned by the controller')

local potion = F.ids.items.ITEM_POTION
Bag.add(s.bag, potion, 2)
mon.hp = 1
T.check(Use.useField(s, s.bag, potion, 1), 'other medicine still works')
T.eq(Bag.get(s.bag, potion), 1, 'other medicine is consumed normally')

Sem.setVar(s, 'repelSteps', 0)
T.check(not R.enabled(s), 'unlimited repel starts off')
local h = require('src.core.game3.encounters')._h
T.check(h.wild_level_allowed_by_repel(1), 'repel off allows low-level encounters')
T.check(R.toggle(s), 'repel turns on')
T.check(not h.wild_level_allowed_by_repel(mon.level - 1), 'repel blocks weaker wild Pokemon')
T.check(h.wild_level_allowed_by_repel(mon.level), 'normal repel permits equal-level wild Pokemon')
for _ = 1, 300 do Steps.onRepelStep(s) end
T.check(Sem.getVar(s, 'repelSteps') > 0, 'unlimited repel does not expire')
T.eq(#Steps._queue, 0, 'no expired-repel messages')
local Schema = require('src.core.game3.save_schema_firered')
local restored = Schema.fromSaveTable(Schema.toSaveTable(s))
T.check(R.enabled(restored), 'repel choice survives a save round trip')
T.eq(Bag.get(restored.bag, C.id), 1, 'reusable candy survives saving')
R.toggle(s)
T.eq(Sem.getVar(s, 'repelSteps'), 0, 'toggle off restores normal encounters immediately')
Sem.setVar(s, 'repelSteps', 12)
R.toggle(s)
Steps.onRepelStep(s)
R.toggle(s)
T.eq(Sem.getVar(s, 'repelSteps'), 12, 'paid repel steps survive the toggle')
Steps.onRepelStep(s)
T.eq(Sem.getVar(s, 'repelSteps'), 11, 'paid repel resumes counting normally')

local function entries()
  return MR.call('ui.start_menu.items', function(_, list) return list end, Runtime._game,
    {{id='bag',label='BAG'}, {id='save',label='SAVE'}, {id='exit',label='EXIT'}})
end
local candyEntry, repelEntry
for _, e in ipairs(entries()) do
  if e.id == 'g3_campaign_candy' then candyEntry = e end
  if e.id == 'g3_campaign_repel' then repelEntry = e end
end
T.check(candyEntry and repelEntry, 'both options appear in START')
repelEntry.onSelect(Runtime._game, s)
T.eq(repelEntry.label, 'REPEL: ON', 'toggle label updates immediately')
local PartyMenu = require('src.ui.game3.party_menu')
local show, opened = PartyMenu.show
PartyMenu.show = function(_, _, opts) opened = opts end
candyEntry.onSelect(Runtime._game, s)
T.check(opened and opened.item == C.id and opened.mode == 'use' and opened.bag == s.bag,
  'START opens the real party item flow with the real bag')
PartyMenu.show = show
SD.setCart(nil)
T.check(not R.enabled(s), 'repel is scoped to the campaign cart')
T.check(not C.grant(s), 'candy grant is scoped to the campaign cart')
for _, e in ipairs(entries()) do
  T.check(e.id ~= 'g3_campaign_candy' and e.id ~= 'g3_campaign_repel', 'no campaign shortcuts on vanilla')
end
T.finish('campaign reusable candy and repel')
