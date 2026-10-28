-- Held items on the campaign (campaign/battle/items.lua), headless on stock
-- 0.3.73 through the built mod: damage-formula items compared against no
-- item, then battle scenarios that look for each item's own effect (battle
-- text or state). Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local State=require('src.core.game3.battle.state')
local Battle=require('src.core.game3.battle')
local Ui=require('src.core.game3.battle.ui')
local Moves=require('src.core.game3.battle.moves')
local items=F.ids.items
local Field=Moves._campaignField

-- ---------------------------------------------------------------- formula
local function battler(name,level,extra)
  local m=F.mon(name,level,{'TACKLE'},extra)
  local b=State.makeBattler(m,'player',{partyIndex=1,id=0})
  return b
end
local Damage=require('src.core.game3.battle.damage')
local function dmg(atk,def,move,opts)
  opts=opts or {}
  opts.forceRoll,opts.forceCrit,opts.rng=100,false,function(lo) return lo or 0 end
  return (Damage.calc(atk,def,Moves.get(F.move(move)),opts))
end
local function compare(label,item,holder,move,attackerName,defenderName,expect)
  local a,d=battler(attackerName or 'MEW',50),battler(defenderName or 'MEW',50)
  d.side='enemy'
  local base=dmg(a,d,move)
  local who=holder=='attacker' and a or d
  who.item=items[item];who.mon.item=items[item]
  local with=dmg(a,d,move)
  local ratio=with/math.max(1,base)
  T.check(math.abs(ratio-expect)<0.08,('%s: %d -> %d (x%.2f, expected x%.2f)'):format(label,base,with,ratio,expect))
end
compare('Life Orb boosts by 1.3','ITEM_LIFE_ORB','attacker','TACKLE',nil,nil,1.3)
compare('Expert Belt boosts super-effective hits','ITEM_EXPERT_BELT','attacker','SHADOW_BALL',nil,nil,1.2)
compare('Expert Belt leaves neutral hits','ITEM_EXPERT_BELT','attacker','TACKLE',nil,nil,1)
compare('Muscle Band boosts physical','ITEM_MUSCLE_BAND','attacker','TACKLE',nil,nil,1.1)
compare('Wise Glasses boosts special','ITEM_WISE_GLASSES','attacker','PSYCHIC',nil,nil,1.1)
compare('Choice Specs boosts special','ITEM_CHOICE_SPECS','attacker','PSYCHIC',nil,nil,1.5)
compare('Choice Specs leaves physical','ITEM_CHOICE_SPECS','attacker','TACKLE',nil,nil,1)
compare('Assault Vest softens special','ITEM_ASSAULT_VEST','defender','PSYCHIC',nil,nil,1/1.5)
compare('Eviolite softens hits on an unevolved mon','ITEM_EVIOLITE','defender','TACKLE',nil,'BIDOOF',1/1.5)
compare('Eviolite does nothing on a final form','ITEM_EVIOLITE','defender','TACKLE',nil,'MEW',1)
compare('a plate boosts its type','ITEM_MIND_PLATE','attacker','PSYCHIC',nil,nil,1.2)
compare('type items boost by 20% (donor rules)','ITEM_TWISTED_SPOON','attacker','PSYCHIC',nil,nil,1.2)
compare('a resist berry halves a super-effective hit','ITEM_KASIB_BERRY','defender','SHADOW_BALL',nil,nil,0.5)
compare('Light Ball doubles Pikachu\'s Attack','ITEM_LIGHT_BALL','attacker','TACKLE','PIKACHU',nil,1.93)
local gemA,gemD=battler('MEW',50),battler('MEW',50)
gemD.side='enemy'
local gemBase=dmg(gemA,gemD,'TACKLE')
gemA.item=items.ITEM_NORMAL_GEM
T.check(math.abs(dmg(gemA,gemD,'TACKLE')/gemBase-1.3)<0.08,'a gem boosts its type by 1.3')
-- Utility Umbrella: the attacker's umbrella drops the rain boost (the donor
-- checks the attacker's item for the damage modifier)
do
  local a,d=battler('MEW',50),battler('MEW',50)
  d.side='enemy'
  local rain=dmg(a,d,'SURF',{weatherKind='RAIN'})
  local plain=dmg(a,d,'SURF')
  T.check(rain>plain,'rain boosts Surf ('..plain..' -> '..rain..')')
  a.item=items.ITEM_UTILITY_UMBRELLA;a.mon.item=a.item
  T.eq(dmg(a,d,'SURF',{weatherKind='RAIN'}),plain,'Utility Umbrella: no rain boost for the holder\'s Surf')
end
-- Shed Shell: the holder can switch out of a trap
do
  local Engine=require('src.core.game3.battle.engine')
  local b=battler('MEW',50)
  b.expTrapped=true
  T.eq((Engine.canSwitch({},nil,b)),false,'a trapped battler can\'t switch')
  b.item=items.ITEM_SHED_SHELL;b.mon.item=b.item
  T.eq((Engine.canSwitch({},nil,b)),true,'Shed Shell: it can')
end
-- speed and type immunity
local scarf=battler('MEW',50)
local ad=require('src.core.game3.battle.adapter').new({playerSide={},enemySide={},battlers={}},function() end)
local s0=Field.U.speed(ad,scarf)
scarf.item=items.ITEM_CHOICE_SCARF
T.check(Field.U.speed(ad,scarf)==math.floor(s0*1.5),'Choice Scarf: x1.5 Speed')
scarf.item=items.ITEM_IRON_BALL
T.check(Field.U.speed(ad,scarf)==math.floor(s0/2),'Iron Ball: half Speed')
local balloonA,balloonD=battler('MEW',50),battler('MEW',50)
balloonD.side='enemy'
balloonD.item=items.ITEM_AIR_BALLOON
T.eq(dmg(balloonA,balloonD,'EARTHQUAKE'),0,'Air Balloon: Ground moves miss the holder')
local ringA,ringD=battler('MEW',50),battler('GASTLY',50)
ringD.side='enemy'
T.eq(dmg(ringA,ringD,'TACKLE'),0,'a Ghost is immune to Tackle')
ringD.item=items.ITEM_RING_TARGET
T.check(dmg(ringA,ringD,'TACKLE')>0,'Ring Target: the immunity is gone')

-- ---------------------------------------------------------------- battles
local texts
local push=Ui.push
Ui.push=function(text,...) if texts and text then texts[#texts+1]=tostring(text):gsub('\n',' ') end return push(text,...) end
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local TRAINER=assert(C.trainers.byName.TRAINER_ROXANNE_1)
local function mons(spec)
  local out={}
  for i,m in ipairs(spec) do
    local extra={}
    if m.item then extra.item=items[m.item] end
    if m.status then extra.status=m.status end
    out[i]=F.mon(m[1],m.level or 40,m.moves or {'TACKLE'},extra)
    if m.hp then out[i].hp=math.max(1,math.floor(out[i].maxHp*m.hp)) end
  end
  return out
end
-- wild doubles: the wild pair keeps the items given to it
local function scenario(label,player,foe,expect,opts)
  opts=opts or {}
  texts={}
  F.reseed(0x2468)
  local ok,err=pcall(function()
    local w=mons(foe)
    F.battle({playerParty=mons(player),foe=w[1],wildPartner=w[2],wild=true,double=true,onStarted=opts.onStarted})
  end)
  Battle.reset()
  local joined=table.concat(texts,' / ')
  local hit=ok and joined:find(expect,1,true)~=nil
  if opts.check then hit=ok and hit and opts.check(texts) end
  T.check(hit,label..(ok and '' or (' ERROR '..tostring(err))))
  if not hit and ok then print('   texts: '..joined:sub(1,500)) end
end
scenario('Life Orb costs HP',{{'MEW',item='ITEM_LIFE_ORB'},{'MEW'}},{{'MEW'},{'MEW'}},'lost some of its HP')
scenario('Rocky Helmet hurts contact',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_ROCKY_HELMET'},{'MEW',item='ITEM_ROCKY_HELMET'}},'Rocky Helmet')
scenario('Weakness Policy',{{'MEW',moves={'SHADOW_BALL'}},{'MEW',moves={'SHADOW_BALL'}}},{{'MEW',item='ITEM_WEAKNESS_POLICY',level=60},{'MEW',item='ITEM_WEAKNESS_POLICY',level=60}},'Weakness Policy')
scenario('Air Balloon announces and pops',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_AIR_BALLOON'},{'MEW'}},'Air Balloon popped')
scenario('Red Card sends the attacker out',{{'MEW'},{'MEW'},{'MEW'}},{{'MEW',item='ITEM_RED_CARD',level=60},{'MEW',item='ITEM_RED_CARD',level=60}},'Red Card')
scenario('Eject Button sends the holder out',{{'MEW',item='ITEM_EJECT_BUTTON'},{'MEW',item='ITEM_EJECT_BUTTON'},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},'Eject Button')
scenario('Focus Sash',{{'MEW',level=80,moves={'SHADOW_BALL'}},{'MEW',level=80,moves={'SHADOW_BALL'}}},{{'MEW',level=20,item='ITEM_FOCUS_SASH'},{'MEW',level=20,item='ITEM_FOCUS_SASH'}},'Focus Sash')
scenario('Sitrus Berry heals a quarter',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_SITRUS_BERRY'},{'MEW',item='ITEM_SITRUS_BERRY'}},'Sitrus Berry')
scenario('Black Sludge hurts a non-Poison holder',{{'MEW',item='ITEM_BLACK_SLUDGE'},{'MEW'}},{{'MEW'},{'MEW'}},'Black Sludge')
scenario('Flame Orb burns its holder',{{'MEW',item='ITEM_FLAME_ORB'},{'MEW'}},{{'MEW'},{'MEW'}},'was burned')
scenario('Toxic Orb badly poisons',{{'MEW',item='ITEM_TOXIC_ORB'},{'MEW'}},{{'MEW'},{'MEW'}},'badly poisoned')
scenario('Sticky Barb hurts its holder',{{'MEW',item='ITEM_STICKY_BARB'},{'MEW'}},{{'MEW'},{'MEW'}},'Sticky Barb')
scenario('Power Herb skips the charge',{{'MEW',item='ITEM_POWER_HERB',moves={'SOLAR_BEAM'}},{'MEW'}},{{'MEW'},{'MEW'}},'Power Herb')
scenario('Kee Berry',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_KEE_BERRY',level=60},{'MEW',item='ITEM_KEE_BERRY',level=60}},'used up')
scenario('Jaboca Berry',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_JABOCA_BERRY',level=60},{'MEW',item='ITEM_JABOCA_BERRY',level=60}},"berry")
scenario('Throat Spray',{{'MEW',item='ITEM_THROAT_SPRAY',moves={'HYPER_VOICE'}},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},'SP. ATK')
scenario('Assault Vest blocks status moves',{{'MEW',item='ITEM_ASSAULT_VEST',moves={'GROWL'}},{'MEW'}},{{'MEW'},{'MEW'}},'Assault Vest')
scenario('Safety Goggles stop powder',{{'MEW',moves={'SLEEP_POWDER'}},{'MEW',moves={'SLEEP_POWDER'}}},{{'MEW',item='ITEM_SAFETY_GOGGLES'},{'MEW',item='ITEM_SAFETY_GOGGLES'}},"doesn't affect")
scenario('Room Service on Trick Room',{{'MEW',moves={'TRICK_ROOM'}},{'MEW',item='ITEM_ROOM_SERVICE'}},{{'MEW'},{'MEW'}},'SPEED fell')
scenario('Blunder Policy after a miss',{{'MEW',item='ITEM_BLUNDER_POLICY',moves={'ZAP_CANNON'}},{'MEW',moves={'ZAP_CANNON'}}},{{'MEW'},{'MEW'}},'SPEED sharply rose')
scenario('Custap Berry moves first in a pinch',{{'MEW',item='ITEM_CUSTAP_BERRY',hp=0.2},{'MEW'}},{{'MEW'},{'MEW'}},'Custap Berry')
scenario('Grassy Seed on Grassy Terrain',{{'MEW',moves={'GRASSY_TERRAIN'}},{'MEW',item='ITEM_GRASSY_SEED'}},{{'MEW'},{'MEW'}},'DEFENSE rose')
local function rocks(st) st.playerSide.campaignStealthRock=true end
scenario('without Boots, Stealth Rock hurts a switch-in',{{'MEW',item='ITEM_EJECT_BUTTON'},{'MEW',item='ITEM_EJECT_BUTTON'},{'MEW'}},{{'MEW',level=60},{'MEW',level=60}},'Pointed stones dug into',{onStarted=rocks})
scenario('Heavy-Duty Boots: no Stealth Rock on switch-in',{{'MEW',item='ITEM_EJECT_BUTTON'},{'MEW'},{'MEW',item='ITEM_HEAVY_DUTY_BOOTS'}},{{'MEW',level=60},{'MEW',level=60}},'Eject Button',{onStarted=rocks,check=function(list)
  -- the Pokemon the Eject Button brings in is the Boots holder: no rock damage
  for i,t in ipairs(list) do
    if t:find('Eject Button',1,true) then
      return not ((list[i+2] or ''):find('Pointed stones',1,true) or (list[i+1] or ''):find('Pointed stones',1,true))
    end
  end
  return false
end})

-- field durations
local function duration(label,move,item,read,expect)
  F.reseed(0x1357)
  local seen
  local resolve=require('src.core.game3.battle.engine').resolveMove
  local Engine=require('src.core.game3.battle.engine')
  Engine.resolveMove=function(u,t,m,...)
    local r={resolve(u,t,m,...)}
    local st=select(3,...)
    if st and not seen and tonumber(m)==F.move(move) then seen=read(st) end
    return unpack(r)
  end
  local foeT=Trainers.foeFromId(TRAINER)
  foeT.party=mons({{'MEW'},{'MEW'}})
  pcall(F.battle,{playerParty=mons({{'MEW',item=item,moves={move}},{'MEW'}}),foe=foeT,double=true,trainerId=TRAINER})
  Battle.reset()
  Engine.resolveMove=resolve
  T.eq(seen,expect,label)
end
duration('Light Clay: Reflect for 8 turns','REFLECT','ITEM_LIGHT_CLAY',function(st) return st.playerSide.expReflectTurns end,8)
duration('Damp Rock: rain for 8 turns','RAIN_DANCE','ITEM_DAMP_ROCK',function(st) return st.weatherTurns end,8)
duration('Terrain Extender: 8 turns','ELECTRIC_TERRAIN','ITEM_TERRAIN_EXTENDER',function(st) return st.campaignField and st.campaignField.terrainTurns end,8)
duration('no Light Clay: Reflect for 5','REFLECT',nil,function(st) return st.playerSide.expReflectTurns end,5)

T.finish('campaign held items')
