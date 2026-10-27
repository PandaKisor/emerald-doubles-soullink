/* Compare the offline calculator against damage emitted by the actual Lua runtime. */
'use strict';
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const C=require('./calculator.js'),base=path.resolve(__dirname,'../../generated/handbook');
const D=JSON.parse(fs.readFileSync(path.join(base,'data.json'))),R=JSON.parse(fs.readFileSync(path.join(base,'damage_reference.json')));
const stageNames={attack:'atk',defense:'def',spAtk:'spa',spDef:'spd',speed:'spe'};
const mon=m=>({...m,hp:m.currentHP,status:m.status==='NONE'?'':m.status,stages:Object.fromEntries(Object.entries(m.stages).map(([k,v])=>[stageNames[k]||k,v]))});
let rolls=0;
for(const test of R.cases){
 const i=test.input,f={...i.field,doubles:i.field.double,weather:i.field.weather==='NONE'?'':i.field.weather};
 const a=mon(i.attacker),d={...mon(i.defender),reflect:f.reflect,lightScreen:f.lightScreen};
 assert.deepEqual(C.stats(D,a),test.expected.attackerStats,test.id+' attacker stats');
 assert.deepEqual(C.stats(D,d),test.expected.defenderStats,test.id+' defender stats');
 const actual=C.calculate(D,a,d,i.move,f);
 assert.deepEqual(actual.rolls,test.expected.damage,test.id+' damage');rolls+=actual.rolls.length;
}
for(const t of D.trainers){
 for(const m of t.party){assert(D.species[m.species]);assert.deepEqual(C.stats(D,m),m.stats,t.symbol+' roster stats');for(const id of m.moves)assert(D.moves[id]||id===0);}
 if(t.partnerId)assert(D.trainers.some(p=>p.id===t.partnerId));
}
for(const w of D.wild){assert(D.maps[w.map]);assert.equal(w.slots.reduce((n,s)=>n+s.weight,0)+(w.emptyWeight||0),100);}
for(const s of D.sources){assert(D.items[s.item]);if(s.map)assert(D.maps[s.map]);}
let guideStops=0,guideTrainers=new Set();
for(const c of D.routeGuide){
 assert(c.steps.length&&c.cap>0&&c.bosses.length,c.title);
 for(const id of c.bosses)assert(D.trainers.some(t=>t.id===id),c.title+' boss');
 for(const s of c.steps){guideStops++;assert(!s.primary||D.maps[s.primary],s.title);for(const m of s.maps)assert(D.maps[m],s.title+' '+m);for(const id of s.trainers){assert(!guideTrainers.has(id),'trainer listed twice: '+id);guideTrainers.add(id);}}
}
for(let i=1;i<D.routeGuide.length;i++)assert(D.routeGuide[i].cap>D.routeGuide[i-1].cap,'caps climb: '+D.routeGuide[i].title);
for(const sp of Object.values(D.species))if(!sp.excluded&&sp.id>0)assert(D.icons.index[sp.id]!=null||sp.symbol==='SPECIES_EGG','icon for '+sp.symbol);
const html=fs.readFileSync(process.argv[2]||path.resolve(__dirname,'../../../../emerald-field-guide-'+D.meta.campaignVersion+'.html'),'utf8');
assert(!/<(?:script|link|img)[^>]+(?:src|href)=["']https?:/i.test(html),'No network dependencies');
assert(!html.includes('/* DATA */'));
console.log(`PASS: ${R.cases.length} native damage scenarios / ${rolls} exact rolls; all trainer stats, encounter weights, item/map references, ${D.routeGuide.length} guide chapters / ${guideStops} stops / ${guideTrainers.size} trainers placed; icons; offline embedding.`);
