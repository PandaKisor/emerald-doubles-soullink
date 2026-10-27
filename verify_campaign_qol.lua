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
-- START > RELEARN MOVE / IV CHECK, the starter kit, berries in marts (0.27.0)
local PT, K, W = F.campaign.partyTools, F.campaign.starterKit, F.campaign.world
local relearnEntry, ivEntry
for _, e in ipairs(entries()) do
  if e.id == 'g3_campaign_relearn' then relearnEntry = e end
  if e.id == 'g3_campaign_ivs' then ivEntry = e end
end
T.check(relearnEntry and relearnEntry.label == 'RELEARN MOVE', 'START menu offers RELEARN MOVE')
T.check(ivEntry and ivEntry.label == 'IV CHECK', 'START menu offers IV CHECK')
local ivMon = F.mon('TREECKO', 20, {'POUND'})
ivMon.ivs = { hp = 31, atk = 0, def = 12, spa = 30, spd = 7, spe = 25 }
ivMon.evs = { hp = 4, atk = 0, def = 0, spa = 252, spd = 0, spe = 252 }
ivMon.personality = 13 -- Jolly: +Spe -SpA
local rows, nature, hpType = PT.ivRows(ivMon)
T.eq(#rows, 6, 'IV CHECK shows six stats')
T.eq(rows[1].iv, 31, 'HP IV'); T.eq(rows[4].iv, 30, 'Sp. Atk IV'); T.eq(rows[6].ev, 252, 'Speed EV')
T.eq(nature, 'JOLLY', 'nature name')
T.eq(rows[6].mark, '+', 'Jolly raises Speed'); T.eq(rows[4].mark, '-', 'Jolly lowers Sp. Atk')
T.eq(rows[2].mark, '', 'unaffected stats are unmarked')
ivMon.personality = 0
local _, _, _ = PT.ivRows(ivMon)
T.check(select(1, PT.ivRows(ivMon))[1].mark == '', 'neutral natures mark nothing')
T.check(type(hpType) == 'string' and #hpType > 0, 'Hidden Power type is named')
local ks = F.session()
local oran, potionId = F.ids.items.ITEM_ORAN_BERRY, F.ids.items.ITEM_POTION
T.check(K.grant(ks), 'starter kit granted once')
T.eq(Bag.get(ks.bag, oran), 2, 'two Oran Berries'); T.eq(Bag.get(ks.bag, potionId), 1, 'one Potion')
T.check(not K.grant(ks), 'starter kit is not granted twice')
T.eq(Bag.get(ks.bag, oran), 2, 'still two Oran Berries')
T.check(Schema.fromSaveTable(Schema.toSaveTable(ks)).modData.g3_campaign.starterKit, 'starter kit flag survives a save')
local gm, lily = { kind = 'general' }, nil
for _, m in pairs(W.sources.marts) do if m.label == 'LilycoveCity_DepartmentStore_2F_EventScript_ClerkLeft' then lily = m end end
T.check(lily ~= nil, 'Lilycove 2F left clerk is a campaign mart')
T.eq(#W.berries(8, { kind = 'fixed' }), 0, 'other specialty shops sell no extra berries')
local has = function(list, sym) for _, x in ipairs(list) do if x == F.ids.items[sym] then return true end end return false end
T.check(has(W.berries(0, gm), 'ITEM_ORAN_BERRY') and not has(W.berries(0, gm), 'ITEM_SITRUS_BERRY'), 'Oran from the start, Sitrus not yet')
T.check(has(W.berries(2, gm), 'ITEM_SITRUS_BERRY') and not has(W.berries(2, gm), 'ITEM_LUM_BERRY'), 'Sitrus at two badges')
T.check(has(W.berries(8, gm), 'ITEM_LUM_BERRY') and has(W.berries(8, gm), 'ITEM_ORAN_BERRY'), 'tiers add up')
T.check(has(W.berries(0, lily), 'ITEM_OCCA_BERRY'), 'Lilycove sells resist berries')
W.wrapPrices()
local ItemsData = require('src.core.game3.items_data')
T.eq(ItemsData.info(oran).price, 100, 'marts charge 100 for an Oran Berry')
T.eq(ItemsData.info(F.ids.items.ITEM_LUM_BERRY).price, 500, 'and 500 for a Lum Berry')
-- field guide sync: START > GUIDE SYNC and every save write guide-sync.bin (0.37.0)
local GS = F.campaign.guideSync
local syncEntry
for _, e in ipairs(entries()) do if e.id == 'g3_campaign_guide' then syncEntry = e end end
T.check(syncEntry and syncEntry.label == 'GUIDE SYNC', 'START menu offers GUIDE SYNC')
local gs = F.session()
gs.party = { ivMon, F.mon('ZIGZAGOON', 7, {'TACKLE'}, { isEgg = true }) }
gs.flags[0x820] = true -- FLAG_BADGE01_GET
gs.storage = { boxes = { { mons = { [3] = F.mon('WURMPLE', 4, {'TACKLE'}) } } } }
gs.map, gs.x, gs.y = 'EM_ROUTE104', 12, 30
ivMon.personality, ivMon.ability, ivMon.abilityId = 13, nil, nil
local shared, partnerSnap = nil, { name = 'MAY', party = { { 280, 33 } }, box = {} }
local tracker = { run = {}, d = { areaName = function(a) return a == 16 and 'ROUTE 101' or '?' end } }
function tracker:view()
  return { pairs = { { a = 16, status = 'alive', mine = { state = 'caught', s = 261, u = '1:2' }, theirs = { state = 'caught', s = 265, u = '3:4' } } },
           banned = { ['9:9'] = true }, names = { ['1:2'] = 'ZIGGY' } }
end
local gsGame = { phase = 'field', save = { version = 'emerald', meta = { playthroughId = 'guidetest' } },
  mods = { exports = { g3_coop = { levelCap = function() return 19 end, partnerGuide = function() return partnerSnap end,
    shareGuide = function(d) shared = d end, tracker = function() return tracker end } } } }
local snap = GS.snapshot(gsGame, gs)
T.eq(snap.format, 'emerald-guide-sync', 'snapshot names its format')
T.eq(#snap.party, 1, 'eggs are left out of the party')
local r = snap.party[1]
T.eq(r[1], F.species('TREECKO'), 'species'); T.eq(r[2], 20, 'level'); T.eq(r[5], 13, 'nature from personality')
T.eq(r[6], 31, 'HP IV first'); T.eq(r[9], 30, 'Sp. Atk IV fourth'); T.eq(r[17], 252, 'Speed EV last')
T.eq(r[18], F.move('POUND'), 'first move')
T.eq(r[4], F.P.abilities(F.species('TREECKO'))[2], 'ability as battles pick it (odd personality: second)')
T.eq(#snap.box, 1, 'box mons are listed'); T.eq(snap.box[1][1], F.species('WURMPLE'), 'box species')
local hasBadge = false
for _, f in ipairs(snap.flags) do if f == 0x820 then hasBadge = true end end
T.check(hasBadge, 'set flags are listed')
T.eq(snap.player.cap, 19, 'level cap'); T.eq(snap.player.map, 'EM_ROUTE104', 'current map')
T.eq(snap.partner, partnerSnap, 'partner party comes from co-op')
T.eq(snap.soulLink.rows[1].name, 'ROUTE 101', 'Soul Link rows carry the area name')
T.eq(snap.soulLink.rows[1].mine[4], 'ZIGGY', 'and the nickname'); T.eq(snap.soulLink.banned[1], '9:9', 'banned uids')
T.check(GS.write(gsGame, gs), 'guide sync writes to mod storage')
T.check(shared and #shared.party == 1, 'this player\'s party is shared with the partner')
local body = love.filesystem.read(GS.path(gsGame))
T.check(type(body) == 'string' and body:find('"emerald-guide-sync"', 1, true), 'guide-sync.bin holds the JSON at ' .. tostring(GS.path(gsGame)))
local back = require('src.link.Json').decode(body)
T.eq(back and back.party[1][1], F.species('TREECKO'), 'the file decodes')
-- the field guide's browser smoke test loads this exact file
do local f = io.open('../porting/native/generated/handbook/guide-sync-sample.json', 'wb') if f then f:write(body) f:close() end end
-- Pokédex footprints for the new species (0.38.1)
T.check(F.campaign.footprints and F.campaign.footprints.count() > 300, 'new species have Inclement footprints')
-- Devon 3F: Mr. Stone's renamed gift gives Inclement's Scope Lens (0.38.1)
local devon = W.sources.gifts['g3:08212595']
T.eq(devon and devon[tostring(F.ids.items.ITEM_EXP_SHARE)], 'ITEM_SCOPE_LENS', 'Mr. Stone gives a Scope Lens')
SD.setCart(nil)
T.check(not R.enabled(s), 'repel is scoped to the campaign cart')
T.check(not C.grant(s), 'candy grant is scoped to the campaign cart')
T.check(not K.grant(F.session()), 'starter kit is scoped to the campaign cart')
T.check(not GS.write(gsGame, gs), 'guide sync is scoped to the campaign cart')
T.eq(H.heal(Runtime._game, s), 0, 'healing is scoped to the campaign cart')
for _, e in ipairs(entries()) do
  T.check(e.id ~= 'g3_campaign_candy' and e.id ~= 'g3_campaign_repel' and e.id ~= 'g3_campaign_heal'
    and e.id ~= 'g3_campaign_relearn' and e.id ~= 'g3_campaign_ivs' and e.id ~= 'g3_campaign_guide',
    'no campaign shortcuts on vanilla')
end
T.finish('campaign reusable candy, repel, team healing, relearner, IV check, starter kit, berries and guide sync')
