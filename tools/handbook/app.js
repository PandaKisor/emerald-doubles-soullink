(() => {
  'use strict';
  const D = JSON.parse(document.getElementById('guide-data').textContent), C = FieldCalc;
  const $ = id => document.getElementById(id);
  const esc = s => String(s ?? '').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  const clean = s => String(s || '').replace(/^EM_|^ITEM_|^TRAINER_|^SPECIES_|^MOVE_/, '').replaceAll('_',' ').replace(/([a-z])([A-Z])/g,'$1 $2');
  const norm = s => String(s || '').toLowerCase().replace(/[^a-z0-9]/g,'');
  const name = (kind,id) => D[kind]?.[id]?.displayName || D[kind]?.[id]?.name || ('#' + id);
  const species = Object.values(D.species).filter(s=>!s.excluded && s.id>0).sort((a,b)=>name('species',a.id).localeCompare(name('species',b.id)));
  const moves = Object.values(D.moves).filter(m=>m.supported!==false && m.id>0).sort((a,b)=>a.name.localeCompare(b.name));
  const items = Object.values(D.items).filter(i=>i.id>0).sort((a,b)=>a.name.localeCompare(b.name));
  const trainers = D.trainers.filter(t=>!t.phantom && t.party.length>0);
  const trainerById = Object.fromEntries(D.trainers.map(t=>[t.id,t]));
  const maps = Object.values(D.maps).filter(m=>m.id).sort((a,b)=>a.name.localeCompare(b.name));
  const typeColors = ['#8f9676','#b87955','#899ac0','#a178a7','#b39b66','#9b9269','#829344','#777f9e','#7a999a','#999','#c97c48','#6e98ae','#7ca166','#b8a344','#b98291','#81adad','#7884b2','#77776c','#bf91a5'];
  const typePills = types => [...new Set(types)].map(t=>`<span class="type" style="--type:${typeColors[t]}">${esc(D.types[t])}</span>`).join('');
  const fullStats = (val) => Object.fromEntries(C.keys.map(k=>[k,val]));
  function freshMon(id,level=15) { const s=D.species[id];return {species:+id,level,ivs:fullStats(31),evs:fullStats(0),stages:fullStats(0),nature:0,ability:s.abilities[0]||0,item:0,status:'',hp:null,moves:s.learnset.filter(r=>r[0]<=level).slice(-4).map(r=>r[1]),friendship:255}; }
  const roxanne = trainers.find(t=>t.symbol==='TRAINER_ROXANNE_1');
  const baseState = {a:freshMon(277),d:roxanne?{...freshMon(roxanne.party[0].species),...roxanne.party[0],stages:fullStats(0),hp:null}:freshMon(74),move:71,field:{doubles:true,spread:false,crit:false,weather:'',terrain:'',power:null},badges:0,plan:{name:'Our Hoenn run',stops:[]}};
  const KEY='emerald-field-guide-v1';
  let state=baseState, storageOk=true, timer, currentTab='calculator';
  try {const raw=localStorage.getItem(KEY);if(raw){const s=JSON.parse(raw);if(s.a && s.d && D.species[s.a.species] && D.species[s.d.species] && s.plan?.stops && Array.isArray(s.plan.stops))state={...baseState,...s,field:{...baseState.field,...s.field}};}} catch {storageOk=false;}
  function save(){try{localStorage.setItem(KEY,JSON.stringify(state));$('save-state').textContent='Saved on this browser';}catch{storageOk=false;$('save-state').textContent='Use Export to keep your plan';}}
  if(!storageOk)$('save-state').textContent='Use Export to keep your plan';
  function toast(message){$('toast').textContent=message;$('toast').classList.add('show');clearTimeout(timer);timer=setTimeout(()=>$('toast').classList.remove('show'),2800);}
  function lookup(rows,value){const n=norm(value);return rows.find(r=>norm(r.displayName||r.name)===n)||rows.find(r=>String(r.id)===value);}
  function list(id,rows){$(id).innerHTML=rows.map(r=>`<option value="${esc(r.displayName||r.name)}"></option>`).join('');}
  list('species-list',species);list('move-list',moves);list('item-list',items);list('map-list',maps);
  $('version').textContent=D.meta.campaignVersion;
  function options(rows,selected){return rows.map(([id,label])=>`<option value="${esc(id)}" ${String(id)===String(selected)?'selected':''}>${esc(label)}</option>`).join('');}
  function switchTab(tab){if(!$(tab)?.classList.contains('page'))tab='calculator';currentTab=tab;document.querySelectorAll('.page').forEach(p=>p.classList.toggle('active',p.id===tab));document.querySelectorAll('[data-tab]').forEach(b=>b.classList.toggle('active',b.dataset.tab===tab));$('section-name').textContent=({calculator:'Fight calculator',trainers:'Trainer teams',wild:'Wild encounters',items:'Item finder',route:'Route planner'})[tab];history.replaceState(null,'','#'+tab);if(tab==='trainers')renderTrainers();if(tab==='wild')renderWild();if(tab==='items')renderItems();if(tab==='route')renderRoute();}
  document.querySelectorAll('[data-tab]').forEach(b=>b.addEventListener('click',()=>switchTab(b.dataset.tab)));
  function card(side){
    const m=state[side], sp=D.species[m.species], st=C.stats(D,m), isA=side==='a';
    const abilityRows=[[0,'No ability'],...sp.abilities.filter(x=>x>0).map(id=>[id,name('abilities',id)])];
    if(m.ability && !abilityRows.some(r=>r[0]===m.ability))abilityRows.push([m.ability,name('abilities',m.ability)]);
    return `<div class="combatant-head"><span class="seat"><b>${isA?'A':'B'}</b>${isA?'YOUR ATTACKER':'DEFENDER'}</span><div class="types">${typePills(sp.types)}</div></div>
     <div class="form-grid species-row"><label class="field">Pokémon<input data-mon="${side}" data-key="species" list="species-list" value="${esc(name('species',m.species))}" autocomplete="off"></label><label class="field">Level<input data-mon="${side}" data-key="level" type="number" min="1" max="100" value="${m.level}"></label></div>
     <div class="form-grid"><label class="field">Ability<select data-mon="${side}" data-key="ability">${options(abilityRows,m.ability)}</select></label><label class="field">Held item<input data-mon="${side}" data-key="item" list="item-list" value="${m.item?esc(name('items',m.item)):''}" placeholder="No item"></label></div>
     <div class="form-grid three"><label class="field">Nature<select data-mon="${side}" data-key="nature">${options(Object.entries(D.natures).map(([id,n])=>[id,n.name]),m.nature)}</select></label><label class="field">Current HP<input data-mon="${side}" data-key="hp" type="number" min="1" max="${st.hp}" value="${m.hp??st.hp}" title="Maximum HP: ${st.hp}"></label><label class="field">Status<select data-mon="${side}" data-key="status">${options([['','Healthy'],['BRN','Burn'],['PAR','Paralysis'],['PSN','Poison'],['TOX','Bad poison'],['SLP','Sleep'],['FRZ','Freeze']],m.status)}</select></label></div>
     <div class="stat-row">${C.keys.map(k=>`<div class="stat-cell"><small>${({hp:'HP',atk:'ATK',def:'DEF',spa:'SP. ATK',spd:'SP. DEF',spe:'SPEED'})[k]}</small><strong>${st[k]}</strong></div>`).join('')}</div>
     <details ${m.editOpen?'open':''} data-edit="${side}"><summary>IVs, EVs & stat stages</summary><div class="stat-edit"><span></span>${C.keys.map(k=>`<span>${k.toUpperCase()}</span>`).join('')}${['ivs','evs','stages'].map(group=>`<span>${group==='stages'?'Stage':group==='ivs'?'IVs':'EVs'}</span>${C.keys.map(k=>group==='stages'&&k==='hp'?'<span>—</span>':`<input aria-label="${isA?'Attacker':'Defender'} ${k} ${group}" data-mon="${side}" data-group="${group}" data-key="${k}" type="number" min="${group==='stages'?-6:0}" max="${group==='stages'?6:group==='ivs'?31:252}" value="${m[group]?.[k]||0}">`).join('')}`).join('')}</div><p class="footnote">EV total: ${Object.values(m.evs||{}).reduce((n,v)=>n+Number(v),0)} / 510. Intimidate and other entry changes must be entered as stages.</p><label class="field">Friendship (Return / Frustration)<input data-mon="${side}" data-key="friendship" type="number" min="0" max="255" value="${m.friendship??255}"></label></details>
     <div class="checks"><label><input data-mon="${side}" data-key="tailwind" type="checkbox" ${m.tailwind?'checked':''}> Tailwind</label>${!isA?`<label><input data-mon="${side}" data-key="reflect" type="checkbox" ${m.reflect?'checked':''}> Reflect</label><label><input data-mon="${side}" data-key="lightScreen" type="checkbox" ${m.lightScreen?'checked':''}> Light Screen / Veil</label>`:''}</div>`;
  }
  function renderCombatants(){
    $('attacker-card').innerHTML=card('a');$('defender-card').innerHTML=card('d');$('defender-card').classList.add('enemy');
    document.querySelectorAll('[data-mon]').forEach(el=>el.addEventListener('change',()=>{
      const side=el.dataset.mon, k=el.dataset.key, m=state[side];
      if(k==='species'){const row=lookup(species,el.value);if(!row){toast('Choose a Pokémon from the list.');el.value=name('species',m.species);return;}state[side]=freshMon(row.id,m.level);}
      else if(k==='item'){const row=el.value.trim()?lookup(items,el.value):{id:0};if(!row){toast('Choose an item from the list, or leave it blank.');return;}m.item=row.id;}
      else if(el.dataset.group){m[el.dataset.group]||={};m[el.dataset.group][k]=Math.max(+el.min,Math.min(+el.max,Math.floor(+el.value||0)));}
      else if(el.type==='checkbox')m[k]=el.checked;
      else if(k==='status')m[k]=el.value;
      else {m[k]=Number(el.value);if(el.type==='number')m[k]=Math.max(+el.min,Math.min(+el.max,Math.floor(+el.value||0)));if(['level','nature'].includes(k))m.hp=null;}
      if(side==='a' && k==='species')chooseDefaultMove();renderCalc();save();
    }));
    document.querySelectorAll('[data-edit]').forEach(el=>el.addEventListener('toggle',()=>{state[el.dataset.edit].editOpen=el.open;save();}));
  }
  function chooseDefaultMove(){const found=(state.a.moves||[]).find(id=>D.moves[id]?.category!=='status');if(found)state.move=found;syncSpread();}
  function syncSpread(){state.field.spread=[8,32].includes(D.moves[state.move]?.target);}
  function renderCalc(){renderCombatants();renderMove();syncField();renderResult();}
  function renderMove(){
    const m=D.moves[state.move];$('move-input').value=m?.name||'';
    const suggested=[...new Set([...(state.a.moves||[]),...D.species[state.a.species].learnset.filter(r=>r[0]<=state.a.level).slice(-4).map(r=>r[1])])].filter(id=>D.moves[id]).slice(0,8);
    $('move-quick').innerHTML=suggested.map(id=>`<button class="chip ${id===state.move?'active':''}" data-move="${id}">${esc(name('moves',id))}</button>`).join('');
    $('move-quick').querySelectorAll('[data-move]').forEach(b=>b.onclick=()=>{state.move=+b.dataset.move;syncSpread();renderMove();syncField();renderResult();save();});
    $('move-facts').innerHTML=m?`<div class="move-meta"><span><small>TYPE</small>${typePills([m.type])}</span><span><small>CATEGORY</small>${esc(m.category)}</span><span><small>POWER</small>${m.power||'—'}</span><span><small>ACCURACY</small>${m.accuracy?m.accuracy+'%':'Always'}</span><span><small>PRIORITY</small>${m.priority>0?'+':''}${m.priority}</span></div><p class="footnote">${esc(m.description)}</p>`:'';
  }
  $('move-input').onchange=()=>{const m=lookup(moves,$('move-input').value);if(!m){toast('Choose a move from the list.');return;}state.move=m.id;state.field.power=null;syncSpread();renderMove();syncField();renderResult();save();};
  const fieldKeys=['weather','terrain','power','doubles','spread','crit','helpingHand','permanentWeather','trickRoom'];
  function syncField(){for(const k of fieldKeys){const el=$(k);if(el.type==='checkbox')el.checked=!!state.field[k];else el.value=state.field[k]??'';}}
  for(const k of fieldKeys)$(k).onchange=()=>{const el=$(k);state.field[k]=el.type==='checkbox'?el.checked:k==='power'?(el.value?Math.max(1,Math.min(999,Number(el.value))):null):el.value;renderResult();save();};
  $('reset-field').onclick=()=>{state.field={doubles:true,weather:'',terrain:'',crit:false};syncSpread();syncField();renderResult();save();};
  $('swap-sides').onclick=()=>{[state.a,state.d]=[state.d,state.a];chooseDefaultMove();renderCalc();save();};
  const pct = n => (n*100).toFixed(n===0||n===1?0:1)+'%';
  function renderResult(){
    const r=C.calculate(D,state.a,state.d,state.move,state.field), move=D.moves[state.move];
    const prefix=`<p class="eyebrow">MATCHUP RESULT</p><h2>${esc(move?.name||'Choose a move')}</h2>`;
    if(r.error||r.status){$('result').innerHTML=prefix+`<p class="result-placeholder">${esc(r.error||'No direct damage')}</p><p>${esc(r.notes?.join(' ')||'Change the move or provide the required context.')}</p>`;return;}
    const speedA=C.speed(D,state.a,state.field),speedD=C.speed(D,state.d,state.field);
    const first=speedA===speedD?'Speed tie':(state.field.trickRoom?speedA<speedD:speedA>speedD)?name('species',state.a.species):name('species',state.d.species);
    const multi=(move.runtime?.hits>1)||/MULTI_HIT|DOUBLE_HIT|TRIPLE_KICK/.test(move.sourceEffect||'')||/SURGING_STRIKES|DRAGON_DARTS|TRIPLE_AXEL/.test(move.symbol||'');
    const warnings=[...new Set(r.warnings||[])];
    $('result').innerHTML=prefix+`<div class="damage-range">${r.min===r.max?r.min:r.min+'–'+r.max}<small>HP${multi?' / hit':''}</small></div><div class="damage-pct">${pct(r.min/r.ds.hp)} – ${pct(r.max/r.ds.hp)} of max HP</div><div class="hp-bar"><div class="max" style="width:${Math.min(100,r.max/r.dhp*100)}%"></div><div class="min" style="width:${Math.min(100,r.min/r.dhp*100)}%"></div></div><div class="bar-label"><span>Damage to current HP</span><span>${r.dhp} / ${r.ds.hp} HP</span></div>
      <div class="result-metrics"><div><small>${multi?'ONE-HIT KO':'ONE-ATTACK KO'} · IF IT HITS</small><strong>${pct(r.ko)}</strong></div><div><small>TYPE EFFECTIVENESS</small><strong>${r.eff}×</strong></div><div><small>SPEED A / B</small><strong>${speedA} / ${speedD}</strong></div><div><small>${state.field.trickRoom?'TRICK ROOM ORDER':'SAME-PRIORITY ORDER'}</small><strong style="font-size:13px">${esc(first)}</strong></div></div>
      <ul class="result-notes"><li>${r.spread?'Spread reduction applied (multiple targets).':'Single-target damage; no spread reduction.'}</li><li>${r.critical?'Critical hit; relevant negative Attack and positive Defense stages ignored.':'No critical hit.'}</li><li>KO chance uses 16 equally likely damage rolls, conditional on connecting. Priority and accuracy can change the outcome.</li><li>Partner auras, protection, survival items, healing, recoil, residual damage, and follow-up turns are not simulated.</li></ul>
      ${warnings.length?`<div class="warning">${warnings.map(esc).join('<br>')}</div>`:''}
      <details><summary>Calculation details & all 16 rolls</summary><div class="trace">Power used: ${r.power}. ${r.physical?'Physical':'Special'}${r.fixed?' · fixed damage':''}.<br>Attack stat: ${r.attack??'—'} · Defense stat: ${r.defense??'—'} · Base damage: ${r.base??'—'}.<br>${(r.notes||[]).map(esc).join('<br>')}</div><div class="rolls">${r.rolls.join(' · ')}</div></details>`;
  }
  let trainerLimit=20,wildLimit=20,itemLimit=24;
  const trainerSearch=t=>[t.displayName,t.symbol,...t.maps.map(m=>m.name),...t.party.map(m=>name('species',m.species)),...(trainerById[t.partnerId]?.party||[]).map(m=>name('species',m.species))].join(' ');
  const trainerIndex=new Map(trainers.map(t=>[t.id,norm(trainerSearch(t))]));
  function roster(t,label){return `<div class="${label?'partner-label':''}">${label?esc(label):''}</div><div class="roster">${t.party.map((m,i)=>`<div class="roster-mon"><div class="mon-top"><strong>${esc(name('species',m.species))} <small>Lv. ${m.level}</small></strong><div class="trainer-load"><button class="button small" data-load="${t.id}:${i}:a" title="Load as attacker">→ A</button><button class="button small" data-load="${t.id}:${i}:d" title="Load as defender">→ B</button></div></div><p>${esc(name('abilities',m.ability))} · ${m.item?esc(name('items',m.item)):'No item'} · ${esc(D.natures[m.nature]?.name||'—')}</p><div class="moves">${m.moves.filter(id=>id>0).map(id=>esc(name('moves',id))).join(' / ')}</div><details><summary>Stats, IVs and EVs</summary><div class="trace">${C.keys.map(k=>`${k.toUpperCase()}: ${m.stats[k]} (${m.ivs[k]} IV / ${m.evs[k]} EV)`).join('<br>')}</div></details></div>`).join('')}</div>`;}
  function renderTrainers(){
    const query=norm($('trainer-search').value),filter=$('trainer-filter').value;
    const found=trainers.filter(t=>(!query||trainerIndex.get(t.id).includes(query))&&(filter!=='authored'||t.authored)&&(filter!=='boss'||/ROXANNE|BRAWLY|WATTSON|FLANNERY|NORMAN|WINONA|TATE|LIZA|JUAN|WALLACE|SIDNEY|PHOEBE|GLACIA|DRAKE|STEVEN|MAXIE|ARCHIE|MAY_|BRENDAN_/i.test(t.symbol)));
    $('trainer-count').textContent=`${found.length} trainer teams · ${Math.min(trainerLimit,found.length)} shown. Trainer spoilers included.`;
    $('trainer-results').innerHTML=found.slice(0,trainerLimit).map(t=>`<article class="panel"><div class="trainer-top"><div><p class="eyebrow">${t.authored?'CAMPAIGN TEAM':'VANILLA TEAM'}</p><h3>${esc(t.displayName)}</h3><p class="trainer-meta">${esc(t.maps.map(m=>m.name).join(' · ')||'Location not mapped')}</p><small class="muted">${esc(clean(t.symbol))}</small></div>${t.maps[0]?`<button class="button small" data-add-map="${esc(t.maps[0].id)}" data-note="${esc('Prepare for '+t.displayName)}">+ Route</button>`:''}</div>${roster(t)}${t.partnerId&&trainerById[t.partnerId]?roster(trainerById[t.partnerId],'Doubles partner · '+trainerById[t.partnerId].displayName):''}</article>`).join('')||empty('No trainers found','Try a trainer name, route, or Pokémon.');
    $('trainer-more').hidden=found.length<=trainerLimit;
    $('trainer-results').querySelectorAll('[data-load]').forEach(b=>b.onclick=()=>{const [id,i,side]=b.dataset.load.split(':'),t=trainerById[id],m=t.party[i];state[side]={...freshMon(m.species,m.level),...structuredClone(m),stages:fullStats(0),hp:null};if(side==='a')chooseDefaultMove();renderCalc();save();switchTab('calculator');window.scrollTo(0,0);toast(`${t.displayName}’s ${name('species',m.species)} loaded as ${side==='a'?'attacker':'defender'}.`);});wireAdd($('trainer-results'));
  }
  function empty(title,message){return `<div class="empty"><h3>${esc(title)}</h3><p>${esc(message)}</p></div>`;}
  $('trainer-search').oninput=()=>{trainerLimit=20;renderTrainers();};$('trainer-filter').onchange=$('trainer-search').oninput;$('trainer-more').onclick=()=>{trainerLimit+=20;renderTrainers();};
  const methods=[...new Set(D.wild.map(w=>w.method))].sort();$('wild-method').innerHTML='<option value="">Every method</option>'+options(methods.map(m=>[m,m]),'');
  function renderWild(){
    const q=norm($('wild-search').value),method=$('wild-method').value;
    const found=D.wild.filter(w=>(!method||w.method===method)&&(!q||norm(w.mapName+' '+w.slots.map(s=>name('species',s.species)).join(' ')).includes(q)));
    $('wild-count').textContent=`${found.length} encounter tables · ${new Set(found.map(w=>w.map)).size} maps`;
    $('wild-results').innerHTML=found.slice(0,wildLimit).map(w=>{
      const combined={};for(const s of w.slots){if(!combined[s.species])combined[s.species]={...s};else{const c=combined[s.species];c.weight+=s.weight;c.minLevel=Math.min(c.minLevel,s.minLevel);c.maxLevel=Math.max(c.maxLevel,s.maxLevel);}}
      const rows=Object.values(combined).sort((a,b)=>b.weight-a.weight);
      return `<article class="panel"><div class="trainer-top"><div><p class="eyebrow">${esc(w.method)}${w.variant!=null?' · TABLE '+(Number(w.variant)+1):''}</p><h3>${esc(w.mapName)}</h3></div><button class="button small" data-add-map="${esc(w.map)}" data-note="${esc('Encounter method: '+w.method)}">+ Route</button></div><table class="encounter-table"><thead><tr><th>POKÉMON</th><th>LEVEL</th><th>BASE SHARE</th></tr></thead><tbody>${rows.map(s=>`<tr><td>${esc(name('species',s.species))}</td><td>${s.minLevel===s.maxLevel?s.minLevel:s.minLevel+'–'+s.maxLevel}</td><td>${s.weight}%</td></tr>`).join('')}</tbody></table>${w.emptyWeight?`<p class="footnote">${w.emptyWeight}% empty slot in the runtime table.</p>`:''}${w.note?`<p class="footnote">${esc(w.note)}</p>`:''}</article>`;}).join('')||empty('No encounters found','Try a Pokémon name or a different area.');
    $('wild-more').hidden=found.length<=wildLimit;wireAdd($('wild-results'));
  }
  $('wild-search').oninput=()=>{wildLimit=20;renderWild();};$('wild-method').onchange=$('wild-search').oninput;$('wild-more').onclick=()=>{wildLimit+=20;renderWild();};
  $('badges').innerHTML=options(Array.from({length:9},(_,i)=>[i,i===0?'0 badges':i+' badge'+(i===1?'':'s')]),state.badges);
  const sourceByItem={};for(const s of D.sources){(sourceByItem[s.item]||=[]).push(s);}
  $('item-kind').innerHTML='<option value="">Every source</option>'+options([...new Set(D.sources.map(s=>s.kind))].sort().map(k=>[k,k]),'');
  function sourceAvailable(s){return Array.isArray(s.badges)?s.badges.includes(Number(state.badges)):s.minBadges==null||s.minBadges<=state.badges;}
  function showSource(s){return `<li><div class="source-line"><span class="location">${esc(s.mapName||s.label||'Field menu')}</span>${s.map?`<button class="text-button" data-add-map="${esc(s.map)}" data-note="${esc('Find '+name('items',s.item)+' · '+s.kind+(s.x!=null?' at '+s.x+', '+s.y:''))}">+ Route</button>`:''}</div><div class="location-info"><span class="tag">${esc(s.kind)}</span>${s.x!=null?'Tile '+s.x+', '+s.y:''}${s.minBadges!=null?' · From '+s.minBadges+' badge'+(s.minBadges===1?'':'s'):''}</div>${s.label?`<div class="location-info">${esc(clean(s.label).replace(/Event Script /g,'').replace(/Text /g,''))}</div>`:''}</li>`;}
  function renderItems(){
    const q=norm($('item-search').value),kind=$('item-kind').value;
    const found=items.map(i=>({item:i,sources:(sourceByItem[i.id]||[]).filter(s=>sourceAvailable(s)&&(!kind||s.kind===kind))})).filter(r=>r.sources.length&&(!q||norm(r.item.name+' '+r.item.description+' '+r.sources.map(s=>s.mapName+' '+s.label).join(' ')).includes(q)));
    $('item-count').textContent=`${found.length} items with indexed sources · shops shown for ${state.badges} badges`;
    $('item-results').innerHTML=found.slice(0,itemLimit).map(({item:i,sources:s})=>`<article class="panel"><div class="trainer-top"><div><p class="eyebrow">${esc(clean(i.pocket))}</p><h3>${esc(i.name)}</h3></div><span class="number-pill">${s.length} source${s.length===1?'':'s'}</span></div><p class="footnote">${esc(i.description)}</p><ul class="source-list">${s.slice(0,4).map(showSource).join('')}</ul>${s.length>4?`<details class="source-extra"><summary>Show ${s.length-4} more locations</summary><ul class="source-list">${s.slice(4).map(showSource).join('')}</ul></details>`:''}</article>`).join('')||empty('No indexed sources found','Try another item, location, badge count, or source filter.');
    $('item-more').hidden=found.length<=itemLimit;wireAdd($('item-results'));
  }
  $('item-search').oninput=()=>{itemLimit=24;renderItems();};$('item-kind').onchange=$('item-search').oninput;$('badges').onchange=()=>{state.badges=+$('badges').value;itemLimit=24;renderItems();save();};$('item-more').onclick=()=>{itemLimit+=24;renderItems();};
  function wireAdd(root){root.querySelectorAll('[data-add-map]').forEach(b=>b.onclick=()=>addStop(b.dataset.addMap,b.dataset.note||''));}
  function mapName(id){return D.maps[id]?.name||clean(id);}
  function addStop(map,note='',quiet=false,repeat=false){
    const existing=!repeat&&state.plan.stops.find(s=>s.map===map&&!s.done);
    if(existing){if(note&&!existing.notes.includes(note))existing.notes+=(existing.notes?'\n':'')+note;if(!quiet)toast('Added a reminder to '+mapName(map)+'.');}
    else {state.plan.stops.push({id:Date.now().toString(36)+Math.random().toString(36).slice(2,7),map,done:false,mine:'',partner:'',notes:note});if(!quiet)toast(mapName(map)+' added to your route.');}
    updatePlanBadge();save();if(currentTab==='route')renderRoute();
  }
  function updatePlanBadge(){const s=state.plan.stops;$('route-count').textContent=s.filter(x=>!x.done).length;}
  function renderRoute(){
    updatePlanBadge();$('plan-name').value=state.plan.name;
    const all=state.plan.stops,done=all.filter(s=>s.done).length;$('plan-progress').textContent=`${done} of ${all.length} stops completed`;$('plan-bar').style.width=(all.length?done/all.length*100:0)+'%';
    $('route-stops').innerHTML=all.map((s,i)=>`<article class="panel route-stop ${s.done?'done':''}" data-stop="${esc(s.id)}"><div class="stop-number">${i+1}</div><div><div class="stop-head"><h3>${esc(mapName(s.map))}</h3><div class="stop-actions"><button class="icon-button" data-action="up" aria-label="Move ${esc(mapName(s.map))} up" ${i===0?'disabled':''}>↑</button><button class="icon-button" data-action="down" aria-label="Move ${esc(mapName(s.map))} down" ${i===all.length-1?'disabled':''}>↓</button><button class="icon-button" data-action="remove" aria-label="Remove ${esc(mapName(s.map))}">×</button></div></div><div class="stop-links"><button class="text-button" data-view="trainers">Trainers (${trainers.filter(t=>t.maps.some(m=>m.id===s.map)).length}) ↗</button><button class="text-button" data-view="wild">Encounters (${D.wild.filter(w=>w.map===s.map).length}) ↗</button><button class="text-button" data-view="items">Items (${D.sources.filter(x=>x.map===s.map).length}) ↗</button></div><div class="form-grid"><label class="field">Your planned encounter<input data-stop-key="mine" list="species-list" value="${esc(s.mine)}" maxlength="100" placeholder="Choose or write a note"></label><label class="field">Partner’s planned encounter<input data-stop-key="partner" list="species-list" value="${esc(s.partner)}" maxlength="100" placeholder="Choose or write a note"></label></div><label class="field">Notes & reminders<textarea data-stop-key="notes" maxlength="3000" placeholder="Items to collect, team changes, or encounter strategy…">${esc(s.notes)}</textarea></label><label class="stop-done"><input type="checkbox" data-action="done" ${s.done?'checked':''}> Stop completed</label></div></article>`).join('')||empty('The road is yours.','Add a location, choose a suggested path, or add stops from trainers, encounters, and item results.');
    $('route-stops').querySelectorAll('[data-stop]').forEach(card=>{const id=card.dataset.stop;
      card.querySelectorAll('[data-stop-key]').forEach(el=>el.oninput=()=>{state.plan.stops.find(s=>s.id===id)[el.dataset.stopKey]=el.value;save();});
      card.querySelectorAll('[data-action]').forEach(b=>b.onclick=()=>{const i=state.plan.stops.findIndex(s=>s.id===id),action=b.dataset.action;
        if(action==='done')state.plan.stops[i].done=b.checked;
        if(action==='remove')state.plan.stops.splice(i,1);
        if(action==='up'&&i>0)[state.plan.stops[i-1],state.plan.stops[i]]=[state.plan.stops[i],state.plan.stops[i-1]];
        if(action==='down'&&i<state.plan.stops.length-1)[state.plan.stops[i+1],state.plan.stops[i]]=[state.plan.stops[i],state.plan.stops[i+1]];
        save();renderRoute();});
      card.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>{const s=state.plan.stops.find(s=>s.id===id),tab=b.dataset.view,id=tab==='trainers'?'trainer-search':tab==='wild'?'wild-search':'item-search';$(id).value=mapName(s.map);if(tab==='trainers')$('trainer-filter').value='all';if(tab==='wild')$('wild-method').value='';if(tab==='items')$('item-kind').value='';switchTab(tab);window.scrollTo(0,0);});
    });
  }
  $('plan-name').oninput=()=>{state.plan.name=$('plan-name').value;save();};
  $('add-stop').onclick=()=>{const m=lookup(maps,$('route-map').value);if(!m){toast('Choose a location from the list.');return;}addStop(m.id,'',false,true);$('route-map').value='';};
  $('route-map').onkeydown=e=>{if(e.key==='Enter')$('add-stop').click();};
  const early=['LITTLEROOT_TOWN','ROUTE101','OLDALE_TOWN','ROUTE103','ROUTE102','PETALBURG_CITY','ROUTE104','PETALBURG_WOODS','RUSTBORO_CITY','RUSTBORO_CITY_GYM'];
  const later=['ROUTE116','RUSTURF_TUNNEL','DEWFORD_TOWN','DEWFORD_TOWN_GYM','GRANITE_CAVE_1F','SLATEPORT_CITY','SLATEPORT_CITY_OCEANIC_MUSEUM_2F','ROUTE110','MAUVILLE_CITY','MAUVILLE_CITY_GYM','ROUTE117','VERDANTURF_TOWN','ROUTE111','ROUTE112','FIERY_PATH','ROUTE113','FALLARBOR_TOWN','ROUTE114','METEOR_FALLS_1F_1R','MT_CHIMNEY','JAGGED_PASS','LAVARIDGE_TOWN','LAVARIDGE_TOWN_GYM_1F','PETALBURG_CITY_GYM','ROUTE118','ROUTE119','FORTREE_CITY','ROUTE120','FORTREE_CITY_GYM','ROUTE121','LILYCOVE_CITY','MT_PYRE_1F','MAGMA_HIDEOUT_1F','SLATEPORT_CITY','AQUA_HIDEOUT_1F','ROUTE124','MOSSDEEP_CITY','MOSSDEEP_CITY_GYM','MOSSDEEP_CITY_SPACE_CENTER_2F','ROUTE127','ROUTE128','SEAFLOOR_CAVERN_ROOM9','SOOTOPOLIS_CITY','SKY_PILLAR_1F','SOOTOPOLIS_CITY_GYM_1F','EVER_GRANDE_CITY','VICTORY_ROAD_1F','EVER_GRANDE_CITY_SIDNEYS_ROOM','EVER_GRANDE_CITY_PHOEBES_ROOM','EVER_GRANDE_CITY_GLACIAS_ROOM','EVER_GRANDE_CITY_DRAKES_ROOM','EVER_GRANDE_CITY_CHAMPIONS_ROOM'];
  function suggested(ids){let n=0;for(const short of ids){const id='EM_'+short;if(D.maps[id]){let note='';if(short==='LITTLEROOT_TOWN')note='Your starter uses Littleroot’s Soul Link encounter.';if(short==='ROUTE101')note='Birch’s rescue is excluded. Plan your regular wild encounter here.';if(short==='PETALBURG_CITY')note='Norman/Wally’s borrowed Zigzagoon is excluded from encounter tracking.';if(short==='PETALBURG_WOODS')note='Return to Route 104 after the woods, then continue to Rustboro.';addStop(id,note,true,true);n++;}}save();renderRoute();toast('Suggested path added. Reorder it to suit your run.');}
  $('starter-route').onclick=()=>suggested(early);$('story-route').onclick=()=>suggested([...early,...later]);
  $('clear-completed').onclick=()=>{state.plan.stops=state.plan.stops.filter(s=>!s.done);save();renderRoute();};
  function download(data,filename){const url=URL.createObjectURL(new Blob([JSON.stringify(data,null,2)],{type:'application/json'})),a=document.createElement('a');a.href=url;a.download=filename;a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);}
  function exportPlan(){download({format:'emerald-field-guide-plan',schema:1,campaignVersion:D.meta.campaignVersion,badges:state.badges,plan:state.plan},(state.plan.name||'Hoenn route').replace(/[^a-z0-9_-]+/gi,'-')+'.json');toast('Plan exported. Send it with this HTML file.');}
  $('export-route').onclick=exportPlan;$('export-all').onclick=exportPlan;$('import-plan').onclick=()=>$('import-file').click();
  function validatePlan(v){
    if(v.format!=='emerald-field-guide-plan'||v.schema!==1||!v.plan||!Array.isArray(v.plan.stops)||v.plan.stops.length>500)throw Error('This is not a supported route plan.');
    return {name:String(v.plan.name||'Imported run').slice(0,120),stops:v.plan.stops.map((s,i)=>{if(!s||!D.maps[s.map])throw Error('A route stop is not in this build.');return {id:'import-'+Date.now()+'-'+i,map:s.map,done:s.done===true,mine:String(s.mine||'').slice(0,100),partner:String(s.partner||'').slice(0,100),notes:String(s.notes||'').slice(0,3000)};})};
  }
  $('import-file').onchange=async()=>{const file=$('import-file').files[0];if(!file)return;try{if(file.size>2e6)throw Error('The plan file is too large.');const v=JSON.parse(await file.text()),plan=validatePlan(v);if(state.plan.stops.length&&!confirm('Replace the current route with this imported plan? Export your current plan first if you want to keep it.'))return;state.plan=plan;state.badges=Math.max(0,Math.min(8,Number(v.badges)||0));$('badges').value=state.badges;save();renderRoute();toast(v.campaignVersion===D.meta.campaignVersion?'Plan imported.':'Plan imported from campaign '+v.campaignVersion+'. Check for changed teams and locations.');}catch(e){toast(e.message||'Could not read this plan.');}finally{$('import-file').value='';}};
  $('about-content').innerHTML=`<p><strong>Campaign ${esc(D.meta.campaignVersion)} · Co-op ${esc(D.meta.coopVersion)}</strong><br>Made for stock Gen1Recomp ${esc(D.meta.engineVersion)}. No connection or account is needed. All data and scripts are inside this file.</p><p>Trainer and encounter data comes from the resolved campaign build, including the added doubles partners. Item locations combine vanilla Emerald map/script facts with the campaign’s substitutions and marts. Additional gameplay mods can change these facts.</p><p><strong>Calculator scope.</strong> Direct damage for one selected attacker and defender, with IVs, EVs, natures, stages, current HP, status, supported abilities and items, weather, terrain, screens, spread damage, and critical hits. Ranges use the campaign’s fixed-point rounding. Unsupported or context-sensitive effects are called out in the result; it is not a full battle simulator.</p><p>Speed order is for equal-priority moves. Entry triggers such as Intimidate and weather-setting abilities must be entered manually. KO chances are conditional on a hit, before survival effects. Multi-hit moves show per-hit damage.</p><p><strong>Route plans.</strong> Stored locally in this browser when available. Moving the HTML does not move the browser’s storage. Use Export / Import to share or back up a route. Imported plans replace the current route after confirmation. The suggested story path is an itinerary, not a full walkthrough.</p><p><strong>Data coverage and limits</strong></p><ul>${D.meta.limitations.map(x=>`<li>${esc(x)}</li>`).join('')}</ul><p>Pokémon © Nintendo / Creatures / GAME FREAK. Campaign by Aeryk Kisor; Inclement Emerald content by Buffel Saft and contributors; Gen1Recomp by BOIS CLUB GAMES. This companion includes gameplay reference data, no ROM, save, or game artwork.</p>`;
  document.querySelector('.brand').onclick=e=>{e.preventDefault();switchTab('calculator');};
  $('about-footer').onclick=$('about-open').onclick=()=>$('about').showModal();$('about-close').onclick=()=>$('about').close();
  updatePlanBadge();renderCalc();switchTab(location.hash.slice(1)||'calculator');
  // A small explicit test surface for the offline browser smoke harness.
  window.GuideTest={get state(){return state;},data:D,addStop,renderCalc,renderRoute,switchTab,validatePlan,lookup};
})();
