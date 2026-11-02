-- Pledge combos and Round's follow-up, headless on stock 0.3.73 through the
-- built mod: two different Pledges merge (the first waits, the second comes
-- straight after at 150 and leaves a side effect), matching ones don't, and an
-- ally's Round is pulled up behind the first. Plus After You and RELEARN MOVE.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local State=require('src.core.game3.battle.state')
local Battle=require('src.core.game3.battle')
local Engine=require('src.core.game3.battle.engine')
local Moves=require('src.core.game3.battle.moves')
local Ui=require('src.core.game3.battle.ui')
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local TRAINER=assert(C.trainers.byName.TRAINER_ROXANNE_1)

local log,order,sides={}, {}, {}
local function note(text) log[#log+1]=tostring(text) end
local push,pushTimed=Ui.push,Ui.pushTimed
Ui.push=function(text,...) note(text) return push(text,...) end
Ui.pushTimed=function(text,...) note(text) return pushTimed(text,...) end
local resolve=Engine.resolveMove
Engine.resolveMove=function(user,target,moveId,slot,ad,st,out,...)
  order[#order+1]={turn=st.turn,user=State.idOf(State.occupant(st,user)),move=tonumber(moveId) or Moves.numForName(moveId)}
  local r={resolve(user,target,moveId,slot,ad,st,out,...)}
  for _,k in ipairs({'campaignSeaOfFire','campaignRainbow','campaignSwamp'}) do
    if (st.enemySide[k] or 0)>0 then sides['enemy'..k]=true end
    if (st.playerSide[k] or 0)>0 then sides['player'..k]=true end
  end
  return unpack(r)
end
local function has(pattern) for _,l in ipairs(log) do if l:find(pattern) then return l end end end
local function fight(a,b,seed,foeMon)
  log,order,sides={}, {}, {}
  F.reseed(seed or 0x1234)
  local foe=Trainers.foeFromId(TRAINER)
  local q={} for i=1,3 do q[i]=F.mon(foeMon or 'BLISSEY',45,{'TACKLE'}) end
  foe.party=q; foe.doubleBattle=true
  local party={}
  for i=1,3 do party[#party+1]=F.mon(a[1],a[2],a[3]); party[#party+1]=F.mon(b[1],b[2],b[3]) end
  local ok,err=pcall(F.battle,{playerParty=party,foe=foe,double=true,trainerId=TRAINER})
  Battle.reset()
  T.check(ok,'battle runs: '..tostring(err))
end
local function adjacent(a,b)
  local byTurn={}
  for i=1,#order-1 do
    if order[i].turn==order[i+1].turn and order[i].move==a and order[i+1].move==b and order[i].user%2==0 and order[i+1].user%2==0 then return true end
  end
end
local G,R,W=F.move('GRASS_PLEDGE'),F.move('FIRE_PLEDGE'),F.move('WATER_PLEDGE')

-- a slow Pledge user and a fast one: Blissey's level puts a foe between them
fight({'JOLTEON',50,{'GRASS_PLEDGE'}},{'SNORLAX',30,{'FIRE_PLEDGE'}})
T.check(has('is waiting for'),'the first Pledge waits')
T.check(has('become one'),'the second merges')
T.check(adjacent(G,R),'the ally goes straight after, whatever its Speed')
T.check(sides.enemycampaignSeaOfFire,'Grass + Fire: sea of fire on the foes')
T.check(has('hurt by the sea of fire'),'the sea of fire burns each turn')
T.check(has('sea of fire around'),'the sea of fire ends')

fight({'JOLTEON',50,{'WATER_PLEDGE'}},{'SNORLAX',30,{'FIRE_PLEDGE'}})
T.check(sides.playercampaignRainbow,'Fire + Water: rainbow on our side')
fight({'JOLTEON',50,{'WATER_PLEDGE'}},{'SNORLAX',30,{'GRASS_PLEDGE'}})
T.check(sides.enemycampaignSwamp,'Grass + Water: swamp on the foes')

fight({'JOLTEON',50,{'FIRE_PLEDGE'}},{'SNORLAX',30,{'FIRE_PLEDGE'}})
T.check(not has('is waiting for'),'matching Pledges do not merge')
fight({'JOLTEON',50,{'FIRE_PLEDGE'}},{'SNORLAX',30,{'TACKLE'}})
T.check(not has('is waiting for'),'a Pledge beside another move does not wait')

-- the type and power of the merged attack
do
  local seen
  local hits=Engine.moveEndBookkeeping
  Engine.moveEndBookkeeping=function(M,...) if M.campaignPledge then seen=M.moveType end return hits(M,...) end
  fight({'JOLTEON',50,{'GRASS_PLEDGE'}},{'SNORLAX',30,{'FIRE_PLEDGE'}})
  Engine.moveEndBookkeeping=hits
  T.eq(seen,10,'Grass + Fire is a Fire attack')
end

-- Round: the slow ally follows the fast one past a mid-speed foe
fight({'JOLTEON',50,{'ROUND'}},{'SNORLAX',30,{'ROUND'}})
T.check(adjacent(F.move('ROUND'),F.move('ROUND')),'the ally\'s Round follows at once')

-- After You: a queue fix (it used to look one place too far along)
fight({'JOLTEON',50,{'AFTER_YOU'}},{'SNORLAX',30,{'TACKLE'}})
T.check(has('took the kind offer'),'After You pulls the ally up')

-- the AI merges them: both foes carry another attack too, and still pick the combo
do
  log,order,sides={}, {}, {}
  F.reseed(0x1234)
  local foe=Trainers.foeFromId(TRAINER)
  foe.party={F.mon('MEW',45,{'GRASS_PLEDGE','TACKLE'}),F.mon('MEW',45,{'FIRE_PLEDGE','TACKLE'}),F.mon('MEW',45,{'TACKLE'})}
  -- the trainer record doubles as the lead Pokémon
  foe.item,foe.heldItem,foe.ability=nil,nil,nil
  for k,v in pairs(foe.party[1]) do foe[k]=v end
  foe.doubleBattle=true
  local party={} for i=1,3 do party[i]=F.mon('BLISSEY',45,{'TACKLE'}) end
  local ok,err=pcall(F.battle,{playerParty=party,foe=foe,double=true,trainerId=TRAINER})
  Battle.reset()
  T.check(ok,'AI Pledge battle runs: '..tostring(err))
  T.check(has('become one'),'the AI merges its Pledges')
  T.check(sides.playercampaignSeaOfFire,'and the sea of fire lands on the player')
end

-- RELEARN MOVE: from two badges, for the lines the tutor rows allow
do
  local P=F.campaign.partyTools
  local world=require('src.core.game3.marts')._campaignWorld
  local badges=world.badges
  world.badges=function() return 1 end
  T.eq(#P.pledges(F.mon('MUDKIP',10,{'TACKLE'})),0,'no Pledge before two badges')
  world.badges=function() return 2 end
  local got=P.pledges(F.mon('MUDKIP',10,{'TACKLE'}))
  T.eq(#got,1,'Mudkip gets one Pledge')
  T.eq(got[1],W,'and it is Water Pledge')
  T.eq(#P.pledges(F.mon('MUDKIP',10,{'WATER_PLEDGE'})),0,'not if it already knows it')
  T.eq(#P.pledges(F.mon('ZIGZAGOON',10,{'TACKLE'})),0,'not for other lines')
  world.badges=badges
end
T.finish('Pledge combos and Round')
