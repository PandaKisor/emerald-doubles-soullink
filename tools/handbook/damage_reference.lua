-- Native reference values for the shareable handbook calculator.
-- Run from Gen3Mod/gen1recomp-0.3.73:
-- luajit ../porting/native/tools/handbook/damage_reference.lua [output.json]
-- This intentionally uses the built campaign and its real adapter/handlers.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local State = require('src.core.game3.battle.state')
local Adapter = require('src.core.game3.battle.adapter')
local Battle = require('src.core.game3.battle')
local Damage = require('src.core.game3.battle.damage')
local Moves = require('src.core.game3.battle.moves')
assert(Moves._campaignField.active(), 'Campaign battle handlers must be active')

local abilityIds = {}
for id,row in pairs(F.data.abilities) do abilityIds[row.symbol:gsub('^ABILITY_', '')] = id end
local function six(value)
  return {hp=value, atk=value, def=value, spa=value, spd=value, spe=value}
end
local function stats(mon)
  return {hp=mon.maxHp, atk=mon.attack, def=mon.defense, spa=mon.spAtk, spd=mon.spDef, spe=mon.speed}
end
local function battler(spec, side, id, move)
  spec = spec or {}
  local name = spec.species or 'MEW'
  local ability = assert(abilityIds[spec.ability or 'NONE'], spec.ability or 'NONE')
  local item = spec.item and assert(F.ids.items['ITEM_' .. spec.item], spec.item) or 0
  local ivs, evs, nature = spec.ivs or six(31), spec.evs or six(0), spec.nature or 0
  local mon = F.mon(name, spec.level or 50, {move}, {
    personality=0, nature=nature, ivs=ivs, evs=evs, ability=ability,
    item=item, friendship=255, gender='M', status=spec.status,
  })
  if spec.hpFraction then mon.hp=math.max(1, math.floor(mon.maxHp * spec.hpFraction)) end
  if spec.currentHP then mon.hp=spec.currentHP end
  local b = State.makeBattler(mon, side, {id=id, partyIndex=1})
  b.ability, b.mon.ability, b.item, b.mon.item = ability, ability, item, item
  for key,value in pairs(spec.stages or {}) do b.stages[key]=value end
  local row = F.data.species[b.species]
  return b, {
    species=b.species, speciesSymbol=row.symbol, speciesName=row.name,
    level=mon.level, ivs=ivs, evs=evs, nature=nature,
    natureName=F.data.manifest.nature.names[nature], personality=0,
    ability=ability, abilitySymbol=F.data.abilities[ability].symbol,
    abilityName=F.data.abilities[ability].name,
    item=item, itemSymbol=spec.item and ('ITEM_' .. spec.item) or 'ITEM_NONE',
    status=spec.status or 'NONE', stages=b.stages, currentHP=mon.hp,
    friendship=255, gender='M',
  }, stats(mon), row.stats
end

local specs = {
  {'neutral_physical', 'Neutral physical attack', 'TACKLE'},
  {'neutral_special', 'Neutral special attack', 'THUNDERBOLT'},
  {'stab_physical', 'Normal STAB physical attack', 'BODY_SLAM', {species='SNORLAX'}},
  {'stab_special', 'Psychic STAB special attack', 'PSYCHIC'},
  {'resisted_physical', 'Rock resists Normal', 'TACKLE', nil, {species='GEODUDE'}},
  {'super_effective_special', 'Water against Rock/Ground', 'SURF', nil, {species='GEODUDE'}},
  {'immune_physical', 'Ghost is immune to Normal', 'TACKLE', nil, {species='GASTLY'}},
  {'spread_double', 'Surf hits multiple targets in doubles', 'SURF', nil, nil, {spread=true}},
  {'critical', 'Critical physical attack', 'BODY_SLAM', nil, nil, {crit=true}},
  {'burn', 'Burn reduces physical damage', 'BODY_SLAM', {status='BRN'}},
  {'rain', 'Rain boosts Water', 'SURF', nil, nil, {weather='RAIN'}},
  {'sun', 'Sun boosts Fire', 'FLAMETHROWER', nil, nil, {weather='SUN'}},
  {'rain_fire', 'Rain weakens Fire', 'FLAMETHROWER', nil, nil, {weather='RAIN'}},
  {'permanent_rain', 'Permanent rain uses the campaign Water boost', 'SURF', nil, nil, {weather='RAIN', permanentWeather=true}},
  {'reflect_double', 'Reflect in doubles', 'BODY_SLAM', nil, nil, {reflect=true}},
  {'light_screen_double', 'Light Screen in doubles', 'THUNDERBOLT', nil, nil, {lightScreen=true}},
  {'reflect_single', 'Reflect with one defender remaining', 'BODY_SLAM', nil, nil, {reflect=true, doubleScreens=false}},
  {'helping_hand', 'Helping Hand boosts base power', 'BODY_SLAM', nil, nil, {helpingHand=true}},
  {'physical_stages', 'Attack +2 against Defense +1', 'BODY_SLAM', {stages={attack=2}}, {stages={defense=1}}},
  {'special_stages', 'Sp. Atk -1 against Sp. Def +2', 'THUNDERBOLT', {stages={spAtk=-1}}, {stages={spDef=2}}},
  {'critical_ignores_stages_screen', 'Critical ignores negative attack, positive defense and screen', 'BODY_SLAM', {stages={attack=-2}}, {stages={defense=3}}, {crit=true,reflect=true}},
  {'huge_power', 'Azumarill with Huge Power', 'AQUA_TAIL', {species='AZUMARILL',ability='HUGE_POWER'}},
  {'guts', 'Burned Machamp with Guts', 'BRICK_BREAK', {species='MACHAMP',ability='GUTS',status='BRN'}},
  {'blaze_full_hp', 'Blaziken with Blaze at full HP', 'FLAMETHROWER', {species='BLAZIKEN',ability='BLAZE'}},
  {'blaze_pinch', 'Blaziken with Blaze at one-third HP', 'FLAMETHROWER', {species='BLAZIKEN',ability='BLAZE',hpFraction=1/3}},
  {'technician', 'Scizor with Technician using Bullet Punch', 'BULLET_PUNCH', {species='SCIZOR',ability='TECHNICIAN'}},
  {'thick_fat_physical', 'Thick Fat against physical Fire', 'FIRE_PUNCH', nil, {species='SNORLAX',ability='THICK_FAT'}},
  {'thick_fat_special', 'Thick Fat against special Fire', 'FLAMETHROWER', nil, {species='SNORLAX',ability='THICK_FAT'}},
  {'choice_band', 'Choice Band physical attack', 'BODY_SLAM', {item='CHOICE_BAND'}},
  {'choice_specs', 'Choice Specs special attack', 'THUNDERBOLT', {item='CHOICE_SPECS'}},
  {'life_orb', 'Life Orb after random damage', 'BODY_SLAM', {item='LIFE_ORB'}},
  {'eviolite_physical', 'Eviolite on an unevolved physical defender', 'BODY_SLAM', nil, {species='BIDOOF',item='EVIOLITE'}},
  {'eviolite_special', 'Eviolite on an unevolved special defender', 'THUNDERBOLT', nil, {species='BIDOOF',item='EVIOLITE'}},
  {'fixed_level', 'Seismic Toss deals the attacker level', 'SEISMIC_TOSS', {level=37}},
  {'fixed_immune', 'Ghost is immune to Seismic Toss', 'SEISMIC_TOSS', {level=37}, {species='GASTLY'}},
  {'fixed_dragon_rage', 'Dragon Rage deals 40', 'DRAGON_RAGE'},
  {'trained_nature', 'Adamant level-37 attacker with EVs and varied IVs', 'BODY_SLAM',
    {species='ZIGZAGOON',level=37,nature=3,ivs={hp=18,atk=31,def=21,spa=0,spd=12,spe=30},evs={hp=4,atk=252,def=0,spa=0,spd=0,spe=252}},
    {species='MIGHTYENA',level=38,nature=5,evs={hp=252,atk=0,def=252,spa=0,spd=4,spe=0}}},
  {'combined_modifiers', 'Spread, rain, STAB, Helping Hand, Life Orb and Light Screen', 'SURF',
    {species='SWAMPERT',item='LIFE_ORB',nature=15,evs={hp=4,atk=0,def=0,spa=252,spd=0,spe=252}},
    {species='SNORLAX',nature=23}, {spread=true,weather='RAIN',helpingHand=true,lightScreen=true}},
}

local out = {
  schemaVersion=1, campaignVersion='0.26.0', engineVersion='0.3.73', damageRules='inclement',
  provenance='campaign_fixture.lua; live stock engine Damage.calc with the built campaign and native Adapter.new',
  command='cd Gen3Mod/gen1recomp-0.3.73 && luajit ../porting/native/tools/handbook/damage_reference.lua',
  notes={
    'Each damage array is ordered by the explicit integer damage roll 85 through 100.',
    'Base stats and expected battle stats use hp/atk/def/spa/spd/spe; stages use native attack/defense/spAtk/spDef/speed keys.',
    'Ability NONE is explicit for cases that isolate a modifier; do not replace it with the species default ability.',
    'Field defaults to doubles with both sides populated by a second ability-free Mew; screens use their doubles modifier unless overridden.',
    'These references exercise Damage.calc, not accuracy, critical-hit probability, action order, recoil, or move execution side effects.',
  },
  cases={},
}
for _,spec in ipairs(specs) do
  local field={weather='NONE',double=true,spread=false,crit=false,reflect=false,lightScreen=false,
    doubleScreens=true,helpingHand=false,permanentWeather=false}
  for key,value in pairs(spec[6] or {}) do field[key]=value end
  local attacker,aInput,aStats,aBase=battler(spec[4],'player',0,spec[3])
  local defender,dInput,dStats,dBase=battler(spec[5],'enemy',1,spec[3])
  local st={playerSide={},enemySide={},battlers={[0]=attacker,[1]=defender},turn=1,
    damageRules='inclement',double=true,weather=field.weather~='NONE' and field.weather or nil}
  st.player,st.enemy=attacker,defender
  st.battlers[2]=battler(nil,'player',2,'TACKLE')
  st.battlers[3]=battler(nil,'enemy',3,'TACKLE')
  local ad=Adapter.new(st,function() end)
  Battle._adapter=ad
  attacker.expHelpingHand=field.helpingHand
  local id=F.move(spec[3])
  local move=Moves.get(id)
  assert(move.damageRules=='inclement', 'Move is missing the campaign damage rules')
  local rolls,info={},nil
  for roll=85,100 do
    local value
    value,info=Damage.calc(attacker,defender,move,{
      adapter=ad,st=st,damageRules='inclement',forceRoll=roll,forceCrit=field.crit,
      rng=function(lo) return lo or 0 end,
      weatherKind=st.weather,permanentWeather=field.permanentWeather,
      reflect=field.reflect,lightScreen=field.lightScreen,doubleScreens=field.doubleScreens,
      spread=field.spread,trace=true,
    })
    rolls[#rolls+1]=value
  end
  local dataMove=F.data.moves[id]
  out.cases[#out.cases+1]={
    id=spec[1],label=spec[2],
    input={attacker=aInput,defender=dInput,move=id,moveSymbol=dataMove.symbol,
      moveName=dataMove.name,category=move.category,power=move.power,type=move.type,field=field},
    expected={attackerStats=aStats,defenderStats=dStats,attackerBaseStats=aBase,defenderBaseStats=dBase,
      damage=rolls,min=rolls[1],max=rolls[#rolls],effectiveness=info.effectiveness,
      critical=info.critical,physical=info.physical,stab=info.stab,setDamage=info.setDamage or false,
      damageTrace=info.damageTrace},
  }
  print(('%-36s %d-%d'):format(spec[1],rolls[1],rolls[#rolls]))
end
Battle._adapter=nil

local function quote(s)
  return '"'..s:gsub('[%z\1-\31\\"]',function(c)
    local esc={['"']='\\"',['\\']='\\\\',['\n']='\\n',['\r']='\\r',['\t']='\\t'}
    return esc[c] or string.format('\\u%04x',c:byte())
  end)..'"'
end
local function json(v,depth)
  depth=depth or 0
  local t=type(v)
  if t=='nil' then return 'null' elseif t=='boolean' or t=='number' then return tostring(v)
  elseif t=='string' then return quote(v)
  elseif t=='table' then
    local count,array,scalarArray=0,true,true
    for k,value in pairs(v) do
      count=count+1
      if type(k)~='number' or k<1 or k%1~=0 then array=false end
      if type(value)=='table' then scalarArray=false end
    end
    array=array and count==#v
    local parts,pad={},string.rep('  ',depth+1)
    if array then
      for i=1,#v do parts[i]=json(v[i],depth+1) end
      if scalarArray then return '['..table.concat(parts,', ')..']' end
      return '[\n'..pad..table.concat(parts,',\n'..pad)..'\n'..string.rep('  ',depth)..']'
    end
    local keys={};for k in pairs(v) do keys[#keys+1]=k end
    table.sort(keys,function(a,b)return tostring(a)<tostring(b)end)
    for _,k in ipairs(keys) do parts[#parts+1]=quote(tostring(k))..': '..json(v[k],depth+1) end
    return '{\n'..pad..table.concat(parts,',\n'..pad)..'\n'..string.rep('  ',depth)..'}'
  end
  error('Cannot encode '..t)
end
local output=(arg and arg[1]) or '../porting/native/generated/handbook/damage_reference.json'
local file=assert(io.open(output,'w'));file:write(json(out),'\n');file:close()
print(('Exported %d cases to %s'):format(#out.cases,output))
