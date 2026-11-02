/* Whole-game difficulty model. Run after tools/handbook/export.py:
     node tools/difficulty_report.js [out.json]
   Walks the route guide in story order. The player's pool at each fight is the
   16 highest-BST lines reachable so far (wild tables plus the Hoenn starters),
   evolved by level or stone, using level-up moves known by then. Damage comes
   from the field guide's calculator, which matches the battle code roll for
   roll. Foes use their real party, tag partner, ability and item; the player
   has neither, and there's no weather, stat boosts, crits or AI. */
'use strict';
const fs=require('node:fs'),path=require('node:path');
const C=require('./handbook/calculator.js');
const D=JSON.parse(fs.readFileSync(path.resolve(__dirname,'../generated/handbook/data.json')));
const byId=new Map(D.trainers.map(t=>[t.id,t]));
const median=a=>{const s=[...a].sort((x,y)=>x-y);return s.length?s[Math.floor((s.length-1)/2)]:0;};
const pct=(a,p)=>{const s=[...a].sort((x,y)=>x-y);return s.length?s[Math.floor((s.length-1)*p)]:0;};
const mean=a=>a.length?a.reduce((x,y)=>x+y,0)/a.length:0;
const bst=s=>Object.values(s.stats).reduce((x,y)=>x+y,0);

// ---- evolution
const STONE_ALLOWED=true;
function evolved(id,level){
  let cur=id,guard=0;
  for(;guard<4;guard++){
    const s=D.species[cur];
    const next=[];
    for(const e of s.evolutions||[]) if(e&&e.target&&D.species[e.target]&&(e.method!=='EVO_LEVEL'||Number(e.param)<=level)&&(e.method==='EVO_LEVEL'||level>=25)) next.push(e.target);
    if(STONE_ALLOWED) for(const e of s.itemEvolutions||[]) if(e&&e.target&&D.species[e.target]&&level>=25) next.push(e.target);
    const usable=next.filter(t=>!D.species[t].excluded);
    if(!usable.length) break;
    usable.sort((a,b)=>bst(D.species[b])-bst(D.species[a]));
    cur=usable[0];
  }
  return cur;
}
// ---- the player's Pokémon
const movesFor=(sp,level)=>{
  const seen=new Set(),chain=[sp];
  const pre=Object.values(D.species).filter(s=>(s.evolutions||[]).concat(s.itemEvolutions||[]).some(e=>e&&e.target==sp));
  for(const s of pre)chain.push(s.id);
  for(const id of chain)for(const [l,m] of D.species[id].learnset||[])if(l<=level)seen.add(m);
  return [...seen].filter(m=>{const v=D.moves[m];return v&&v.category!=='status'&&v.power>1;})
    .sort((a,b)=>D.moves[b].power-D.moves[a].power).slice(0,8);
};
function playerMon(sp,level,trained){
  const s=D.species[sp],base=s.stats;
  const physical=base.atk>=base.spa;
  const iv=trained?31:15;
  const evs=trained?{hp:0,atk:physical?252:0,def:0,spa:physical?0:252,spd:0,spe:252}:{hp:0,atk:0,def:0,spa:0,spd:0,spe:0};
  return {species:sp,level,ivs:{hp:iv,atk:iv,def:iv,spa:iv,spd:iv,spe:iv},evs,nature:0,ability:(s.abilities||[])[0]||0,item:0,moves:movesFor(sp,level)};
}
// ---- one attacker against one defender
function hits(a,d,field){
  let best=Infinity,oneShot=false,superEff=false;
  const hp=C.stats(D,d).hp;
  for(const m of a.moves){
    const mv=D.moves[m];
    if(!mv||mv.category==='status'||!(mv.power>1||/DAMAGE|LEVEL|SUPER_FANG/.test(mv.sourceEffect||'')))continue;
    let r;try{r=C.calculate(D,a,d,m,field);}catch(e){continue;}
    if(!r||r.error||!r.rolls||r.status)continue;
    const avg=mean(r.rolls);
    if(avg<=0)continue;
    const acc=(mv.accuracy>0?mv.accuracy:100)/100;
    const need=Math.ceil(hp/avg)/acc;
    if(need<best)best=need;
    if(r.max>=hp&&acc>=.7)oneShot=true;
    if((r.eff||1)>1)superEff=true;
  }
  return {hits:best,oneShot,superEff};
}
const SPREAD=m=>[8,32].includes(D.moves[m]?.target);
const name=m=>(D.moves[m]?.symbol||'').replace('MOVE_','');
const SUPPORT=/^(TAILWIND|TRICK_ROOM|FAKE_OUT|PROTECT|DETECT|FOLLOW_ME|RAGE_POWDER|HELPING_HAND|REFLECT|LIGHT_SCREEN|AURORA_VEIL)$/;

function fight(trainer,pool,level){
  const foes=[...trainer.party];
  const partner=trainer.partnerId&&byId.get(trainer.partnerId);
  if(partner)foes.push(...partner.party);
  const field={doubles:true};
  const rows=[];
  for(const f of foes){
    const fh=[],yh=[];let shots=0,fast=0,se=0,n=0;
    const fs_=C.speed(D,f,{});
    for(const p of pool){
      const pm=p;
      const a=hits(f,pm,field),b=hits(pm,f,field);
      if(a.hits<Infinity)fh.push(a.hits);else fh.push(12);
      if(b.hits<Infinity)yh.push(b.hits);else yh.push(12);
      if(a.oneShot)shots++;
      if(a.superEff)se++;
      if(fs_>C.speed(D,pm,{}))fast++;
      n++;
    }
    rows.push({foeHits:median(fh),yourHits:pct(yh,1/3),oneShot:shots/n,outsped:fast/n,superEff:se/n,
      spread:f.moves.some(SPREAD),support:f.moves.some(m=>SUPPORT.test(name(m)))});
  }
  const A=mean(rows.map(r=>r.foeHits)),B=mean(rows.map(r=>r.yourHits));
  const teamClear=rows.reduce((x,r)=>x+r.yourHits,0)/2;   // two attackers on your side
  return {foes:foes.length,ace:Math.max(...foes.map(f=>f.level)),foeHits:A,yourHits:B,ratio:A/B,
    oneShot:mean(rows.map(r=>r.oneShot)),outsped:mean(rows.map(r=>r.outsped)),superEff:mean(rows.map(r=>r.superEff)),
    spread:mean(rows.map(r=>r.spread?1:0)),support:mean(rows.map(r=>r.support?1:0)),teamClear,
    race:(A*6/2)/teamClear}; // turns to wipe your six / turns to clear theirs
}

// ---- walk the story
const starters=['TREECKO','TORCHIC','MUDKIP'].map(n=>Object.values(D.species).find(s=>s.symbol==='SPECIES_'+n).id);
const seen=new Set(starters);
const LAND=new Set(['Land','Grass','Surf','Water','Rock Smash','Old Rod','Good Rod','Super Rod','Fishing']);
const wildBy={};
for(const w of D.wild){(wildBy[w.map]=wildBy[w.map]||[]).push(w);}
function poolAt(level,trained){
  const lines=new Map();
  for(const sp of seen){
    const e=evolved(sp,level);
    if(!lines.has(e))lines.set(e,D.species[e]);
  }
  return [...lines.values()].filter(s=>!s.excluded).sort((a,b)=>bst(b)-bst(a)).slice(0,16)
    .map(s=>playerMon(s.id,level,trained)).filter(p=>p.moves.length);
}
const out={version:D.meta.campaignVersion,chapters:[]};
for(const ch of D.routeGuide){
  const c={title:ch.title,cap:ch.cap,bosses:[],routes:{casual:[],trained:[]}};
  const bossIds=new Set(ch.bosses||[]);
  const done=new Set();
  for(const st of ch.steps||[]){
    for(const m of st.maps||[])for(const w of wildBy[m]||[])for(const s of w.slots||[])if(D.species[s.species])seen.add(s.species);
    for(const raw of st.trainers||[]){
      const id=typeof raw==='object'?raw.id:raw;
      const t=byId.get(id);
      if(!t||!t.party||!t.party.length||done.has(id)||t.partnerOf)continue;
      done.add(id);
      const ace=Math.max(...t.party.map(f=>f.level));
      const level=Math.min(ch.cap,ace+1);
      const casual=fight(t,poolAt(level,false),level),trained=fight(t,poolAt(level,true),level);
      const boss=bossIds.has(id)||t.party.some(f=>(f.evs.hp+f.evs.atk+f.evs.def+f.evs.spa+f.evs.spd+f.evs.spe)>=500);
      if(boss)c.bosses.push({name:t.displayName,casual,trained});
      else{c.routes.casual.push(casual);c.routes.trained.push(trained);}
    }
  }
  out.chapters.push(c);
}
const f=process.argv[2]||path.resolve(__dirname,'../generated/handbook/difficulty.json');
fs.writeFileSync(f,JSON.stringify(out));
const fmt=r=>`${r.foes}\t${r.ace}\t${r.foeHits.toFixed(2)}\t${r.yourHits.toFixed(2)}\t${r.ratio.toFixed(2)}\t${(r.oneShot*100).toFixed(0)}%\t${(r.outsped*100).toFixed(0)}%\t${(r.superEff*100).toFixed(0)}%\t${(r.spread*100).toFixed(0)}%\t${r.teamClear.toFixed(1)}\t${r.race.toFixed(2)}`;
const avg=list=>{const o={};for(const k of ['foes','ace','foeHits','yourHits','ratio','oneShot','outsped','superEff','spread','support','teamClear','race'])o[k]=mean(list.map(x=>x[k]));return o;};
for(const c of out.chapters){
  console.log(`\n## ${c.title} (cap ${c.cap})  routes ${c.routes.casual.length}, bosses ${c.bosses.length}`);
  console.log('who\tprofile\tfoes\tace\tfoeHits\tyourHits\tratio\t1shot\toutsped\tSE\tspread\tclear\trace');
  if(c.routes.casual.length){console.log('ROUTES\tcasual\t'+fmt(avg(c.routes.casual)));console.log('ROUTES\ttrained\t'+fmt(avg(c.routes.trained)));}
  for(const b of c.bosses){console.log(b.name+'\tcasual\t'+fmt(b.casual));console.log(b.name+'\ttrained\t'+fmt(b.trained));}
}
