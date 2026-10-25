-- Authored trainer teams (campaign/trainers.lua + trainer_teams.lua), headless
-- on stock 0.3.73 through the built mod: every authored mon is legal for the
-- campaign (species, ability on that species, moves with battle support,
-- items), the teams replace the ROM's, partners turn route fights into
-- two-trainer doubles, Roxanne's ace sets the cap, and every listed fight
-- runs to the end. Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local Battle=require('src.core.game3.battle')
local Bridge=require('src.core.game3.battle_bridge')
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local teams=assert(loadfile('../porting/native/campaign/trainer_teams.lua'))()
local drafted=assert(loadfile('../porting/native/campaign/trainer_teams_gen.lua'))()
for _,key in ipairs({'trainers','partners'}) do
  for name,t in pairs(drafted[key]) do if teams[key][name]==nil then teams[key][name]=t end end
end
local campaign=F.campaign
local supported=campaign.battleMoves
local ids=F.ids

-- legality
local function checkMon(where,m)
  local sp=ids.species['SPECIES_'..m[1]]
  T.check(sp~=nil,where..': species '..m[1])
  if not sp then return end
  local row=F.data.species[sp]
  if m.ability then
    local ok=false
    for _,a in ipairs(row.abilities) do if a~=0 and F.data.abilities[a].symbol=='ABILITY_'..m.ability then ok=true end end
    T.check(ok,where..': '..m[1]..' can have '..m.ability)
  end
  for _,mv in ipairs(m.moves or {}) do
    local id=ids.moves['MOVE_'..mv]
    T.check(id~=nil and (id<=354 or supported[id]),where..': '..m[1]..' move '..mv..' has battle support')
  end
  if m.item then T.check(ids.items['ITEM_'..m.item]~=nil and F.data.items[ids.items['ITEM_'..m.item]]~=nil,where..': item '..m.item) end
  T.check(#(m.moves or {})>=1 and #m.moves<=4,where..': '..m[1]..' has 1-4 moves')
end
for name,t in pairs(teams.trainers) do
  T.check(C.trainers.byName['TRAINER_'..name]~=nil,name..' is a vanilla trainer')
  for _,m in ipairs(t.party) do checkMon(name,m) end
  if t.partner then
    T.check(teams.partners[t.partner]~=nil,name..' partner '..t.partner..' exists')
    T.check(#t.party<=3,name..' brings at most three beside a partner')
  else
    -- (the Route 103 rival meets a player who has only a starter)
    if not name:find('_ROUTE_103_') then T.check(#t.party>=2,name..' has at least two for a double') end
  end
end
for name,p in pairs(teams.partners) do
  for _,m in ipairs(p.party) do checkMon(name,m) end
  T.check(#p.party<=3,name..' brings at most three')
end

-- the ROM's teams are replaced, IVs/EVs/natures/abilities come through
local calvin=C.trainers.byName.TRAINER_CALVIN_1
local t=Trainers.get(calvin)
T.eq(F.P.name(t.party[1].species),'Poochyena','Calvin leads with the authored Poochyena')
T.eq(t.party[1].level,8,'at level 8')
local foe=Trainers.foeFromId(calvin)
T.eq(foe.party[2].nature,3,'Lillipup is Adamant')
T.eq(foe.party[1].ivs.atk,20,'route IVs 20')
T.eq(foe.party[1].item,F.ids.items.ITEM_ORAN_BERRY,'held items reach the battle')
T.eq(foe.party[1].evs.atk,84,'route EVs on Attack')
local roxanne=C.trainers.byName.TRAINER_ROXANNE_1
local best=0
for _,m in ipairs(Trainers.get(roxanne).party) do best=math.max(best,m.level) end
T.eq(best,15,"Roxanne's ace is level 15 (the cap g3_coop reads)")
-- the caps (each milestone's best ace, g3_coop's order) never go down
do
  local function ace(name)
    local id=C.trainers.byName['TRAINER_'..name]
    local top=0
    for _,m in ipairs(id and Trainers.get(id).party or {}) do top=math.max(top,m.level) end
    return top
  end
  local function rival(at) return {'BRENDAN_'..at..'_MUDKIP','BRENDAN_'..at..'_TREECKO','BRENDAN_'..at..'_TORCHIC',
    'MAY_'..at..'_MUDKIP','MAY_'..at..'_TREECKO','MAY_'..at..'_TORCHIC'} end
  local milestones={{'ROXANNE_1'},rival('RUSTBORO'),{'BRAWLY_1'},rival('ROUTE_110'),{'WALLY_MAUVILLE'},{'WATTSON_1'},
    {'TABITHA_MT_CHIMNEY'},{'MAXIE_MT_CHIMNEY'},{'FLANNERY_1'},{'NORMAN_1'},{'SHELLY_WEATHER_INSTITUTE'},rival('ROUTE_119'),
    {'WINONA_1'},rival('LILYCOVE'),{'TABITHA_MAGMA_HIDEOUT'},{'MAXIE_MAGMA_HIDEOUT'},{'MATT'},{'MAXIE_MOSSDEEP','TABITHA_MOSSDEEP'},
    {'TATE_AND_LIZA_1'},{'SHELLY_SEAFLOOR_CAVERN'},{'ARCHIE'},{'JUAN_1'},{'WALLY_VR_1'},{'SIDNEY'},{'PHOEBE'},{'GLACIA'},
    {'DRAKE'},{'WALLACE'}}
  local last,ok,where=0,true,''
  for _,names in ipairs(milestones) do
    local top=0
    for _,n in ipairs(names) do top=math.max(top,ace(n)) end
    if top<last then ok,where=false,where..' '..names[1]..' '..top..'<'..last end
    last=math.max(last,top)
  end
  T.check(ok,'level caps never drop along the story'..where)
  T.eq(ace('WALLACE'),58,'the Champion ace is the last cap')
end
-- a trainer's bag can be authored (items = { ... })
do
  local teams2=F.campaign.trainers
  local id=C.trainers.byName.TRAINER_JOSH
  local rec=teams2.byId[id]
  local saved=rec.bag
  rec.bag={F.ids.items.ITEM_SUPER_POTION,0,0,0}
  T.eq(Trainers.get(id).items[1],F.ids.items.ITEM_SUPER_POTION,'an authored bag replaces the ROM\'s')
  rec.bag=saved
end
-- partners
local opts=campaign.trainers.battleOpts({trainerId=calvin})
T.check(opts.twoOpponents and opts.trainerIdB,'Calvin fights beside a partner')
local infoB=Trainers.info(opts.trainerIdB)
T.eq(infoB and infoB.name,'DALE','partner name')
T.eq(infoB and infoB.className,'YOUNGSTER','partner borrows the class')
T.check(not campaign.trainers.battleOpts({trainerId=roxanne}).twoOpponents,'Roxanne fights alone')

-- every listed fight runs, with its partner
local function myParty()
  local out={}
  for i,n in ipairs({'COMBUSKEN','MARSHTOMP','GROVYLE','MEW'}) do
    out[i]=F.mon(n,16,{'TACKLE','EMBER','WATER_GUN','ABSORB'})
  end
  out[4]=F.mon('MEW',18,{'PSYCHIC','SHADOW_BALL','THUNDERBOLT','ICE_BEAM'})
  return out
end
local names={}
for name in pairs(teams.trainers) do names[#names+1]=name end
table.sort(names)
for i,name in ipairs(names) do
  F.reseed(0x9100+i)
  local id=C.trainers.byName['TRAINER_'..name]
  local foeT=Trainers.foeFromId(id)
  local o=campaign.trainers.battleOpts({trainerId=id})
  local half
  if o.trainerIdB then foeT,half=Bridge.twoOpponentFoe(foeT,o.trainerIdB) end
  local st
  local ok,err=pcall(function()
    st=F.battle({playerParty=myParty(),foe=foeT,double=true,trainerId=id,twoOpponents=o.twoOpponents,trainerIdB=o.trainerIdB,
      foeHalf=half})
  end)
  local result=Battle.getResult and Battle.getResult()
  Battle.reset()
  T.check(ok,name..' battle runs'..(ok and '' or (' '..tostring(err))))
end
T.finish('campaign trainer teams')
