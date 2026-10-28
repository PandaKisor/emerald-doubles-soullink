-- Co-op link content on the campaign: versus battles keep real levels and
-- show the partner as Brendan/May; Expanded species, moves, abilities,
-- natures, items and balls cross the link wire format intact.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local LB=require('src.core.game3.link.battle')
local P=require('src.core.game3.pokemon')
LB.unionRoom=true
T.eq(LB.unpackOpts().forceLevel,nil,'versus battles keep real levels')
local zorua=F.mon('ZORUA',12,{'DARK_PULSE','U_TURN','NASTY_PLOT','PURSUIT'},{abilityNum=2,nature=3,item=F.ids.items.ITEM_OCCA_BERRY,pokeball=F.ids.items.ITEM_DREAM_BALL})
local torchic=F.mon('TORCHIC',9,{'EMBER','FLAME_CHARGE'})
local back,why=LB.unpackParty(LB.packParty({zorua,torchic}))
T.check(back~=nil,'an Expanded party crosses the link '..tostring(why))
if back then
  T.eq(back[1].species,zorua.species,'new species kept')
  T.eq(back[1].level,12,'level 12 kept');T.eq(back[2].level,9,'level 9 kept')
  T.eq(P.moveIdAt(back[1],1),F.move('DARK_PULSE'),'new moves kept')
  T.eq(P.moveIdAt(back[2],2),F.move('FLAME_CHARGE'),'and the starter\'s new move')
  T.eq(back[1].abilityNum,2,'hidden ability slot kept')
  T.eq(P.natureOf(back[1]),3,'minted nature kept')
  T.eq(tonumber(back[1].item or back[1].heldItem),F.ids.items.ITEM_OCCA_BERRY,'Expanded held item kept')
  T.eq(tonumber(back[1].pokeball),F.ids.items.ITEM_DREAM_BALL,'Expanded ball kept')
end
-- authored trainer teams (tag partners included) cross the link as built
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local roxanne=Trainers.foeFromId(C.trainers.byName.TRAINER_ROXANNE_1)
local opts=F.campaign.trainers.battleOpts({trainerId=C.trainers.byName.TRAINER_CALVIN_1})
local partner=Trainers.foeFromId(opts.trainerIdB)
for label,foe in pairs({Roxanne=roxanne,['Calvin\'s partner']=partner}) do
  local party={}
  for i,m in ipairs(foe.party) do
    local c={} for k,v in pairs(m) do c[k]=v end
    if not c.pp then c.pp,c.maxPp={},{} for j,mv in ipairs(c.moves) do c.pp[j]=P.movePp(mv);c.maxPp[j]=c.pp[j] end end
    P.applyStats(c);c.hp=c.maxHp
    c.exp=require('src.core.game3.summary_data').expForLevel(P.growthRate(c.species),c.level)
    party[i]=c
  end
  local got,err=LB.unpackParty(LB.packParty(party))
  T.check(got~=nil,label..'\'s team crosses the link '..tostring(err))
  if got then
    for i,m in ipairs(party) do
      T.eq(got[i].species,m.species,label..' mon '..i..' species')
      T.eq(P.natureOf(got[i]),P.natureOf(m),label..' mon '..i..' nature')
      T.eq(got[i].abilityNum,m.abilityNum,label..' mon '..i..' ability slot')
      T.eq(tonumber(got[i].item or got[i].heldItem) or 0,tonumber(m.item or m.heldItem) or 0,label..' mon '..i..' item')
      T.eq(got[i].attack,m.attack,label..' mon '..i..' Attack (IVs/EVs)')
    end
  end
end
T.eq(LB.peerPicId({gender=0}),71,'a male partner is drawn as Brendan')
T.eq(LB.peerPicId({gender=1}),72,'a female partner as May')
T.finish('co-op link content')
