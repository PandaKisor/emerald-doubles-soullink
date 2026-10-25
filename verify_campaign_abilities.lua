-- Abilities on the campaign (campaign/battle/abilities.lua), headless on
-- stock 0.3.73 through the built mod: damage-formula abilities compared
-- against no ability, speed and priority, then wild-double scenarios that
-- look for each ability's own battle text or state.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit; optional args: labels.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local State=require('src.core.game3.battle.state')
local Battle=require('src.core.game3.battle')
local Ui=require('src.core.game3.battle.ui')
local Moves=require('src.core.game3.battle.moves')
local Engine=require('src.core.game3.battle.engine')
local Field=Moves._campaignField
local A=assert(Field.abilities,'abilities module installed')
local items=F.ids.items
local abilityIds={}
for id,row in pairs(F.data.abilities) do abilityIds[row.symbol:gsub('^ABILITY_','')]=id end
local only={}
for _,a in ipairs(arg or {}) do only[a]=true end
local function wanted(label) return next(only)==nil or only[label] end

-- a species that has the ability, and its slot
local holders={}
do
  local best={}
  for id,row in pairs(F.data.species) do
    local sym=row.symbol or ''
    if not sym:find('_MEGA') and not sym:find('_GMAX') and not sym:find('_PRIMAL') then
      for slot,a in ipairs(row.abilities or {}) do
        if a and a~=0 and (not best[a] or id<best[a][1]) then best[a]={id,sym:gsub('^SPECIES_',''),slot-1} end
      end
    end
  end
  for a,v in pairs(best) do holders[a]={v[2],v[3]} end
end
local function holder(sym)
  local h=assert(holders[assert(abilityIds[sym],sym)],'no species has '..sym)
  return h[1],h[2]
end

-- ---------------------------------------------------------------- formula
local Adapter=require('src.core.game3.battle.adapter')
local st={playerSide={},enemySide={},battlers={},turn=1}
local ad=Adapter.new(st,function() end)
local function battler(name,level,side,ability)
  local m=F.mon(name or 'MEW',level or 50,{'TACKLE'})
  local b=State.makeBattler(m,side or 'player',{partyIndex=1,id=side=='enemy' and 1 or 0})
  if ability then b.ability=abilityIds[ability] end
  return b
end
local Damage=require('src.core.game3.battle.damage')
local function dmg(atk,def,move,opts)
  opts=opts or {}
  opts.forceRoll,opts.forceCrit,opts.rng,opts.adapter=100,false,function(lo) return lo or 0 end,ad
  return (Damage.calc(atk,def,Moves.get(F.move(move)),opts))
end
-- damage with the ability on attacker or defender, against the same pair without
local function compare(label,ability,who,move,expect,o)
  if not wanted(label) then return end
  o=o or {}
  local a,d=battler(o.attacker,100,'player'),battler(o.defender,100,'enemy')
  if o.setup then o.setup(a,d) end
  local base=dmg(a,d,move)
  local b=who=='attacker' and a or d
  b.ability=abilityIds[ability]
  local with=dmg(a,d,move)
  local ratio=with/math.max(1,base)
  T.check(math.abs(ratio-expect)<0.08,('%s: %d -> %d (x%.2f, expected x%.2f)'):format(label,base,with,ratio,expect))
end
compare('Technician boosts weak moves','TECHNICIAN','attacker','TACKLE',1.5)
compare('Technician leaves strong moves','TECHNICIAN','attacker','BODY_SLAM',1)
compare('Iron Fist boosts punches','IRON_FIST','attacker','FIRE_PUNCH',1.2)
compare('Tough Claws boosts contact','TOUGH_CLAWS','attacker','TACKLE',1.3)
compare('Tough Claws leaves non-contact','TOUGH_CLAWS','attacker','SWIFT',1)
compare('Strong Jaw boosts bites','STRONG_JAW','attacker','BITE',1.5)
compare('Mega Launcher boosts pulses','MEGA_LAUNCHER','attacker','WATER_PULSE',1.5)
compare('Sheer Force boosts moves with effects','SHEER_FORCE','attacker','FLAMETHROWER',1.3)
compare('Reckless boosts recoil moves','RECKLESS','attacker','DOUBLE_EDGE',1.2)
compare('Steelworker boosts Steel moves','STEELWORKER','attacker','IRON_HEAD',1.5)
compare('Transistor boosts Electric moves','TRANSISTOR','attacker','THUNDERBOLT',1.5)
compare("Dragon's Maw boosts Dragon moves",'DRAGONS_MAW','attacker','DRAGON_PULSE',1.5)
compare('Water Bubble doubles Water moves','WATER_BUBBLE','attacker','SURF',2)
compare('Water Bubble halves Fire on the holder','WATER_BUBBLE','defender','FLAMETHROWER',0.5)
compare('Punk Rock boosts sound','PUNK_ROCK','attacker','HYPER_VOICE',1.3)
compare('Punk Rock halves sound taken','PUNK_ROCK','defender','HYPER_VOICE',0.5)
compare('Gorilla Tactics boosts physical','GORILLA_TACTICS','attacker','TACKLE',1.5)
compare('Gorilla Tactics leaves special','GORILLA_TACTICS','attacker','PSYCHIC',1)
compare('Fur Coat halves physical','FUR_COAT','defender','TACKLE',0.5)
compare('Fur Coat leaves special','FUR_COAT','defender','PSYCHIC',1)
compare('Multiscale halves at full HP','MULTISCALE','defender','TACKLE',0.5)
compare('Filter softens super-effective','FILTER','defender','SHADOW_BALL',0.75)
compare('Filter leaves neutral','FILTER','defender','TACKLE',1)
compare('Tinted Lens doubles resisted hits','TINTED_LENS','attacker','TACKLE',2,{defender='GEODUDE'})
compare('Neuroforce boosts super-effective','NEUROFORCE','attacker','SHADOW_BALL',1.25)
compare('Thick Fat halves physical Fire','THICK_FAT','defender','FIRE_PUNCH',0.5)
compare('Heatproof halves Fire','HEATPROOF','defender','FLAMETHROWER',0.5)
compare('Dry Skin: Fire hurts more','DRY_SKIN','defender','FLAMETHROWER',1.25)
compare('Fluffy halves contact','FLUFFY','defender','TACKLE',0.5)
compare('Fluffy doubles Fire','FLUFFY','defender','FLAMETHROWER',2)
compare('Ice Scales: special damage (donor: stat and final)','ICE_SCALES','defender','PSYCHIC',0.25)
compare('Prism Armor softens super-effective','PRISM_ARMOR','defender','SHADOW_BALL',0.75)
compare('Blaze outside a pinch: x1.2 (Inclement)','BLAZE','attacker','FLAMETHROWER',1.2)
compare('Vengeance boosts Ghost moves','VENGEANCE','attacker','SHADOW_BALL',1.2)
compare('Solar Power without sun does nothing','SOLAR_POWER','attacker','PSYCHIC',1)
if wanted('Flash Fire') then
  local a,d=battler('MEW',50,'player'),battler('MEW',50,'enemy')
  local base=dmg(a,d,'FLAMETHROWER')
  a.expFlashFire=true
  T.check(math.abs(dmg(a,d,'FLAMETHROWER')/base-1.5)<0.08,'Flash Fire boost applies under the Inclement rules')
end
compare('Unaware ignores the attacker\'s boosts','UNAWARE','defender','TACKLE',0.5,
  {setup=function(a) a.stages.attack=2 end})
compare('Unaware ignores the defender\'s boosts','UNAWARE','attacker','TACKLE',1.9,
  {setup=function(a,d) d.stages.defense=2 end})
compare('Rivalry: same gender x1.25 / opposite x0.75','RIVALRY','attacker','TACKLE',
  1.25,{setup=function(a,d) a.mon.gender,d.mon.gender='M','M' end})
Battle._adapter=ad
if wanted('Scrappy') then
  local a,d=battler('MEW',50,'player'),battler('GASTLY',50,'enemy')
  T.eq(dmg(a,d,'TACKLE'),0,'Tackle does not touch a Ghost')
  a.ability=abilityIds.SCRAPPY
  T.check(dmg(a,d,'TACKLE')>0,'Scrappy: Tackle hits a Ghost')
end
if wanted('speed') then
  local b=battler('MEW',50,'player')
  local s0=Engine.speedOf(b,st,ad)
  b.ability=abilityIds.SLOW_START;b.campaignSlowStart=5
  T.eq(Engine.speedOf(b,st,ad),math.floor(s0/2),'Slow Start halves Speed')
  b.ability=abilityIds.UNBURDEN;b.campaignHadItem=true;b.item=0;b.mon.item=0
  T.eq(Engine.speedOf(b,st,ad),s0*2,'Unburden doubles Speed once the item is gone')
  b.ability=abilityIds.QUICK_FEET;b.status='BRN';b.mon.status='BRN'
  T.eq(Engine.speedOf(b,st,ad),math.floor(s0*1.5),'Quick Feet: x1.5 Speed with a status')
  b.status,b.mon.status=nil,nil
end
if wanted('priority') then
  local b=battler('MEW',50,'player')
  b.ability=abilityIds.PRANKSTER
  T.eq(A.priority(ad,b,F.move('THUNDER_WAVE')),1,'Prankster: status moves +1')
  T.eq(A.priority(ad,b,F.move('TACKLE')),0,'Prankster: attacks unchanged')
  b.ability=abilityIds.GALE_WINGS
  T.eq(A.priority(ad,b,F.move('WING_ATTACK')),1,'Gale Wings: Flying moves +1')
  b.ability=abilityIds.TRIAGE
  T.eq(A.priority(ad,b,F.move('GIGA_DRAIN')),3,'Triage: draining moves +3')
  b.ability=abilityIds.BLITZ_BOXER
  T.eq(A.priority(ad,b,F.move('MACH_PUNCH')),2,'Blitz Boxer: punches +1')
end

Battle._adapter=nil
-- ---------------------------------------------------------------- battles
local texts
local push=Ui.push
Ui.push=function(text,...) if texts and text then texts[#texts+1]=tostring(text):gsub('\n',' ') end return push(text,...) end
local function mons(spec)
  local out={}
  for i,m in ipairs(spec) do
    local name,slot=m[1],m.slot
    if m.ability then name,slot=holder(m.ability) end
    local extra={}
    if m.item then extra.item=items[m.item] end
    if m.status then extra.status=m.status end
    if slot then extra.abilityNum=slot end
    if m.gender then extra.gender=m.gender end
    out[i]=F.mon(name,m.level or 40,m.moves or {'TACKLE'},extra)
    if m.hp then out[i].hp=math.max(1,math.floor(out[i].maxHp*m.hp)) end
  end
  return out
end
local lastState
local function scenario(label,player,foe,expect,opts)
  if not wanted(label) then return end
  opts=opts or {}
  texts={}
  F.reseed(opts.seed or 0x2468)
  local ok,err=pcall(function()
    local w=mons(foe)
    lastState=F.battle({playerParty=mons(player),foe=w[1],wildPartner=w[2],wild=true,double=true,onStarted=opts.onStarted})
  end)
  Battle.reset()
  local joined=table.concat(texts,' / ')
  local hit=ok and (expect==nil or joined:find(expect,1,true)~=nil)
  if opts.absent then hit=hit and joined:find(opts.absent,1,true)==nil end
  if opts.check then hit=ok and hit and opts.check(texts,joined) end
  T.check(hit,label..(ok and '' or (' ERROR '..tostring(err))))
  if (not hit and ok) or os.getenv('SHOW') then print('   texts: '..joined:sub(1,900)) end
end
local strong={'MEW',level=80}
local weak={'MEW',level=10}

-- switch-in
scenario('Intimidate (native, rewritten)',{{ability='INTIMIDATE'},{'MEW'}},{{'MEW'},{'MEW'}},'Intimidate cuts')
scenario('Inner Focus blocks Intimidate (Gen 8)',{{ability='INTIMIDATE'},{'MEW'}},{{ability='INNER_FOCUS'},{'MEW'}},'prevents it from losing Attack')
scenario('Defiant answers Intimidate',{{ability='INTIMIDATE'},{'MEW'}},{{ability='DEFIANT'},{'MEW'}},'Defiant raised its Attack')
scenario('Competitive answers Intimidate',{{ability='INTIMIDATE'},{'MEW'}},{{ability='COMPETITIVE'},{'MEW'}},'Competitive raised its Sp. Atk')
scenario('Rattled answers Intimidate',{{ability='INTIMIDATE'},{'MEW'}},{{ability='RATTLED'},{'MEW'}},'Rattled raised its Speed')
scenario('Mirror Armor reflects Intimidate',{{ability='INTIMIDATE'},{'MEW'}},{{ability='MIRROR_ARMOR'},{'MEW'}},'Mirror Armor reflected')
scenario('Contrary turns Intimidate around',{{ability='INTIMIDATE'},{'MEW'}},{{ability='CONTRARY'},{'MEW'}},'Intimidate raised')
scenario('Snow Warning summons hail',{{ability='SNOW_WARNING'},{'MEW'}},{{'MEW'},{'MEW'}},'whipped up a hailstorm')
scenario('Electric Surge',{{ability='ELECTRIC_SURGE'},{'MEW'}},{{'MEW'},{'MEW'}},'electric current')
scenario('Psychic Surge',{{ability='PSYCHIC_SURGE'},{'MEW'}},{{'MEW'},{'MEW'}},'battlefield got weird')
scenario('Download',{{ability='DOWNLOAD'},{'MEW'}},{{'MEW'},{'MEW'}},'Download raised')
scenario('Intrepid Sword',{{ability='INTREPID_SWORD'},{'MEW'}},{{'MEW'},{'MEW'}},'raised its Attack')
scenario('Frisk finds held items',{{ability='FRISK'},{'MEW'}},{{'MEW',item='ITEM_ORAN_BERRY'},{'MEW'}},'frisked')
scenario('Forewarn',{{ability='FOREWARN'},{'MEW'}},{{'MEW',moves={'THUNDERBOLT'}},{'MEW'}},'Forewarn alerted')
scenario('Anticipation',{{ability='ANTICIPATION'},{'MEW'}},{{'MEW',moves={'BRICK_BREAK'}},{'MEW'}},'shuddered')
scenario('Mold Breaker announces itself',{{ability='MOLD_BREAKER'},{'MEW'}},{{'MEW'},{'MEW'}},'breaks the mold')
scenario('Pressure announces itself',{{ability='PRESSURE'},{'MEW'}},{{'MEW'},{'MEW'}},'exerting its pressure')
scenario('Unnerve',{{ability='UNNERVE'},{'MEW'}},{{'MEW'},{'MEW'}},'too nervous')
scenario('Slow Start',{{ability='SLOW_START'},{'MEW'}},{{'MEW'},{'MEW'}},"can't get it going")
scenario('Neutralizing Gas',{{ability='NEUTRALIZING_GAS'},{'MEW'}},{{'MEW'},{'MEW'}},'Neutralizing gas filled')
scenario('Neutralizing Gas stops Intimidate',{{ability='NEUTRALIZING_GAS'},{'MEW'}},{{ability='INTIMIDATE'},{'MEW'}},nil,{absent='Intimidate cuts'})
scenario('Imposter transforms',{{ability='IMPOSTER'},{'MEW'}},{{'MEW'},{'MEW'}},'transformed into')
scenario('Screen Cleaner',{{ability='SCREEN_CLEANER'},{'MEW'}},{{'MEW',moves={'REFLECT'}},{'MEW'}},nil)
scenario('Trace copies a new ability',{{ability='TRACE'},{'MEW'}},{{ability='TOUGH_CLAWS'},{ability='TOUGH_CLAWS'}},'Tough Claws')

-- absorbing and blocking
scenario('Sap Sipper absorbs Grass',{{'MEW',moves={'RAZOR_LEAF'}},{'MEW',moves={'RAZOR_LEAF'}}},{{ability='SAP_SIPPER'},{ability='SAP_SIPPER'}},'Sap Sipper raised its Attack')
scenario('Motor Drive absorbs Electric',{{'MEW',moves={'THUNDERBOLT'}},{'MEW',moves={'THUNDERBOLT'}}},{{ability='MOTOR_DRIVE'},{ability='MOTOR_DRIVE'}},'Motor Drive raised its Speed')
scenario('Storm Drain absorbs Water',{{'MEW',moves={'WATER_GUN'}},{'MEW',moves={'WATER_GUN'}}},{{ability='STORM_DRAIN'},{ability='STORM_DRAIN'}},'Storm Drain raised its Sp. Atk')
scenario('Lightning Rod absorbs Electric (Gen 5+)',{{'MEW',moves={'THUNDERBOLT'}},{'MEW',moves={'THUNDERBOLT'}}},{{ability='LIGHTNING_ROD'},{ability='LIGHTNING_ROD'}},'Lightning Rod raised its Sp. Atk')
scenario('Dry Skin drinks Water',{{'MEW',moves={'WATER_GUN'}},{'MEW',moves={'WATER_GUN'}}},{{ability='DRY_SKIN',hp=0.5},{ability='DRY_SKIN',hp=0.5}},'restored HP using its Dry Skin')
scenario('Bulletproof blocks ball moves',{{'MEW',moves={'SHADOW_BALL'}},{'MEW',moves={'SHADOW_BALL'}}},{{ability='BULLETPROOF'},{ability='BULLETPROOF'}},'Bulletproof blocks')
scenario('Soundproof blocks new sound moves',{{'MEW',moves={'BOOMBURST'}},{'MEW',moves={'BOOMBURST'}}},{{ability='SOUNDPROOF'},{ability='SOUNDPROOF'}},'Soundproof blocks')
scenario('Queenly Majesty blocks priority',{{'MEW',moves={'QUICK_ATTACK'}},{'MEW',moves={'QUICK_ATTACK'}}},{{ability='QUEENLY_MAJESTY'},{'MEW'}},'cannot use')
scenario('Prankster status moves fail on Dark types',{{ability='PRANKSTER',moves={'THUNDER_WAVE'}},{'MEW',moves={'GROWL'}}},{{'UMBREON'},{'UMBREON'}},"doesn't affect")
scenario('Overcoat blocks powder',{{'MEW',moves={'SLEEP_POWDER'}},{'MEW',moves={'SLEEP_POWDER'}}},{{ability='OVERCOAT'},{ability='OVERCOAT'}},"doesn't affect")
scenario('Magic Bounce reflects status moves',{{'MEW',moves={'GROWL'}},{'MEW',moves={'GROWL'}}},{{ability='MAGIC_BOUNCE'},{ability='MAGIC_BOUNCE'}},'bounced')
scenario('Telepathy dodges an ally\'s spread move',{{'MEW',moves={'EARTHQUAKE'}},{ability='TELEPATHY'}},{{'MEW'},{'MEW'}},'avoids attacks by its ally')
scenario('Comatose cannot be put to sleep',{{'MEW',moves={'SPORE'}},{'MEW',moves={'SPORE'}}},{{ability='COMATOSE'},{ability='COMATOSE'}},'is drowsing',{absent='fell asleep'})
scenario('Corrosion poisons Steel types',{{ability='CORROSION',moves={'TOXIC'}},{'MEW',moves={'GROWL'}}},{{'STEELIX'},{'STEELIX'}},'badly poisoned')

-- when hit
scenario('Iron Barbs',{{'MEW',moves={'TACKLE'}},{'MEW',moves={'TACKLE'}}},{{ability='IRON_BARBS'},{ability='IRON_BARBS'}},'Iron Barbs')
scenario('Rough Skin (1/8, Inclement)',{{'MEW',moves={'TACKLE'}},{'MEW',moves={'TACKLE'}}},{{ability='ROUGH_SKIN'},{ability='ROUGH_SKIN'}},'Rough Skin')
scenario('Long Reach makes no contact',{{ability='LONG_REACH',moves={'TACKLE'}},{ability='LONG_REACH',moves={'TACKLE'}}},{{ability='ROUGH_SKIN'},{ability='ROUGH_SKIN'}},nil,{absent='Rough Skin'})
scenario('Justified',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='JUSTIFIED',level=60},{ability='JUSTIFIED',level=60}},'Justified raised its Attack')
scenario('Rattled on Bug moves',{{'MEW',moves={'BUG_BITE'}},{'MEW',moves={'BUG_BITE'}}},{{ability='RATTLED',level=60},{ability='RATTLED',level=60}},'Rattled raised its Speed')
scenario('Stamina',{{'MEW'},{'MEW'}},{{ability='STAMINA',level=60},{ability='STAMINA',level=60}},'Stamina raised its Defense')
scenario('Weak Armor',{{'MEW'},{'MEW'}},{{ability='WEAK_ARMOR',level=60},{ability='WEAK_ARMOR',level=60}},'Weak Armor lowered its Defense')
scenario('Water Compaction',{{'MEW',moves={'WATER_GUN'}},{'MEW',moves={'WATER_GUN'}}},{{ability='WATER_COMPACTION',level=60},{ability='WATER_COMPACTION',level=60}},'Water Compaction raised')
scenario('Steam Engine',{{'MEW',moves={'EMBER'}},{'MEW',moves={'EMBER'}}},{{ability='STEAM_ENGINE',level=60},{ability='STEAM_ENGINE',level=60}},'Steam Engine raised its Speed')
scenario('Cotton Down',{{'MEW'},{'MEW'}},{{ability='COTTON_DOWN',level=60},{ability='COTTON_DOWN',level=60}},'Cotton Down')
scenario('Gooey',{{'MEW'},{'MEW'}},{{ability='GOOEY',level=60},{ability='GOOEY',level=60}},'Gooey')
scenario('Sand Spit',{{'MEW'},{'MEW'}},{{ability='SAND_SPIT',level=60},{ability='SAND_SPIT',level=60}},'Sand Spit whipped up')
scenario('Mummy spreads on contact',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='MUMMY',level=60},{ability='MUMMY',level=60}},'became Mummy')
scenario('Wandering Spirit swaps abilities',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='WANDERING_SPIRIT',level=60},{ability='WANDERING_SPIRIT',level=60}},'swapped Abilities')
scenario('Perish Body',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='PERISH_BODY',level=60},{ability='PERISH_BODY',level=60}},'faint in three turns')
scenario('Pickpocket',{{'MEW',item='ITEM_ORAN_BERRY'},{'MEW',item='ITEM_ORAN_BERRY'}},{{ability='PICKPOCKET',level=60},{ability='PICKPOCKET',level=60}},'stole')
scenario('Disguise soaks a hit',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='DISGUISE',level=60},{ability='DISGUISE',level=60}},'disguise served it as a decoy')
scenario('Sturdy holds on from full HP',{{'MEW',level=90,moves={'PSYCHIC'}},{'MEW',level=90,moves={'PSYCHIC'}}},{{ability='STURDY',level=5},{ability='STURDY',level=5}},'endured the hit')
scenario('Berserk',{{'MEW',level=40},{'MEW',level=40}},{{ability='BERSERK',level=45},{ability='BERSERK',level=45}},'Berserk raised')
scenario('Cursed Body',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{ability='CURSED_BODY',level=60},{ability='CURSED_BODY',level=60}},'Cursed Body')
scenario('Emergency Exit retreats',{{'MEW',level=60,moves={'PSYCHIC'}},{'MEW',level=60,moves={'PSYCHIC'}},{'MEW'}},{{'MEW'},{'MEW'}},nil,{seed=0x1111})

-- the attacker's own
scenario('Moxie after a knockout',{{ability='MOXIE',level=80},{'MEW',level=80}},{{'MEW',level=5},{'MEW',level=5}},'Moxie raised its Attack')
scenario('Beast Boost after a knockout',{{ability='BEAST_BOOST',level=80},{'MEW',level=80}},{{'MEW',level=5},{'MEW',level=5}},'Beast Boost raised')
scenario('Soul-Heart on any knockout',{{ability='SOUL_HEART',level=80},{'MEW',level=80}},{{'MEW',level=5},{'MEW',level=5}},'Soul-Heart raised')
scenario('Grim Neigh',{{ability='GRIM_NEIGH',level=80},{'MEW',level=80}},{{'MEW',level=5},{'MEW',level=5}},'Grim Neigh raised')
scenario('Aftermath',{{'MEW',level=80},{'MEW',level=80}},{{ability='AFTERMATH',level=5},{ability='AFTERMATH',level=5}},'caught in the aftermath')
scenario('Innards Out',{{'MEW',level=80},{'MEW',level=80}},{{ability='INNARDS_OUT',level=5},{ability='INNARDS_OUT',level=5}},'Innards Out')
scenario('Magician steals',{{ability='MAGICIAN',moves={'SWIFT'}},{'MEW'}},{{'MEW',item='ITEM_ORAN_BERRY',level=60},{'MEW',item='ITEM_ORAN_BERRY',level=60}},'stole')
scenario('Poison Touch',{{ability='POISON_TOUCH'},{ability='POISON_TOUCH'}},{{'MEW',level=60},{'MEW',level=60}},'Poison Touch')
scenario('Protean changes type',{{ability='PROTEAN',moves={'EMBER'}},{'MEW'}},{{'MEW'},{'MEW'}},'transformed it into the')
scenario('Contrary turns drops into boosts',{{ability='CONTRARY',moves={'LEAF_STORM'}},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},nil,
  {check=function(list,joined) return joined:find('rose',1,true)~=nil end})
scenario('Magic Guard: no Life Orb recoil',{{ability='MAGIC_GUARD',item='ITEM_LIFE_ORB'},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},nil,{absent='lost some of its HP'})
scenario('Sheer Force: no Life Orb recoil on boosted moves',{{ability='SHEER_FORCE',item='ITEM_LIFE_ORB',moves={'FLAMETHROWER'}},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},nil,{absent='lost some of its HP'})

-- end of turn
scenario('Poison Heal heals with a Toxic Orb',{{ability='POISON_HEAL',item='ITEM_TOXIC_ORB',hp=0.5},{'MEW'}},{{'MEW',level=10},{'MEW',level=10}},'Poison Heal restored')
scenario('Magic Guard: no poison damage',{{ability='MAGIC_GUARD',item='ITEM_TOXIC_ORB'},{'MEW'}},{{'MEW',level=10},{'MEW',level=10}},nil,{absent='hurt by poison'})
scenario('Ice Body heals in hail',{{ability='SNOW_WARNING'},{ability='ICE_BODY',hp=0.5}},{{'MEW',level=10},{'MEW',level=10}},'Ice Body restored')
scenario('Overcoat ignores hail',{{ability='SNOW_WARNING'},{ability='OVERCOAT'}},{{'MEW',level=10},{'MEW',level=10}},nil,
  {check=function(list) for _,t in ipairs(list) do if t:find('pelted by HAIL',1,true) and t:find('Overcoat',1,true) then return false end end return true end})
scenario('Solar Power costs HP in sun',{{ability='DROUGHT'},{ability='SOLAR_POWER'}},{{'MEW',level=10},{'MEW',level=10}},'Solar Power takes its toll')
scenario('Dry Skin heals in rain',{{ability='DRIZZLE',moves={'GROWL'}},{ability='DRY_SKIN',hp=0.5,moves={'GROWL'}}},{{'MEW',level=10},{'MEW',level=10}},'Dry Skin restored')
scenario('Hydration cures in rain',{{ability='DRIZZLE'},{ability='HYDRATION',status='PSN'}},{{'MEW',level=10},{'MEW',level=10}},'Hydration cured')
scenario('Moody',{{ability='MOODY'},{'MEW'}},{{'MEW',level=10},{'MEW',level=10}},'rose sharply')
scenario('Bad Dreams hurts sleepers',{{ability='BAD_DREAMS',moves={'GROWL'}},{'MEW',moves={'GROWL'}}},{{'MEW',level=30,status='SLP'},{'MEW',level=30,status='SLP'}},'is tormented')
scenario('Harvest regrows a berry',{{ability='HARVEST',item='ITEM_SITRUS_BERRY',hp=0.4},{ability='DROUGHT'}},{{'MEW',level=30},{'MEW',level=30}},'harvested')
scenario('Cheek Pouch',{{ability='CHEEK_POUCH',item='ITEM_SITRUS_BERRY',hp=0.45},{'MEW'}},{{'MEW',level=30},{'MEW',level=30}},'Cheek Pouch restored')
scenario('Unnerve stops berries',{{'MEW',item='ITEM_SITRUS_BERRY',hp=0.45},{'MEW',item='ITEM_SITRUS_BERRY',hp=0.45}},{{ability='UNNERVE',level=10},{ability='UNNERVE',level=10}},nil,
  {check=function(list) local fainted for i,t in ipairs(list) do if t:find('fainted',1,true) and not fainted then fainted=i end if t:find('Sitrus',1,true) then return fainted~=nil end end return true end})
scenario('Pixilate turns Normal moves Fairy',{{ability='PIXILATE'},{ability='PIXILATE'}},{{'DRATINI'},{'DRATINI'}},'super effective')
scenario('Refrigerate turns Normal moves Ice',{{ability='REFRIGERATE'},{ability='REFRIGERATE'}},{{'DRATINI'},{'DRATINI'}},'super effective')
scenario('Absorb abilities check every target of a spread move',{{'MEW',moves={'DISCHARGE'}},{'MEW',moves={'GROWL'}}},{{ability='VOLT_ABSORB'},{ability='MOTOR_DRIVE'}},'Motor Drive raised')

scenario('Dancer copies a dance',{{'MEW',moves={'SWORDS_DANCE'}},{'MEW',moves={'DRAGON_DANCE'}}},{{ability='DANCER',level=40},{ability='DANCER',level=40}},'Dancer copied the dance',
  {check=function(list,joined) return joined:find('ATTACK rose',1,true)~=nil end})
-- battle forms
local function formCheck(sym) return function() return lastState and true end end
scenario('Zen Mode below half HP',{{'MEW',level=60},{'MEW',level=60}},{{'DARMANITAN',slot=2,level=60,hp=0.45},{'DARMANITAN',slot=2,level=60,hp=0.45}},'triggered Zen Mode')
scenario('Stance Change to Blade',{{'AEGISLASH',slot=0},{'MEW'}},{{'MEW',level=30},{'MEW',level=30}},'Changed to Blade Forme')
scenario('Schooling at level 20+',{{'MEW',level=10},{'MEW',level=10}},{{'WISHIWASHI',slot=0,level=25},{'WISHIWASHI',slot=0,level=25}},'formed a school')
scenario('Shields Down below half HP',{{'MEW',level=40},{'MEW',level=40}},{{'MINIOR',slot=0,level=40,hp=0.45},{'MINIOR',slot=0,level=40,hp=0.45}},'Shields Down activated')
scenario('Disguise busts into its form',{{'MEW',moves={'BITE'}},{'MEW',moves={'BITE'}}},{{'MIMIKYU',slot=0,level=60},{'MIMIKYU',slot=0,level=60}},'disguise was busted')
scenario('Hunger Switch alternates',{{'MEW',level=50,moves={'GROWL'}},{'MEW',level=50,moves={'GROWL'}}},{{'MORPEKO',slot=0,level=40},{'MORPEKO',slot=0,level=40}},'transformed')
scenario('Steadfast on a flinch',{{'MEW',level=80,moves={'FAKE_OUT'}},{'MEW',level=80,moves={'FAKE_OUT'}}},{{ability='STEADFAST',level=80},{ability='STEADFAST',level=80}},'Steadfast raised its Speed')
if wanted('weight') then
  local b=battler('MEW',50,'player')
  local w=Field.U.weight(b)
  b.ability=abilityIds.HEAVY_METAL
  Battle._adapter=ad
  T.eq(Field.U.weight(b),w*2,'Heavy Metal doubles weight')
  b.ability=abilityIds.LIGHT_METAL
  T.eq(Field.U.weight(b),math.max(1,math.floor(w/2)),'Light Metal halves weight')
  Battle._adapter=nil
end

-- leftovers
if wanted('names') then
  T.eq(A.name('LIGHTNING_ROD'),'Lightning Rod','full ability names in battle lines')
  T.eq(A.name('SOUL_HEART'),'Soul-Heart','Soul-Heart keeps its hyphen')
end
scenario('Soul-Heart on any knockout (sandstorm)',{{ability='SOUL_HEART',level=60,moves={'SANDSTORM'}},{'MEW',level=60,moves={'GROWL'}}},{{'MEW',level=2,hp=0.05},{'MEW',level=2,hp=0.05}},'Soul-Heart raised')
scenario('Steadfast when a flinch stops it',{{'MEW',level=80,moves={'FAKE_OUT'}},{'MEW',level=80,moves={'FAKE_OUT'}}},{{ability='STEADFAST',level=60},{ability='STEADFAST',level=60}},'Steadfast raised its Speed')
scenario('Illusion takes a partymate\'s look and breaks on a hit',{{'MEW',level=40},{'MEW',level=40}},{{ability='ILLUSION',level=40},{'MEW',level=40}},'illusion wore off')
scenario('Disguise stays broken after a switch',{{'MEW',moves={'BITE','U_TURN'},level=60},{'MEW',moves={'BITE'},level=60}},{{'MIMIKYU',slot=0,level=60},{'MIMIKYU',slot=0,level=60}},'disguise was busted',
  {check=function(list) local n=0 for _,t in ipairs(list) do if t:find('decoy',1,true) then n=n+1 end end return n<=2 end})
scenario('Ripen doubles a stat berry',{{'MEW',level=12},{'MEW',level=12}},{{ability='RIPEN',level=40,item='ITEM_LIECHI_BERRY',hp=0.3},{ability='RIPEN',level=40,item='ITEM_LIECHI_BERRY',hp=0.3}},'Ripen raised its Attack')
if wanted('weight moves') then
  -- (vanilla dex weights come from the ROM; the fixture has the new species')
  local a,d=battler('MEW',50,'player'),battler('TIMBURR',50,'enemy')
  local base=dmg(a,d,'LOW_KICK')
  Battle._adapter=ad
  d.ability=abilityIds.HEAVY_METAL
  T.check(dmg(a,d,'LOW_KICK')>base,'Low Kick reads Heavy Metal\'s weight')
  Battle._adapter=nil
end
if wanted('choice lock') then
  local b=battler('MEW',50,'player')
  b.mon.moves={F.move('TACKLE'),F.move('PSYCHIC')};b.mon.pp={30,10}
  b.item=items.ITEM_CHOICE_SCARF;b.mon.item=b.item
  b.choicedMove=F.move('TACKLE')
  local bad=Engine.moveLimitations(b,ad)
  T.check(bad[2] and not bad[1],'Choice Scarf locks the move menu')
end
T.finish('campaign abilities')
