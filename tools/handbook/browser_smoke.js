(async()=>{
 const params=new URLSearchParams(location.search),checks=[],errors=window.smokeErrors||[];
 const ok=(v,label)=>{if(!v)throw Error(label);checks.push(label);};
 const $=id=>document.getElementById(id),change=(el,value,event='change')=>{el.value=value;el.dispatchEvent(new Event(event,{bubbles:true}));};
 const sleep=ms=>new Promise(r=>setTimeout(r,ms));
 const search=async q=>{change($('search'),q,'input');await sleep(250);};
 const openStep=si=>{const d=document.querySelector(`#chapter details[data-step="${si}"]`);d.open=true;d.dispatchEvent(new Event('toggle'));return d;};
 // the sync file verify_campaign_qol.lua wrote, with extra flags: chapter 1's first trainers beaten, one item found
 const syncWith=extra=>{const v=JSON.parse(window.syncSample);v.flags.push(...extra);return JSON.stringify(v);};
 try{
  const G=window.GuideTest;ok(G,'Guide boots from a local HTML file');
  const D=G.data,ch0=D.routeGuide[0],rox=D.trainers.find(t=>t.symbol==='TRAINER_ROXANNE_1'),roxStep=ch0.steps.findIndex(s=>s.trainers.includes(rox.id));
  if(params.has('preview')){
   const view=params.get('preview');
   if(params.has('sync'))G.loadSync(syncWith([...ch0.steps.slice(0,6).flatMap(s=>s.trainers).map(id=>0x500+id),...D.sources.filter(x=>x.flag&&ch0.steps[3].maps.includes(x.map)).slice(0,1).map(x=>x.flag)]),true);
   if(params.has('team')){const a=G.state.a;G.state.roster.me=[{...structuredClone(a),species:280,level:15,moves:[52,10,45,98]},{...structuredClone(a),species:286,level:14,moves:[33,45,106,0].filter(Boolean)}];G.state.roster.partner=[{...structuredClone(a),species:283,level:15,moves:[55,33,45,189]},{...structuredClone(a),species:288,level:14,moves:[33,43,44].filter(Boolean)}];}
   G.state.chapter=Number(params.get('chapter')||0);
   if(view==='results'){$('search').value=params.get('q')||'Roxanne';G.show('results');return;}
   G.show(view);
   if(view==='guide')for(const i of (params.get('open')||'').split(',').filter(Boolean))openStep(i);
   if(params.has('battle')){G.openBattle(rox.id);if(params.get('battle')!=='hits')document.querySelector(`[data-bview="${params.get('battle')}"]`).click();}
   return;
  }
  if(sessionStorage.getItem('smokeReload')){
   ok(G.state.notes['0.1']==='Catch a Wurmple for the pair.','Stop notes survive reload');
   ok(G.state.planned['0.1']?.mine==='Treecko','Planned encounters survive reload');
   ok(G.sync&&G.sync.player.name,'The loaded game survives reload');
   ok(G.state.roster.me.length>0,'Teams survive reload');
   checks.push(...JSON.parse(sessionStorage.getItem('smokeChecks')));sessionStorage.removeItem('smokeReload');
  }else{
   localStorage.removeItem('emerald-field-guide-v1');localStorage.removeItem('emerald-field-guide-sync');
   ok(!document.querySelector('.tabs'),'One page: no separate tabs');
   // calculator
   G.show('calculator');ok($('result').textContent.includes('HP'),'Calculator renders damage');
   change(document.querySelector('[data-mon="a"][data-key="level"]'),'30');ok(G.state.a.level===30,'Calculator edits change state');
   change(document.querySelector('[data-mon="a"][data-move-slot="0"]'),'Ember');ok(G.state.a.moves[0]===Object.values(D.moves).find(m=>m.name==='Ember').id,'Edit a move slot');
   const levelA=G.state.a.level;$('swap-sides').click();ok(G.state.d.level===levelA,'Swap sides');$('swap-sides').click();
   // search
   await search('Roxanne');ok(document.querySelector('#results.active')&&$('results-body').querySelector('.trainer'),'Search finds trainers');
   const load=$('results-body').querySelector('[data-load$=":d"]'),[id,i]=load.dataset.load.split(':');
   const expected=D.trainers.find(t=>String(t.id)===id).party[Number(i)];load.click();
   ok(G.state.d.species===expected.species&&G.state.d.level===expected.level,'A searched trainer loads the exact defender');
   await search('Route 101');const stopBtn=$('results-body').querySelector('.result-stop');ok(stopBtn,'Search finds stops');
   stopBtn.click();ok(document.querySelector('#guide.active')&&document.querySelector('#chapter details[open]')&&$('search').value==='','A stop result opens that stop in the guide');
   await search('Rare Candy');ok($('results-body').textContent.includes('Rare Candy'),'Search finds items');
   await search('Zigzagoon');ok($('results-body').textContent.includes('Wild Pokémon')&&$('results-body').querySelector('[data-goto]'),'Search finds where to catch a Pokémon');
   await search('qqzzxx');ok($('results-body').querySelector('.empty'),'Empty search result');
   $('search-clear').click();ok(document.querySelector('#guide.active'),'Back to the route guide');
   // guide
   ok(document.querySelectorAll('#chapters [data-chapter]').length===D.routeGuide.length,'Route guide lists every chapter');
   document.querySelector('#chapters [data-chapter="1"]').click();ok(G.state.chapter===1&&$('chapter').textContent.includes('Brawly'),'Chapter navigation');
   const brawly=D.routeGuide[1].steps.findIndex(s=>s.trainers.some(id=>D.trainers.find(t=>t.id===id).symbol==='TRAINER_BRAWLY_1'));
   const step=openStep(brawly);ok(step.querySelector('.step-body').textContent.includes('Brawly')&&step.querySelectorAll('.mi').length>3,'Opening a stop shows its trainers with icons');
   ok(step.querySelector('.boss-prep'),'Gym stops have boss prep');
   step.querySelector('[data-done]').click();ok(G.state.guideDone['1.'+brawly],'Mark a guide stop done');
   const shopCh=D.routeGuide.findIndex(c=>c.steps.some(s=>D.shops.some(x=>s.maps.includes(x.map)))),shopSi=D.routeGuide[shopCh].steps.findIndex(s=>D.shops.some(x=>s.maps.includes(x.map)));
   document.querySelector(`#chapters [data-chapter="${shopCh}"]`).click();ok(openStep(shopSi).querySelector('.shop .chip'),'Stops list shop stock at your badges');
   const reCh=D.routeGuide.findIndex(c=>c.steps.some(s=>s.trainers.some(id=>G.rematches[id]))),reSi=D.routeGuide[reCh].steps.findIndex(s=>s.trainers.some(id=>G.rematches[id]));
   document.querySelector(`#chapters [data-chapter="${reCh}"]`).click();ok(openStep(reSi).querySelector('.rematches .trainer'),'Stops list rematch teams');
   document.querySelector('#chapters [data-chapter="0"]').click();
   const r103=ch0.steps.findIndex(s=>s.title==='Route 103'),rs=openStep(r103);
   ok(rs.querySelectorAll('.trainer').length===1,'Rival variants fold into one card');
   document.querySelector('#rival-starter [data-rival-starter="MUDKIP"]').click();
   ok(document.querySelector(`details[data-step="${r103}"] .mon b`).textContent==='Treecko','Rival card follows the chosen starter');
   // notes, planned encounters, item checklist
   const s1=openStep(1);
   change(s1.querySelector('[data-note]'),'Catch a Wurmple for the pair.','input');ok(G.state.notes['0.1']==='Catch a Wurmple for the pair.','Write a stop note');
   change(s1.querySelector('[data-plan][data-who="mine"]'),'Treecko','input');change(s1.querySelector('[data-plan][data-who="partner"]'),'Torchic','input');
   ok(G.state.planned['0.1'].partner==='Torchic','Plan both players’ encounters');
   const itemSi=ch0.steps.findIndex(s=>D.sources.some(x=>x.flag&&s.maps.includes(x.map))),idd=openStep(itemSi),box=idd.querySelector('[data-item-got]');
   box.click();ok(G.state.gotItems[box.dataset.itemGot]&&box.closest('li').classList.contains('got'),'Tick an item off by hand');
   // teams
   ok($('roster-panel').querySelector('[data-roster-add="me"]'),'Team panel offers to add Pokémon');
   G.show('calculator');change(document.querySelector('[data-mon="a"][data-key="species"]'),'Torchic');change(document.querySelector('[data-mon="a"][data-key="level"]'),'15');
   document.querySelector('#attacker-card [data-roster-add="me"]').click();ok(G.state.roster.me.length===1&&G.state.roster.me[0].species===280,'Add the attacker to your team');
   change(document.querySelector('[data-mon="a"][data-key="level"]'),'16');ok(G.state.roster.me[0].level===16,'Edits save back to the team');
   change(document.querySelector('[data-mon="a"][data-key="species"]'),'Mudkip');document.querySelector('#attacker-card [data-roster-add="partner"]').click();
   ok(G.state.roster.partner[0]?.species===283,'Add a Pokémon to the partner’s team');
   // battle plan
   document.querySelector(`[data-battle="${rox.id}"]`)||G.show('guide');
   G.openBattle(rox.id);const bp=$('battle');
   ok(!bp.hidden&&bp.querySelector('.matchups tbody tr')&&bp.querySelectorAll('.matchups td.cell').length>=2,'Battle plan shows your hits');
   ok(bp.querySelectorAll('[data-foe-toggle].on').length===2,'Two foes start on the field');
   ok(bp.querySelectorAll('[data-my-toggle].on').length===2,'Both players’ leads are active');
   bp.querySelector('[data-bview="taken"]').click();ok(bp.querySelectorAll('.matchups tbody tr').length===rox.party.length,'Their hits list every foe');
   bp.querySelector('[data-bview="speed"]').click();const order=()=>[...bp.querySelectorAll('.speed-order strong')].map(x=>+x.textContent);
   const fast=order();ok(fast.length===4&&fast.every((v,i)=>!i||fast[i-1]>=v),'Speed order lists the four active Pokémon fastest first');
   $('bf-tr').click();const tr=order();ok(tr.every((v,i)=>!i||tr[i-1]<=v),'Trick Room reverses the order');$('bf-tr').click();
   const before=order();bp.querySelector('[data-par]').click();ok(order().reduce((a,b)=>a+b)<before.reduce((a,b)=>a+b),'Paralysis slows a Pokémon');
   bp.querySelector('[data-bview="hits"]').click();bp.querySelector('[data-foe-toggle]').click();ok(bp.querySelectorAll('[data-foe-toggle].on').length===1,'Change who stands on the field');
   const cell=bp.querySelector('td.cell[data-calc]'),[,,mv]=cell.dataset.calc.split('|');cell.click();
   ok(document.querySelector('#calculator.active')&&G.state.move===+mv&&G.state.d.species===rox.party[0].species,'A battle-plan cell opens in the calculator');
   G.show('guide');$('battle-close').click();ok(bp.hidden,'Close the battle plan');
   // export / import
   let blob;const oldURL=URL.createObjectURL,oldClick=HTMLAnchorElement.prototype.click;
   URL.createObjectURL=b=>{blob=b;return 'blob:smoke';};HTMLAnchorElement.prototype.click=function(){};
   $('export-notes').click();URL.createObjectURL=oldURL;HTMLAnchorElement.prototype.click=oldClick;
   const exported=JSON.parse(await blob.text());ok(exported.format==='emerald-field-guide-notes'&&exported.notes['0.1']&&exported.roster.me.length===1,'Export notes and teams');
   G.state.notes={};const transfer=new DataTransfer();transfer.items.add(new File([JSON.stringify(exported)],'notes.json',{type:'application/json'}));$('import-file').files=transfer.files;
   window.confirm=()=>true;await $('import-file').onchange();
   ok(G.state.notes['0.1']==='Catch a Wurmple for the pair.'&&G.state.roster.partner[0]?.species===283,'Import restores notes and both teams');
   const legacy=G.validateNotes({format:'emerald-field-guide-plan',schema:1,plan:{stops:[{map:'EM_ROUTE104',notes:'old note'}]}});ok(legacy.legacy?.length===1,'Old plan files still import');
   let rejected=false;try{G.validateNotes({format:'nope'});}catch{rejected=true;}ok(rejected,'A foreign notes file is refused');
   // game sync
   const snap=JSON.parse(window.syncSample),item=D.sources.find(x=>x.flag&&ch0.steps[itemSi].maps.includes(x.map));
   const linkStep=ch0.steps.findIndex(s=>s.maps.some(m=>D.maps[m].mapsec===snap.soulLink.rows[0].a));
   ok(G.loadSync(syncWith([item.flag,...ch0.steps[roxStep].trainers.map(id=>0x500+id)]))&&G.sync.party.length===1,'Load a game sync file');
   ok(!G.loadSync('{"format":"nope"}'),'A foreign sync file is refused');
   // dropping the file on the page loads it too (Chrome's picker refuses AppData on Windows)
   {const dt=new DataTransfer();dt.items.add(new File([syncWith([item.flag])],'guide-sync.bin'));window.dispatchEvent(new DragEvent('drop',{dataTransfer:dt,cancelable:true}));await sleep(300);
    ok(G.sync&&G.sync.flags.includes(item.flag)&&!G.sync.flags.includes(0x500+ch0.steps[roxStep].trainers[0]),'Dropping guide-sync.bin on the page loads it');
    ok(G.loadSync(syncWith([item.flag,...ch0.steps[roxStep].trainers.map(id=>0x500+id)])),'Load the full sync again');}
   ok($('sync-win-path').textContent==='%APPDATA%\\pokemon-love2d\\mod_storage\\emerald','The help names the Windows folder to paste');
   ok($('sync-chip').textContent.includes('1 badge'),'Header shows the loaded game');
   ok(G.state.roster.me[0].species===snap.party[0][0]&&G.state.roster.me[0].ivs.spa===snap.party[0][8]&&G.state.roster.me[0].evs.spe===snap.party[0][16],'Your team follows the game with its IVs and EVs');
   ok(G.state.roster.partner[0].species===snap.partner.party[0][0],'The partner’s team comes from co-op');
   G.show('guide');ok(G.state.chapter===1,'Guide jumps to the chapter you are on');
   ok(document.querySelector('#chapters [data-chapter="0"] .num').textContent==='✓','Chapters with their badge are done');
   document.querySelector('#chapters [data-chapter="3"]').click();ok($('chapter').textContent.includes('reached this chapter yet')&&!$('chapter').querySelector('.trainer'),'Chapters past your badges stay hidden');
   $('chapter').querySelector('[data-reveal]').click();ok(document.querySelector('#chapter details.step'),'Reveal a hidden chapter');
   await search('Wattson');ok($('results-note').textContent.includes('past your badges hidden')&&!$('results-body').querySelector('.trainer'),'Search hides spoilers');
   $('search-clear').click();document.querySelector('#chapters [data-chapter="0"]').click();
   const rd=openStep(roxStep);ok(rd.querySelector('.trainer.beaten .pill.won'),'Beaten trainers are marked');ok(rd.querySelector('.step-num').textContent==='✓','A stop with every trainer beaten is done');
   ok(openStep(itemSi).querySelector('[data-item-got]:disabled'),'Items picked up in the game are ticked');
   const ld=openStep(linkStep);ok(ld.querySelector('.link-row')&&ld.textContent.includes('ZIGGY'),'Soul Link pairs show on their stop');
   G.show('calculator');ok(document.querySelector('[data-from-team="d"] option[value="partner:0"]')&&document.querySelector('[data-from-team="d"] option[value^="sync-b:"]'),'Calculator offers both teams and the boxes');
   change(document.querySelector('[data-from-team="d"]'),'partner:0');ok(G.state.d.species===snap.partner.party[0][0],'Load the partner’s Pokémon as defender');
   G.show('guide');
   ok(!errors.length,'No runtime errors');
   sessionStorage.setItem('smokeChecks',JSON.stringify(checks));sessionStorage.setItem('smokeReload','1');location.reload();return;
  }
  ok(!errors.length,'No errors after reload');
  await fetch('__REPORT_URL__',{method:'POST',mode:'cors',headers:{'Content-Type':'text/plain'},body:JSON.stringify({ok:true,checks,errors})});
 }catch(e){await fetch('__REPORT_URL__',{method:'POST',mode:'cors',headers:{'Content-Type':'text/plain'},body:JSON.stringify({ok:false,checks,error:e.stack||String(e),errors})});}
})();
