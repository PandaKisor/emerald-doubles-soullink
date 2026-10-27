-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T, C, R, H = F.T, F.campaign.candy, F.campaign.repel, F.campaign.heal
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
local candyEntry, repelEntry, healEntry
for _, e in ipairs(entries()) do
  if e.id == 'g3_campaign_candy' then candyEntry = e end
  if e.id == 'g3_campaign_repel' then repelEntry = e end
  if e.id == 'g3_campaign_heal' then healEntry = e end
end
T.check(candyEntry and repelEntry and healEntry, 'all three options appear in START')
repelEntry.onSelect(Runtime._game, s)
T.eq(repelEntry.label, 'REPEL: ON', 'toggle label updates immediately')
local PartyMenu = require('src.ui.game3.party_menu')
local show, opened = PartyMenu.show
PartyMenu.show = function(_, _, opts) opened = opts end
candyEntry.onSelect(Runtime._game, s)
T.check(opened and opened.item == C.id and opened.mode == 'use' and opened.bag == s.bag,
  'START opens the real party item flow with the real bag')
PartyMenu.show = show

-- Heal every slot with the actual nurse implementation, including PP Ups.
s.party = {}
for i = 1, 6 do
  local m = F.mon('TREECKO', 10, {'POUND', 'ABSORB'}, {ppBonusesPacked = 3})
  m.hp, m.status, m.sleep, m.pp[1], m.pp[2] = i == 6 and 0 or 1, 8, 3, 0, 0
  s.party[i] = m
end
local Message = require('src.ui.game3.message')
local messageShow, message = Message.show
Message.show = function(text) message = text end
healEntry.onSelect(Runtime._game, s)
Message.show = messageShow
T.check(message and message:find('fully healed', 1, true), 'menu confirms healing')
for i, m in ipairs(s.party) do
  T.eq(m.hp, m.maxHp, 'healing restores HP in slot ' .. i)
  T.eq(m.status, nil, 'healing clears status in slot ' .. i)
  T.eq(m.sleep, nil, 'healing clears sleep in slot ' .. i)
  T.eq(m.pp[1], math.floor(F.P.movePp(m.moves[1]) * 8 / 5), 'PP Ups retained in slot ' .. i)
  T.eq(m.pp[2], F.P.movePp(m.moves[2]), 'second move PP restored in slot ' .. i)
end
local SL = dofile('../coop/g3_coop/lib/soullink.lua')
local Tracker = dofile('../coop/g3_coop/lib/tracker.lua')
local rules = {on=true,hard=true}
local tr = Tracker.new({SL=SL,session=function() return s end,options=function() return rules end,
  read=function() return nil,'not_found' end,write=function() return true end,
  newId=function() return 'heal' end,toast=function() end,speciesName=tostring,
  isEgg=function() return false end})
tr:ensure()
tr:_append({k='catch',a=16,s=s.party[1].species,u=SL.uid(s.party[1])})
s.party[1].hp = 0 -- field faint not yet scanned
s.party[2].hp = 1
Runtime._game.mods.exports.g3_coop.tracker = function() return tr end
local healed, skipped = H.heal(Runtime._game, s)
T.eq(healed, 5, 'hard rules heal the five eligible team members')
T.eq(skipped, 1, 'hard rules skip the dead member')
T.eq(s.party[1].hp, 0, 'field faint is recorded before healing')
T.check(tr:view().dead[SL.uid(s.party[1])], 'healing preserves Soul Link faint history')
T.eq(s.party[2].hp, s.party[2].maxHp, 'remaining team heals under hard rules')
rules.on = false
T.eq(H.heal(Runtime._game, s), 6, 'Soul Link off heals all six, including fainted members')
local healedSave = Schema.fromSaveTable(Schema.toSaveTable(s))
T.eq(healedSave.party[1].hp, s.party[1].maxHp, 'healed HP survives save round trip')
T.eq(healedSave.party[1].pp[1], s.party[1].pp[1], 'healed PP survives save round trip')
SD.setCart(nil)
T.check(not R.enabled(s), 'repel is scoped to the campaign cart')
T.check(not C.grant(s), 'candy grant is scoped to the campaign cart')
T.eq(H.heal(Runtime._game, s), 0, 'healing is scoped to the campaign cart')
for _, e in ipairs(entries()) do
  T.check(e.id ~= 'g3_campaign_candy' and e.id ~= 'g3_campaign_repel' and e.id ~= 'g3_campaign_heal',
    'no campaign shortcuts on vanilla')
end
T.finish('campaign reusable candy, repel and team healing')
