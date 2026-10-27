/* Direct-hit calculator for the packaged campaign. See lib/damage.lua,
 * lib/damage_rules.lua and campaign/battle/{field,items,abilities}.lua.
 * Intentionally reports context it cannot model rather than inventing it. */
(function (root) {
  'use strict';
  const keys = ['hp', 'atk', 'def', 'spa', 'spd', 'spe'];
  const floor = Math.floor;
  const clamp = (n, lo, hi) => Math.max(lo, Math.min(hi, Number(n) || 0));
  const q = (m, v) => floor((m * v + 2048) / 4096);
  const stage = (v, s = 0) => floor(v * (s >= 0 ? (2 + s) / 2 : 2 / (2 - s)));
  const mul = (v, m) => Math.max(1, floor(v * m));
  const symbol = (obj, prefix) => (obj?.symbol || '').replace(prefix, '');
  function stats(data, mon) {
    const base = data.species[mon.species]?.stats || {};
    const effects = data.natures[mon.nature || 0]?.effects || {};
    const lv = clamp(mon.level, 1, 100), result = {};
    for (const key of keys) {
      const raw = floor((2 * (base[key] || 1) + clamp(mon.ivs?.[key] ?? 31, 0, 31)
        + floor(clamp(mon.evs?.[key] || 0, 0, 252) / 4)) * lv / 100);
      result[key] = key === 'hp' ? raw + lv + 10 : floor((raw + 5) * (100 + (effects[key] || 0) * 10) / 100);
    }
    if (data.species[mon.species]?.symbol === 'SPECIES_SHEDINJA') result.hp = 1;
    return result;
  }
  function ability(data, mon) { return symbol(data.abilities[mon.ability], 'ABILITY_'); }
  function held(data, mon) {
    if (ability(data, mon) === 'KLUTZ') return {};
    return data.items[mon.item] || {};
  }
  function hold(data, mon) { return (held(data, mon).holdEffect || '').replace('HOLD_EFFECT_', ''); }
  function speed(data, mon, field = {}) {
    let n = stage(stats(data, mon).spe, mon.stages?.spe || 0);
    const ab = ability(data, mon), it = hold(data, mon);
    const w = it === 'UTILITY_UMBRELLA' && ['RAIN','SUN'].includes(field.weather) ? '' : field.weather;
    if ((ab === 'SWIFT_SWIM' && w === 'RAIN') || (ab === 'CHLOROPHYLL' && w === 'SUN')) n *= 2;
    if (mon.status === 'PAR') n = floor(n / 2);
    if (it === 'CHOICE_SCARF') n = floor(n * 1.5);
    if (['MACHO_BRACE', 'IRON_BALL', 'POWER_ITEM'].includes(it)) n = floor(n / 2);
    if (mon.tailwind) n *= 2;
    if ((ab === 'SAND_RUSH' && w === 'SAND') || (ab === 'SLUSH_RUSH' && w === 'HAIL') || (ab === 'SURGE_SURFER' && field.terrain === 'ELECTRIC')) n *= 2;
    else if (ab === 'QUICK_FEET' && mon.status) { n = floor(n * 1.5); if (mon.status === 'PAR') n *= 2; }
    return Math.max(1, n);
  }
  const supportedAbilities = new Set(('NONE STENCH DAMP LIMBER INSOMNIA VITAL_SPIRIT IMMUNITY OWN_TEMPO OBLIVIOUS INNER_FOCUS ' +
    'KEEN_EYE INTIMIDATE PRESSURE SYNCHRONIZE STATIC POISON_POINT FLAME_BODY EFFECT_SPORE CUTE_CHARM SHED_SKIN ' +
    'NATURAL_CURE SERENE_GRACE PICKUP RUN_AWAY HYPER_CUTTER CLEAR_BODY WHITE_SMOKE ROCK_HEAD STURDY ' +
    'ROUGH_SKIN IRON_BARBS MAGIC_GUARD OVERCOAT REGENERATOR MOXIE COMPETITIVE DEFIANT DROUGHT DRIZZLE SNOW_WARNING SAND_STREAM ' +
    'HUGE_POWER PURE_POWER GUTS HUSTLE MARVEL_SCALE THICK_FAT FUR_COAT ICE_SCALES MULTISCALE SHADOW_SHIELD FILTER SOLID_ROCK PRISM_ARMOR ' +
    'BLAZE OVERGROW TORRENT SWARM VENGEANCE TECHNICIAN FLARE_BOOST TOXIC_BOOST IRON_FIST RECKLESS KEEN_EDGE SHEER_FORCE SAND_FORCE ' +
    'TOUGH_CLAWS STRONG_JAW MEGA_LAUNCHER WATER_BUBBLE STEELWORKER STEELY_SPIRIT TRANSISTOR DRAGONS_MAW PUNK_ROCK GORILLA_TACTICS ' +
    'SOLAR_POWER DEFEATIST GRASS_PELT HEATPROOF DRY_SKIN FLUFFY TINTED_LENS SNIPER NEUROFORCE ADAPTABILITY UNAWARE INFILTRATOR ' +
    'LEVITATE WATER_ABSORB VOLT_ABSORB FLASH_FIRE LIGHTNING_ROD STORM_DRAIN SAP_SIPPER MOTOR_DRIVE WONDER_GUARD SOUNDPROOF BULLETPROOF ' +
    'MOLD_BREAKER TERAVOLT TURBOBLAZE SCRAPPY BATTLE_ARMOR SHELL_ARMOR RIPEN KLUTZ SWIFT_SWIM CHLOROPHYLL QUICK_FEET ' +
    'SAND_RUSH SLUSH_RUSH SURGE_SURFER PRANKSTER GALE_WINGS TRIAGE BLITZ_BOXER').split(' '));
  const damageHooks = new Set(['campaignCalc','campaignPre','campaignStats','campaignEffectiveness']);
  const handledMoves = new Set(('GRASS_KNOT LOW_KICK GYRO_BALL ELECTRO_BALL HEAT_CRASH HEAVY_SLAM STORED_POWER POWER_TRIP PUNISHMENT ' +
    'PSYSHOCK PSYSTRIKE SECRET_SWORD BODY_PRESS FOUL_PLAY CHIP_AWAY SACRED_SWORD DARKEST_LARIAT HEX VENOSHOCK BRINE ' +
    'WRING_OUT CRUSH_GRIP WEATHER_BALL HIDDEN_POWER RETURN FRUSTRATION ERUPTION WATER_SPOUT FLAIL REVERSAL ' +
    'FACADE FREEZE_DRY FLYING_PRESS BULLDOZE').split(' '));
  function calculate(data, attacker, defender, moveId, field = {}) {
    const move = data.moves[moveId];
    if (!move) return {error:'Choose a move.'};
    const warnings = [], notes = [];
    const a = {...attacker}, d = {...defender};
    const as = stats(data, a), ds = stats(data, d);
    const aSpecies = data.species[a.species], dSpecies = data.species[d.species];
    if (!aSpecies || !dSpecies) return {error:'Choose both Pokémon.'};
    const ahp = clamp(a.hp ?? as.hp, 1, as.hp), dhp = clamp(d.hp ?? ds.hp, 1, ds.hp);
    const name = symbol(move, 'MOVE_');
    let ak = ability(data, a), dk = ability(data, d);
    const ai = hold(data, a), di = hold(data, d), ar = held(data, a), dr = held(data, d);
    const ignored = ['MOLD_BREAKER','TERAVOLT','TURBOBLAZE'].includes(ak);
    if (ignored) dk = '';
    for (const [who, ab] of [['Attacker', ak], ['Defender', dk]]) {
      if (ab && !supportedAbilities.has(ab)) warnings.push(who + ' ability ' + ab.replaceAll('_',' ') + ' is not modeled.');
    }
    if ([a, d].some(m => keys.reduce((n,k) => n + Number(m.evs?.[k] || 0), 0) > 510)) warnings.push('An EV total exceeds 510.');
    let type = move.type, physical = move.category === 'physical', power = Number(move.power) || 0, multiplier = 1;
    let weather = ai === 'UTILITY_UMBRELLA' && ['RAIN','SUN'].includes(field.weather) ? '' : field.weather;
    const flag = f => (move.sourceFlags || []).includes('FLAG_' + f);
    const contact = flag('MAKES_CONTACT') && ai !== 'PROTECTIVE_PADS';
    let critical = !!field.crit && !['BATTLE_ARMOR','SHELL_ARMOR'].includes(dk);
    const aGround = !(aSpecies.types.includes(2) || ak === 'LEVITATE' || ai === 'AIR_BALLOON') || ai === 'IRON_BALL';
    const dGround = !(dSpecies.types.includes(2) || dk === 'LEVITATE' || di === 'AIR_BALLOON') || di === 'IRON_BALL';
    if (move.category === 'status') return {status:true, notes:[move.description || 'Status move; no direct damage.'], warnings, as, ds};
    if (name === 'RETURN' || name === 'FRUSTRATION') power = floor(10 * (name === 'RETURN' ? (a.friendship ?? 255) : 255 - (a.friendship ?? 255)) / 25);
    if (['ERUPTION','WATER_SPOUT'].includes(name)) power = Math.max(1, floor(ahp * power / as.hp));
    if (['FLAIL','REVERSAL'].includes(name)) {
      const h = Math.max(1, floor(ahp * 48 / as.hp));
      power = h <= 1 ? 200 : h <= 4 ? 150 : h <= 9 ? 100 : h <= 16 ? 80 : h <= 32 ? 40 : 20;
    }
    if (name === 'HIDDEN_POWER') {
      const order = ['hp','atk','def','spe','spa','spd'];
      const bits = order.reduce((v,k,i)=>v+((a.ivs?.[k] ?? 31) % 2)*2**i,0);
      type = floor(15 * bits / 63) + 1; if (type >= 9) type++;
    }
    if (name === 'WEATHER_BALL' && weather) { type = {RAIN:11,SUN:10,SAND:5,HAIL:15}[weather] ?? type; multiplier *= 2; }
    if (['LOW_KICK','GRASS_KNOT'].includes(name)) {
      const kg = dSpecies.weightKg;
      if (kg == null && !field.power) return {error:'Weight data is unavailable. Enter an explicit base power.', warnings};
      power = kg < 10 ? 20 : kg < 25 ? 40 : kg < 50 ? 60 : kg < 100 ? 80 : kg < 200 ? 100 : 120;
    }
    if (name === 'GYRO_BALL') power = Math.min(150, floor(25 * speed(data,d,field) / speed(data,a,field)) + 1);
    if (name === 'ELECTRO_BALL') power = [40,60,80,120][floor(speed(data,a,field) / speed(data,d,field))] || 150;
    if (['HEAVY_SLAM','HEAT_CRASH'].includes(name)) {
      if (!aSpecies.weightKg || !dSpecies.weightKg) {
        if (!field.power) return {error:'Weight data is unavailable. Enter an explicit base power.',warnings};
      } else power = [40,40,60,80,100][floor(aSpecies.weightKg/dSpecies.weightKg)] || 120;
    }
    if (['STORED_POWER','POWER_TRIP','PUNISHMENT'].includes(name)) {
      const who = name === 'PUNISHMENT' ? d : a;
      const boost = Object.values(who.stages || {}).reduce((n,v) => n + Math.max(0, v), 0);
      power = name === 'PUNISHMENT' ? Math.min(200,60 + 20 * boost) : 20 + 20 * boost;
      warnings.push('Accuracy and evasion boosts are not included in stored-power totals.');
    }
    if (['WRING_OUT','CRUSH_GRIP'].includes(name)) power = Math.max(1,floor(120*dhp/ds.hp));
    if (name === 'FACADE' && ['BRN','PAR','PSN','TOX'].includes(a.status)) multiplier *= 2;
    if (name === 'HEX' && d.status) power *= 2;
    if (name === 'VENOSHOCK' && ['PSN','TOX'].includes(d.status)) power *= 2;
    if (name === 'BRINE' && dhp <= floor(ds.hp/2)) power *= 2;
    const contextMoves = ['COUNTER','MIRROR_COAT','METAL_BURST','BIDE','BEAT_UP','MAGNITUDE','PRESENT','SPIT_UP','NATURAL_GIFT','FLING','TRUMP_CARD','FISSURE','GUILLOTINE','HORN_DRILL','SHEER_COLD','FINAL_GAMBIT'];
    if (contextMoves.includes(name)) return {error:'This move needs battle history or a special resolution and is not calculated here.',warnings};
    if ((move.hooks || []).some(h => damageHooks.has(h)) && !handledMoves.has(name)) {
      if (!field.power) warnings.push('This move has a custom context effect. Set base power manually if its condition changes damage.');
    }
    if (field.power) { power = clamp(field.power,1,999); notes.push('Manual base power override.'); }
    const chart = t => data.typeChart[type]?.[t] ?? 1;
    let eff = [...new Set(dSpecies.types)].reduce((v,t) => {
      let e = chart(t);
      if (name === 'FREEZE_DRY' && t === 11) e = 2;
      if (ak === 'SCRAPPY' && t === 7 && [0,1].includes(type)) e = 1;
      if (di === 'RING_TARGET' && e === 0) e = 1;
      if (di === 'IRON_BALL' && type === 4 && t === 2) e = 1;
      if (name === 'FLYING_PRESS') e *= data.typeChart[2]?.[t] ?? 1;
      return v * e;
    },1);
    let immune = '';
    if ((type === 4 && !dGround) || (dk === 'WONDER_GUARD' && eff <= 1)) immune = 'Defender ability or airborne state';
    if ((type === 11 && ['WATER_ABSORB','STORM_DRAIN','DRY_SKIN'].includes(dk)) ||
      (type === 13 && ['VOLT_ABSORB','LIGHTNING_ROD','MOTOR_DRIVE'].includes(dk)) ||
      (type === 10 && dk === 'FLASH_FIRE') || (type === 12 && dk === 'SAP_SIPPER') ||
      (dk === 'SOUNDPROOF' && flag('SOUND')) || (dk === 'BULLETPROOF' && flag('BALLISTIC'))) immune = 'Defender immunity';
    if (field.terrain === 'PSYCHIC' && dGround && move.priority > 0) immune = 'Psychic Terrain';
    if (name === 'STRUGGLE') {eff=1;immune='';}
    if (immune) {eff=0;notes.push(immune);}
    if (eff === 0) return {rolls:Array(16).fill(0),min:0,max:0,ko:0,twoKo:0,eff,power,as,ds,dhp,warnings,notes,type,physical};
    let fixed;
    if (name === 'DRAGON_RAGE') fixed=40;
    if (name === 'SONIC_BOOM' || name === 'SONICBOOM') fixed=20;
    if (['SEISMIC_TOSS','NIGHT_SHADE'].includes(name)) fixed=Number(a.level);
    if (name === 'SUPER_FANG') fixed=Math.max(1,floor(dhp/2));
    if (name === 'ENDEAVOR') fixed=Math.max(0,dhp-ahp);
    if (name === 'PSYWAVE') return {error:'Psywave uses a separate random distribution; this calculator does not model it.',warnings};
    if (fixed != null) return summarize(Array(16).fill(fixed),{eff,power,as,ds,dhp,warnings,notes,type,physical,fixed:true}, d, data);
    if (power <= 0) return {error:'This move has no direct damage formula in this calculator.',warnings};
    // Campaign power modifiers, then terrain and held-item power modifiers.
    let pm=1;
    const boostFlags={IRON_FIST:['IRON_FIST_BOOST',1.2],RECKLESS:['RECKLESS_BOOST',1.2],KEEN_EDGE:['KEEN_EDGE_BOOST',1.3],SHEER_FORCE:['SHEER_FORCE_BOOST',1.3],STRONG_JAW:['STRONG_JAW_BOOST',1.5],MEGA_LAUNCHER:['MEGA_LAUNCHER_BOOST',1.5]};
    if (ak==='TECHNICIAN' && power<=60) pm*=1.5;
    if (boostFlags[ak] && flag(boostFlags[ak][0])) pm*=boostFlags[ak][1];
    if (ak==='FLARE_BOOST' && a.status==='BRN' && !physical) pm*=1.5;
    if (ak==='TOXIC_BOOST' && ['PSN','TOX'].includes(a.status) && physical) pm*=1.5;
    if (ak==='SAND_FORCE' && weather==='SAND' && [4,5,8].includes(type)) pm*=1.3;
    if (ak==='TOUGH_CLAWS' && contact) pm*=1.3;
    if (ak==='WATER_BUBBLE' && type===11) pm*=2;
    if (['STEELWORKER','STEELY_SPIRIT'].includes(ak) && type===8) pm*=1.5;
    if (ak==='TRANSISTOR' && type===13 || ak==='DRAGONS_MAW' && type===16) pm*=1.5;
    if (ak==='PUNK_ROCK' && flag('SOUND')) pm*=1.3;
    if (ak==='GORILLA_TACTICS' && physical) pm*=1.5;
    if (['HEATPROOF','WATER_BUBBLE'].includes(dk) && type===10) pm*=.5;
    else if (dk==='DRY_SKIN' && type===10) pm*=1.25;
    else if (dk==='FLUFFY') {if(contact)pm*=.5;if(type===10)pm*=2;}
    power=mul(power,pm);
    if (aGround && ((field.terrain==='GRASSY' && type===12)||(field.terrain==='ELECTRIC' && type===13)||(field.terrain==='PSYCHIC' && type===14))) power=mul(power,1.3);
    if (field.terrain==='MISTY' && type===16 && dGround) power=mul(power,.5);
    if (field.terrain==='GRASSY' && ['EARTHQUAKE','MAGNITUDE','BULLDOZE'].includes(name)) power=mul(power,.5);
    const paramType = val => typeof val==='string' ? Object.entries(data.types).find(([,n])=>'TYPE_'+n.toUpperCase()===val)?.[0] : null;
    const secondary = ar.secondaryId || ar.holdEffectParam;
    if (ai==='MUSCLE_BAND' && physical || ai==='WISE_GLASSES' && !physical) power=mul(power,1.1);
    if (ai==='PLATE' && Number(paramType(secondary))===type) power=mul(power,1.2);
    if (ai==='GEMS' && Number(paramType(secondary))===type && move.power>1) power=mul(power,1.3);
    const orbs={ADAMANT_ORB:['DIALGA',[8,16]],LUSTROUS_ORB:['PALKIA',[11,16]],GRISEOUS_ORB:['GIRATINA',[7,16]],SOUL_DEW:['LATIA',[14,16]]};
    if(orbs[ai] && aSpecies.symbol.includes(orbs[ai][0]) && orbs[ai][1].includes(type))power=mul(power,1.2);
    if (ai==='METRONOME') warnings.push('Metronome repeat-turn boosts are not included.');
    if(field.helpingHand)power=q(6144,power);
    let atk=as.atk, def=ds.def, spa=as.spa, spd=ds.spd;
    if(ai==='CHOICE_SPECS')spa=mul(spa,1.5);
    if(ai==='LIGHT_BALL' && aSpecies.symbol==='SPECIES_PIKACHU'){atk*=2;spa*=2;}
    if(di==='ASSAULT_VEST')spd=mul(spd,1.5);
    if(di==='EVIOLITE' && (dSpecies.evolutions?.length || dSpecies.itemEvolutions?.length)){def=mul(def,1.5);spd=mul(spd,1.5);}
    const used = factor => {if(physical)atk=mul(atk,factor);else spa=mul(spa,factor);};
    const pinch = ahp<=floor(as.hp/3), pinchTypes={OVERGROW:12,BLAZE:10,TORRENT:11,SWARM:6,VENGEANCE:7};
    if(ak==='SOLAR_POWER' && weather==='SUN' && !physical)spa=mul(spa,1.5);
    else if(ak==='DEFEATIST' && ahp<=floor(as.hp/2)){atk=mul(atk,.5);spa=mul(spa,.5);}
    else if(pinchTypes[ak]===type && (ak==='VENGEANCE' || !pinch))used(pinch?1.5:1.2);
    if(dk==='THICK_FAT' && physical && [10,15].includes(type))atk=mul(atk,.5);
    else if(dk==='ICE_SCALES' && !physical)spa=mul(spa,.5);
    if(dk==='FUR_COAT')def*=2;
    else if(dk==='GRASS_PELT' && field.terrain==='GRASSY')def=mul(def,1.5);
    else if(dk==='PUNK_ROCK' && flag('SOUND')){def*=2;spd*=2;}
    if(['HUGE_POWER','PURE_POWER'].includes(ak))atk*=2;
    const boosts={BUG_POWER:6,STEEL_POWER:8,GROUND_POWER:4,ROCK_POWER:5,GRASS_POWER:12,DARK_POWER:17,FIGHTING_POWER:1,ELECTRIC_POWER:13,WATER_POWER:11,FLYING_POWER:2,POISON_POWER:3,ICE_POWER:15,GHOST_POWER:7,PSYCHIC_POWER:14,FIRE_POWER:10,DRAGON_POWER:16,NORMAL_POWER:0};
    if(boosts[ai]===type)used(1+(Number(ar.holdEffectParam)||0)/100);
    if(ai==='CHOICE_BAND')atk=mul(atk,1.5);
    if(ai==='DEEP_SEA_TOOTH' && aSpecies.symbol==='SPECIES_CLAMPERL')spa*=2;
    if(di==='DEEP_SEA_SCALE' && dSpecies.symbol==='SPECIES_CLAMPERL')spd*=2;
    if(di==='METAL_POWDER' && dSpecies.symbol==='SPECIES_DITTO')def*=2;
    if(ai==='THICK_CLUB' && ['SPECIES_CUBONE','SPECIES_MAROWAK'].includes(aSpecies.symbol))atk*=2;
    if(dk==='THICK_FAT' && [10,15].includes(type))spa=mul(spa,.5);
    if(ak==='HUSTLE' || ak==='GUTS' && a.status)atk=mul(atk,1.5);
    if(dk==='MARVEL_SCALE' && d.status)def=mul(def,1.5);
    if(pinch && pinchTypes[ak]===type && ak!=='VENGEANCE')power=mul(power,1.5);
    let aStage=a.stages?.[physical?'atk':'spa']||0, dStage=d.stages?.[physical?'def':'spd']||0;
    if(['PSYSHOCK','PSYSTRIKE','SECRET_SWORD'].includes(name)){spd=def;dStage=d.stages?.def||0;}
    if(name==='BODY_PRESS'){atk=as.def;aStage=a.stages?.def||0;}
    if(name==='FOUL_PLAY'){atk=ds.atk;aStage=d.stages?.atk||0;}
    if(['CHIP_AWAY','SACRED_SWORD','DARKEST_LARIAT'].includes(name))dStage=0;
    if(dk==='UNAWARE')aStage=0;if(ak==='UNAWARE')dStage=0;
    if(critical){aStage=Math.max(0,aStage);dStage=Math.min(0,dStage);}
    const attack=stage(physical?atk:spa,aStage), defense=Math.max(1,stage(physical?def:spd,dStage));
    const base=floor(floor(attack*power*(floor(2*a.level/5)+2)/defense)/50)+2;
    let damage=base, modifier=4096;
    const combine=m=>{modifier=q(m,modifier);};
    const spread=field.doubles!==false && (field.spread ?? [8,32].includes(move.target));
    if(spread)combine(3072);combine(floor(eff*4096));
    if(critical)damage=q(6144,damage);
    if(a.status==='BRN' && physical && ak!=='GUTS' && name!=='FACADE')damage=q(2048,damage);
    if(weather==='RAIN'){if(type===10)damage=q(2048,damage);if(type===11)damage=q(field.permanentWeather?4915:6144,damage);}
    if(weather==='SUN'){if(type===11)damage=q(2048,damage);if(type===10)damage=q(field.permanentWeather?4915:6144,damage);}
    const stab=name!=='STRUGGLE' && aSpecies.types.includes(type);
    if(stab)combine(ak==='ADAPTABILITY'?8192:6144);
    if(!critical && ak!=='INFILTRATOR' && (physical?d.reflect:d.lightScreen))combine((field.doubleScreens ?? (field.doubles!==false))?2703:2048);
    if(multiplier!==1)combine(floor(multiplier*4096));
    damage=Math.max(1,q(modifier,damage));
    const rolls=[];
    for(let r=85;r<=100;r++) {
      let n=Math.max(1,floor(damage*r/100));
      if(ai==='LIFE_ORB')n=floor(n*1.3);else if(ai==='EXPERT_BELT' && eff>1)n=floor(n*1.2);
      if(di==='RESIST_BERRY' && Number(paramType(dr.secondaryId||dr.holdEffectParam))===type && (eff>1||type===0))n=floor(n/(dk==='RIPEN'?4:2));
      n=Math.max(1,n);
      let fm=1;
      if(ak==='TINTED_LENS' && eff<1)fm*=2;else if(ak==='SNIPER' && critical)fm*=1.5;else if(ak==='NEUROFORCE' && eff>=2)fm*=1.25;
      if(['MULTISCALE','SHADOW_SHIELD'].includes(dk) && dhp===ds.hp)fm*=.5;
      else if(['FILTER','SOLID_ROCK','PRISM_ARMOR'].includes(dk) && eff>=2)fm*=.75;
      else if(dk==='ICE_SCALES' && !physical)fm*=.5;
      n=Math.max(1,floor(n*fm));
      if(name==='FALSE_SWIPE')n=Math.min(n,Math.max(0,dhp-1));
      rolls.push(n);
    }
    if(['FOCUS_SASH','FOCUS_BAND'].includes(di)||dk==='STURDY') warnings.push('Damage is before Focus Sash / Focus Band / Sturdy survival checks.');
    if(flag('TWO_STRIKES')||/MULTI_HIT|DOUBLE_HIT|TRIPLE_KICK/.test(move.sourceEffect||'')||/DOUBLE_IRON_BASH|SURGING_STRIKES|DRAGON_DARTS|TRIPLE_AXEL/.test(name))warnings.push('Range is for one hit; repeated-hit total is not simulated.');
    return summarize(rolls,{eff,power,as,ds,dhp,warnings,notes,type,physical,base,attack,defense,critical,spread,stab},d,data);
  }
  function summarize(rolls, info, defender, data) {
    const ko=rolls.filter(n=>n>=info.dhp).length/rolls.length;
    let two=0;for(const a of rolls)for(const b of rolls)if(a+b>=info.dhp)two++;
    return {...info,rolls,min:Math.min(...rolls),max:Math.max(...rolls),ko,twoKo:two/(rolls.length**2)};
  }
  root.FieldCalc={stats,speed,calculate,stage,keys};
  if(typeof module!=='undefined' && module.exports)module.exports=root.FieldCalc;
})(typeof globalThis!=='undefined'?globalThis:this);
