(async()=>{
 const params=new URLSearchParams(location.search),checks=[],errors=window.smokeErrors||[];
 const ok=(v,label)=>{if(!v)throw Error(label);checks.push(label);};
 const $=id=>document.getElementById(id),change=(el,value,event='change')=>{el.value=value;el.dispatchEvent(new Event(event,{bubbles:true}));};
 try{
  const G=window.GuideTest;ok(G,'Guide boots from a local HTML file');
  if(params.has('preview')){
   const view=params.get('preview');G.state.chapter=Number(params.get('chapter')||0);G.switchTab(view);
   if(view==='guide')for(const i of (params.get('open')||'').split(',').filter(Boolean)){const d=document.querySelector(`details[data-step="${i}"]`);d.open=true;d.dispatchEvent(new Event('toggle'));}
   if(view==='route'){G.addChapter(0);change(document.querySelector('[data-stop-key="mine"]'),'Treecko','input');change(document.querySelector('[data-stop-key="partner"]'),'Torchic','input');}
   if(view==='trainers'){change($('trainer-filter'),'authored');}
   return;
  }
  if(sessionStorage.getItem('smokeReload')){
   ok(G.state.plan.name==='Shared Hoenn plan','Plan name survives reload');
   ok(G.state.plan.stops.some(s=>s.mine==='Treecko'&&s.partner==='Torchic'),'Both players’ encounter notes survive reload');
   checks.push(...JSON.parse(sessionStorage.getItem('smokeChecks')));sessionStorage.removeItem('smokeReload');
   G.switchTab('calculator');
  }else{
   localStorage.removeItem('emerald-field-guide-v1');G.state.plan={name:'Our Hoenn run',stops:[]};
   G.switchTab('calculator');ok($('result').textContent.includes('HP'),'Calculator renders damage');
   change(document.querySelector('[data-mon="a"][data-key="level"]'),'30');ok(G.state.a.level===30,'Calculator edits change state');
   const levelA=G.state.a.level;$('swap-sides').click();ok(G.state.d.level===levelA,'Swap sides');
   G.switchTab('trainers');change($('trainer-search'),'Roxanne','input');
   ok($('trainer-results').querySelectorAll('[data-load]').length>0&&$('trainer-results').querySelector('.mi'),'Trainer search finds roster with icons');
   const load=$('trainer-results').querySelector('[data-load$=":d"]'),[id,i]=load.dataset.load.split(':');
   const expected=G.data.trainers.find(t=>String(t.id)===id).party[Number(i)];load.click();
   ok(G.state.d.species===expected.species&&G.state.d.level===expected.level,'Trainer loads exact defender');
   G.switchTab('wild');change($('wild-search'),'Route 101','input');
   ok($('wild-results').textContent.includes('Route 101'),'Wild location search');
   $('wild-results').querySelector('[data-add-map]').click();ok(G.state.plan.stops[0].map==='EM_ROUTE101','Encounter adds route reminder');
   G.switchTab('items');
   for(const kind of new Set(G.data.sources.map(s=>s.kind))){change($('item-kind'),kind);ok(!$('item-results').querySelector('.empty'),'Item source filter: '+kind);}
   change($('item-kind'),'Poké Mart');change($('badges'),'8');
   const count=new Set(G.data.sources.filter(s=>s.kind==='Poké Mart'&&(s.badges?s.badges.includes(8):s.minBadges==null||s.minBadges<=8)).map(s=>s.item)).size;
   ok($('item-count').textContent.startsWith(count+' items'),'Exact badge-dependent shop stock');
   change($('item-kind'),'');change($('item-search'),'Rare Candy','input');
   ok($('item-results').textContent.includes('Rare Candy'),'Item search');
   G.state.plan.stops=[];G.switchTab('guide');
   ok(document.querySelectorAll('#chapters [data-chapter]').length===G.data.routeGuide.length,'Route guide lists every chapter');
   document.querySelector('#chapters [data-chapter="1"]').click();ok(G.state.chapter===1&&$('chapter').textContent.includes('Brawly'),'Chapter navigation');
   const brawly=G.data.routeGuide[1].steps.findIndex(s=>s.trainers.some(id=>G.data.trainers.find(t=>t.id===id).symbol==='TRAINER_BRAWLY_1'));
   const step=document.querySelector(`details[data-step="${brawly}"]`);step.open=true;step.dispatchEvent(new Event('toggle'));
   ok(step.querySelector('.step-body').textContent.includes('Brawly')&&step.querySelectorAll('.mi').length>3,'Opening a stop shows its trainers with icons');
   step.querySelector('[data-done]').click();ok(G.state.guideDone['1.'+brawly],'Mark a guide stop done');
   document.querySelector('#chapters [data-chapter="0"]').click();
   const r103=G.data.routeGuide[0].steps.findIndex(s=>s.title==='Route 103'),rs=document.querySelector(`details[data-step="${r103}"]`);rs.open=true;rs.dispatchEvent(new Event('toggle'));
   ok(rs.querySelectorAll('.trainer').length===1,'Rival variants fold into one card');
   document.querySelector('#rival-starter [data-rival-starter="MUDKIP"]').click();
   ok(document.querySelector(`details[data-step="${r103}"] .trainer h3`)&&document.querySelector(`details[data-step="${r103}"] .mon b`).textContent==='Treecko','Rival card follows the chosen starter');
   G.switchTab('route');G.addChapter(0);
   ok(G.state.plan.stops.length===G.data.routeGuide[0].steps.length,'Chapter stops added to the plan');
   ok(G.state.plan.stops.every(s=>G.data.maps[s.map]),'Every added stop is a real map');
   G.state.plan.stops=G.state.plan.stops.slice(0,10);G.renderRoute();
   const first=G.state.plan.stops[0].id;document.querySelector('[data-action="down"]').click();ok(G.state.plan.stops[1].id===first,'Reorder route stops');
   const name=G.data.maps[G.state.plan.stops[0].map].name;change($('route-map'),name);$('add-stop').click();ok(G.state.plan.stops.length===11,'Manually add a return visit');
   change($('plan-name'),'Shared Hoenn plan','input');
   change(document.querySelector('[data-stop-key="mine"]'),'Treecko','input');change(document.querySelector('[data-stop-key="partner"]'),'Torchic','input');
   change(document.querySelector('[data-stop-key="notes"]'),'Collect the item, heal, then prepare the pair.','input');
   document.querySelector('[data-action="done"]').click();ok($('plan-progress').textContent==='1 of 11 stops completed','Mark route stop complete');
   let blob;const oldURL=URL.createObjectURL,oldClick=HTMLAnchorElement.prototype.click;
   URL.createObjectURL=b=>{blob=b;return 'blob:smoke';};HTMLAnchorElement.prototype.click=function(){};
   $('export-route').click();URL.createObjectURL=oldURL;HTMLAnchorElement.prototype.click=oldClick;
   const exported=JSON.parse(await blob.text());ok(exported.format==='emerald-field-guide-plan'&&exported.plan.stops.length===11,'Export actual plan JSON');
   const transfer=new DataTransfer();transfer.items.add(new File([JSON.stringify(exported)],'plan.json',{type:'application/json'}));$('import-file').files=transfer.files;
   window.confirm=()=>true;await $('import-file').onchange();
   ok(G.state.plan.stops[0].mine==='Treecko'&&G.state.plan.stops[0].partner==='Torchic','Import restores both players and route');
   let rejected=false;try{G.validatePlan({format:'emerald-field-guide-plan',schema:1,plan:{stops:[{map:'bogus'}]}});}catch{rejected=true;}ok(rejected,'Invalid imported map is rejected');
   ok(!errors.length,'No runtime errors');
   sessionStorage.setItem('smokeChecks',JSON.stringify(checks));sessionStorage.setItem('smokeReload','1');location.reload();return;
  }
  ok(!errors.length,'No errors after reload');
  await fetch('__REPORT_URL__',{method:'POST',mode:'cors',headers:{'Content-Type':'text/plain'},body:JSON.stringify({ok:true,checks,errors})});
 }catch(e){await fetch('__REPORT_URL__',{method:'POST',mode:'cors',headers:{'Content-Type':'text/plain'},body:JSON.stringify({ok:false,checks,error:e.stack||String(e),errors})});}
})();
