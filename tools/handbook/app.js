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
  const G = D.routeGuide;
  const plural = (n, word) => n + ' ' + word + (n === 1 ? '' : 's');

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
  const foeMon = m => ({...freshMon(m.species, m.level), ...structuredClone(m), stages: fullStats(0), hp: null, status: ''});
  const roxanne = trainers.find(t => t.symbol === 'TRAINER_ROXANNE_1');
  const baseState = {a: freshMon(277), d: roxanne ? foeMon(roxanne.party[0]) : freshMon(74), move: 71,
    field: {doubles: true, spread: false, crit: false, weather: '', terrain: '', power: null}, badges: 0,
    chapter: 0, guideDone: {}, rival: {starter: 'TREECKO', gender: 'MAY'}, spoilers: 'hide', revealed: {},
    notes: {}, planned: {}, gotItems: {}, roster: {me: [], partner: []}, rosterFollowsGame: true,
    battle: {trainer: null, active: ['me:0', 'me:1', 'partner:0', 'partner:1'], foes: null, weather: '', terrain: '', trickRoom: false, tailwindUs: false, tailwindThem: false, par: {}, view: 'hits'}};
  const KEY = 'emerald-field-guide-v1';
  let state = structuredClone(baseState), storageOk = true, timer, currentView = 'guide';
  // the chapter-list indexes come first: loading an old plan maps its stops onto them
  const chapterOf = {}, stepOf = {}, bossIds = new Set(), mapChapter = {};
  G.forEach((c, ci) => {
    c.bosses.forEach(id => bossIds.add(id));
    c.steps.forEach((s, si) => { s.trainers.forEach(id => { chapterOf[id] = ci; stepOf[id] = [ci, si]; }); s.maps.forEach(m => { if (mapChapter[m] == null) mapChapter[m] = ci; }); });
  });
  const stepKey = (ci, si) => ci + '.' + si;
  // the 0.36 "Our plan" tab: its stop notes move to the guide's stops
  function migratePlan(stops) {
    for (const p of stops) {
      if (!p || !D.maps[p.map]) continue;
      const ci = mapChapter[p.map]; if (ci == null) continue;
      const k = stepKey(ci, G[ci].steps.findIndex(s => s.maps.includes(p.map)));
      if (p.notes) state.notes[k] = (state.notes[k] ? state.notes[k] + '\n' : '') + String(p.notes).slice(0, 3000);
      if (p.mine || p.partner) state.planned[k] = {mine: String(p.mine || '').slice(0, 100), partner: String(p.partner || '').slice(0, 100)};
      if (p.done) state.guideDone[k] = true;
    }
  }
  try {
    const raw = localStorage.getItem(KEY);
    if (raw) {
      const s = JSON.parse(raw);
      if (s.a && s.d && D.species[s.a.species] && D.species[s.d.species]) {
        state = {...baseState, ...s, field: {...baseState.field, ...s.field}, rival: {...baseState.rival, ...s.rival}, guideDone: s.guideDone || {}, revealed: s.revealed || {},
          notes: s.notes || {}, planned: s.planned || {}, gotItems: s.gotItems || {}, battle: {...baseState.battle, ...s.battle, par: s.battle?.par || {}},
          roster: {me: (s.roster?.me || []).filter(m => D.species[m?.species]), partner: (s.roster?.partner || []).filter(m => D.species[m?.species])}};
        if (s.plan?.stops?.length && !s.planMigrated) { migratePlan(s.plan.stops); state.planMigrated = true; }
        delete state.plan;
      }
    }
  } catch { storageOk = false; }
  if (!(state.chapter >= 0 && state.chapter < G.length)) state.chapter = 0;
  function save() { try { localStorage.setItem(KEY, JSON.stringify(state)); $('save-state').textContent = 'Saved on this browser'; } catch { storageOk = false; $('save-state').textContent = 'Not saved here: use Export to keep your notes'; } }
  if (!storageOk) $('save-state').textContent = 'Not saved here: use Export to keep your notes';
  function toast(message) { $('toast').textContent = message; $('toast').classList.add('show'); clearTimeout(timer); timer = setTimeout(() => $('toast').classList.remove('show'), 2800); }
  function lookup(rows, value) { const n = norm(value); return rows.find(r => norm(r.displayName || r.name) === n) || rows.find(r => String(r.id) === value); }
  function list(id, rows) { $(id).innerHTML = rows.map(r => `<option value="${esc(r.displayName || r.name)}"></option>`).join(''); }
  list('species-list', species); list('move-list', moves); list('item-list', items);
  $('version').textContent = 'v' + D.meta.campaignVersion;
  function options(rows, selected) { return rows.map(([id, label]) => `<option value="${esc(id)}" ${String(id) === String(selected) ? 'selected' : ''}>${esc(label)}</option>`).join(''); }
  const empty = (title, message) => `<div class="empty"><h3>${esc(title)}</h3><p>${esc(message)}</p></div>`;
  function mapName(id) { return D.maps[id]?.name || clean(id); }

  // theme -------------------------------------------------------------------------
  const THEME = 'emerald-field-guide-theme';
  function applyTheme(t) { if (t) document.documentElement.dataset.theme = t; else delete document.documentElement.dataset.theme; }
  try { applyTheme(localStorage.getItem(THEME)); } catch {}
  $('theme-toggle').onclick = () => {
    const dark = document.documentElement.dataset.theme ? document.documentElement.dataset.theme === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches;
    const next = dark ? 'light' : 'dark'; applyTheme(next); try { localStorage.setItem(THEME, next); } catch {}
  };

  // views: the route guide, search results, the calculator ----------------------------
  function show(view) {
    if (!['guide', 'results', 'calculator'].includes(view)) view = 'guide';
    currentView = view;
    document.querySelectorAll('.page').forEach(p => p.classList.toggle('active', p.id === view));
    history.replaceState(null, '', '#' + view);
    if (view === 'guide') renderGuide(); if (view === 'results') renderResults(); if (view === 'calculator') renderCalc();
  }
  $('calc-open').onclick = () => { show('calculator'); window.scrollTo(0, 0); };
  $('calc-back').onclick = () => { show('guide'); };

  const RIVAL = /^TRAINER_(BRENDAN|MAY)_(.+)_(TREECKO|TORCHIC|MUDKIP)$/;
  const isStory = t => bossIds.has(t.id) || RIVAL.test(t.symbol) || /GRUNT|MAXIE|ARCHIE|TABITHA|SHELLY|MATT|COURTNEY|WALLY/.test(t.symbol);
  const capOf = t => { const c = G[chapterOf[t.id]]; return c && c.bosses.includes(t.id) ? Math.max(...t.party.map(m => m.level)) : null; };
  // rematches: TRAINER_X_2.. belong to TRAINER_X / TRAINER_X_1
  const rematches = {};
  { const bySym = Object.fromEntries(trainers.map(t => [t.symbol, t]));
    for (const t of trainers) { const m = /^(.*)_([2-6])$/.exec(t.symbol); if (!m || chapterOf[t.id] != null) continue;
      const base = bySym[m[1] + '_1'] || bySym[m[1]]; if (base) (rematches[base.id] ||= []).push(t); }
    for (const l of Object.values(rematches)) l.sort((a, b) => a.symbol.localeCompare(b.symbol, 'en', {numeric: true})); }

  // game sync: guide-sync.bin from START > GUIDE SYNC (campaign/guide_sync.lua) --------
  // mon rows: species, level, item, ability, nature, IVs x6, EVs x6, moves x4, hp, maxHp, uid, nickname
  const SYNC = 'emerald-field-guide-sync', BADGE = 0x820, TRAINER_FLAG = 0x500;
  let sync = null, flags = new Set();
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
      moves: r.slice(17, 21).filter(id => id > 0 && D.moves[id]), hp: r[21] > 0 && r[21] < r[22] ? r[21] : null, nickname: r[24] || '', uid: r[23] || ''};
  }
  const monsOf = rows => arr(rows).map(monFrom).filter(Boolean);
  // every Pokémon the guide knows from the game, as [key, label, mon]
  function syncMons() {
    if (!sync) return [];
    const out = [], who = sync.partner?.name || 'Partner';
    const add = (rows, key, label) => arr(rows).forEach((r, i) => { const m = monFrom(r); if (m) out.push([key + ':' + i, label, m]); });
    add(sync.party, 'p', 'Your party'); add(sync.partner?.party, 'q', who + '’s party'); add(sync.box, 'b', 'Your boxes'); add(sync.partner?.box, 'r', who + '’s boxes');
    return out;
  }
  const syncMon = key => syncMons().find(x => x[0] === key)?.[2];
  const badgeCount = () => [0, 1, 2, 3, 4, 5, 6, 7].filter(i => flags.has(BADGE + i)).length;
  const beaten = t => !!sync && !!t && flags.has(TRAINER_FLAG + t.id);
  const pickedUp = (src, key) => (!!sync && src.flag > 0 && flags.has(src.flag)) || !!state.gotItems[key];
  // the chapter you are on: one per badge, then the League
  const reached = () => sync ? Math.min(G.length - 1, badgeCount()) : G.length - 1;
  const locked = ci => !!sync && state.spoilers !== 'show' && ci > reached() && !state.revealed?.[ci];
  function syncAge() { const m = Math.round((Date.now() - sync.loadedAt) / 60000); return m < 1 ? 'just now' : m < 60 ? m + ' min ago' : m < 1440 ? Math.round(m / 60) + ' h ago' : Math.round(m / 1440) + ' d ago'; }
  function renderSyncChip() {
    $('sync-chip').innerHTML = sync ? `<b>${esc(sync.player?.name || 'Your game')}</b> · ${plural(badgeCount(), 'badge')}${sync.player?.cap ? ' · cap ' + sync.player.cap : ''} · ${esc(mapName(sync.player?.map))} <small>${syncAge()}</small>` : '';
    $('sync-load').textContent = sync ? 'Reload ↻' : 'Load game';
  }
  function renderSyncPanel() {
    const el = $('sync-panel');
    if (!sync) { el.innerHTML = `<div class="tiny-label">Your game</div><p class="footnote">Load <b>guide-sync.bin</b> to tick off beaten trainers and found items, fill both teams, show your Soul Link pairs, and hide spoilers past your badges.</p><button class="button small full" data-sync-help>How to load your game</button>`; return; }
    const sl = sync.soulLink?.rows || [], alive = sl.filter(r => r.status === 'alive').length, dead = sl.filter(r => r.status === 'dead' || r.status === 'broken').length;
    el.innerHTML = `<div class="tiny-label">Your game</div><div class="footnote" style="margin-top:0">${esc(sync.player?.name || 'You')}${sync.partner ? ' & ' + esc(sync.partner.name || 'partner') : ''} · ${plural(badgeCount(), 'badge')}${sync.player?.cap ? ' · cap ' + sync.player.cap : ''}</div>
      ${sl.length ? `<div class="footnote">Soul Link: ${plural(alive, 'linked pair')} alive · ${dead} lost</div>` : ''}
      <label class="check-line"><input type="checkbox" id="spoilers" ${state.spoilers === 'show' ? 'checked' : ''}> Show chapters past my badges</label>`;
    $('spoilers').onchange = () => { state.spoilers = $('spoilers').checked ? 'show' : 'hide'; save(); renderGuide(); };
  }
  function loadSync(text, quiet) {
    let v; try { v = validSync(JSON.parse(text)); } catch { v = null; }
    if (!v) { toast('That file is not a guide sync from this campaign.'); return false; }
    useSync(v, Date.now());
    try { localStorage.setItem(SYNC, JSON.stringify(sync)); } catch {}
    if (state.rosterFollowsGame) rosterFromGame(true);
    state.chapter = reached(); save();
    renderSyncChip(); show(currentView);
    if (!quiet) toast(`Loaded ${sync.player?.name || 'your game'}: ${plural(badgeCount(), 'badge')}, ${sync.party.length} in the party${sync.partner ? ', partner included' : ''}${v.campaign && v.campaign !== D.meta.campaignVersion ? ' (game on ' + v.campaign + ', guide ' + D.meta.campaignVersion + ')' : ''}.`);
    return true;
  }
  // the browser's plain file chooser: Chrome's newer picker refuses files under
  // AppData (where the game writes on Windows) as "system files"
  function pickSync() { $('sync-help').close(); $('sync-file').click(); }
  async function loadSyncFile(f) {
    if (!f) return;
    if (f.size > 8e6) toast('That file is too large.'); else loadSync(await f.text());
  }
  $('sync-load').onclick = () => $('sync-help').showModal();
  $('sync-pick').onclick = pickSync;
  $('sync-help-close').onclick = () => $('sync-help').close();
  $('sync-forget').onclick = () => { useSync(null); try { localStorage.removeItem(SYNC); } catch {} $('sync-help').close(); renderSyncChip(); show(currentView); toast('The loaded game was forgotten.'); };
  $('sync-file').onchange = async () => { await loadSyncFile($('sync-file').files[0]); $('sync-file').value = ''; };
  $('sync-copy-path').onclick = async () => {
    try { await navigator.clipboard.writeText($('sync-win-path').textContent); toast('Copied. Paste it into the file window\'s address bar and press Enter.'); }
    catch { toast('Select the path and copy it by hand.'); }
  };
  // or drop the file anywhere on the page
  addEventListener('dragover', e => { if ([...(e.dataTransfer?.types || [])].includes('Files')) e.preventDefault(); });
  addEventListener('drop', e => { const f = e.dataTransfer?.files?.[0]; if (!f) return; e.preventDefault(); $('sync-help').close(); loadSyncFile(f); });

  // teams: both players' rosters, filled from the game or by hand -------------------------
  const sideName = side => side === 'me' ? (sync?.player?.name || 'You') : (sync?.partner?.name || 'Partner');
  function rosterFromGame(quiet) {
    if (!sync) return;
    state.roster.me = monsOf(sync.party).slice(0, 6);
    if (sync.partner) state.roster.partner = monsOf(sync.partner.party).slice(0, 6);
    if (!quiet) toast('Both teams now match your game.');
  }
  const rosterMon = key => { const [side, i] = String(key).split(':'); return state.roster[side]?.[+i]; };
  let calcRef = null; // the team slot the calculator's attacker edits
  function monChip(key, m) {
    return `<button class="party-mon" data-roster-mon="${key}" title="${esc((m.nickname ? m.nickname + ' · ' : '') + name('species', m.species))} Lv${m.level} · open in the calculator">${icon(m.species)}<span>${m.level}</span></button>`;
  }
  function renderRoster() {
    const box = side => {
      const r = state.roster[side];
      return `<div class="roster-side"><div class="tiny-label">${esc(sideName(side))}</div><div class="party-row">${r.map((m, i) => monChip(side + ':' + i, m)).join('')}${r.length < 6 ? `<button class="party-mon add" data-roster-add="${side}" title="Add the calculator’s attacker to this team">+</button>` : ''}</div></div>`;
    };
    $('roster-panel').innerHTML = `<div class="panel-head"><div class="tiny-label">Teams</div>${sync ? `<button class="text-button" id="roster-sync">Match my game</button>` : ''}</div>${box('me')}${box('partner')}
      ${sync ? `<label class="check-line"><input type="checkbox" id="roster-follow" ${state.rosterFollowsGame ? 'checked' : ''}> Refill from each game load</label>` : ''}
      <p class="footnote">Click a Pokémon to edit it in the calculator; <b>+</b> adds the calculator’s attacker. Battle plans use these teams.</p>`;
    if ($('roster-sync')) $('roster-sync').onclick = () => { rosterFromGame(); save(); renderRoster(); renderBattle(); };
    if ($('roster-follow')) $('roster-follow').onchange = () => { state.rosterFollowsGame = $('roster-follow').checked; save(); };
  }
  function openRosterMon(key) {
    const m = rosterMon(key); if (!m) return;
    state.a = structuredClone(m); calcRef = key; chooseDefaultMove(); save(); show('calculator'); window.scrollTo(0, 0);
  }

  // trainer cards -------------------------------------------------------------------
  function monTile(t, m, i, ace) {
    const sp = D.species[m.species];
    return `<div class="mon ${ace ? 'ace' : ''}">
      <div class="mon-top">${icon(m.species)}<div class="mon-name"><b>${esc(name('species', m.species))}</b>${typePills(sp?.types || [])}</div><span class="lv">Lv${m.level}</span></div>
      <div class="mon-meta"><span><i>@</i> ${m.item ? esc(name('items', m.item)) : '<i>no item</i>'}</span><span>${esc(name('abilities', m.ability))} · <i>${esc(D.natures[m.nature]?.name || '—')}</i></span></div>
      <div class="moves">${m.moves.filter(id => id > 0).map(moveChip).join('')}</div>
      <details><summary>Stats</summary><div class="statline">${C.keys.map(k => `<span><small>${k.toUpperCase()}</small>${m.stats[k]}</span>`).join('')}</div><div class="footnote">IVs ${C.keys.map(k => m.ivs[k]).join('/')} · EVs ${C.keys.map(k => m.evs[k]).join('/')}</div></details>
      <div class="mon-actions"><button class="button small" data-load="${t.id}:${i}:d" title="Load as the defender">Calc vs</button><button class="button small" data-load="${t.id}:${i}:a" title="Load as the attacker">Calc from</button></div></div>`;
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
    return `<article class="panel trainer ${cap != null ? 'boss' : ''} ${beaten(t) ? 'beaten' : ''} ${state.battle.trainer === t.id ? 'planning' : ''}"><div class="trainer-head">${icon(t.party[t.party.length - 1].species, '')}<div class="who"><h3>${esc(t.displayName)}</h3><div class="where">${esc(t.maps.map(m => m.name).join(' · ') || 'Location not mapped')}</div><div class="tags">${tags}</div></div><button class="button small primary" data-battle="${t.id}" title="Matchups, speed order and damage both ways">Battle plan ⚔</button></div>
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
  const rivalPick = g => g.variants[state.rival.gender + '_' + state.rival.starter] || Object.values(g.variants)[0];
  function rivalCard(g) {
    const r = state.rival, t = rivalPick(g);
    const bar = `<div class="variants"><span class="muted" style="font-size:12px;align-self:center;margin-right:4px">You chose</span><div class="segmented">${STARTERS.map(([s, id]) => `<button data-rival-starter="${s}" class="${r.starter === s ? 'active' : ''}">${icon(id)}</button>`).join('')}</div><div class="segmented">${['MAY', 'BRENDAN'].map(x => `<button data-rival-gender="${x}" class="${r.gender === x ? 'active' : ''}">${x === 'MAY' ? 'May' : 'Brendan'}</button>`).join('')}</div></div>`;
    return trainerCard(t, bar);
  }
  const cards = ids => rivalGroups(ids).map(g => g.t ? trainerCard(g.t) : rivalCard(g)).join('');

  // shared clicks ---------------------------------------------------------------------
  document.addEventListener('click', e => {
    const load = e.target.closest('[data-load]');
    if (load) {
      const [id, i, side] = load.dataset.load.split(':'), t = trainerById[id], m = t.party[i];
      state[side] = foeMon(m); if (side === 'a') { calcRef = null; chooseDefaultMove(); }
      save(); show('calculator'); window.scrollTo(0, 0);
      toast(`${t.displayName}’s ${name('species', m.species)} loaded as ${side === 'a' ? 'attacker' : 'defender'}.`);
      return;
    }
    const bt = e.target.closest('[data-battle]');
    if (bt) { openBattle(+bt.dataset.battle); return; }
    const rm = e.target.closest('[data-roster-mon]');
    if (rm) { openRosterMon(rm.dataset.rosterMon); return; }
    const ra = e.target.closest('[data-roster-add]');
    if (ra) { const side = ra.dataset.rosterAdd, r = state.roster[side]; if (r.length < 6) { r.push(structuredClone(state.a)); calcRef = side + ':' + (r.length - 1); save(); renderRoster(); renderBattle(); if (currentView === 'calculator') renderCalc(); toast(`${name('species', state.a.species)} added to ${sideName(side)}’s team.`); } return; }
    if (e.target.closest('[data-sync-help]')) { $('sync-help').showModal(); return; }
    const rv = e.target.closest('[data-reveal]');
    if (rv) { state.revealed[rv.dataset.reveal] = true; save(); renderGuide(); return; }
    const go = e.target.closest('[data-goto]');
    if (go) { const [ci, si] = go.dataset.goto.split('.').map(Number); gotoStep(ci, si); return; }
    const rs = e.target.closest('[data-rival-starter]'), rg = e.target.closest('[data-rival-gender]');
    if (rs || rg) {
      if (rs) state.rival.starter = rs.dataset.rivalStarter; if (rg) state.rival.gender = rg.dataset.rivalGender;
      save(); renderRivalPicker(); if (currentView === 'guide') renderChapter(true); if (currentView === 'results') renderResults();
    }
  });
  function gotoStep(ci, si) {
    $('search').value = '';
    state.chapter = ci; save(); show('guide');
    const d = document.querySelector(`#chapter details[data-step="${si}"]`);
    if (d) { d.open = true; d.dispatchEvent(new Event('toggle')); d.scrollIntoView({block: 'start'}); }
  }

  // route guide ---------------------------------------------------------------------
  const stepMaps = s => new Set(s.maps);
  function stepWild(s) { const m = stepMaps(s); return D.wild.filter(w => m.has(w.map)); }
  const sourceIndex = new Map(D.sources.map((x, i) => [x, i]));
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
  function wildCard(w, title) {
    const combined = {};
    for (const s of w.slots) { const c = combined[s.species]; if (!c) combined[s.species] = {...s}; else { c.weight += s.weight; c.minLevel = Math.min(c.minLevel, s.minLevel); c.maxLevel = Math.max(c.maxLevel, s.maxLevel); } }
    const rows = Object.values(combined).sort((a, b) => b.weight - a.weight);
    return `<article class="panel wild-card"><div class="panel-head"><div><div class="kicker">${esc(title || w.method)}${w.variant != null ? ' · table ' + (Number(w.variant) + 1) : ''}</div>${title ? '' : `<h3>${esc(w.mapName)}</h3>`}</div></div>
      <div class="enc">${rows.map(s => `<div class="enc-row">${icon(s.species)}<span>${esc(name('species', s.species))}</span><span class="lv">${s.minLevel === s.maxLevel ? s.minLevel : s.minLevel + '–' + s.maxLevel}</span><span class="pct"><span class="bar"><i style="width:${s.weight}%"></i></span>${s.weight}%</span></div>`).join('')}</div>
      ${w.emptyWeight ? `<p class="footnote">${w.emptyWeight}% empty slot in the runtime table.</p>` : ''}${w.note ? `<p class="footnote">${esc(w.note)}</p>` : ''}</article>`;
  }
  function wildBlock(rows) {
    const byMethod = {};
    for (const w of rows) (byMethod[w.method] ||= []).push(w);
    return `<div class="wild-group">${Object.entries(byMethod).map(([method, ws]) => ws.map(w => wildCard(w, method + (ws.length > 1 || rows.some(x => x.map !== w.map) ? ' · ' + w.mapName : ''))).join('')).join('')}</div>`;
  }
  // boss prep: their types, the attack types they carry, the fastest foe, your team against the cap
  const effect = (atk, defTypes) => defTypes.reduce((x, dt) => x * (D.typeChart?.[atk]?.[dt] ?? 1), 1);
  function bossPrep(ci, t) {
    const foes = [...t.party, ...(t.partnerId && trainerById[t.partnerId] ? trainerById[t.partnerId].party : [])];
    const moveTypes = {}; for (const m of foes) for (const id of m.moves) { const mv = D.moves[id]; if (mv && mv.category !== 'status') moveTypes[mv.type] = (moveTypes[mv.type] || 0) + 1; }
    const fast = foes.reduce((a, m) => m.stats.spe > a.stats.spe ? m : a);
    const cap = G[ci].cap, mine = state.roster.me, atCap = mine.filter(m => m.level >= cap).length;
    const weak = Object.keys(moveTypes).map(ty => [ty, mine.filter(m => effect(ty, D.species[m.species]?.types || []) > 1).length]).filter(x => x[1] > 0).sort((a, b) => b[1] - a[1]);
    const status = [...new Set(foes.flatMap(m => m.moves).filter(id => D.moves[id]?.category === 'status').map(id => name('moves', id)))];
    return `<div class="boss-prep panel"><div class="panel-head"><h4>Boss prep · ${esc(t.displayName)}</h4><button class="button small primary" data-battle="${t.id}">Battle plan ⚔</button></div>
      <div class="prep-grid"><div><small>LEVEL CAP</small><strong>${cap}</strong><span class="footnote">${mine.length ? `${atCap}/${mine.length} of your team at the cap` : 'Add your team to compare'}</span></div>
      <div><small>THEIR TYPES</small><span>${typePills(foes.flatMap(m => D.species[m.species]?.types || []))}</span></div>
      <div><small>ATTACKS THEY CARRY</small><span>${typePills(Object.keys(moveTypes).sort((a, b) => moveTypes[b] - moveTypes[a]))}</span></div>
      <div><small>FASTEST</small><span>${icon(fast.species)} ${esc(name('species', fast.species))} · ${fast.stats.spe} Spe</span></div></div>
      ${weak.length ? `<p class="footnote">Your team is weak to: ${weak.map(([ty, n]) => `${esc(D.types[ty])} (${n})`).join(', ')}.</p>` : ''}
      ${status.length ? `<p class="footnote">Support moves: ${status.map(esc).join(', ')}.</p>` : ''}</div>`;
  }
  function rematchBlock(s) {
    const rows = s.trainers.flatMap(id => (rematches[id] || []).map(r => [trainerById[id], r]));
    if (!rows.length) return '';
    return `<details class="rematches"><summary><h4>Rematches · ${rows.length}</h4></summary><div class="grid">${rows.map(([b, r]) => trainerCard(r, `<div class="partner-bar">Rematch of ${esc(b.displayName)} · Lv ${Math.min(...r.party.map(m => m.level))}–${Math.max(...r.party.map(m => m.level))}</div>`)).join('')}</div></details>`;
  }
  function stepBody(ci, si) {
    const s = G[ci].steps[si], k = stepKey(ci, si), wild = stepWild(s), src = stepSources(s), shops = stepShops(s);
    const parts = [], links = stepLinks(s), plan = state.planned[k] || {};
    if (links.length) parts.push(`<div><h4>Soul Link</h4><div class="links">${links.map(r => `<div class="link-row ${esc(r.status || '')}"><b>${esc(r.name || '')}</b><span class="side">${linkSide(r.mine)}</span><span class="side">${linkSide(r.theirs)}</span><span class="pill">${esc(r.status || '')}</span></div>`).join('')}</div></div>`);
    for (const id of s.trainers) if (bossIds.has(id) && !RIVAL.test(trainerById[id].symbol)) parts.push(bossPrep(ci, trainerById[id]));
    if (s.trainers.length) parts.push(`<div><h4>Trainers · ${sync ? stepBeaten(s) + '/' : ''}${rivalGroups(s.trainers).length}</h4><div class="grid">${cards(s.trainers)}</div>${rematchBlock(s)}</div>`);
    if (wild.length) parts.push(`<div><h4>Wild Pokémon</h4>${wildBlock(wild)}</div>`);
    if (src.length) parts.push(`<div><h4>Items · ${src.filter(x => pickedUp(x, sourceIndex.get(x))).length}/${src.length}</h4><ul class="item-list checklist">${src.map(x => { const i = sourceIndex.get(x), got = pickedUp(x, i), fromGame = sync && x.flag > 0 && flags.has(x.flag); return `<li class="${got ? 'got' : ''}"><label><input type="checkbox" data-item-got="${i}" ${got ? 'checked' : ''} ${fromGame ? 'disabled title="Picked up in your game"' : ''}><b>${esc(name('items', x.item))}</b></label><small><span class="tag">${esc(x.kind)}</span>${esc(x.mapName)}${x.x != null ? ' · tile ' + x.x + ', ' + x.y : ''}</small></li>`; }).join('')}</ul></div>`);
    if (shops.length) parts.push(`<div><h4>Shops at ${plural(state.badges, 'badge')}</h4>${shops.map(sh => `<div class="shop"><b>${esc(sh.mapName)}</b><div class="chips">${(sh.stockByBadges?.[Math.min(8, state.badges)] || []).map(id => `<span class="chip static">${esc(name('items', id))}</span>`).join('')}</div></div>`).join('')}</div>`);
    parts.push(`<div class="stop-notes"><h4>Your notes</h4><div class="form-grid"><label class="field">Planned encounter · ${esc(sideName('me'))}<input data-plan="${k}" data-who="mine" list="species-list" maxlength="100" value="${esc(plan.mine || '')}" placeholder="Pokémon or note"></label><label class="field">Planned encounter · ${esc(sideName('partner'))}<input data-plan="${k}" data-who="partner" list="species-list" maxlength="100" value="${esc(plan.partner || '')}" placeholder="Pokémon or note"></label></div><label class="field">Notes<textarea data-note="${k}" maxlength="3000" placeholder="Items to grab, team changes, strategy…">${esc(state.notes[k] || '')}</textarea></label></div>`);
    return parts.join('');
  }
  function wireStep(body) {
    body.querySelectorAll('[data-note]').forEach(el => el.oninput = () => { if (el.value) state.notes[el.dataset.note] = el.value; else delete state.notes[el.dataset.note]; save(); });
    body.querySelectorAll('[data-plan]').forEach(el => el.oninput = () => { (state.planned[el.dataset.plan] ||= {})[el.dataset.who] = el.value; save(); });
    body.querySelectorAll('[data-item-got]').forEach(el => el.onchange = () => { if (el.checked) state.gotItems[el.dataset.itemGot] = true; else delete state.gotItems[el.dataset.itemGot]; save(); el.closest('li').classList.toggle('got', el.checked); });
  }
  function renderChapter(keepOpen) {
    const ci = state.chapter, c = G[ci];
    const open = keepOpen ? new Set([...document.querySelectorAll('#chapter details.step[open]')].map(d => d.dataset.step)) : new Set();
    const bosses = c.bosses.map(id => trainerById[id]).filter(Boolean);
    const nav = `<div class="toolbar" style="margin-top:14px;justify-content:space-between">${ci > 0 ? `<button class="button" data-chapter-go="${ci - 1}">← ${esc(G[ci - 1].title)}</button>` : '<span></span>'}${ci < G.length - 1 ? `<button class="button primary" data-chapter-go="${ci + 1}">${esc(G[ci + 1].title)} →</button>` : ''}</div>`;
    const root = $('chapter');
    if (locked(ci)) {
      root.innerHTML = `<section class="panel chapter-hero locked"><div><div class="kicker">Chapter ${ci + 1} of ${G.length}</div><h1>${esc(c.title)}</h1><p>You haven’t reached this chapter yet (${plural(badgeCount(), 'badge')}). Its trainers, teams and items stay hidden until you do.</p><button class="button" data-reveal="${ci}">Show it anyway</button></div><div class="cap-box"><small>Level cap</small><strong>${c.cap}</strong></div></section>${nav}`;
    } else {
      root.innerHTML = `<section class="panel chapter-hero"><div><div class="kicker">Chapter ${ci + 1} of ${G.length}</div><h1>${esc(c.title)}</h1><p>${esc(c.intro)}</p></div>
      <div class="cap-box"><small>Level cap</small><strong>${c.cap}</strong></div>
      <div class="bosses">${bosses.map(t => { const top = t.party.reduce((a, m) => m.level >= a.level ? m : a); return `<span class="boss-chip ${beaten(t) ? 'won' : ''}" data-jump="${t.id}">${icon(top.species)}${esc(t.displayName.replace(/^Pkmn Trainer |^Pokémon Trainer /, ''))}<span class="lv">${top.level}</span></span>`; }).join('')}</div></section>
      <div class="steps">${c.steps.map((s, si) => {
        const wild = stepWild(s), mons = [...new Set(wild.flatMap(w => w.slots.map(x => x.species)))], nItems = stepSources(s).length;
        const nTrainers = rivalGroups(s.trainers).length, done = stepDone(ci, si), won = sync ? stepBeaten(s) : 0, nLinks = stepLinks(s).length, noted = !!state.notes[stepKey(ci, si)];
        return `<details class="panel step ${done ? 'done' : ''}" data-step="${si}" ${open.has(String(si)) ? 'open' : ''}><summary><span class="step-num" data-done="${si}" title="Mark this stop done">${done ? '✓' : si + 1}</span><h3>${esc(s.title)}</h3><span class="step-counts">${nTrainers ? `<span class="pill ${sync && won === nTrainers ? 'won' : ''}">${sync ? won + '/' : ''}${plural(nTrainers, 'trainer')}</span>` : ''}${nLinks ? `<span class="pill link">${plural(nLinks, 'link')}</span>` : ''}${mons.length ? `<span class="pill">${mons.length} wild</span>` : ''}${nItems ? `<span class="pill">${plural(nItems, 'item')}</span>` : ''}${noted ? '<span class="pill note">✎ note</span>' : ''}</span>${s.note ? `<span class="step-note">${esc(s.note)}</span>` : ''}${mons.length ? `<span class="step-icons">${mons.slice(0, 16).map(id => icon(id)).join('')}</span>` : ''}</summary><div class="step-body"></div></details>`;
      }).join('')}</div>${nav}`;
      root.querySelectorAll('details.step').forEach(d => {
        const fill = () => { const body = d.querySelector('.step-body'); if (d.open && !body.innerHTML) { body.innerHTML = stepBody(ci, +d.dataset.step); wireStep(body); } };
        d.addEventListener('toggle', fill); fill();
      });
      root.querySelectorAll('[data-done]').forEach(b => b.addEventListener('click', e => { e.preventDefault(); const k = stepKey(ci, +b.dataset.done); if (state.guideDone[k]) delete state.guideDone[k]; else state.guideDone[k] = true; save(); renderChapters(); renderChapter(true); }));
      root.querySelectorAll('[data-jump]').forEach(b => b.onclick = () => {
        const si = c.steps.findIndex(s => s.trainers.includes(+b.dataset.jump)), d = root.querySelector(`details[data-step="${si}"]`);
        if (d) { d.open = true; d.scrollIntoView({behavior: 'smooth'}); }
      });
    }
    root.querySelectorAll('[data-chapter-go]').forEach(b => b.onclick = () => { state.chapter = +b.dataset.chapterGo; save(); renderGuide(); window.scrollTo(0, 0); });
  }
  function renderGuide() { renderChapters(); renderRivalPicker(); renderSyncPanel(); renderRoster(); renderChapter(false); renderBattle(); }

  // battle plan: the side panel for one fight -------------------------------------------
  // all battles are doubles: a lone trainer sends out two, a tag battle one from each trainer
  function battleTrainers() {
    const t = trainerById[state.battle.trainer];
    if (!t) return [];
    const p = t.partnerId && trainerById[t.partnerId];
    return p ? [t, p] : [t];
  }
  function battleFoes() {
    const ts = battleTrainers(), out = [];
    ts.forEach((t, ti) => t.party.forEach((m, i) => out.push({key: ti + ':' + i, t, m: foeMon(m)})));
    const on = new Set(state.battle.foes || (ts.length > 1 ? ['0:0', '1:0'] : ['0:0', '0:1']));
    for (const f of out) f.on = on.has(f.key);
    return out;
  }
  function battleMine() {
    const out = [], on = new Set(state.battle.active);
    for (const side of ['me', 'partner']) state.roster[side].forEach((m, i) => out.push({key: side + ':' + i, side, m, on: on.has(side + ':' + i)}));
    return out;
  }
  function openBattle(id) {
    const t = trainerById[id]; if (!t) return;
    state.battle.trainer = id; state.battle.foes = null; state.battle.par = {};
    // keep chosen actives that still exist; otherwise two leads from each team
    if (!battleMine().some(x => x.on)) state.battle.active = ['me:0', 'me:1', 'partner:0', 'partner:1'];
    save(); if (currentView !== 'guide') show('guide');
    renderBattle(); document.querySelectorAll('.trainer').forEach(el => el.classList.toggle('planning', !!el.querySelector(`.trainer-head [data-battle="${id}"]`)));
    if (!state.roster.me.length) toast('Add your team (Load game, or + in the Teams panel) to see your matchups.');
  }
  const pct = n => (n * 100).toFixed(n === 0 || n >= 1 ? 0 : 1) + '%', whole = n => Math.round(n * 100);
  function koLabel(r) {
    const hp = r.dhp;
    if (!r.max) return {text: 'no damage', cls: 'none'};
    if (r.min >= hp) return {text: 'OHKO', cls: 'ohko'};
    if (r.max >= hp) return {text: Math.round(r.ko * 100) + '% OHKO', cls: 'ohko-chance'};
    const lo = Math.ceil(hp / r.max), hi = r.min ? Math.ceil(hp / r.min) : 99;
    if (lo > 8) return {text: '9+ hits', cls: 'slow'};
    return {text: lo === hi ? lo + 'HKO' : lo + '–' + (hi > 8 ? '9+' : hi) + 'HKO', cls: lo <= 2 ? 'two' : 'slow'};
  }
  function battleField() {
    const b = state.battle;
    return {doubles: true, weather: b.weather, terrain: b.terrain, trickRoom: b.trickRoom, crit: false, helpingHand: false, power: null};
  }
  // the attacker's best damaging move into one target, spread moves reduced when two targets stand
  function bestHit(att, def, standing) {
    let best = null;
    for (const id of att.moves || []) {
      const mv = D.moves[id];
      if (!mv || mv.category === 'status') continue;
      const spread = [8, 32].includes(mv.target) && standing > 1;
      let r; try { r = C.calculate(D, att, def, id, {...battleField(), spread}); } catch { continue; }
      if (!r || r.error || r.status || r.max == null) continue;
      const score = (r.min + r.max) / 2 / r.dhp;
      if (!best || score > best.score) best = {id, r, score, spread};
    }
    return best;
  }
  function hitCell(att, def, standing, aKey, dKey) {
    const b = bestHit(att, def, standing);
    if (!b) return `<td class="cell none" title="No damaging move">—</td>`;
    const k = koLabel(b.r), mv = D.moves[b.id];
    return `<td class="cell ${k.cls}" data-calc="${aKey}|${dKey}|${b.id}" title="${esc(mv.name)}: ${b.r.min}–${b.r.max} HP of ${b.r.dhp} (${pct(b.r.min / b.r.dhp)}–${pct(b.r.max / b.r.dhp)})${b.spread ? ' (spread)' : ''} · click for the full calculation"><b>${esc(mv.name)}${b.spread ? ' <i>⇉</i>' : ''}</b><span>${whole(b.r.min / b.r.dhp)}–${whole(b.r.max / b.r.dhp)}%</span><small>${k.text}</small></td>`;
  }
  function speedOf(x, side) {
    const b = state.battle, mon = {...x.m, status: b.par[x.key] ? 'PAR' : x.m.status, tailwind: side === 'us' ? b.tailwindUs : b.tailwindThem};
    return C.speed(D, mon, {weather: b.weather, terrain: b.terrain});
  }
  function renderBattle() {
    const el = $('battle'), ts = battleTrainers();
    document.querySelector('.guide').classList.toggle('with-battle', ts.length > 0);
    if (!ts.length) { el.hidden = true; el.innerHTML = ''; return; }
    el.hidden = false;
    const b = state.battle, foes = battleFoes(), mine = battleMine(), us = mine.filter(x => x.on), them = foes.filter(x => x.on);
    const chip = (x, attr, onText, offText) => `<button class="party-mon ${x.on ? 'on' : ''}" ${attr}="${x.key}" title="${esc(name('species', x.m.species))} Lv${x.m.level} · ${x.on ? onText : offText}">${icon(x.m.species)}<span>${x.m.level}</span></button>`;
    let body = '';
    if (!us.length) body = `<p class="empty-note">Pick up to four of your Pokémon above (two each in co-op). ${state.roster.me.length ? '' : 'Your team is empty: Load game, or add Pokémon with + in the Teams panel.'}</p>`;
    else if (b.view === 'hits' || b.view === 'taken') {
      const yours = b.view === 'hits', rows = yours ? us : foes, cols = yours ? foes : us;
      const standing = Math.max(1, (yours ? them : us).length);
      const key = x => (x.t ? 'f:' : 'm:') + x.key;
      body = `<div class="grid-scroll"><table class="matchups"><thead><tr><th></th>${cols.map(c => `<th class="${c.on ? '' : 'off'}">${icon(c.m.species)}<small>${c.m.level}</small></th>`).join('')}</tr></thead><tbody>
        ${rows.map(r => `<tr class="${r.on ? '' : 'off'}"><th>${icon(r.m.species)}<small>${esc(name('species', r.m.species))}</small></th>${cols.map(c => hitCell(r.m, c.m, standing, key(r), key(c))).join('')}</tr>`).join('')}</tbody></table></div>
        <p class="footnote">${yours ? 'Your best move into each foe' : 'Each foe’s best move into your active Pokémon'}; ⇉ marks spread moves, reduced when two targets stand. Faded rows and columns are in the back. Click a cell for the full calculation.</p>`;
      // moves that also hit your own ally (Earthquake, Explosion, Surf-likes that target everyone)
      const ally = [];
      if (yours) for (const x of us) for (const id of x.m.moves || []) {
        const mv = D.moves[id]; if (mv?.target !== 32) continue;
        for (const y of us) if (y !== x) { let r; try { r = C.calculate(D, x.m, y.m, id, {...battleField(), spread: true}); } catch { continue; }
          if (r && !r.error && r.max != null) ally.push(`${icon(x.m.species)} ${esc(mv.name)} → ${icon(y.m.species)} ${esc(name('species', y.m.species))}: ${r.max === 0 ? 'immune' : pct(r.min / r.dhp) + '–' + pct(r.max / r.dhp)}`); }
      }
      if (ally.length) body += `<div class="ally-hits"><div class="tiny-label">Hits your own side</div>${ally.map(x => `<div>${x}</div>`).join('')}</div>`;
    } else {
      const all = [...us.map(x => ({x, side: 'us', s: speedOf(x, 'us')})), ...them.map(x => ({x, side: 'them', s: speedOf(x, 'them')}))];
      all.sort((p, q) => b.trickRoom ? p.s - q.s : q.s - p.s);
      body = `<ol class="speed-order">${all.map(({x, side, s}, i) => `<li class="${side}"><span class="rank">${i + 1}</span>${icon(x.m.species)}<b>${esc(name('species', x.m.species))}</b><small>${side === 'us' ? 'yours' : 'foe'}</small><strong>${s}</strong>${all.some((o, j) => j !== i && o.s === s) ? '<span class="pill">tie</span>' : '<span></span>'}<label class="par"><input type="checkbox" data-par="${x.key}" ${b.par[x.key] ? 'checked' : ''}> Par</label></li>`).join('')}</ol>
        <p class="footnote">${b.trickRoom ? 'Trick Room: slowest first.' : 'Fastest first.'} Priority moves (Quick Attack, Fake Out, Prankster) go before this order; Choice Scarf, Quick Feet and weather abilities are included.</p>`;
    }
    const t = ts[0], bySide = side => mine.filter(x => x.side === side);
    el.innerHTML = `<div class="battle-head"><div><div class="kicker">Battle plan</div><h2>${esc(ts.map(x => x.displayName).join(' & '))}</h2><div class="footnote" style="margin:0">${esc(t.maps[0]?.name || '')}${capOf(t) != null ? ' · cap ' + capOf(t) : ''}${beaten(t) ? ' · beaten ✓' : ''}</div></div><button class="icon-button" id="battle-close" aria-label="Close the battle plan">×</button></div>
      <div class="battle-side"><div class="tiny-label">Foes · click to set who is on the field</div><div class="party-row">${foes.map(f => chip(f, 'data-foe-toggle', 'on the field', 'in the back')).join('')}</div></div>
      ${['me', 'partner'].map(side => bySide(side).length ? `<div class="battle-side"><div class="tiny-label">${esc(sideName(side))}</div><div class="party-row">${bySide(side).map(x => chip(x, 'data-my-toggle', 'active', 'benched')).join('')}</div></div>` : '').join('')}
      <div class="battle-field"><select id="bf-weather" aria-label="Weather">${options([['', 'Clear'], ['RAIN', 'Rain'], ['SUN', 'Sun'], ['SAND', 'Sandstorm'], ['HAIL', 'Hail']], b.weather)}</select><select id="bf-terrain" aria-label="Terrain">${options([['', 'No terrain'], ['ELECTRIC', 'Electric'], ['GRASSY', 'Grassy'], ['PSYCHIC', 'Psychic'], ['MISTY', 'Misty']], b.terrain)}</select>
        <label><input type="checkbox" id="bf-tr" ${b.trickRoom ? 'checked' : ''}> Trick Room</label><label><input type="checkbox" id="bf-twu" ${b.tailwindUs ? 'checked' : ''}> Our Tailwind</label><label><input type="checkbox" id="bf-twt" ${b.tailwindThem ? 'checked' : ''}> Their Tailwind</label></div>
      <div class="segmented battle-tabs">${[['hits', 'Your hits'], ['taken', 'Their hits'], ['speed', 'Speed order']].map(([v, l]) => `<button data-bview="${v}" class="${b.view === v ? 'active' : ''}">${l}</button>`).join('')}</div>
      <div class="battle-body">${body}</div>
      <p class="footnote">Abilities such as Intimidate, items that trigger on entry, accuracy and crits aren’t applied here; open a cell in the calculator to set them.</p>`;
    $('battle-close').onclick = () => { state.battle.trainer = null; save(); renderBattle(); document.querySelectorAll('.trainer.planning').forEach(x => x.classList.remove('planning')); };
    el.querySelectorAll('[data-bview]').forEach(x => x.onclick = () => { b.view = x.dataset.bview; save(); renderBattle(); });
    el.querySelectorAll('[data-foe-toggle]').forEach(x => x.onclick = () => { const cur = new Set(battleFoes().filter(f => f.on).map(f => f.key)), k = x.dataset.foeToggle; if (cur.has(k)) cur.delete(k); else cur.add(k); b.foes = [...cur]; save(); renderBattle(); });
    el.querySelectorAll('[data-my-toggle]').forEach(x => x.onclick = () => { const k = x.dataset.myToggle, cur = b.active.filter(a => battleMine().some(m => m.key === a)), i = cur.indexOf(k); if (i >= 0) cur.splice(i, 1); else { if (cur.length >= 4) cur.shift(); cur.push(k); } b.active = cur; save(); renderBattle(); });
    el.querySelectorAll('[data-par]').forEach(x => x.onchange = () => { if (x.checked) b.par[x.dataset.par] = true; else delete b.par[x.dataset.par]; save(); renderBattle(); });
    el.querySelectorAll('[data-calc]').forEach(x => x.onclick = () => {
      const [ak, dk, mv] = x.dataset.calc.split('|'), get = k => k.startsWith('f:') ? battleFoes().find(f => f.key === k.slice(2))?.m : rosterMon(k.slice(2));
      const a = get(ak), d = get(dk); if (!a || !d) return;
      state.a = structuredClone(a); state.d = structuredClone(d); state.move = +mv; calcRef = ak.startsWith('m:') ? ak.slice(2) : null;
      state.field = {...state.field, doubles: true, weather: b.weather, terrain: b.terrain, trickRoom: b.trickRoom, power: null, crit: false}; syncSpread();
      save(); show('calculator'); window.scrollTo(0, 0);
    });
    $('bf-weather').onchange = () => { b.weather = $('bf-weather').value; save(); renderBattle(); };
    $('bf-terrain').onchange = () => { b.terrain = $('bf-terrain').value; save(); renderBattle(); };
    $('bf-tr').onchange = () => { b.trickRoom = $('bf-tr').checked; save(); renderBattle(); };
    $('bf-twu').onchange = () => { b.tailwindUs = $('bf-twu').checked; save(); renderBattle(); };
    $('bf-twt').onchange = () => { b.tailwindThem = $('bf-twt').checked; save(); renderBattle(); };
  }

  // search: stops, trainers, wild Pokémon and items, spoilers kept hidden ----------------------
  let searchTimer;
  $('search').oninput = () => { clearTimeout(searchTimer); searchTimer = setTimeout(() => { if ($('search').value.trim().length >= 2) show('results'); else if (currentView === 'results') show('guide'); }, 120); };
  $('search').onkeydown = e => { if (e.key === 'Escape') { $('search').value = ''; show('guide'); } };
  $('search-clear').onclick = () => { $('search').value = ''; show('guide'); };
  const trainerText = t => norm([t.displayName, t.symbol, ...t.maps.map(m => m.name), ...t.party.map(m => name('species', m.species)), ...(trainerById[t.partnerId]?.party || []).map(m => name('species', m.species))].join(' '));
  const trainerIndex = new Map(trainers.map(t => [t.id, trainerText(t)]));
  const mapLocked = map => mapChapter[map] != null && locked(mapChapter[map]);
  function renderResults() {
    const q = norm($('search').value), raw = $('search').value.trim();
    let hidden = 0;
    const visible = ci => { if (ci != null && locked(ci)) { hidden++; return false; } return true; };
    const stops = []; G.forEach((c, ci) => c.steps.forEach((s, si) => { if (norm(s.title + ' ' + s.maps.map(mapName).join(' ')).includes(q) && visible(ci)) stops.push([ci, si, s]); }));
    // one entry per rival meeting, shown for the chosen starter
    const seen = new Set(), ts = [];
    for (const t of trainers) {
      if (chapterOf[t.id] == null || !trainerIndex.get(t.id).includes(q) || !visible(chapterOf[t.id])) continue;
      const m = RIVAL.exec(t.symbol);
      if (!m) { ts.push({t}); continue; }
      if (seen.has(m[2])) continue; seen.add(m[2]);
      const [ci, si] = stepOf[t.id]; ts.push(rivalGroups(G[ci].steps[si].trainers).find(g => g.place === m[2]));
    }
    const wild = [];
    for (const s of species.filter(s => norm(name('species', s.id)).includes(q)).slice(0, 12)) {
      const all = D.wild.filter(w => w.slots.some(x => x.species === s.id)), where = all.filter(w => !mapLocked(w.map));
      hidden += all.length - where.length;
      if (where.length) wild.push([s, where]);
    }
    const its = items.filter(i => norm(i.name).includes(q)).slice(0, 16).map(i => [i, D.sources.filter(x => x.item === i.id && (!x.map || !mapLocked(x.map)))]).filter(x => x[1].length);
    $('results-title').textContent = `“${raw}”`;
    $('results-note').textContent = `${plural(stops.length, 'stop')} · ${plural(ts.length, 'trainer')} · ${wild.length} wild Pokémon · ${plural(its.length, 'item')}${hidden ? ` · ${hidden} past your badges hidden` : ''}`;
    const goto = map => { const ci = mapChapter[map]; if (ci == null) return 'disabled'; return `data-goto="${ci}.${G[ci].steps.findIndex(s => s.maps.includes(map))}"`; };
    const parts = [];
    if (stops.length) parts.push(`<h2 class="results-h">Stops</h2><div class="result-stops">${stops.slice(0, 24).map(([ci, si, s]) => `<button class="panel result-stop" data-goto="${ci}.${si}"><small>Chapter ${ci + 1} · ${esc(G[ci].title)}</small><b>${esc(s.title)}</b></button>`).join('')}</div>`);
    if (ts.length) parts.push(`<h2 class="results-h">Trainers</h2><div class="grid">${ts.slice(0, 12).map(g => { const t = g.t || rivalPick(g), [ci, si] = stepOf[t.id], link = `<div class="partner-bar"><button class="text-button" data-goto="${ci}.${si}">Go to ${esc(G[ci].steps[si].title)} →</button></div>`; return g.t ? trainerCard(g.t, link) : rivalCard(g); }).join('')}</div>${ts.length > 12 ? `<p class="footnote">${ts.length - 12} more: search more precisely.</p>` : ''}`);
    if (wild.length) parts.push(`<h2 class="results-h">Wild Pokémon</h2><div class="grid">${wild.map(([s, where]) => `<article class="panel"><div class="panel-head"><div class="who-line">${icon(s.id)}<h3>${esc(name('species', s.id))}</h3></div><span>${typePills(s.types || [])}</span></div><ul class="source-list">${where.slice(0, 10).map(w => { const sl = w.slots.filter(x => x.species === s.id), wt = sl.reduce((n, x) => n + x.weight, 0); return `<li><div class="source-line"><button class="text-button location" ${goto(w.map)}>${esc(w.mapName)}</button><span class="pct">${wt}%</span></div><div class="location-info"><span class="tag">${esc(w.method)}</span>Lv ${Math.min(...sl.map(x => x.minLevel))}–${Math.max(...sl.map(x => x.maxLevel))}</div></li>`; }).join('')}</ul>${where.length > 10 ? `<p class="footnote">${where.length - 10} more areas.</p>` : ''}</article>`).join('')}</div>`);
    if (its.length) parts.push(`<h2 class="results-h">Items</h2><div class="grid">${its.map(([i, src]) => `<article class="panel"><div class="panel-head"><div><div class="kicker">${esc(clean(i.pocket))}</div><h3>${esc(i.name)}</h3></div><span class="pill">${plural(src.length, 'source')}</span></div><p class="footnote" style="margin-top:0">${esc(i.description)}</p><ul class="source-list">${src.slice(0, 8).map(x => `<li><div class="source-line">${x.map ? `<button class="text-button location" ${goto(x.map)}>${esc(x.mapName || x.label)}</button>` : `<span class="location">${esc(x.label || 'Field menu')}</span>`}</div><div class="location-info"><span class="tag">${esc(x.kind)}</span>${x.x != null ? 'Tile ' + x.x + ', ' + x.y : ''}${x.minBadges != null ? ' · from ' + plural(x.minBadges, 'badge') : ''}</div></li>`).join('')}</ul>${src.length > 8 ? `<p class="footnote">${src.length - 8} more sources.</p>` : ''}</article>`).join('')}</div>`);
    $('results-body').innerHTML = parts.join('') || empty('Nothing found', 'Try a trainer, a place, a Pokémon or an item.');
  }

  // calculator -------------------------------------------------------------------------
  function card(side) {
    const m = state[side], sp = D.species[m.species], st = C.stats(D, m), isA = side === 'a';
    const abilityRows = [[0, 'No ability'], ...sp.abilities.filter(x => x > 0).map(id => [id, name('abilities', id)])];
    if (m.ability && !abilityRows.some(r => r[0] === m.ability)) abilityRows.push([m.ability, name('abilities', m.ability)]);
    const label = mm => esc((mm.nickname && mm.nickname !== name('species', mm.species).toUpperCase() ? mm.nickname + ' · ' : '') + name('species', mm.species)) + ' Lv' + mm.level;
    const teamOpts = ['me', 'partner'].filter(s => state.roster[s].length).map(s => `<optgroup label="${esc(sideName(s))}">${state.roster[s].map((mm, i) => `<option value="${s}:${i}">${label(mm)}</option>`).join('')}</optgroup>`).join('');
    const boxOpts = sync ? syncMons().filter(x => /^[br]:/.test(x[0])).map(([k, l, mm]) => `<option value="sync-${k}">${label(mm)} · ${esc(l)}</option>`).join('') : '';
    const fromTeams = teamOpts || boxOpts ? `<label class="field">From your teams<select data-from-team="${side}"><option value="">Choose a Pokémon…</option>${teamOpts}${boxOpts ? `<optgroup label="Boxes">${boxOpts}</optgroup>` : ''}</select></label>` : '';
    return `<div class="combatant-head"><span class="seat"><b>${isA ? 'A' : 'B'}</b>${isA ? 'ATTACKER' : 'DEFENDER'}</span><div>${typePills(sp.types)}</div></div>
     ${fromTeams}${isA && calcRef && rosterMon(calcRef) ? `<p class="footnote editing">Editing ${esc(sideName(calcRef.split(':')[0]))}’s ${esc(name('species', m.species))}: changes save to the team.</p>` : ''}
     <div class="form-grid species-row">${icon(m.species, 'big')}<label class="field">Pokémon<input data-mon="${side}" data-key="species" list="species-list" value="${esc(name('species', m.species))}" autocomplete="off"></label><label class="field">Level<input data-mon="${side}" data-key="level" type="number" min="1" max="100" value="${m.level}"></label></div>
     <div class="form-grid"><label class="field">Ability<select data-mon="${side}" data-key="ability">${options(abilityRows, m.ability)}</select></label><label class="field">Held item<input data-mon="${side}" data-key="item" list="item-list" value="${m.item ? esc(name('items', m.item)) : ''}" placeholder="No item"></label></div>
     <div class="form-grid three"><label class="field">Nature<select data-mon="${side}" data-key="nature">${options(Object.entries(D.natures).map(([id, n]) => [id, n.name]), m.nature)}</select></label><label class="field">Current HP<input data-mon="${side}" data-key="hp" type="number" min="1" max="${st.hp}" value="${m.hp ?? st.hp}" title="Maximum HP: ${st.hp}"></label><label class="field">Status<select data-mon="${side}" data-key="status">${options([['', 'Healthy'], ['BRN', 'Burn'], ['PAR', 'Paralysis'], ['PSN', 'Poison'], ['TOX', 'Bad poison'], ['SLP', 'Sleep'], ['FRZ', 'Freeze']], m.status)}</select></label></div>
     <div class="stat-row">${C.keys.map(k => `<div class="stat-cell"><small>${({hp: 'HP', atk: 'ATK', def: 'DEF', spa: 'SPA', spd: 'SPD', spe: 'SPE'})[k]}</small><strong>${st[k]}</strong></div>`).join('')}</div>
     <div class="form-grid four">${[0, 1, 2, 3].map(i => `<label class="field">Move ${i + 1}<input data-mon="${side}" data-move-slot="${i}" list="move-list" value="${m.moves?.[i] ? esc(name('moves', m.moves[i])) : ''}" placeholder="—"></label>`).join('')}</div>
     <details ${m.editOpen ? 'open' : ''} data-edit="${side}"><summary>IVs, EVs & stat stages</summary><div class="stat-edit"><span></span>${C.keys.map(k => `<span>${k.toUpperCase()}</span>`).join('')}${['ivs', 'evs', 'stages'].map(group => `<span>${group === 'stages' ? 'Stage' : group === 'ivs' ? 'IVs' : 'EVs'}</span>${C.keys.map(k => group === 'stages' && k === 'hp' ? '<span>—</span>' : `<input aria-label="${isA ? 'Attacker' : 'Defender'} ${k} ${group}" data-mon="${side}" data-group="${group}" data-key="${k}" type="number" min="${group === 'stages' ? -6 : 0}" max="${group === 'stages' ? 6 : group === 'ivs' ? 31 : 252}" value="${m[group]?.[k] || 0}">`).join('')}`).join('')}</div><p class="footnote">EV total: ${Object.values(m.evs || {}).reduce((n, v) => n + Number(v), 0)} / 510. Enter Intimidate and other entry effects as stages.</p><label class="field">Friendship (Return / Frustration)<input data-mon="${side}" data-key="friendship" type="number" min="0" max="255" value="${m.friendship ?? 255}"></label></details>
     <div class="checks"><label><input data-mon="${side}" data-key="tailwind" type="checkbox" ${m.tailwind ? 'checked' : ''}> Tailwind</label>${!isA ? `<label><input data-mon="${side}" data-key="reflect" type="checkbox" ${m.reflect ? 'checked' : ''}> Reflect</label><label><input data-mon="${side}" data-key="lightScreen" type="checkbox" ${m.lightScreen ? 'checked' : ''}> Light Screen / Veil</label>` : ''}</div>
     ${isA ? `<div class="toolbar tight">${['me', 'partner'].map(s => `<button class="button small" data-roster-add="${s}" ${state.roster[s].length >= 6 ? 'disabled' : ''}>Add to ${esc(sideName(s))}’s team</button>`).join('')}</div>` : ''}`;
  }
  // the attacker writes back to its team slot while one is being edited
  function writeBack() { if (!calcRef || !rosterMon(calcRef)) return; const [s, i] = calcRef.split(':'); state.roster[s][+i] = structuredClone(state.a); renderRoster(); }
  function renderCombatants() {
    $('attacker-card').innerHTML = card('a'); $('defender-card').innerHTML = card('d');
    document.querySelectorAll('[data-from-team]').forEach(el => el.addEventListener('change', () => {
      const v = el.value, m = v.startsWith('sync-') ? syncMon(v.slice(5)) : rosterMon(v); if (!m) return;
      state[el.dataset.fromTeam] = structuredClone(m);
      if (el.dataset.fromTeam === 'a') { calcRef = v.startsWith('sync-') ? null : v; chooseDefaultMove(); }
      renderCalc(); save();
    }));
    document.querySelectorAll('[data-mon]').forEach(el => el.addEventListener('change', () => {
      const side = el.dataset.mon, k = el.dataset.key, m = state[side];
      if (el.dataset.moveSlot != null) { const row = el.value.trim() ? lookup(moves, el.value) : {id: 0}; if (!row) { toast('Choose a move from the list.'); return; } const ms = [0, 1, 2, 3].map(i => m.moves?.[i] || 0); ms[+el.dataset.moveSlot] = row.id; m.moves = ms.filter(Boolean); }
      else if (k === 'species') { const row = lookup(species, el.value); if (!row) { toast('Choose a Pokémon from the list.'); el.value = name('species', m.species); return; } state[side] = freshMon(row.id, m.level); }
      else if (k === 'item') { const row = el.value.trim() ? lookup(items, el.value) : {id: 0}; if (!row) { toast('Choose an item from the list, or leave it blank.'); return; } m.item = row.id; }
      else if (el.dataset.group) { m[el.dataset.group] ||= {}; m[el.dataset.group][k] = Math.max(+el.min, Math.min(+el.max, Math.floor(+el.value || 0))); }
      else if (el.type === 'checkbox') m[k] = el.checked;
      else if (k === 'status') m[k] = el.value;
      else { m[k] = Number(el.value); if (el.type === 'number') m[k] = Math.max(+el.min, Math.min(+el.max, Math.floor(+el.value || 0))); if (['level', 'nature'].includes(k)) m.hp = null; }
      if (side === 'a' && (k === 'species' || el.dataset.moveSlot != null)) chooseDefaultMove();
      if (side === 'a') writeBack();
      renderCalc(); save();
    }));
    document.querySelectorAll('[data-edit]').forEach(el => el.addEventListener('toggle', () => { state[el.dataset.edit].editOpen = el.open; save(); }));
  }
  function chooseDefaultMove() { if (!(state.a.moves || []).includes(state.move)) { const found = (state.a.moves || []).find(id => D.moves[id]?.category !== 'status'); if (found) state.move = found; } syncSpread(); }
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
  $('swap-sides').onclick = () => { [state.a, state.d] = [state.d, state.a]; calcRef = null; chooseDefaultMove(); renderCalc(); save(); };
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

  // notes export / import ------------------------------------------------------------------
  const NOTES_FORMAT = 'emerald-field-guide-notes';
  function download(data, filename) { const url = URL.createObjectURL(new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'})), a = document.createElement('a'); a.href = url; a.download = filename; a.click(); setTimeout(() => URL.revokeObjectURL(url), 1000); }
  function exportNotes() { download({format: NOTES_FORMAT, schema: 2, campaignVersion: D.meta.campaignVersion, notes: state.notes, planned: state.planned, guideDone: state.guideDone, gotItems: state.gotItems, roster: state.roster, rival: state.rival}, 'emerald-notes-' + new Date().toISOString().slice(0, 10) + '.json'); toast('Notes exported. Send the file with this guide to your partner.'); }
  function validateNotes(v) {
    const str = (x, n) => String(x ?? '').slice(0, n), keyOk = k => /^\d+\.\d+$/.test(k) && !!G[+k.split('.')[0]]?.steps[+k.split('.')[1]];
    if (v?.format === 'emerald-field-guide-plan' && Array.isArray(v.plan?.stops)) return {legacy: v.plan.stops};
    if (v?.format !== NOTES_FORMAT || v.schema !== 2) throw Error('This is not a notes file from this guide.');
    const pick = (o, f) => Object.fromEntries(Object.entries(o && typeof o === 'object' ? o : {}).filter(([k]) => keyOk(k)).map(([k, x]) => [k, f(x)]));
    const team = l => (Array.isArray(l) ? l : []).filter(m => D.species[m?.species]).slice(0, 6).map(m => ({...freshMon(m.species, Math.max(1, Math.min(100, +m.level || 1))), ...m, moves: (Array.isArray(m.moves) ? m.moves : []).filter(id => D.moves[id]).slice(0, 4)}));
    return {notes: pick(v.notes, x => str(x, 3000)), planned: pick(v.planned, x => ({mine: str(x?.mine, 100), partner: str(x?.partner, 100)})), guideDone: pick(v.guideDone, () => true),
      gotItems: Object.fromEntries(Object.keys(v.gotItems || {}).filter(k => D.sources[+k]).map(k => [k, true])), roster: {me: team(v.roster?.me), partner: team(v.roster?.partner)}};
  }
  $('export-notes').onclick = exportNotes; $('import-notes').onclick = () => $('import-file').click();
  $('import-file').onchange = async () => {
    const file = $('import-file').files[0]; if (!file) return;
    try {
      if (file.size > 2e6) throw Error('The notes file is too large.');
      const v = JSON.parse(await file.text()), n = validateNotes(v);
      if (n.legacy) { migratePlan(n.legacy); save(); renderGuide(); toast('Old plan imported into the stops’ notes.'); return; }
      if ((Object.keys(state.notes).length || state.roster.me.length) && !confirm('Replace your notes and teams with the imported ones? Export yours first if you want to keep them.')) return;
      Object.assign(state, n); save(); renderGuide();
      toast(v.campaignVersion === D.meta.campaignVersion ? 'Notes imported.' : 'Notes imported from guide ' + v.campaignVersion + '. Check for changed teams and locations.');
    } catch (e) { toast(e.message || 'Could not read this file.'); } finally { $('import-file').value = ''; }
  };

  // about -------------------------------------------------------------------------------
  const hand = trainers.filter(t => t.handpicked).length;
  $('about-content').innerHTML = `<p><strong>Campaign ${esc(D.meta.campaignVersion)} · Co-op ${esc(D.meta.coopVersion)}</strong><br>Made for stock Gen1Recomp ${esc(D.meta.engineVersion)}. Works offline; everything is inside this file.</p>
    <p><strong>Route guide.</strong> Vanilla Emerald’s story in order, one chapter per level cap. Each stop lists its trainers (with tag partners and rematches), wild tables, items, shops at your badge count, and your own notes. ${hand} of ${trainers.length} trainers have hand-picked teams; the rest are generated from the donor hack’s and marked “Generated”.</p>
    <p><strong>Battle plans.</strong> “Battle plan ⚔” on a trainer opens a side panel against your teams: each side’s best move with damage and KO odds, spread damage (and what hits your own ally), and the speed order with Tailwind, Trick Room and paralysis. Every cell opens in the calculator.</p>
    <p><strong>Your game.</strong> START › GUIDE SYNC (or saving) writes guide-sync.bin; Load game reads it to fill both teams, tick off beaten trainers and found items, show Soul Link pairs, and hide chapters past your badges.</p>
    <p><strong>Calculator.</strong> Direct damage for one attacker and defender, with IVs, EVs, natures, stages, current HP, status, supported abilities and items, weather, terrain, screens, spread damage and crits. Entry triggers such as Intimidate go in as stages. It is not a full battle simulator.</p>
    <p><strong>Notes</strong> are stored in this browser. Use Export / Import to share or back up.</p>
    <p><strong>Data coverage and limits</strong></p><ul>${D.meta.limitations.map(x => `<li>${esc(x)}</li>`).join('')}</ul>
    <p class="footnote">Pokémon © Nintendo / Creatures / GAME FREAK. Campaign by Aeryk Kisor; some species, moves, trainer and item data and the Pokémon icons adapted from Inclement Emerald by Buffel Saft and contributors; Gen1Recomp by BOIS CLUB GAMES. No ROM or save data is included.</p>`;
  $('about-footer').onclick = $('about-open').onclick = () => $('about').showModal(); $('about-close').onclick = () => $('about').close();
  document.querySelector('.brand').onclick = e => { e.preventDefault(); $('search').value = ''; show('guide'); };

  if (sync && state.rosterFollowsGame && !state.roster.me.length) rosterFromGame(true);
  renderSyncChip(); show(location.hash.slice(1) === 'calculator' ? 'calculator' : 'guide');
  // A small explicit test surface for the offline browser smoke harness.
  window.GuideTest = {get state() { return state; }, get sync() { return sync; }, loadSync, data: D, show, renderGuide, renderCalc, openBattle, gotoStep, validateNotes, lookup, rematches};
})();
