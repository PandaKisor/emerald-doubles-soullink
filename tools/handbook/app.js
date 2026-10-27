(() => {
  'use strict';
  const D = JSON.parse(document.getElementById('guide-data').textContent), C = FieldCalc;
  const $ = id => document.getElementById(id);
  const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  const clean = s => String(s || '').replace(/^EM_|^ITEM_|^TRAINER_|^SPECIES_|^MOVE_/, '').replaceAll('_', ' ').replace(/([a-z])([A-Z])/g, '$1 $2');
  const norm = s => String(s || '').toLowerCase().replace(/[^a-z0-9]/g, '');
  const name = (kind, id) => D[kind]?.[id]?.displayName || D[kind]?.[id]?.name || ('#' + id);
  const species = Object.values(D.species).filter(s => !s.excluded && s.id > 0).sort((a, b) => name('species', a.id).localeCompare(name('species', b.id)));
  const moves = Object.values(D.moves).filter(m => m.supported !== false && m.id > 0).sort((a, b) => a.name.localeCompare(b.name));
  const items = Object.values(D.items).filter(i => i.id > 0).sort((a, b) => a.name.localeCompare(b.name));
  const trainers = D.trainers.filter(t => !t.phantom && t.party.length > 0);
  const trainerById = Object.fromEntries(D.trainers.map(t => [t.id, t]));
  const maps = Object.values(D.maps).filter(m => m.id).sort((a, b) => a.name.localeCompare(b.name));
  const G = D.routeGuide;

  // types, icons, moves ---------------------------------------------------------
  const typeColors = ['#a8a77a','#c22e28','#a98ff3','#a33ea1','#e2bf65','#b6a136','#a6b91a','#735797','#b7b7ce','#68a090','#ee8130','#6390f0','#7ac74c','#f7d02c','#f95587','#96d9d6','#6f35fc','#705746','#d685ad'];
  const darkInk = new Set([4, 5, 6, 8, 12, 13, 15]);
  const typeStyle = t => `--type:${typeColors[t]};${darkInk.has(+t) ? '--type-ink:#1d2621;' : ''}`;
  const typePills = types => [...new Set(types)].map(t => `<span class="type" style="${typeStyle(t)}">${esc(D.types[t])}</span>`).join(' ');
  const I = D.icons;
  document.head.insertAdjacentHTML('beforeend', `<style>.mi{background-image:url(${I.sheet});background-size:${I.columns * I.cell}px auto}</style>`);
  const icon = (id, cls = '') => {
    const n = I.index[id];
    if (n == null) return `<span class="mi ${cls}"></span>`;
    return `<span class="mi ${cls}" style="background-position:-${(n % I.columns) * I.cell}px -${Math.floor(n / I.columns) * I.cell}px" title="${esc(name('species', id))}"></span>`;
  };
  const moveChip = id => {
    const m = D.moves[id];
    if (!m) return '';
    return `<span class="move ${m.category === 'status' ? 'status' : ''}" style="${typeStyle(m.type)}" title="${esc(D.types[m.type])} · ${esc(m.category)}${m.power ? ' · ' + m.power + ' BP' : ''}">${esc(m.name)}</span>`;
  };

  // state -----------------------------------------------------------------------
  const fullStats = val => Object.fromEntries(C.keys.map(k => [k, val]));
  function freshMon(id, level = 15) { const s = D.species[id]; return {species: +id, level, ivs: fullStats(31), evs: fullStats(0), stages: fullStats(0), nature: 0, ability: s.abilities[0] || 0, item: 0, status: '', hp: null, moves: s.learnset.filter(r => r[0] <= level).slice(-4).map(r => r[1]), friendship: 255}; }
  const roxanne = trainers.find(t => t.symbol === 'TRAINER_ROXANNE_1');
  const baseState = {a: freshMon(277), d: roxanne ? {...freshMon(roxanne.party[0].species), ...roxanne.party[0], stages: fullStats(0), hp: null} : freshMon(74), move: 71,
    field: {doubles: true, spread: false, crit: false, weather: '', terrain: '', power: null}, badges: 0, plan: {name: 'Our Hoenn run', stops: []},
    chapter: 0, guideDone: {}, rival: {starter: 'TREECKO', gender: 'MAY'}, spoilers: 'hide', revealed: {}};
  const KEY = 'emerald-field-guide-v1';
  let state = structuredClone(baseState), storageOk = true, timer, currentTab = 'guide';
  try {
    const raw = localStorage.getItem(KEY);
    if (raw) { const s = JSON.parse(raw); if (s.a && s.d && D.species[s.a.species] && D.species[s.d.species] && s.plan?.stops && Array.isArray(s.plan.stops)) state = {...baseState, ...s, field: {...baseState.field, ...s.field}, rival: {...baseState.rival, ...s.rival}, guideDone: s.guideDone || {}, revealed: s.revealed || {}}; }
  } catch { storageOk = false; }
  if (!(state.chapter >= 0 && state.chapter < G.length)) state.chapter = 0;
  function save() { try { localStorage.setItem(KEY, JSON.stringify(state)); $('save-state').textContent = 'Saved on this browser'; } catch { storageOk = false; $('save-state').textContent = 'Use Export to keep your plan'; } }
  if (!storageOk) $('save-state').textContent = 'Use Export to keep your plan';
  function toast(message) { $('toast').textContent = message; $('toast').classList.add('show'); clearTimeout(timer); timer = setTimeout(() => $('toast').classList.remove('show'), 2800); }
  function lookup(rows, value) { const n = norm(value); return rows.find(r => norm(r.displayName || r.name) === n) || rows.find(r => String(r.id) === value); }
  function list(id, rows) { $(id).innerHTML = rows.map(r => `<option value="${esc(r.displayName || r.name)}"></option>`).join(''); }
  list('species-list', species); list('move-list', moves); list('item-list', items); list('map-list', maps);
  $('version').textContent = 'v' + D.meta.campaignVersion;
  function options(rows, selected) { return rows.map(([id, label]) => `<option value="${esc(id)}" ${String(id) === String(selected) ? 'selected' : ''}>${esc(label)}</option>`).join(''); }
  const empty = (title, message) => `<div class="empty"><h3>${esc(title)}</h3><p>${esc(message)}</p></div>`;

  // theme -------------------------------------------------------------------------
  const THEME = 'emerald-field-guide-theme';
  function applyTheme(t) { if (t) document.documentElement.dataset.theme = t; else delete document.documentElement.dataset.theme; }
  try { applyTheme(localStorage.getItem(THEME)); } catch {}
  $('theme-toggle').onclick = () => {
    const dark = document.documentElement.dataset.theme ? document.documentElement.dataset.theme === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches;
    const next = dark ? 'light' : 'dark'; applyTheme(next); try { localStorage.setItem(THEME, next); } catch {}
  };

  // tabs ----------------------------------------------------------------------------
  function switchTab(tab) {
    if (!$(tab)?.classList.contains('page')) tab = 'guide';
    currentTab = tab;
    document.querySelectorAll('.page').forEach(p => p.classList.toggle('active', p.id === tab));
    document.querySelectorAll('[data-tab]').forEach(b => b.classList.toggle('active', b.dataset.tab === tab));
    history.replaceState(null, '', '#' + tab);
    if (tab === 'guide') renderGuide(); if (tab === 'trainers') renderTrainers(); if (tab === 'wild') renderWild(); if (tab === 'items') renderItems(); if (tab === 'route') renderRoute(); if (tab === 'calculator') renderCalc();
  }
  document.querySelectorAll('[data-tab]').forEach(b => b.addEventListener('click', () => switchTab(b.dataset.tab)));

  // game sync: guide-sync.bin from START > GUIDE SYNC (campaign/guide_sync.lua) --------
  // mon rows: species, level, item, ability, nature, IVs x6, EVs x6, moves x4, hp, maxHp, uid, nickname
  const SYNC = 'emerald-field-guide-sync', BADGE = 0x820, TRAINER_FLAG = 0x500;
  let sync = null, flags = new Set(), syncHandle = null;
  // Lua encodes an empty table as {}: lists are normalized here
  const arr = x => Array.isArray(x) ? x : [];
  function validSync(v) {
    if (!v || typeof v !== 'object' || v.format !== 'emerald-guide-sync') return null;
    for (const k of ['party', 'box', 'flags']) v[k] = arr(v[k]);
    if (v.partner && typeof v.partner === 'object') { v.partner.party = arr(v.partner.party); v.partner.box = arr(v.partner.box); } else v.partner = null;
    if (v.soulLink && typeof v.soulLink === 'object') { v.soulLink.rows = arr(v.soulLink.rows); v.soulLink.banned = arr(v.soulLink.banned); } else v.soulLink = null;
    return v;
  }
  function useSync(v, at) {
    sync = v; flags = new Set(v?.flags || []);
    if (v) { sync.loadedAt = at || sync.loadedAt || Date.now(); state.badges = badgeCount(); }
  }
  try { useSync(validSync(JSON.parse(localStorage.getItem(SYNC) || 'null'))); } catch {}
  function monFrom(r) {
    if (!Array.isArray(r) || !D.species[r[0]]) return null;
    const ivs = Object.fromEntries(C.keys.map((k, i) => [k, +r[5 + i] || 0])), evs = Object.fromEntries(C.keys.map((k, i) => [k, +r[11 + i] || 0]));
    return {...freshMon(r[0], r[1] || 1), item: r[2] || 0, ability: r[3] || D.species[r[0]].abilities[0] || 0, nature: r[4] || 0, ivs, evs,
      moves: r.slice(17, 21).filter(id => id > 0 && D.moves[id]), hp: r[21] > 0 && r[21] < r[22] ? r[21] : null, nickname: r[24] || ''};
  }
  // every Pokémon the guide knows from the game, as [key, label, mon]
  function syncMons() {
    if (!sync) return [];
    const out = [], who = sync.partner?.name || 'Partner';
    const add = (rows, key, label) => (rows || []).forEach((r, i) => { const m = monFrom(r); if (m) out.push([key + ':' + i, label, m]); });
    add(sync.party, 'p', 'Your party'); add(sync.partner?.party, 'q', who + '’s party'); add(sync.box, 'b', 'Your boxes'); add(sync.partner?.box, 'r', who + '’s boxes');
    return out;
  }
  const syncMon = key => syncMons().find(x => x[0] === key)?.[2];
  const badgeCount = () => [0, 1, 2, 3, 4, 5, 6, 7].filter(i => flags.has(BADGE + i)).length;
  const beaten = t => !!sync && !!t && flags.has(TRAINER_FLAG + t.id);
  const pickedUp = src => !!sync && src.flag > 0 && flags.has(src.flag);
  // the chapter you are on: one per badge, then the League
  const reached = () => sync ? Math.min(G.length - 1, badgeCount()) : G.length - 1;
  const locked = ci => !!sync && state.spoilers !== 'show' && ci > reached() && !state.revealed?.[ci];
  function syncAge() { const m = Math.round((Date.now() - sync.loadedAt) / 60000); return m < 1 ? 'just now' : m < 60 ? m + ' min ago' : m < 1440 ? Math.round(m / 60) + ' h ago' : Math.round(m / 1440) + ' d ago'; }
  function renderSyncChip() {
    $('sync-chip').innerHTML = sync ? `<b>${esc(sync.player?.name || 'Your game')}</b> · ${badgeCount()} badge${badgeCount() === 1 ? '' : 's'}${sync.player?.cap ? ' · cap ' + sync.player.cap : ''} · ${esc(mapName(sync.player?.map))} <small>${syncAge()}</small>` : '';
    $('sync-load').textContent = sync ? (syncHandle ? 'Reload ↻' : 'Load game') : 'Load game';
  }
  function monChip(key, m) {
    return `<button class="party-mon" data-sync-mon="${key}" title="${esc((m.nickname ? m.nickname + ' · ' : '') + name('species', m.species))} · load into the calculator">${icon(m.species)}<span>${m.level}</span></button>`;
  }
  function renderSyncPanel() {
    const el = $('sync-panel');
    if (!sync) { el.innerHTML = `<div class="tiny-label">Your game</div><p class="footnote">Load <b>guide-sync.bin</b> to tick off beaten trainers and found items, show both parties and your Soul Link pairs, and hide spoilers past your badges.</p><button class="button small full" data-sync-help>How to load your game</button>`; return; }
    const mine = (sync.party || []).map((r, i) => [i, monFrom(r)]).filter(x => x[1]), theirs = (sync.partner?.party || []).map((r, i) => [i, monFrom(r)]).filter(x => x[1]);
    const sl = sync.soulLink?.rows || [], alive = sl.filter(r => r.status === 'alive').length, dead = sl.filter(r => r.status === 'dead' || r.status === 'broken').length;
    el.innerHTML = `<div class="tiny-label">${esc(sync.player?.name || 'You')}</div><div class="party-row">${mine.map(([i, m]) => monChip('p:' + i, m)).join('')}</div>
      ${sync.partner ? `<div class="tiny-label" style="margin-top:8px">${esc(sync.partner.name || 'Partner')}</div><div class="party-row">${theirs.map(([i, m]) => monChip('q:' + i, m)).join('') || '<span class="footnote">No party shared yet</span>'}</div>` : ''}
      ${sl.length ? `<div class="footnote">Soul Link: ${alive} linked pair${alive === 1 ? '' : 's'} alive · ${dead} lost</div>` : ''}
      <label class="check-line"><input type="checkbox" id="spoilers" ${state.spoilers === 'show' ? 'checked' : ''}> Show chapters past my badges</label>
      <p class="footnote">Click a Pokémon to load it into the calculator.</p>`;
    $('spoilers').onchange = () => { state.spoilers = $('spoilers').checked ? 'show' : 'hide'; save(); rerender(); renderChapters(); };
  }
  function loadSync(text, quiet) {
    let v; try { v = validSync(JSON.parse(text)); } catch { v = null; }
    if (!v) { toast('That file is not a guide sync from this campaign.'); return false; }
    useSync(v, Date.now());
    try { localStorage.setItem(SYNC, JSON.stringify(sync)); } catch {}
    state.chapter = reached(); save();
    renderSyncChip(); renderSyncPanel(); $('badges').value = state.badges; switchTab(currentTab);
    if (!quiet) toast(`Loaded ${sync.player?.name || 'your game'}: ${badgeCount()} badges, ${sync.party.length} in the party${sync.partner ? ', partner included' : ''}${v.campaign && v.campaign !== D.meta.campaignVersion ? ' (game on ' + v.campaign + ', guide ' + D.meta.campaignVersion + ')' : ''}.`);
    return true;
  }
  // Chrome / Edge: keep the file handle in IndexedDB so Reload is one click
  const idb = (mode, fn) => new Promise((ok, fail) => {
    try { const r = indexedDB.open('emerald-field-guide', 1); r.onupgradeneeded = () => r.result.createObjectStore('h'); r.onerror = () => fail(r.error);
      r.onsuccess = () => { const tx = r.result.transaction('h', mode), q = fn(tx.objectStore('h')); tx.oncomplete = () => ok(q?.result); tx.onerror = () => fail(tx.error); }; } catch (e) { fail(e); }
  });
  async function readHandle(h) {
    if ((await h.queryPermission?.({mode: 'read'})) !== 'granted' && (await h.requestPermission?.({mode: 'read'})) !== 'granted') throw Error('Permission to read the file was refused.');
    return loadSync(await (await h.getFile()).text());
  }
  async function pickSync() {
    $('sync-help').close();
    if (!window.showOpenFilePicker) { $('sync-file').click(); return; }
    try {
      const [h] = await showOpenFilePicker({id: 'guide-sync', types: [{description: 'Guide sync', accept: {'application/octet-stream': ['.bin'], 'application/json': ['.json']}}]});
      if (await readHandle(h)) { syncHandle = h; try { await idb('readwrite', st => st.put(h, 'sync')); } catch {} renderSyncChip(); }
    } catch (e) { if (e.name !== 'AbortError') $('sync-file').click(); }
  }
  $('sync-load').onclick = async () => {
    if (syncHandle) { try { await readHandle(syncHandle); return; } catch (e) { toast(e.message || 'Could not read the file again; choose it once more.'); } }
    $('sync-help').showModal();
  };
  $('sync-pick').onclick = pickSync;
  $('sync-help-close').onclick = () => $('sync-help').close();
  $('sync-forget').onclick = () => { useSync(null); syncHandle = null; try { localStorage.removeItem(SYNC); idb('readwrite', st => st.delete('sync')).catch(() => {}); } catch {} $('sync-help').close(); renderSyncChip(); renderSyncPanel(); switchTab(currentTab); toast('The loaded game was forgotten.'); };
  $('sync-file').onchange = async () => { const f = $('sync-file').files[0]; if (f) { if (f.size > 8e6) toast('That file is too large.'); else loadSync(await f.text()); } $('sync-file').value = ''; };
  if (window.indexedDB) idb('readonly', st => st.get('sync')).then(h => { if (h) { syncHandle = h; renderSyncChip(); } }).catch(() => {});

  // trainer cards -------------------------------------------------------------------
  const chapterOf = {}, bossIds = new Set();
  G.forEach((c, ci) => { c.bosses.forEach(id => bossIds.add(id)); c.steps.forEach(s => s.trainers.forEach(id => { chapterOf[id] = ci; })); });
  const RIVAL = /^TRAINER_(BRENDAN|MAY)_(.+)_(TREECKO|TORCHIC|MUDKIP)$/;
  const isStory = t => bossIds.has(t.id) || RIVAL.test(t.symbol) || /GRUNT|MAXIE|ARCHIE|TABITHA|SHELLY|MATT|COURTNEY|WALLY/.test(t.symbol);
  const capOf = t => { const c = G[chapterOf[t.id]]; return c && c.bosses.includes(t.id) ? Math.max(...t.party.map(m => m.level)) : null; };
  function monTile(t, m, i, ace) {
    const sp = D.species[m.species];
    return `<div class="mon ${ace ? 'ace' : ''}">
      <div class="mon-top">${icon(m.species)}<div class="mon-name"><b>${esc(name('species', m.species))}</b>${typePills(sp?.types || [])}</div><span class="lv">Lv${m.level}</span></div>
      <div class="mon-meta"><span><i>@</i> ${m.item ? esc(name('items', m.item)) : '<i>no item</i>'}</span><span>${esc(name('abilities', m.ability))} · <i>${esc(D.natures[m.nature]?.name || '—')}</i></span></div>
      <div class="moves">${m.moves.filter(id => id > 0).map(moveChip).join('')}</div>
      <details><summary>Stats</summary><div class="statline">${C.keys.map(k => `<span><small>${k.toUpperCase()}</small>${m.stats[k]}</span>`).join('')}</div><div class="footnote">IVs ${C.keys.map(k => m.ivs[k]).join('/')} · EVs ${C.keys.map(k => m.evs[k]).join('/')}</div></details>
      <div class="mon-actions"><button class="button small" data-load="${t.id}:${i}:a" title="Load as attacker">Calc as A</button><button class="button small" data-load="${t.id}:${i}:d" title="Load as defender">Calc as B</button></div></div>`;
  }
  function team(t) {
    const top = Math.max(...t.party.map(m => m.level)), aceAt = t.party.findIndex(m => m.level === top);
    return `<div class="team">${t.party.map((m, i) => monTile(t, m, i, capOf(t) != null && i === aceAt)).join('')}</div>`;
  }
  function trainerCard(t, extra = '') {
    const partner = t.partnerId && trainerById[t.partnerId];
    const cap = capOf(t), story = isStory(t);
    const tags = [cap != null ? `<span class="pill cap">Cap ${cap}</span>` : '', story ? '<span class="pill boss">Story · alone</span>' : '',
      partner ? `<span class="pill tag">Tag battle + ${esc(partner.name)}</span>` : '', t.nativeDouble ? '<span class="pill">Double</span>' : '',
      t.handpicked ? '<span class="pill hand">Hand-picked</span>' : '<span class="pill">Generated</span>', beaten(t) ? '<span class="pill won">Beaten ✓</span>' : ''].join('');
    return `<article class="panel trainer ${cap != null ? 'boss' : ''} ${beaten(t) ? 'beaten' : ''}"><div class="trainer-head">${icon(t.party[t.party.length - 1].species, '')}<div class="who"><h3>${esc(t.displayName)}</h3><div class="where">${esc(t.maps.map(m => m.name).join(' · ') || 'Location not mapped')}</div><div class="tags">${tags}</div></div>${t.maps[0] ? `<button class="button small" data-add-map="${esc(t.maps[0].id)}" data-note="${esc('Fight ' + t.displayName)}">+ Plan</button>` : ''}</div>
      ${extra}${team(t)}${partner ? `<div class="partner-bar">+ Partner: ${esc(partner.displayName)}</div>${team(partner)}` : ''}</article>`;
  }
  // rivals: one card per meeting, showing the variant for the chosen starter + rival
  const STARTERS = [['TREECKO', 277], ['TORCHIC', 280], ['MUDKIP', 283]];
  function rivalGroups(ids) {
    const out = [], groups = {};
    for (const id of ids) {
      const t = trainerById[id], m = RIVAL.exec(t.symbol);
      if (!m) { out.push({t}); continue; }
      if (!groups[m[2]]) { groups[m[2]] = {place: m[2], variants: {}}; out.push(groups[m[2]]); }
      groups[m[2]].variants[m[1] + '_' + m[3]] = t;
    }
    return out;
  }
  function rivalCard(g) {
    const r = state.rival, t = g.variants[r.gender + '_' + r.starter] || Object.values(g.variants)[0];
    const bar = `<div class="variants"><span class="muted" style="font-size:12px;align-self:center;margin-right:4px">You chose</span><div class="segmented">${STARTERS.map(([s, id]) => `<button data-rival-starter="${s}" class="${r.starter === s ? 'active' : ''}">${icon(id)}</button>`).join('')}</div><div class="segmented">${['MAY', 'BRENDAN'].map(x => `<button data-rival-gender="${x}" class="${r.gender === x ? 'active' : ''}">${x === 'MAY' ? 'May' : 'Brendan'}</button>`).join('')}</div></div>`;
    return trainerCard(t, bar);
  }
  const cards = ids => rivalGroups(ids).map(g => g.t ? trainerCard(g.t) : rivalCard(g)).join('');

  // shared clicks: load into calculator, add to plan, rival choice
  document.addEventListener('click', e => {
    const load = e.target.closest('[data-load]');
    if (load) {
      const [id, i, side] = load.dataset.load.split(':'), t = trainerById[id], m = t.party[i];
      state[side] = {...freshMon(m.species, m.level), ...structuredClone(m), stages: fullStats(0), hp: null};
      if (side === 'a') chooseDefaultMove();
      save(); switchTab('calculator'); window.scrollTo(0, 0);
      toast(`${t.displayName}’s ${name('species', m.species)} loaded as ${side === 'a' ? 'attacker' : 'defender'}.`);
      return;
    }
    const sm = e.target.closest('[data-sync-mon]');
    if (sm) { const m = syncMon(sm.dataset.syncMon); if (m) { state.a = structuredClone(m); chooseDefaultMove(); save(); switchTab('calculator'); window.scrollTo(0, 0); toast(`${m.nickname || name('species', m.species)} loaded as attacker.`); } return; }
    if (e.target.closest('[data-sync-help]')) { $('sync-help').showModal(); return; }
    const rv = e.target.closest('[data-reveal]');
    if (rv) { state.revealed[rv.dataset.reveal] = true; save(); renderGuide(); return; }
    const add = e.target.closest('[data-add-map]');
    if (add) { addStop(add.dataset.addMap, add.dataset.note || ''); return; }
    const shop = e.target.closest('[data-shop]');
    if (shop) { $('item-search').value = shop.dataset.shop; $('item-kind').value = ''; switchTab('items'); window.scrollTo(0, 0); return; }
    const rs = e.target.closest('[data-rival-starter]'), rg = e.target.closest('[data-rival-gender]');
    if (rs || rg) {
      if (rs) state.rival.starter = rs.dataset.rivalStarter; if (rg) state.rival.gender = rg.dataset.rivalGender;
      save(); rerender();
    }
  });
  function rerender() { renderRivalPicker(); if (currentTab === 'guide') renderChapter(true); if (currentTab === 'trainers') renderTrainers(); }

  // route guide ---------------------------------------------------------------------
  const stepKey = (ci, si) => ci + '.' + si;
  const stepMaps = s => new Set(s.maps);
  function stepWild(s) { const m = stepMaps(s); return D.wild.filter(w => m.has(w.map)); }
  function stepSources(s) { const m = stepMaps(s); return D.sources.filter(x => x.map && m.has(x.map) && !/Mart|shop/i.test(x.kind)); }
  function stepShops(s) { const m = stepMaps(s); return D.shops.filter(x => x.map && m.has(x.map)); }
  // a rival meeting counts once: any of its starter variants
  const groupBeaten = g => g.t ? beaten(g.t) : Object.values(g.variants).some(beaten);
  const stepBeaten = s => rivalGroups(s.trainers).filter(groupBeaten).length;
  const stepDone = (ci, si) => { const s = G[ci].steps[si], n = rivalGroups(s.trainers).length; return !!state.guideDone[stepKey(ci, si)] || (!!sync && (ci < badgeCount() || n > 0 && stepBeaten(s) === n)); };
  function chapterDone(ci) { return G[ci].steps.every((_, si) => stepDone(ci, si)); }
  // Soul Link rows for the step's region-map sections
  function stepLinks(s) { const secs = new Set(s.maps.map(m => D.maps[m]?.mapsec).filter(x => x != null)); return (sync?.soulLink?.rows || []).filter(r => secs.has(r.a)); }
  const SL_STATE = {caught: 'caught', failed: 'missed', seen: 'met'};
  function linkSide(x) { return x ? `${icon(x[1])}<span>${esc(x[3] || name('species', x[1]))}</span><small>${esc(SL_STATE[x[0]] || x[0])}</small>` : '<small class="muted">no encounter yet</small>'; }
  function renderRivalPicker() {
    $('rival-starter').innerHTML = STARTERS.map(([s, id]) => `<button data-rival-starter="${s}" class="${state.rival.starter === s ? 'active' : ''}" title="${esc(clean(s))}">${icon(id)}</button>`).join('');
    $('rival-gender').innerHTML = ['MAY', 'BRENDAN'].map(x => `<button data-rival-gender="${x}" class="${state.rival.gender === x ? 'active' : ''}">${x === 'MAY' ? 'May' : 'Brendan'}</button>`).join('');
  }
  function renderChapters() {
    $('chapters').innerHTML = G.map((c, ci) => {
      const done = c.steps.filter((_, si) => stepDone(ci, si)).length;
      return `<button class="chapter-link ${ci === state.chapter ? 'active' : ''} ${chapterDone(ci) ? 'done' : ''} ${locked(ci) ? 'locked' : ''}" data-chapter="${ci}"><span class="num">${chapterDone(ci) ? '✓' : locked(ci) ? '🔒' : ci + 1}</span><b>${esc(c.title)}</b><span class="pill cap">${c.cap}</span><small>${done}/${c.steps.length} stops</small></button>`;
    }).join('');
    $('chapters').querySelectorAll('[data-chapter]').forEach(b => b.onclick = () => { state.chapter = +b.dataset.chapter; save(); renderGuide(); window.scrollTo(0, 0); });
  }
  function wildBlock(rows) {
    const byMethod = {};
    for (const w of rows) (byMethod[w.method] ||= []).push(w);
    return `<div class="wild-group">${Object.entries(byMethod).map(([method, ws]) => ws.map(w => wildCard(w, method + (ws.length > 1 || rows.some(x => x.map !== w.map) ? ' · ' + w.mapName : ''))).join('')).join('')}</div>`;
  }
  function stepBody(ci, si) {
    const s = G[ci].steps[si], wild = stepWild(s), src = stepSources(s), shops = stepShops(s);
    const parts = [];
    if (s.trainers.length) parts.push(`<div><h4>Trainers · ${rivalGroups(s.trainers).length}</h4><div class="grid">${cards(s.trainers)}</div></div>`);
    if (wild.length) parts.push(`<div><h4>Wild Pokémon</h4>${wildBlock(wild)}</div>`);
    const links = stepLinks(s);
    if (links.length) parts.unshift(`<div><h4>Soul Link</h4><div class="links">${links.map(r => `<div class="link-row ${esc(r.status || '')}"><b>${esc(r.name || '')}</b><span class="side">${linkSide(r.mine)}</span><span class="side">${linkSide(r.theirs)}</span><span class="pill">${esc(r.status || '')}</span></div>`).join('')}</div></div>`);
    if (src.length) parts.push(`<div><h4>Items · ${sync ? src.filter(pickedUp).length + '/' : ''}${src.length}</h4><ul class="item-list">${src.map(x => `<li class="${pickedUp(x) ? 'got' : ''}"><b>${pickedUp(x) ? '✓ ' : ''}${esc(name('items', x.item))}</b><small><span class="tag">${esc(x.kind)}</span>${esc(x.mapName)}${x.x != null ? ' · tile ' + x.x + ', ' + x.y : ''}</small></li>`).join('')}</ul></div>`);
    const tools = [`<button class="button small" data-add-map="${esc(s.primary || s.maps[0] || '')}" data-note="${esc(s.title + (s.note ? ' — ' + s.note : ''))}">+ Add to our plan</button>`];
    if (shops.length) tools.push(`<button class="button small" data-shop="${esc(shops[0].mapName)}">Shop stock: ${esc(shops.map(x => x.label || x.mapName).join(', '))} →</button>`);
    parts.push(`<div class="step-tools">${tools.join('')}</div>`);
    return parts.join('') || '<p class="muted">Nothing to fight or find here.</p>';
  }
  function renderChapter(keepOpen) {
    const ci = state.chapter, c = G[ci];
    const open = keepOpen ? new Set([...document.querySelectorAll('#chapter details[open]')].map(d => d.dataset.step)) : new Set();
    const bosses = c.bosses.map(id => trainerById[id]).filter(Boolean);
    if (locked(ci)) {
      $('chapter').innerHTML = `<section class="panel chapter-hero locked"><div><div class="kicker">Chapter ${ci + 1} of ${G.length}</div><h1>${esc(c.title)}</h1><p>You haven’t reached this chapter yet (${badgeCount()} badge${badgeCount() === 1 ? '' : 's'}). Its trainers, teams and items stay hidden until you do.</p><button class="button" data-reveal="${ci}">Show it anyway</button></div><div class="cap-box"><small>Level cap</small><strong>${c.cap}</strong></div></section>
        <div class="toolbar" style="margin-top:14px">${ci > 0 ? `<button class="button" data-chapter-go="${ci - 1}">← ${esc(G[ci - 1].title)}</button>` : ''}</div>`;
      $('chapter').querySelectorAll('[data-chapter-go]').forEach(b => b.onclick = () => { state.chapter = +b.dataset.chapterGo; save(); renderGuide(); window.scrollTo(0, 0); });
      return;
    }
    $('chapter').innerHTML = `<section class="panel chapter-hero"><div><div class="kicker">Chapter ${ci + 1} of ${G.length}</div><h1>${esc(c.title)}</h1><p>${esc(c.intro)}</p></div>
      <div class="cap-box"><small>Level cap</small><strong>${c.cap}</strong></div>
      <div class="bosses">${bosses.map(t => { const top = t.party.reduce((a, m) => m.level >= a.level ? m : a); return `<span class="boss-chip ${beaten(t) ? 'won' : ''}" data-jump="${t.id}">${icon(top.species)}${esc(t.displayName.replace(/^Pkmn Trainer |^Pokémon Trainer /, ''))}<span class="lv">${top.level}</span></span>`; }).join('')}</div></section>
      <div class="steps">${c.steps.map((s, si) => {
        const wild = stepWild(s), mons = [...new Set(wild.flatMap(w => w.slots.map(x => x.species)))], items = stepSources(s).length;
        const nTrainers = rivalGroups(s.trainers).length, done = stepDone(ci, si), won = sync ? stepBeaten(s) : 0, nLinks = stepLinks(s).length;
        return `<details class="panel step ${done ? 'done' : ''}" data-step="${si}" ${open.has(String(si)) ? 'open' : ''}><summary><span class="step-num" data-done="${si}" title="Mark this stop done">${done ? '✓' : si + 1}</span><h3>${esc(s.title)}</h3><span class="step-counts">${nTrainers ? `<span class="pill ${sync && won === nTrainers ? 'won' : ''}">${sync ? won + '/' : ''}${nTrainers} trainer${nTrainers === 1 ? '' : 's'}</span>` : ''}${nLinks ? `<span class="pill link">${nLinks} link${nLinks === 1 ? '' : 's'}</span>` : ''}${mons.length ? `<span class="pill">${mons.length} wild</span>` : ''}${items ? `<span class="pill">${items} item${items === 1 ? '' : 's'}</span>` : ''}</span>${s.note ? `<span class="step-note">${esc(s.note)}</span>` : ''}${mons.length ? `<span class="step-icons">${mons.slice(0, 16).map(id => icon(id)).join('')}</span>` : ''}</summary><div class="step-body">${open.has(String(si)) ? stepBody(ci, si) : ''}</div></details>`;
      }).join('')}</div>
      <div class="toolbar" style="margin-top:14px;justify-content:space-between">${ci > 0 ? `<button class="button" data-chapter-go="${ci - 1}">← ${esc(G[ci - 1].title)}</button>` : '<span></span>'}${ci < G.length - 1 ? `<button class="button primary" data-chapter-go="${ci + 1}">${esc(G[ci + 1].title)} →</button>` : ''}</div>`;
    const root = $('chapter');
    root.querySelectorAll('details.step').forEach(d => d.addEventListener('toggle', () => { const body = d.querySelector('.step-body'); if (d.open && !body.innerHTML) body.innerHTML = stepBody(ci, +d.dataset.step); }));
    root.querySelectorAll('[data-done]').forEach(b => b.addEventListener('click', e => { e.preventDefault(); const k = stepKey(ci, +b.dataset.done); if (state.guideDone[k]) delete state.guideDone[k]; else state.guideDone[k] = true; save(); renderChapters(); renderChapter(true); }));
    root.querySelectorAll('[data-chapter-go]').forEach(b => b.onclick = () => { state.chapter = +b.dataset.chapterGo; save(); renderGuide(); window.scrollTo(0, 0); });
    root.querySelectorAll('[data-jump]').forEach(b => b.onclick = () => {
      const si = c.steps.findIndex(s => s.trainers.includes(+b.dataset.jump)), d = root.querySelector(`details[data-step="${si}"]`);
      if (d) { d.open = true; d.scrollIntoView({behavior: 'smooth'}); }
    });
  }
  function renderGuide() { renderChapters(); renderRivalPicker(); renderSyncPanel(); renderChapter(false); }

  // trainers tab --------------------------------------------------------------------
  let trainerLimit = 20, wildLimit = 24, itemLimit = 24;
  $('trainer-chapter').innerHTML += G.map((c, i) => `<option value="${i}">${i + 1}. ${esc(c.title)}</option>`).join('');
  const trainerSearch = t => [t.displayName, t.symbol, ...t.maps.map(m => m.name), ...t.party.map(m => name('species', m.species)), ...(trainerById[t.partnerId]?.party || []).map(m => name('species', m.species))].join(' ');
  const trainerIndex = new Map(trainers.map(t => [t.id, norm(trainerSearch(t))]));
  const trainerOrder = [...trainers].sort((a, b) => (chapterOf[a.id] ?? 99) - (chapterOf[b.id] ?? 99) || Math.max(...a.party.map(m => m.level)) - Math.max(...b.party.map(m => m.level)) || a.id - b.id);
  function renderTrainers() {
    const query = norm($('trainer-search').value), filter = $('trainer-filter').value, chapter = $('trainer-chapter').value;
    const hidden = trainerOrder.filter(t => locked(chapterOf[t.id] ?? -1)).length;
    const found = trainerOrder.filter(t => !locked(chapterOf[t.id] ?? -1) && (!query || trainerIndex.get(t.id).includes(query)) && (filter !== 'authored' || t.handpicked) && (filter !== 'boss' || isStory(t)) && (chapter === '' || chapterOf[t.id] === +chapter));
    $('trainer-count').textContent = `${found.length} trainers · ${Math.min(trainerLimit, found.length)} shown · in story order${hidden ? ` · ${hidden} past your badges hidden` : ''}`;
    $('trainer-results').innerHTML = found.slice(0, trainerLimit).map(t => trainerCard(t)).join('') || empty('No trainers found', 'Try a trainer name, place, or Pokémon.');
    $('trainer-more').hidden = found.length <= trainerLimit;
  }
  $('trainer-search').oninput = () => { trainerLimit = 20; renderTrainers(); };
  $('trainer-filter').onchange = $('trainer-chapter').onchange = $('trainer-search').oninput;
  $('trainer-more').onclick = () => { trainerLimit += 20; renderTrainers(); };

  // wild tab ------------------------------------------------------------------------
  const methods = [...new Set(D.wild.map(w => w.method))].sort();
  $('wild-method').innerHTML = '<option value="">Every method</option>' + options(methods.map(m => [m, m]), '');
  function wildCard(w, title) {
    const combined = {};
    for (const s of w.slots) { const c = combined[s.species]; if (!c) combined[s.species] = {...s}; else { c.weight += s.weight; c.minLevel = Math.min(c.minLevel, s.minLevel); c.maxLevel = Math.max(c.maxLevel, s.maxLevel); } }
    const rows = Object.values(combined).sort((a, b) => b.weight - a.weight);
    return `<article class="panel wild-card"><div class="panel-head"><div><div class="kicker">${esc(title || w.method)}${w.variant != null ? ' · table ' + (Number(w.variant) + 1) : ''}</div>${title ? '' : `<h3>${esc(w.mapName)}</h3>`}</div>${title ? '' : `<button class="button small" data-add-map="${esc(w.map)}" data-note="${esc('Encounter: ' + w.method)}">+ Plan</button>`}</div>
      <div class="enc">${rows.map(s => `<div class="enc-row">${icon(s.species)}<span>${esc(name('species', s.species))}</span><span class="lv">${s.minLevel === s.maxLevel ? s.minLevel : s.minLevel + '–' + s.maxLevel}</span><span class="pct"><span class="bar"><i style="width:${s.weight}%"></i></span>${s.weight}%</span></div>`).join('')}</div>
      ${w.emptyWeight ? `<p class="footnote">${w.emptyWeight}% empty slot in the runtime table.</p>` : ''}${w.note ? `<p class="footnote">${esc(w.note)}</p>` : ''}</article>`;
  }
  function renderWild() {
    const q = norm($('wild-search').value), method = $('wild-method').value;
    const found = D.wild.filter(w => (!method || w.method === method) && (!q || norm(w.mapName + ' ' + w.slots.map(s => name('species', s.species)).join(' ')).includes(q)));
    $('wild-count').textContent = `${found.length} encounter tables · ${new Set(found.map(w => w.map)).size} areas`;
    $('wild-results').innerHTML = found.slice(0, wildLimit).map(w => wildCard(w)).join('') || empty('No encounters found', 'Try a Pokémon name or a different area.');
    $('wild-more').hidden = found.length <= wildLimit;
  }
  $('wild-search').oninput = () => { wildLimit = 24; renderWild(); };
  $('wild-method').onchange = $('wild-search').oninput;
  $('wild-more').onclick = () => { wildLimit += 24; renderWild(); };

  // items tab -------------------------------------------------------------------------
  $('badges').innerHTML = options(Array.from({length: 9}, (_, i) => [i, i === 0 ? '0 badges' : i + ' badge' + (i === 1 ? '' : 's')]), state.badges);
  const sourceByItem = {}; for (const s of D.sources) (sourceByItem[s.item] ||= []).push(s);
  $('item-kind').innerHTML = '<option value="">Every source</option>' + options([...new Set(D.sources.map(s => s.kind))].sort().map(k => [k, k]), '');
  function sourceAvailable(s) { return Array.isArray(s.badges) ? s.badges.includes(Number(state.badges)) : s.minBadges == null || s.minBadges <= state.badges; }
  function showSource(s) { return `<li><div class="source-line"><span class="location">${esc(s.mapName || s.label || 'Field menu')}</span>${s.map ? `<button class="text-button" data-add-map="${esc(s.map)}" data-note="${esc('Find ' + name('items', s.item) + ' · ' + s.kind + (s.x != null ? ' at ' + s.x + ', ' + s.y : ''))}">+ Plan</button>` : ''}</div><div class="location-info"><span class="tag">${esc(s.kind)}</span>${s.x != null ? 'Tile ' + s.x + ', ' + s.y : ''}${s.minBadges != null ? ' · from ' + s.minBadges + ' badge' + (s.minBadges === 1 ? '' : 's') : ''}</div>${s.note && !s.badges ? `<div class="location-info">${esc(s.note)}</div>` : ''}</li>`; }
  function renderItems() {
    const q = norm($('item-search').value), kind = $('item-kind').value;
    const found = items.map(i => ({item: i, sources: (sourceByItem[i.id] || []).filter(s => sourceAvailable(s) && (!kind || s.kind === kind))})).filter(r => r.sources.length && (!q || norm(r.item.name + ' ' + r.item.description + ' ' + r.sources.map(s => s.mapName + ' ' + s.label).join(' ')).includes(q)));
    $('item-count').textContent = `${found.length} items with indexed sources · shops shown for ${state.badges} badges`;
    $('item-results').innerHTML = found.slice(0, itemLimit).map(({item: i, sources: s}) => `<article class="panel"><div class="panel-head"><div><div class="kicker">${esc(clean(i.pocket))}</div><h3>${esc(i.name)}</h3></div><span class="pill">${s.length} source${s.length === 1 ? '' : 's'}</span></div><p class="footnote" style="margin-top:0">${esc(i.description)}</p><ul class="source-list">${s.slice(0, 4).map(showSource).join('')}</ul>${s.length > 4 ? `<details><summary class="footnote">Show ${s.length - 4} more</summary><ul class="source-list">${s.slice(4).map(showSource).join('')}</ul></details>` : ''}</article>`).join('') || empty('No indexed sources found', 'Try another item, place, badge count, or source.');
    $('item-more').hidden = found.length <= itemLimit;
  }
  $('item-search').oninput = () => { itemLimit = 24; renderItems(); };
  $('item-kind').onchange = $('item-search').oninput;
  $('badges').onchange = () => { state.badges = +$('badges').value; itemLimit = 24; renderItems(); save(); };
  $('item-more').onclick = () => { itemLimit += 24; renderItems(); };

  // calculator -------------------------------------------------------------------------
  function card(side) {
    const m = state[side], sp = D.species[m.species], st = C.stats(D, m), isA = side === 'a';
    const abilityRows = [[0, 'No ability'], ...sp.abilities.filter(x => x > 0).map(id => [id, name('abilities', id)])];
    if (m.ability && !abilityRows.some(r => r[0] === m.ability)) abilityRows.push([m.ability, name('abilities', m.ability)]);
    return `<div class="combatant-head"><span class="seat"><b>${isA ? 'A' : 'B'}</b>${isA ? 'ATTACKER' : 'DEFENDER'}</span><div>${typePills(sp.types)}</div></div>
     ${sync ? `<label class="field">From your game<select data-from-game="${side}"><option value="">Choose a Pokémon…</option>${(() => { const groups = {}; for (const [k, label, mm] of syncMons()) (groups[label] ||= []).push(`<option value="${k}">${esc((mm.nickname && mm.nickname !== name('species', mm.species).toUpperCase() ? mm.nickname + ' · ' : '') + name('species', mm.species))} Lv${mm.level}</option>`); return Object.entries(groups).map(([l, o]) => `<optgroup label="${esc(l)}">${o.join('')}</optgroup>`).join(''); })()}</select></label>` : ''}
     <div class="form-grid species-row">${icon(m.species, 'big')}<label class="field">Pokémon<input data-mon="${side}" data-key="species" list="species-list" value="${esc(name('species', m.species))}" autocomplete="off"></label><label class="field">Level<input data-mon="${side}" data-key="level" type="number" min="1" max="100" value="${m.level}"></label></div>
     <div class="form-grid"><label class="field">Ability<select data-mon="${side}" data-key="ability">${options(abilityRows, m.ability)}</select></label><label class="field">Held item<input data-mon="${side}" data-key="item" list="item-list" value="${m.item ? esc(name('items', m.item)) : ''}" placeholder="No item"></label></div>
     <div class="form-grid three"><label class="field">Nature<select data-mon="${side}" data-key="nature">${options(Object.entries(D.natures).map(([id, n]) => [id, n.name]), m.nature)}</select></label><label class="field">Current HP<input data-mon="${side}" data-key="hp" type="number" min="1" max="${st.hp}" value="${m.hp ?? st.hp}" title="Maximum HP: ${st.hp}"></label><label class="field">Status<select data-mon="${side}" data-key="status">${options([['', 'Healthy'], ['BRN', 'Burn'], ['PAR', 'Paralysis'], ['PSN', 'Poison'], ['TOX', 'Bad poison'], ['SLP', 'Sleep'], ['FRZ', 'Freeze']], m.status)}</select></label></div>
     <div class="stat-row">${C.keys.map(k => `<div class="stat-cell"><small>${({hp: 'HP', atk: 'ATK', def: 'DEF', spa: 'SPA', spd: 'SPD', spe: 'SPE'})[k]}</small><strong>${st[k]}</strong></div>`).join('')}</div>
     <details ${m.editOpen ? 'open' : ''} data-edit="${side}"><summary>IVs, EVs & stat stages</summary><div class="stat-edit"><span></span>${C.keys.map(k => `<span>${k.toUpperCase()}</span>`).join('')}${['ivs', 'evs', 'stages'].map(group => `<span>${group === 'stages' ? 'Stage' : group === 'ivs' ? 'IVs' : 'EVs'}</span>${C.keys.map(k => group === 'stages' && k === 'hp' ? '<span>—</span>' : `<input aria-label="${isA ? 'Attacker' : 'Defender'} ${k} ${group}" data-mon="${side}" data-group="${group}" data-key="${k}" type="number" min="${group === 'stages' ? -6 : 0}" max="${group === 'stages' ? 6 : group === 'ivs' ? 31 : 252}" value="${m[group]?.[k] || 0}">`).join('')}`).join('')}</div><p class="footnote">EV total: ${Object.values(m.evs || {}).reduce((n, v) => n + Number(v), 0)} / 510. Enter Intimidate and other entry effects as stages.</p><label class="field">Friendship (Return / Frustration)<input data-mon="${side}" data-key="friendship" type="number" min="0" max="255" value="${m.friendship ?? 255}"></label></details>
     <div class="checks"><label><input data-mon="${side}" data-key="tailwind" type="checkbox" ${m.tailwind ? 'checked' : ''}> Tailwind</label>${!isA ? `<label><input data-mon="${side}" data-key="reflect" type="checkbox" ${m.reflect ? 'checked' : ''}> Reflect</label><label><input data-mon="${side}" data-key="lightScreen" type="checkbox" ${m.lightScreen ? 'checked' : ''}> Light Screen / Veil</label>` : ''}</div>`;
  }
  function renderCombatants() {
    $('attacker-card').innerHTML = card('a'); $('defender-card').innerHTML = card('d');
    document.querySelectorAll('[data-mon]').forEach(el => el.addEventListener('change', () => {
      const side = el.dataset.mon, k = el.dataset.key, m = state[side];
      if (k === 'species') { const row = lookup(species, el.value); if (!row) { toast('Choose a Pokémon from the list.'); el.value = name('species', m.species); return; } state[side] = freshMon(row.id, m.level); }
      else if (k === 'item') { const row = el.value.trim() ? lookup(items, el.value) : {id: 0}; if (!row) { toast('Choose an item from the list, or leave it blank.'); return; } m.item = row.id; }
      else if (el.dataset.group) { m[el.dataset.group] ||= {}; m[el.dataset.group][k] = Math.max(+el.min, Math.min(+el.max, Math.floor(+el.value || 0))); }
      else if (el.type === 'checkbox') m[k] = el.checked;
      else if (k === 'status') m[k] = el.value;
      else { m[k] = Number(el.value); if (el.type === 'number') m[k] = Math.max(+el.min, Math.min(+el.max, Math.floor(+el.value || 0))); if (['level', 'nature'].includes(k)) m.hp = null; }
      if (side === 'a' && k === 'species') chooseDefaultMove();
      renderCalc(); save();
    }));
    document.querySelectorAll('[data-from-game]').forEach(el => el.addEventListener('change', () => { const m = syncMon(el.value); if (!m) return; state[el.dataset.fromGame] = structuredClone(m); if (el.dataset.fromGame === 'a') chooseDefaultMove(); renderCalc(); save(); }));
    document.querySelectorAll('[data-edit]').forEach(el => el.addEventListener('toggle', () => { state[el.dataset.edit].editOpen = el.open; save(); }));
  }
  function chooseDefaultMove() { const found = (state.a.moves || []).find(id => D.moves[id]?.category !== 'status'); if (found) state.move = found; syncSpread(); }
  function syncSpread() { state.field.spread = [8, 32].includes(D.moves[state.move]?.target); }
  function renderCalc() { renderCombatants(); renderMove(); syncField(); renderResult(); }
  function renderMove() {
    const m = D.moves[state.move]; $('move-input').value = m?.name || '';
    const suggested = [...new Set([...(state.a.moves || []), ...D.species[state.a.species].learnset.filter(r => r[0] <= state.a.level).slice(-4).map(r => r[1])])].filter(id => D.moves[id]).slice(0, 8);
    $('move-quick').innerHTML = suggested.map(id => `<button class="chip ${id === state.move ? 'active' : ''}" data-move="${id}">${esc(name('moves', id))}</button>`).join('');
    $('move-quick').querySelectorAll('[data-move]').forEach(b => b.onclick = () => { state.move = +b.dataset.move; syncSpread(); renderMove(); syncField(); renderResult(); save(); });
    $('move-facts').innerHTML = m ? `<div class="move-meta"><span><small>TYPE</small>${typePills([m.type])}</span><span><small>CATEGORY</small>${esc(m.category)}</span><span><small>POWER</small>${m.power || '—'}</span><span><small>ACCURACY</small>${m.accuracy ? m.accuracy + '%' : 'Always'}</span><span><small>PRIORITY</small>${m.priority > 0 ? '+' : ''}${m.priority}</span></div><p class="footnote">${esc(m.description)}</p>` : '';
  }
  $('move-input').onchange = () => { const m = lookup(moves, $('move-input').value); if (!m) { toast('Choose a move from the list.'); return; } state.move = m.id; state.field.power = null; syncSpread(); renderMove(); syncField(); renderResult(); save(); };
  const fieldKeys = ['weather', 'terrain', 'power', 'doubles', 'spread', 'crit', 'helpingHand', 'permanentWeather', 'trickRoom'];
  function syncField() { for (const k of fieldKeys) { const el = $(k); if (el.type === 'checkbox') el.checked = !!state.field[k]; else el.value = state.field[k] ?? ''; } }
  for (const k of fieldKeys) $(k).onchange = () => { const el = $(k); state.field[k] = el.type === 'checkbox' ? el.checked : k === 'power' ? (el.value ? Math.max(1, Math.min(999, Number(el.value))) : null) : el.value; renderResult(); save(); };
  $('reset-field').onclick = () => { state.field = {doubles: true, weather: '', terrain: '', crit: false}; syncSpread(); syncField(); renderResult(); save(); };
  $('swap-sides').onclick = () => { [state.a, state.d] = [state.d, state.a]; chooseDefaultMove(); renderCalc(); save(); };
  const pct = n => (n * 100).toFixed(n === 0 || n === 1 ? 0 : 1) + '%';
  function renderResult() {
    const r = C.calculate(D, state.a, state.d, state.move, state.field), move = D.moves[state.move];
    const prefix = `<div class="kicker">Result</div><h2>${icon(state.a.species)} ${esc(move?.name || 'Choose a move')} → ${icon(state.d.species)}</h2>`;
    if (r.error || r.status) { $('result').innerHTML = prefix + `<p class="result-placeholder">${esc(r.error || 'No direct damage')}</p><p>${esc(r.notes?.join(' ') || 'Change the move or provide the required context.')}</p>`; return; }
    const speedA = C.speed(D, state.a, state.field), speedD = C.speed(D, state.d, state.field);
    const first = speedA === speedD ? 'Speed tie' : (state.field.trickRoom ? speedA < speedD : speedA > speedD) ? name('species', state.a.species) : name('species', state.d.species);
    const multi = (move.runtime?.hits > 1) || /MULTI_HIT|DOUBLE_HIT|TRIPLE_KICK/.test(move.sourceEffect || '') || /SURGING_STRIKES|DRAGON_DARTS|TRIPLE_AXEL/.test(move.symbol || '');
    const warnings = [...new Set(r.warnings || [])];
    $('result').innerHTML = prefix + `<div class="damage-range">${r.min === r.max ? r.min : r.min + '–' + r.max}<small>HP${multi ? ' / hit' : ''}</small></div><div class="damage-pct">${pct(r.min / r.ds.hp)} – ${pct(r.max / r.ds.hp)} of max HP</div><div class="hp-bar"><div class="max" style="width:${Math.min(100, r.max / r.dhp * 100)}%"></div><div class="min" style="width:${Math.min(100, r.min / r.dhp * 100)}%"></div></div><div class="bar-label"><span>Damage to current HP</span><span>${r.dhp} / ${r.ds.hp} HP</span></div>
      <div class="result-metrics"><div><small>${multi ? 'ONE-HIT KO' : 'ONE-ATTACK KO'} · IF IT HITS</small><strong>${pct(r.ko)}</strong></div><div><small>TYPE EFFECTIVENESS</small><strong>${r.eff}×</strong></div><div><small>SPEED A / B</small><strong>${speedA} / ${speedD}</strong></div><div><small>${state.field.trickRoom ? 'TRICK ROOM ORDER' : 'MOVES FIRST'}</small><strong style="font-size:14px">${esc(first)}</strong></div></div>
      <ul class="result-notes"><li>${r.spread ? 'Spread reduction applied (hits both foes).' : 'Single target; no spread reduction.'}</li><li>${r.critical ? 'Critical hit; harmful Attack and helpful Defense stages ignored.' : 'No critical hit.'}</li><li>KO chance over 16 equally likely rolls, assuming it hits.</li><li>Partner auras, protection, survival items, healing, recoil and later turns aren’t simulated.</li></ul>
      ${warnings.length ? `<div class="warning">${warnings.map(esc).join('<br>')}</div>` : ''}
      <details><summary class="footnote">Calculation details & all 16 rolls</summary><div class="trace">Power used: ${r.power}. ${r.physical ? 'Physical' : 'Special'}${r.fixed ? ' · fixed damage' : ''}.<br>Attack stat: ${r.attack ?? '—'} · Defense stat: ${r.defense ?? '—'} · Base damage: ${r.base ?? '—'}.<br>${(r.notes || []).map(esc).join('<br>')}</div><div class="rolls">${r.rolls.join(' · ')}</div></details>`;
  }

  // plan -------------------------------------------------------------------------------
  function mapName(id) { return D.maps[id]?.name || clean(id); }
  function addStop(map, note = '', quiet = false, repeat = false) {
    if (!D.maps[map]) return;
    const existing = !repeat && state.plan.stops.find(s => s.map === map && !s.done);
    if (existing) { if (note && !existing.notes.includes(note)) existing.notes += (existing.notes ? '\n' : '') + note; if (!quiet) toast('Added a reminder to ' + mapName(map) + '.'); }
    else { state.plan.stops.push({id: Date.now().toString(36) + Math.random().toString(36).slice(2, 7), map, done: false, mine: '', partner: '', notes: note}); if (!quiet) toast(mapName(map) + ' added to your plan.'); }
    updatePlanBadge(); save(); if (currentTab === 'route') renderRoute();
  }
  function updatePlanBadge() { $('route-count').textContent = state.plan.stops.filter(x => !x.done).length; }
  function renderRoute() {
    updatePlanBadge(); $('plan-name').value = state.plan.name;
    const all = state.plan.stops, done = all.filter(s => s.done).length;
    $('plan-progress').textContent = `${done} of ${all.length} stops completed`; $('plan-bar').style.width = (all.length ? done / all.length * 100 : 0) + '%';
    $('route-stops').innerHTML = all.map((s, i) => `<article class="panel route-stop ${s.done ? 'done' : ''}" data-stop="${esc(s.id)}"><div class="stop-number">${i + 1}</div><div><div class="stop-head"><h3>${esc(mapName(s.map))}</h3><div class="stop-actions"><button class="icon-button" data-action="up" aria-label="Move ${esc(mapName(s.map))} up" ${i === 0 ? 'disabled' : ''}>↑</button><button class="icon-button" data-action="down" aria-label="Move ${esc(mapName(s.map))} down" ${i === all.length - 1 ? 'disabled' : ''}>↓</button><button class="icon-button" data-action="remove" aria-label="Remove ${esc(mapName(s.map))}">×</button></div></div><div class="stop-links"><button class="text-button" data-view="trainers">Trainers (${trainers.filter(t => t.maps.some(m => m.id === s.map)).length})</button><button class="text-button" data-view="wild">Wild (${D.wild.filter(w => w.map === s.map).length})</button><button class="text-button" data-view="items">Items (${D.sources.filter(x => x.map === s.map).length})</button></div><div class="form-grid"><label class="field">Your encounter<input data-stop-key="mine" list="species-list" value="${esc(s.mine)}" maxlength="100" placeholder="Pokémon or note"></label><label class="field">Partner’s encounter<input data-stop-key="partner" list="species-list" value="${esc(s.partner)}" maxlength="100" placeholder="Pokémon or note"></label></div><label class="field">Notes<textarea data-stop-key="notes" maxlength="3000" placeholder="Items to grab, team changes, strategy…">${esc(s.notes)}</textarea></label><label class="stop-done"><input type="checkbox" data-action="done" ${s.done ? 'checked' : ''}> Done</label></div></article>`).join('') || empty('No stops yet', 'Add a place, add a chapter from the route guide, or press + Plan on any trainer, area or item.');
    $('route-stops').querySelectorAll('[data-stop]').forEach(card => {
      const id = card.dataset.stop;
      card.querySelectorAll('[data-stop-key]').forEach(el => el.oninput = () => { state.plan.stops.find(s => s.id === id)[el.dataset.stopKey] = el.value; save(); });
      card.querySelectorAll('[data-action]').forEach(b => b.onclick = () => {
        const i = state.plan.stops.findIndex(s => s.id === id), action = b.dataset.action;
        if (action === 'done') state.plan.stops[i].done = b.checked;
        if (action === 'remove') state.plan.stops.splice(i, 1);
        if (action === 'up' && i > 0) [state.plan.stops[i - 1], state.plan.stops[i]] = [state.plan.stops[i], state.plan.stops[i - 1]];
        if (action === 'down' && i < state.plan.stops.length - 1) [state.plan.stops[i + 1], state.plan.stops[i]] = [state.plan.stops[i], state.plan.stops[i + 1]];
        save(); renderRoute();
      });
      card.querySelectorAll('[data-view]').forEach(b => b.onclick = () => {
        const s = state.plan.stops.find(s => s.id === id), tab = b.dataset.view, input = tab === 'trainers' ? 'trainer-search' : tab === 'wild' ? 'wild-search' : 'item-search';
        $(input).value = mapName(s.map);
        if (tab === 'trainers') { $('trainer-filter').value = 'all'; $('trainer-chapter').value = ''; } if (tab === 'wild') $('wild-method').value = ''; if (tab === 'items') $('item-kind').value = '';
        switchTab(tab); window.scrollTo(0, 0);
      });
    });
  }
  $('plan-name').oninput = () => { state.plan.name = $('plan-name').value; save(); };
  $('add-stop').onclick = () => { const m = lookup(maps, $('route-map').value); if (!m) { toast('Choose a location from the list.'); return; } addStop(m.id, '', false, true); $('route-map').value = ''; };
  $('route-map').onkeydown = e => { if (e.key === 'Enter') $('add-stop').click(); };
  $('plan-chapter').innerHTML = G.map((c, i) => `<option value="${i}">${i + 1}. ${esc(c.title)}</option>`).join('');
  function addChapter(ci) {
    let n = 0;
    for (const s of G[ci].steps) { const map = s.primary || s.maps[0]; if (map) { addStop(map, s.title + (s.note ? ' — ' + s.note : ''), true, true); n++; } }
    save(); renderRoute(); toast(`${n} stops from “${G[ci].title}” added.`);
  }
  $('add-chapter').onclick = () => addChapter(+$('plan-chapter').value);
  $('clear-completed').onclick = () => { state.plan.stops = state.plan.stops.filter(s => !s.done); save(); renderRoute(); };
  function download(data, filename) { const url = URL.createObjectURL(new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'})), a = document.createElement('a'); a.href = url; a.download = filename; a.click(); setTimeout(() => URL.revokeObjectURL(url), 1000); }
  function exportPlan() { download({format: 'emerald-field-guide-plan', schema: 1, campaignVersion: D.meta.campaignVersion, badges: state.badges, plan: state.plan}, (state.plan.name || 'Hoenn route').replace(/[^a-z0-9_-]+/gi, '-') + '.json'); toast('Plan exported. Send it with this HTML file.'); }
  $('export-route').onclick = exportPlan; $('import-plan').onclick = () => $('import-file').click();
  function validatePlan(v) {
    if (v.format !== 'emerald-field-guide-plan' || v.schema !== 1 || !v.plan || !Array.isArray(v.plan.stops) || v.plan.stops.length > 500) throw Error('This is not a supported route plan.');
    return {name: String(v.plan.name || 'Imported run').slice(0, 120), stops: v.plan.stops.map((s, i) => { if (!s || !D.maps[s.map]) throw Error('A route stop is not in this build.'); return {id: 'import-' + Date.now() + '-' + i, map: s.map, done: s.done === true, mine: String(s.mine || '').slice(0, 100), partner: String(s.partner || '').slice(0, 100), notes: String(s.notes || '').slice(0, 3000)}; })};
  }
  $('import-file').onchange = async () => {
    const file = $('import-file').files[0]; if (!file) return;
    try {
      if (file.size > 2e6) throw Error('The plan file is too large.');
      const v = JSON.parse(await file.text()), plan = validatePlan(v);
      if (state.plan.stops.length && !confirm('Replace the current plan with this imported one? Export your current plan first if you want to keep it.')) return;
      state.plan = plan; state.badges = Math.max(0, Math.min(8, Number(v.badges) || 0)); $('badges').value = state.badges; save(); renderRoute();
      toast(v.campaignVersion === D.meta.campaignVersion ? 'Plan imported.' : 'Plan imported from campaign ' + v.campaignVersion + '. Check for changed teams and locations.');
    } catch (e) { toast(e.message || 'Could not read this plan.'); } finally { $('import-file').value = ''; }
  };

  // about -------------------------------------------------------------------------------
  const hand = trainers.filter(t => t.handpicked).length;
  $('about-content').innerHTML = `<p><strong>Campaign ${esc(D.meta.campaignVersion)} · Co-op ${esc(D.meta.coopVersion)}</strong><br>Made for stock Gen1Recomp ${esc(D.meta.engineVersion)}. Works offline; everything is inside this file.</p>
    <p><strong>Route guide.</strong> Vanilla Emerald’s story in order, one chapter per level cap. Each stop lists its trainers (with tag partners), wild tables and items. ${hand} of ${trainers.length} trainers have hand-picked teams so far; the rest are generated from Inclement Emerald’s and marked “Generated”.</p>
    <p><strong>Calculator.</strong> Direct damage for one attacker and defender, with IVs, EVs, natures, stages, current HP, status, supported abilities and items, weather, terrain, screens, spread damage and crits. Entry triggers such as Intimidate go in as stages. It is not a full battle simulator.</p>
    <p><strong>Plans</strong> are stored in this browser. Use Export / Import to share or back up.</p>
    <p><strong>Data coverage and limits</strong></p><ul>${D.meta.limitations.map(x => `<li>${esc(x)}</li>`).join('')}</ul>
    <p class="footnote">Pokémon © Nintendo / Creatures / GAME FREAK. Campaign by Aeryk Kisor; Inclement Emerald content and icons by Buffel Saft and contributors; Gen1Recomp by BOIS CLUB GAMES. No ROM or save data is included.</p>`;
  $('about-footer').onclick = $('about-open').onclick = () => $('about').showModal(); $('about-close').onclick = () => $('about').close();
  document.querySelector('.brand').onclick = e => { e.preventDefault(); switchTab('guide'); };

  if (sync) $('badges').value = state.badges;
  renderSyncChip(); updatePlanBadge(); switchTab(location.hash.slice(1) || 'guide');
  // A small explicit test surface for the offline browser smoke harness.
  window.GuideTest = {get state() { return state; }, get sync() { return sync; }, loadSync, data: D, addStop, addChapter, renderCalc, renderRoute, renderGuide, switchTab, validatePlan, lookup};
})();
