-- D1 on stock 0.3.73: solo battles are doubles (native probe mod installed).
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,copy=F.T,F.copy
local Battle=require('src.core.game3.battle')
local Runtime=require('src.core.game3.runtime')
-- battle text from the extracted script bundle, as the co-op worlds use
require('src.core.game3.scripting.space').ensureBundle=function() return F.H.bundle end

local seed=0x1234
local function lcg(lo,hi)
  seed=(seed*1103515245+24691)%2147483648
  local v=math.floor(seed/65536)
  if lo==nil then return v/32768 end
  if hi==nil then return 1+v%lo end
  return lo+v%(hi-lo+1)
end

local function session()
  return {version='emerald',engine='game3',name='BRENDAN',trainerId=111,secretId=0,gender=0,
    party={},bag=F.f.Bag.new(),dex=require('src.core.game3.dex').new(),options={},flags={},vars={},money=1000,map='EM_ROUTE102'}
end

local function run(name,opts)
  local s=session()
  Runtime.getSession=function() return s end
  opts.session,opts.headless,opts.autoFight,opts.rng=s,true,true,lcg
  local done
  opts.onDone=function(result) done=result end
  local ok,err=Battle.start(opts)
  T.check(ok,name..' starts '..tostring(err or ''))
  local st=Battle.getState()
  print(('SOLO %s double=%s result=%s turns=%s'):format(name,tostring(st and st.double),tostring(st and st.result),tostring(st and st.turn)))
  return st,done
end

local function pair(level) return {F.mon(0,level,{33,45}),F.mon(0,level,{33})} end
-- trainer parties and names come from the ROM's trainer tables
require('src.import.gba.trainer_extract').run(F.f.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local function trainerWith(n)
  local ids={}
  for _,id in pairs(C.trainers.byName) do ids[#ids+1]=id end
  table.sort(ids)
  for _,id in ipairs(ids) do
    local ok,foe=pcall(Trainers.foeFromId,id)
    if ok and foe and foe.party and #foe.party==n and not foe.doubleBattle then return id,foe end
  end
  error('no trainer with '..n..' mons')
end
local t2,foe2=trainerWith(2)
local t1,foe1=trainerWith(1)

-- two-mon trainer
local st=run('trainer-2',{playerParty=pair(60),foe=foe2,double=true,trainerId=t2})
T.eq(st.double,true,'trainer with two mons fights a double')
T.eq(st.result,'win','strong pair beats a two-mon trainer')

-- one-mon trainer
st=run('trainer-1',{playerParty=pair(60),foe=foe1,double=true,trainerId=t1})
T.eq(st.double,true,'trainer with one mon still fights a double')
T.eq(st.result,'win','pair beats a one-mon trainer')

-- wild double
local w1,w2=F.mon(1,3),F.mon(1,3)
st=run('wild-2',{playerParty=pair(60),foe=w1,wildPartner=w2,wild=true,double=true})
T.eq(st.double,true,'wild battle with a partner mon is a double')
T.eq(#st.foeParty,2,'two wild mons on the field')
T.eq(st.result,'win','pair beats two wild mons')

-- player with one usable mon
st=run('player-1',{playerParty={F.mon(0,60,{33})},foe=Trainers.foeFromId(t2),double=true,trainerId=t2})
T.eq(st.result,'win','a lone mon can still fight a two-mon trainer')

T.finish('solo doubles on stock')
