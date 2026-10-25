-- Trainer AI on the campaign (campaign/battle/ai.lua), headless on stock
-- 0.3.73 through the built mod: set positions at the start of a trainer
-- double, checking what each foe picks, then whole battles that must run
-- without AI errors. Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local State=require('src.core.game3.battle.state')
local Battle=require('src.core.game3.battle')
local Moves=require('src.core.game3.battle.moves')
local AI=assert(Moves._campaignField.ai,'AI module installed')
local items=F.ids.items
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local TRAINER=assert(C.trainers.byName.TRAINER_ROXANNE_1)
local abilityIds={}
for id,row in pairs(F.data.abilities) do abilityIds[row.symbol:gsub('^ABILITY_','')]=id end
local holders={}
for id,row in pairs(F.data.species) do
  local sym=row.symbol or ''
  if not sym:find('_MEGA') and not sym:find('_GMAX') then
    for slot,a in ipairs(row.abilities or {}) do
      if a~=0 and (not holders[a] or id<holders[a][3]) then holders[a]={sym:gsub('^SPECIES_',''),slot-1,id} end
    end
  end
end
local function mons(spec)
  local out={}
  for i,m in ipairs(spec) do
    local name,slot=m[1],m.slot
    if m.ability then local h=assert(holders[abilityIds[m.ability]],m.ability); name,slot=h[1],h[2] end
    local extra={}
    if m.item then extra.item=items[m.item] end
    if slot then extra.abilityNum=slot end
    if m.status then extra.status=m.status end
    out[i]=F.mon(name,m.level or 40,m.moves or {'TACKLE'},extra)
    if m.hp then out[i].hp=math.max(1,math.floor(out[i].maxHp*m.hp)) end
  end
  return out
end
-- a trainer foe (Roxanne's identity) leading with the given party
local function trainer(spec)
  local base=Trainers.foeFromId(TRAINER)
  local party=mons(spec)
  local f={}
  for k,v in pairs(party[1]) do f[k]=v end
  for _,k in ipairs({'trainerId','aiFlags','ai','items','trainerName','trainerClass','trainerClassName','trainerPic','gender','encounterMusic'}) do f[k]=base[k] end
  f.party,f.doubleBattle=party,true
  return f
end
local function moveName(mv) return F.P.moveName(mv) end
-- the first turn's choices of both foes (ids 1 and 3)
local function choices(player,foe,setup)
  local seen={}
  F.reseed(0x5151)
  local foeT=trainer(foe)
  local ok,err=pcall(F.battle,{playerParty=mons(player),foe=foeT,double=true,trainerId=TRAINER,onStarted=function(st)
    if setup then setup(st) end
    for _,id in ipairs({1,3}) do
      local act=AI.choose(st,id,{})
      seen[id]=act and {move=moveName(act.move),target=act.target} or false
    end
    -- stop after the choices: the battle itself is checked elsewhere
    st.over=true
  end})
  Battle.reset()
  if not ok then print('   ERROR '..tostring(err)) end
  return seen
end
local function check(label,player,foe,fn,setup)
  local seen=choices(player,foe,setup)
  local ok,res=pcall(fn,seen[1] or {},seen[3] or {})
  T.check(ok and res,label)
  if not (ok and res) then print(('   foe1=%s->%s foe3=%s->%s %s'):format(tostring(seen[1] and seen[1].move),tostring(seen[1] and seen[1].target),
    tostring(seen[3] and seen[3].move),tostring(seen[3] and seen[3].target),ok and '' or tostring(res))) end
end

check('takes the KO: Psychic on a Machop',{{'MACHOP',level=20},{'MACHOP',level=20}},{{'MEW',moves={'TACKLE','PSYCHIC'}},{'MEW',moves={'TACKLE','PSYCHIC'}}},
  function(a,b) return a.move=='Psychic' and b.move=='Psychic' end)
check('no Earthquake into its own partner',{{'MEW'},{'MEW'}},{{'MEW',moves={'EARTHQUAKE','PSYCHIC'}},{'MEW',level=20}},
  function(a) return a.move=='Psychic' end)
check('Earthquake when the partner flies',{{'GEODUDE',level=30},{'GEODUDE',level=30}},{{'MEW',moves={'EARTHQUAKE','PSYCHIC'}},{'PIDGEOT',moves={'GUST'}}},
  function(a) return a.move=='Earthquake' end)
check('no Thunderbolt into Volt Absorb',{{ability='VOLT_ABSORB',level=40},{ability='VOLT_ABSORB',level=40}},{{'MEW',moves={'THUNDERBOLT','TACKLE'}},{'MEW',moves={'TACKLE'}}},
  function(a) return a.move=='Tackle' end)
check('picks the foe its move hurts',{{'GASTLY',level=40},{'MACHOP',level=40}},{{'MEW',moves={'BODY_SLAM'}},{'MEW',moves={'BODY_SLAM'}}},
  function(a,b) return a.target==2 and b.target==2 end)
check('second foe finishes the other target instead of overkill',{{'MAGIKARP',level=5},{'MEW',level=40}},{{'MEW',level=60,moves={'PSYCHIC'}},{'MEW',level=60,moves={'PSYCHIC'}}},
  function(a,b) return a.target~=b.target end)
check('Fake Out on the first turn',{{'MEW'},{'MEW'}},{{'MEW',moves={'FAKE_OUT','TACKLE'}},{'MEW',moves={'TACKLE'}}},
  function(a) return a.move=='Fake Out' end)
check('no Fake Out after the first turn',{{'MEW'},{'MEW'}},{{'MEW',moves={'FAKE_OUT','TACKLE'}},{'MEW',moves={'TACKLE'}}},
  function(a) return a.move=='Tackle' end,function(st) State.battler(st,1).isFirstTurn=0 end)
check('Protect when it would be knocked out first',{{'MEW',level=80,moves={'SHADOW_BALL'}},{'MEW',level=80,moves={'SHADOW_BALL'}}},{{'MEW',level=40,moves={'PROTECT','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Protect' end)
check('never Protect twice in a row',{{'MEW',level=80,moves={'SHADOW_BALL'}},{'MEW',level=80,moves={'SHADOW_BALL'}}},{{'MEW',level=40,moves={'PROTECT','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Tackle' end,function(st) State.battler(st,1).expProtectStreak=1 end)
check('Trick Room when the team is slower',{{'JOLTEON',level=50},{'JOLTEON',level=50}},{{'SNORLAX',level=50,moves={'TRICK_ROOM','TACKLE'}},{'SNORLAX',level=50,moves={'TRICK_ROOM','TACKLE'}}},
  function(a,b) return (a.move=='Trick Room')~=(b.move=='Trick Room') end)
check('Tailwind when it is down',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'TAILWIND','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Tailwind' end)
check('Spore an unstatused foe',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'SPORE','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Spore' end)
check('no sleep move on a sleeping foe',{{'MEW',level=40,status='SLP'},{'MEW',level=40,status='SLP'}},{{'MEW',level=40,moves={'SPORE','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Tackle' end)
check('heals when low',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,hp=0.25,moves={'RECOVER','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Recover' end)
check('no heal at full HP',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'RECOVER','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Tackle' end)
check('Will-O-Wisp on a physical attacker',{{'MACHAMP',level=40},{'MACHAMP',level=40}},{{'MEW',level=40,moves={'WILL_O_WISP','TACKLE'}},{'MEW',level=40,moves={'TACKLE'}}},
  function(a) return a.move=='Will-O-Wisp' end)
check('Rain Dance for a rain team',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'RAIN_DANCE','TACKLE'}},{ability='SWIFT_SWIM',level=40,moves={'WATER_GUN'}}},
  function(a) return a.move=='Rain Dance' end)
check('no Rain Dance in rain',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'RAIN_DANCE','TACKLE'}},{ability='SWIFT_SWIM',level=40,moves={'WATER_GUN'}}},
  function(a) return a.move=='Tackle' end,function(st) st.weather,st.weatherTurns='RAIN',0 end)
check('setup when safe (Swords Dance)',{{'MAGIKARP',level=20,moves={'SPLASH'}},{'MAGIKARP',level=20,moves={'SPLASH'}}},{{'MEW',level=60,moves={'SWORDS_DANCE','TACKLE'}},{'MEW',level=60,moves={'TACKLE'}}},
  function(a) return true end)
check('Choice lock respected',{{'MEW'},{'MEW'}},{{'MEW',item='ITEM_CHOICE_BAND',moves={'TACKLE','PSYCHIC'}},{'MEW'}},
  function(a) return a.move=='Tackle' end,function(st) State.battler(st,1).choicedMove=F.move('TACKLE') end)

-- switching, replacements, the newer status rules, AI partners
local Ai=require('src.core.game3.battle.ai')
local function actions(player,foe,setup,ids)
  local seen={}
  F.reseed(0x6161)
  local foeT=trainer(foe)
  local ok,err=pcall(F.battle,{playerParty=mons(player),foe=foeT,double=true,trainerId=TRAINER,onStarted=function(st)
    if setup then setup(st) end
    for _,id in ipairs(ids or {1,3}) do
      local act=Ai.chooseAction(st,id,{})
      seen[id]=act and {kind=act.kind,slot=act.slot,move=act.move and moveName(act.move),target=act.target} or false
    end
    seen.replacement=AI.bestReplacement(require('src.core.game3.battle')._adapter,st,1)
    st.over=true
  end})
  Battle.reset()
  if not ok then print('   ERROR '..tostring(err)) end
  return seen
end
local function checkAct(label,player,foe,fn,setup,ids)
  local seen=actions(player,foe,setup,ids)
  local ok,res=pcall(fn,seen)
  T.check(ok and res,label)
  if not (ok and res) then
    local parts={}
    for _,id in ipairs(ids or {1,3}) do local a=seen[id] parts[#parts+1]=id..'='..(a and (a.kind..':'..tostring(a.move or a.slot)..'->'..tostring(a.target)) or 'nil') end
    print('   '..table.concat(parts,' ')..' repl='..tostring(seen.replacement)..(ok and '' or (' '..tostring(res))))
  end
end
checkAct('switches out of a lost matchup',{{'MEW',level=60,moves={'THUNDERBOLT'}},{'MEW',level=60,moves={'THUNDERBOLT'}}},
  {{'GYARADOS',level=30,moves={'SPLASH'}},{'MEW',level=30,moves={'TACKLE'}},{'RHYHORN',level=30,moves={'ROCK_SLIDE'}}},
  function(s) return s[1] and s[1].kind=='switch' and s[1].slot==3 end)
checkAct('no voluntary switch in a linked co-op battle',{{'MEW',level=60,moves={'THUNDERBOLT'}},{'MEW',level=60,moves={'THUNDERBOLT'}}},
  {{'GYARADOS',level=30,moves={'SPLASH'}},{'MEW',level=30,moves={'TACKLE'}},{'RHYHORN',level=30,moves={'ROCK_SLIDE'}}},
  function(s) return s[1] and s[1].kind=='move' end,function(st) st.coopTeam=true end)
checkAct('stays in a fair matchup',{{'MEW',level=40},{'MEW',level=40}},
  {{'MEW',level=40,moves={'PSYCHIC'}},{'MEW',level=40,moves={'TACKLE'}},{'RHYHORN',level=40,moves={'ROCK_SLIDE'}}},
  function(s) return s[1] and s[1].kind=='move' end)
checkAct('replacement: the best matchup in the party',{{'MEW',level=60,moves={'THUNDERBOLT'}},{'MEW',level=60,moves={'THUNDERBOLT'}}},
  {{'GYARADOS',level=30,moves={'SPLASH'}},{'MEW',level=30,moves={'TACKLE'}},{'PIDGEOT',level=30,moves={'GUST'}},{'RHYHORN',level=30,moves={'ROCK_SLIDE'}}},
  function(s) return s.replacement==4 end)
check('Shell Smash when safe',{{'SNORLAX',level=40,moves={'SPLASH'}},{'SNORLAX',level=40,moves={'SPLASH'}}},{{'MEW',level=60,moves={'SHELL_SMASH','TACKLE'}},{'MEW',level=60,moves={'TACKLE'}}},
  function(a) return a.move=='Shell Smash' end)
check('Heal Pulse a low partner',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'HEAL_PULSE','TACKLE'}},{'MEW',level=40,hp=0.25,moves={'TACKLE'}}},
  function(a) return a.move=='Heal Pulse' and a.target==3 end)
check('Defog its own hazards',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'DEFOG','TACKLE'}},{'MEW',level=40}},
  function(a) return a.move=='Defog' end,function(st) st.enemySide.campaignStealthRock=true end)
check('Trick away a Choice Scarf',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,item='ITEM_CHOICE_SCARF',moves={'TRICK','TACKLE'}},{'MEW',level=40}},
  function(a) return a.move=='Trick' end)
check('Baton Pass its boosts',{{'MEW',level=40},{'MEW',level=40}},{{'MEW',level=40,moves={'BATON_PASS','TACKLE'}},{'MEW',level=40},{'MEW',level=40}},
  function(a) return a.move=='Baton Pass' end,function(st) local b=State.battler(st,1) b.stages.attack,b.stages.speed=2,2 end)
checkAct('an AI partner on the player\'s side uses the campaign AI',{{'MEW',level=40,moves={'TACKLE'}},{'MACHOP',level=40,moves={'TACKLE','KARATE_CHOP'}}},
  {{'SNORLAX',level=40},{'SNORLAX',level=40}},
  function(s) return s[2] and s[2].kind=='move' and s[2].move=='Karate Chop' end,function(st) st.kinds=st.kinds or {} st.kinds.partner=true end,{2})

-- whole battles: the AI picks every turn without errors
local errors={}
AI.picks=0
local print0=print
print=function(...) local s=table.concat({...},' ') if s:find('[g3_campaign/ai]',1,true) then errors[#errors+1]=s end print0(...) end
local teams={
  {{'GYARADOS',moves={'EARTHQUAKE','WATERFALL','DRAGON_DANCE','PROTECT'}},{'SALAMENCE',moves={'FLAMETHROWER','DRAGON_CLAW','PROTECT','TAILWIND'}}},
  {{'SNORLAX',moves={'BODY_SLAM','TRICK_ROOM','CRUNCH','REST'}},{'MACHAMP',moves={'DYNAMIC_PUNCH','ROCK_SLIDE','PROTECT','FAKE_OUT'}}},
  {{'BRELOOM',moves={'SPORE','MACH_PUNCH','SEED_BOMB','PROTECT'}},{'ROTOM',moves={'THUNDERBOLT','WILL_O_WISP','HELPING_HAND','PROTECT'}}},
  {{'TOGEKISS',moves={'AIR_SLASH','DAZZLING_GLEAM','FOLLOW_ME','ROOST'}},{'TYRANITAR',moves={'ROCK_SLIDE','CRUNCH','STEALTH_ROCK','EARTHQUAKE'}}},
}
for i,foe in ipairs(teams) do
  F.reseed(0x7000+i)
  for _,m in ipairs(foe) do m.level=45 end
  local foeT=trainer(foe)
  local ok,err=pcall(F.battle,{playerParty=mons({{'MEW',level=50,moves={'PSYCHIC','SHADOW_BALL','FLAMETHROWER','THUNDERBOLT'}},{'MEW',level=50,moves={'SURF','ICE_BEAM','EARTHQUAKE','PROTECT'}}}),
    foe=foeT,double=true,trainerId=TRAINER})
  Battle.reset()
  T.check(ok,'battle '..i..' runs with the AI '..(ok and '' or tostring(err)))
end
print=print0
T.check(#errors==0,'no AI errors in whole battles ('..#errors..')')
T.check((AI.picks or 0)>=8,'the campaign AI made the foes\' picks ('..tostring(AI.picks)..')')
for _,e in ipairs(errors) do print('   '..e) end
T.finish('campaign trainer AI')
