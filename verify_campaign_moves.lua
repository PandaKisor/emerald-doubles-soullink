-- Every expanded move in campaign/move_list.lua, used in a headless trainer
-- double on stock 0.3.73 through the built campaign mod. Checks that each
-- move runs without error and does something: it deals damage, changes a
-- battler, a side or the field, or prints its own message (not only "used",
-- "missed" or "But it failed!"). Prints what changed for review.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit; optional args: symbols.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local Engine=require('src.core.game3.battle.engine')
local Battle=require('src.core.game3.battle')
local State=require('src.core.game3.battle.state')
local list=assert(loadfile('../porting/native/generated/campaign/mods/g3_campaign/campaign/move_list.lua'))()
local only={}
for _,a in ipairs(arg or {}) do only[a]=true end
local items=F.ids.items

-- per-move battle setups: user species, held items, conditions
local SETUP={
  BURN_UP={species='CHARIZARD'}, FLOWER_SHIELD={species='VENUSAUR'}, ROTOTILLER={species='VENUSAUR'},
  FLING={item='ITEM_ORAN_BERRY'}, NATURAL_GIFT={item='ITEM_ORAN_BERRY'}, BESTOW={item='ITEM_ORAN_BERRY'},
  STUFF_CHEEKS={item='ITEM_ORAN_BERRY'}, TEATIME={item='ITEM_ORAN_BERRY'},
  POLTERGEIST={foeItem='ITEM_ORAN_BERRY'}, CORROSIVE_GAS={foeItem='ITEM_ORAN_BERRY'},
  BUG_BITE={foeItem='ITEM_ORAN_BERRY'}, PLUCK={foeItem='ITEM_ORAN_BERRY'}, INCINERATE={foeItem='ITEM_ORAN_BERRY'},
  SWITCHEROO={item='ITEM_ORAN_BERRY'},
  JUDGMENT={item='ITEM_FLAME_PLATE'}, MULTI_ATTACK={item='ITEM_FIRE_MEMORY'}, TECHNO_BLAST={item='ITEM_DOUSE_DRIVE'},
  BELCH={battler=function(b) b.campaignAteBerry=true end},
  LAST_RESORT={moves={'LAST_RESORT','TACKLE'},battler=function(b) b.campaignUsed={[F.move('TACKLE')]=true} end},
  STEEL_ROLLER={field=function(st) st.campaignField={terrain='GRASSY',terrainTurns=5} end},
  AURORA_VEIL={field=function(st) st.weather='HAIL'; st.weatherTurns=5 end},
  MAGNETIC_FLUX={battler=function(b) b.campaignAbility='PLUS' end}, GEAR_UP={battler=function(b) b.campaignAbility='PLUS' end},
  PURIFY={foeStatus='PSN'}, VENOM_DRENCH={foeStatus='PSN'}, HEX={foeStatus='PAR'}, VENOSHOCK={foeStatus='PSN'},
  WAKE_UP_SLAP={foeStatus='SLP'}, SPARKLING_ARIA={foeStatus='BRN'},
  PSYCHO_SHIFT={status='BRN'},
}

local function snapshot(b)
  if not b then return {} end
  local out={status=b.mon and b.mon.status,item=b.mon and (b.mon.item or b.mon.heldItem),
    type1=b.type1,type2=b.type2,species=b.species,mon=tostring(b.mon)}
  for k,v in pairs(b.stages or {}) do out['stage.'..k]=v end
  for _,s in ipairs({'attack','defense','speed','spAtk','spDef'}) do out['mon.'..s]=b.mon and b.mon[s] end
  for k,v in pairs(b) do
    if type(k)=='string' and (k:match('^campaign') or k:match('^exp') or k=='semiInvulnerable' or k=='leechSeed'
        or k=='twoTurnMove' or k=='escapePrevention' or k=='confusionTurns' or k=='substituteHP')
      and type(v)~='function' and not k:match('^expLast') and not k:match('^expHurt') and k~='expMovedThisTurn'
      and k~='expProtectStreak' and k~='expTurnOrder' and k~='campaignUsed' and k~='campaignLastFailed'
      and k~='campaignLastSeenMon' and k~='campaignEnteredTurn' then
      out[k]=type(v)=='table' and 'table' or v
    end
  end
  return out
end
local function sideSnap(side)
  local out={}
  for k,v in pairs(side or {}) do
    if type(v)~='table' and type(v)~='function' and k~='campaignFainted' and k~='campaignRetaliate' then out[k]=v end
  end
  out.spikes=side and side.spikes
  return out
end
local function fieldSnap(st)
  local out={weather=st.weather}
  for k,v in pairs(st.campaignField or {}) do if k~='lastMove' then out['field.'..k]=v end end
  return out
end
local function diff(a,b)
  local keys,out={},{}
  for k in pairs(a) do keys[k]=true end
  for k in pairs(b) do keys[k]=true end
  for k in pairs(keys) do if a[k]~=b[k] then out[#out+1]=k..'='..tostring(a[k])..'>'..tostring(b[k]) end end
  table.sort(out)
  return table.concat(out,' ')
end

local current,uses,setup
local BORING={['But it failed!']=true}
local resolve=Engine.resolveMove
Engine.resolveMove=function(user,target,moveId,...)
  local ad,st=select(2,...),select(3,...)
  local n=tonumber(moveId) or require('src.core.game3.battle.moves').numForName(moveId)
  if not current or n~=current.id then return resolve(user,target,moveId,...) end
  local u=st and State.occupant(st,user) or user
  if setup and not current.setupDone then
    current.setupDone=true
    if setup.battler then setup.battler(u) end
    if setup.field then setup.field(st) end
  end
  local before,hp={}, {}
  for i=0,3 do local b=State.battler(st,i);before[i]=snapshot(b);hp[i]=b and b.mon and b.mon.hp or 0 end
  local sides={player=sideSnap(st.playerSide),enemy=sideSnap(st.enemySide)}
  local fieldBefore=fieldSnap(st)
  local r={resolve(user,target,moveId,...)}
  uses=uses+1
  for i=0,3 do
    local b=State.battler(st,i)
    local now=b and b.mon and b.mon.hp or 0
    if (i==1 or i==3) and now<hp[i] then current.damage=current.damage+hp[i]-now end
    if now>hp[i] then current.changes['#'..i..' healed']=true end
    local d=diff(before[i],snapshot(b))
    if d~='' then current.changes['#'..i..' '..d]=true end
  end
  for key,snap in pairs(sides) do
    local d=diff(snap,sideSnap(key=='player' and st.playerSide or st.enemySide))
    if d~='' then current.changes[key..' side '..d]=true end
  end
  local d=diff(fieldBefore,fieldSnap(st))
  if d~='' then current.changes['field '..d]=true end
  local out=r[1]
  for _,text in ipairs(type(out)=='table' and out or {}) do
    text=tostring(text):gsub('\n',' ')
    if not BORING[text] and not text:match(' used ') and not text:match('missed') and not text:match('avoided') then
      current.texts[text]=true
    end
  end
  return unpack(r)
end

-- a ROM trainer (names, class, AI) fielding three Mew that only Tackle
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local TRAINER=assert(C.trainers.byName.TRAINER_ROXANNE_1)
local function trainerParty(foeItem,foeStatus)
  local foe=Trainers.foeFromId(TRAINER)
  local party={}
  for i=1,3 do
    local m=F.mon('MEW',40,{'TACKLE'})
    if foeItem then m.item=items[foeItem] end
    if foeStatus then m.status=foeStatus end
    party[i]=m
  end
  foe.party=party
  foe.doubleBattle=true
  return foe
end

local symbols={}
for s in pairs(list) do if not next(only) or only[s] then symbols[#symbols+1]=s end end
table.sort(symbols)
local failures={}
for _,symbol in ipairs(symbols) do
  local id=F.move(symbol)
  setup=SETUP[symbol] or {}
  current={id=id,damage=0,changes={},texts={}}
  uses=0
  F.reseed(0x4321)
  local ok,err=pcall(function()
    local extra={}
    if setup.item then extra.item=items[setup.item] end
    if setup.status then extra.status=setup.status end
    local party={}
    for i=1,3 do party[i]=F.mon(setup.species or 'MEW',40,setup.moves or {symbol},extra) end
    return F.battle({playerParty=party,foe=trainerParty(setup.foeItem,setup.foeStatus),double=true,trainerId=TRAINER})
  end)
  Battle.reset()
  local changes,texts={}, {}
  for k in pairs(current.changes) do changes[#changes+1]=k end
  for k in pairs(current.texts) do texts[#texts+1]=k end
  table.sort(changes);table.sort(texts)
  local did=current.damage>0 or #changes>0 or #texts>0
  local pass=ok and uses>0 and did
  if not pass then failures[#failures+1]=symbol end
  print(('%s %-18s uses=%-3d dmg=%-4d %s%s | %s'):format(pass and 'ok  ' or 'FAIL',symbol,uses,current.damage,
    ok and '' or ('ERROR '..tostring(err)..' '),table.concat(changes,' '):sub(1,140),table.concat(texts,' / '):sub(1,140)))
  T.check(pass,symbol..' runs and has an effect')
end
print(('%d moves, %d failing: %s'):format(#symbols,#failures,table.concat(failures,' ')))
T.finish('campaign expanded moves')
