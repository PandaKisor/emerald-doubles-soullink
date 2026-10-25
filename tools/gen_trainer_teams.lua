-- Draft 2 of the campaign's trainer teams: every first-fight vanilla trainer
-- that campaign/trainer_teams.lua doesn't author by hand, converted from
-- Inclement Emerald's team for the same trainer (tools/inclement_trainers.lua)
-- onto fixed levels and the campaign's cap schedule. Writes
-- campaign/trainer_teams_gen.lua, which campaign/content.lua loads under the
-- hand-authored teams (a hand-authored trainer always wins).
--
--   * Levels: Inclement's levels are relative to the player's best Pokémon;
--     here they're relative to the cap of the next boss in vanilla story
--     order (CAPS), clamped into a band per kind of fight (BAND).
--   * A Pokémon too evolved for its new level is scaled back to the stage it
--     could have at that level (Machoke at 22 -> Machop).
--   * Moves without battle support are dropped and topped up from the
--     level-up learnset; abilities are Inclement's slot on the (possibly
--     scaled back) species; unknown items are dropped.
--   * Route trainers with up to three Pokémon get a tag partner whose team is
--     drawn from the same area's Inclement teams; gym trainers, story fights
--     and bosses fight alone. A boss's ace sits on the cap.
--
-- Run from Gen3Mod/gen1recomp-0.3.73 after build_campaign.py:
--   luajit ../porting/native/tools/gen_trainer_teams.lua
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
require('src.import.gba.trainer_extract').run(F.rom, require('src.core.game3.dataset').cache(), { game = 'emerald' })
local Trainers = require('src.core.game3.scripting.trainers')
local C = require('src.core.game3.constants').of('emerald')
local SD = require('src.core.SaveData')
local inc = assert(loadfile('../porting/native/tools/inclement_trainers.lua'))()
local hand = assert(loadfile('../porting/native/campaign/trainer_teams.lua'))()
local OUT = '../porting/native/campaign/trainer_teams_gen.lua'
local data, ids, supported = F.data, F.ids, F.campaign.battleMoves

-- the cap schedule: each boss's ace, in g3_coop's milestone order ----------------
local CAPS = {
  BRAWLY_1 = 19, RIVAL_ROUTE_110 = 20, WALLY_MAUVILLE = 21, WATTSON_1 = 24,
  TABITHA_MT_CHIMNEY = 25, MAXIE_MT_CHIMNEY = 26, FLANNERY_1 = 29, NORMAN_1 = 31,
  SHELLY_WEATHER_INSTITUTE = 32, RIVAL_ROUTE_119 = 33, WINONA_1 = 34, RIVAL_LILYCOVE = 35,
  TABITHA_MAGMA_HIDEOUT = 36, MAXIE_MAGMA_HIDEOUT = 37, MATT = 38,
  MAXIE_MOSSDEEP = 42, TABITHA_MOSSDEEP = 42, TATE_AND_LIZA_1 = 42,
  SHELLY_SEAFLOOR_CAVERN = 43, ARCHIE = 44, JUAN_1 = 46, WALLY_VR_1 = 48,
  SIDNEY = 50, PHOEBE = 52, GLACIA = 54, DRAKE = 56, WALLACE = 58,
}
-- bosses that are leaders (full 31 IVs / 252 EVs) rather than story rivals
local LEADER = { BRAWLY_1 = true, WATTSON_1 = true, FLANNERY_1 = true, NORMAN_1 = true, WINONA_1 = true,
  TATE_AND_LIZA_1 = true, JUAN_1 = true, SIDNEY = true, PHOEBE = true, GLACIA = true, DRAKE = true, WALLACE = true,
  MAXIE_MT_CHIMNEY = true, MAXIE_MAGMA_HIDEOUT = true, ARCHIE = true }
-- the Space Center multi: Maxie and Tabitha each bring three beside each other
local MULTI = { MAXIE_MOSSDEEP = 3, TABITHA_MOSSDEEP = 3 }

-- Inclement's areas -> the cap of the next boss in vanilla play, and the kind
-- of fight. Kinds: route (tag partner), gym (alone), story (alone, grunt tier).
local SECTIONS = {
  ['Route 116'] = { 15, 'route' },
  ['Route 116: Requires Cut'] = { 17, 'route' }, ['Rusturf Tunnel'] = { 17, 'story' },
  ['Route 106 (Dewford Town Access)'] = { 19, 'route' }, ['Dewford Gym'] = { 19, 'gym' },
  ['Route 109 Beach'] = { 20, 'route' }, ['Seashore House'] = { 20, 'route' },
  ['Route 110 (player level ~28)'] = { 20, 'route' }, ['Route 103 East'] = { 20, 'route' },
  ['Route 110 Cycling Road'] = { 24, 'route' }, ['Trick House 1'] = { 24, 'route' },
  ['Route 118'] = { 24, 'route' }, ['Route 117'] = { 24, 'route' }, ['Winstrates'] = { 24, 'route' },
  ['Route 111 South'] = { 24, 'route' }, ['Mauville Gym'] = { 24, 'gym' },
  ['Trick House 2: Dynamo Badge'] = { 25, 'route' }, ['Route 111 North of Rocks'] = { 25, 'route' },
  ['Route 120 Gabby'] = { 25, 'route' }, ['Route 112'] = { 25, 'route' },
  ['Quality team design right here'] = { 25, 'route' }, ['Route 113'] = { 25, 'route' },
  ['Route 114'] = { 25, 'route' }, ['Route 115 South'] = { 25, 'route' }, ['Mt. Chimney'] = { 25, 'route' },
  ['Jagged Pass'] = { 29, 'route' }, ['Lavaridge Gym'] = { 29, 'gym' },
  ['Route 111 Desert'] = { 31, 'route' }, ['Trick House 3: Heat Badge'] = { 31, 'route' },
  ['Petalburg Gym'] = { 31, 'gym' },
  ['Trick House 4: Balance Badge'] = { 32, 'route' }, ['Route 103 Surfing'] = { 32, 'route' },
  ['Route 115 North (Requires Surf)'] = { 32, 'route' }, ['Route 105'] = { 32, 'route' },
  ['Route 106 Surfing'] = { 32, 'route' }, ['Route 107'] = { 32, 'route' }, ['Route 108'] = { 32, 'route' },
  ['Route 109 Surfing'] = { 32, 'route' }, ['Abandoned Ship'] = { 32, 'route' },
  ['Route 118 East'] = { 32, 'route' }, ['Route 123: Route 118 access'] = { 32, 'route' },
  ['Bug Catchers/Maniacs'] = { 32, 'route' }, ['Rangers'] = { 32, 'route' }, ['Other'] = { 32, 'route' },
  ['Weather Institute'] = { 32, 'story' },
  ['Route 120'] = { 34, 'route' }, ['Fortree Gym'] = { 34, 'gym' },
  ['Route 121'] = { 35, 'route' }, ['Route 123'] = { 35, 'route' },
  ['Mt. Pyre Interior'] = { 36, 'route' }, ['Mt. Pyre Summit'] = { 36, 'story' },
  ['Magma Hideout'] = { 36, 'story' }, ['Aqua Hideout'] = { 38, 'story' },
  ['Route 124'] = { 42, 'route' }, ['Route 125'] = { 42, 'route' }, ['Route 126'] = { 42, 'route' },
  ['Route 127'] = { 42, 'route' }, ['Route 128'] = { 42, 'route' }, ['Route 129'] = { 42, 'route' },
  ['Route 130'] = { 42, 'route' }, ['Route 131'] = { 42, 'route' }, ['Route 132'] = { 42, 'route' },
  ['Route 133'] = { 42, 'route' }, ['Route 134'] = { 42, 'route' }, ['Mossdeep Gym'] = { 42, 'gym' },
  ['Mossdeep Space Center'] = { 42, 'story' },
  ['Trick House 6: Mind Badge'] = { 43, 'route' }, ['Seafloor Cavern'] = { 43, 'story' },
  ['Sootopolis Gym'] = { 46, 'gym' },
  ['Trick House 7: Rain Badge'] = { 48, 'route' }, ['Meteor Falls'] = { 48, 'route' },
  ['Victory Road'] = { 48, 'route' }, ['Trick House 8: Post Game'] = { 50, 'route' },
  -- the S.S. Tidal only sails after the Hall of Fame in Emerald
  ['SS Tidal'] = { 58, 'route' },
  ['Ever Grande/Pokemon League'] = { 58, 'route' },
}
-- trainers Inclement files by character, not area
local STORY = {
  GRUNT_MUSEUM_1 = 20, GRUNT_MUSEUM_2 = 20, GRUNT_MT_CHIMNEY_1 = 25, GRUNT_MT_CHIMNEY_2 = 25,
  GRUNT_JAGGED_PASS = 36,
}
local RIVAL = { ROUTE_110 = 'RIVAL_ROUTE_110', ROUTE_119 = 'RIVAL_ROUTE_119', LILYCOVE = 'RIVAL_LILYCOVE' }
-- Steven is the player's partner in the Space Center multi: keep the ROM's
local SKIP = { STEVEN = true }

-- level bands per kind: cap + Inclement's offset + shift, clamped
local BAND = {
  route = { shift = -2, lo = -8, hi = -2 },
  gym = { shift = -1, lo = -5, hi = -2 },
  story = { shift = -1, lo = -6, hi = -1 },
  boss = { shift = 0, lo = -4, hi = -1 },
}
local TIER = { route = 'route', gym = 'gym', story = 'grunt', boss = 'gym' }

-- helpers -----------------------------------------------------------------------
local function clamp(v, lo, hi) return math.max(lo, math.min(hi, v)) end
local function hash(s)
  local h = 5381
  for i = 1, #s do h = (h * 33 + s:byte(i)) % 2147483647 end
  return h
end
local function speciesRow(name) local id = ids.species['SPECIES_' .. name]; return id and data.species[id], id end
local function moveOk(name)
  local id = ids.moves['MOVE_' .. name]
  return id ~= nil and (id <= 354 or supported[id] == true)
end
local function moveName(id) return data.moves[id] and data.moves[id].symbol and data.moves[id].symbol:gsub('^MOVE_', '') end

-- prevolutions, and the level each evolution may happen at
local prevo = {}
for from, list in pairs(inc.evolutions) do
  for _, e in ipairs(list) do
    if not e.method:find('MEGA') and not e.method:find('PRIMAL') and not e.method:find('MOVE_TYPE') then
      prevo[e.into] = prevo[e.into] or { from = from, method = e.method, param = e.param }
    end
  end
end
local function stage(name)
  local n, s = 0, name
  while prevo[s] do n, s = n + 1, prevo[s].from end
  return n
end
-- the level an evolution is allowed at: level-up ones at their level; other
-- methods once a trainer could plausibly have it
local function evoLevel(name)
  local p = prevo[name]
  if p.method:find('^EVO_LEVEL') and p.param > 0 then return p.param end
  if p.method == 'EVO_TRADE' or p.method == 'EVO_TRADE_ITEM' then return stage(name) >= 2 and 36 or 30 end
  return stage(name) >= 2 and 30 or 18
end
local function scaleBack(name, level)
  while prevo[name] and level < evoLevel(name) and speciesRow(prevo[name].from) do name = prevo[name].from end
  return name
end

local function learnsetMoves(row, level)
  local out = {}
  for _, e in ipairs(row.learnset) do
    if e[1] <= level then
      local nm = moveName(e[2])
      if nm then
        for i = #out, 1, -1 do if out[i] == nm then table.remove(out, i) end end
        out[#out + 1] = nm
      end
    end
  end
  return out
end
-- a move this species could know at `level`: level-up by then, an egg move,
-- or a TM/tutor move that isn't too strong for the level (Hyper Beam waits)
local function legal(row, level, name)
  local id = ids.moves['MOVE_' .. name]
  if not id then return false end
  for _, e in ipairs(row.learnset) do if e[2] == id then return e[1] <= level end end
  for _, e in ipairs(row.eggMoves) do if e == id then return true end end
  local taught = false
  for _, item in ipairs(row.machines) do if data.items[item] and data.items[item].machineMove == id then taught = true end end
  for _, t in ipairs(row.tutors) do if data.manifest.tutorMoves[t] == id then taught = true end end
  if not taught then return false end
  local power = data.moves[id] and data.moves[id].power or 0
  return power <= 1 or power <= level * 3 + 30
end
local function fillMoves(row, level, wanted)
  local moves, seen = {}, {}
  for _, m in ipairs(wanted or {}) do
    if #moves < 4 and not seen[m] and moveOk(m) and legal(row, level, m) then moves[#moves + 1], seen[m] = m, true end
  end
  local pool = learnsetMoves(row, level)
  for i = #pool, 1, -1 do
    if #moves >= 4 then break end
    local m = pool[i]
    if not seen[m] and moveOk(m) then moves[#moves + 1], seen[m] = m, true end
  end
  if #moves == 0 then moves[1] = 'TACKLE' end
  return moves
end

local function abilityName(row, slot)
  local a = row.abilities[(slot or 0) + 1]
  if not a or a == 0 then a = row.abilities[1] end
  local info = a and a ~= 0 and data.abilities[a]
  return info and info.symbol and info.symbol:gsub('^ABILITY_', '')
end

-- a role-based EV spread and nature, as in draft 1
local function role(row)
  local s = row.stats
  local phys = s.atk >= s.spa
  local offense = math.max(s.atk, s.spa)
  if offense < math.max(s.def, s.spd) and s.spe < 70 then
    if s.def >= s.spd then return 'bulk', phys and 'IMPISH' or 'BOLD' end
    return 'spdef', phys and 'CAREFUL' or 'CALM'
  end
  if phys then return 'atk', s.spe >= 80 and 'JOLLY' or 'ADAMANT' end
  return 'spa', s.spe >= 80 and 'TIMID' or 'MODEST'
end

local stats = { converted = 0, scaled = 0, droppedItems = 0, droppedMoves = 0, missing = {} }
-- one Inclement mon -> an authored spec at `level`
local function convert(m, level)
  local name = scaleBack(m.species, level)
  if name ~= m.species then stats.scaled = stats.scaled + 1 end
  local row = speciesRow(name)
  if not row then stats.missing[#stats.missing + 1] = m.species return nil end
  local spec = { name, level }
  local wanted = m.moves or {}
  for _, mv in ipairs(wanted) do if not (moveOk(mv) and legal(row, level, mv)) then stats.droppedMoves = stats.droppedMoves + 1 end end
  spec.moves = fillMoves(row, level, wanted)
  spec.ability = abilityName(row, m.ability)
  if m.item then
    -- (Mega Stones and Z-Crystals have no row: the build strips them)
    local item = ids.items['ITEM_' .. m.item]
    if item and data.items[item] then spec.item = m.item else stats.droppedItems = stats.droppedItems + 1 end
  end
  local spread = m.spread and inc.spreads[m.spread]
  local r, nature = role(row)
  spec.spread = r
  spec.nature = (spread and spread.nature ~= 'HARDY') and spread.nature or nature
  -- a boss's hand-made Inclement spread carries its EVs over
  if spread then
    local e, total, uniform = spread.evs, 0, true
    for _, v in pairs(e) do total = total + v; if v ~= e.hp then uniform = false end end
    if total > 0 and not uniform then spec.evs = { hp = e.hp, atk = e.atk, def = e.def, spa = e.spa, spd = e.spd, spe = e.spe } end
  end
  stats.converted = stats.converted + 1
  return spec
end

-- which trainers to write -----------------------------------------------------------
local vanilla = C.trainers.byName
local function isRematch(c)
  if c:find('^GRUNT_') then return false end
  return c:match('_[2-9]$') ~= nil or c:match('_1[0-9]$') ~= nil
end
local plan, order, seen = {}, {}, {}
for _, sec in ipairs(inc.sections) do
  for _, t in ipairs(sec.trainers) do
    local c = t.const
    if not seen[c] and vanilla['TRAINER_' .. c] and not hand.trainers[c] and not isRematch(c) and not SKIP[c] then
      seen[c] = true
      local cap, kind
      local rival = c:match('^BRENDAN_(.-)_[A-Z]+$') or c:match('^MAY_(.-)_[A-Z]+$')
      if CAPS[c] then cap, kind = CAPS[c], 'boss'
      elseif rival and RIVAL[rival] then cap, kind = CAPS[RIVAL[rival]], 'boss'
      elseif STORY[c] then cap, kind = STORY[c], 'story'
      elseif SECTIONS[sec.name] then
        cap, kind = SECTIONS[sec.name][1], SECTIONS[sec.name][2]
        if c:find('^GRUNT_') then kind = 'story' end
      end
      if cap then
        plan[c] = { const = c, section = sec.name, cap = cap, kind = kind, party = t.party, double = t.double }
        order[#order + 1] = c
      else
        io.stderr:write('no cap for ' .. c .. ' (' .. sec.name .. ')\n')
      end
    end
  end
end

-- the ROM's double-battle flag (twins and couples bring both halves)
SD.setCart('none')
for _, c in ipairs(order) do
  local t = Trainers.get(vanilla['TRAINER_' .. c])
  plan[c].romDouble = t and t.doubleBattle and true or false
  plan[c].gender = t and t.gender or 0
  plan[c].className = t and t.className or '?'
end
SD.setCart('emerald_doubles_soullink')

local function levelFor(p, off)
  local b = BAND[p.kind]
  return clamp(p.cap + off + b.shift, math.max(2, p.cap + b.lo), p.cap + b.hi)
end
local function buildParty(p)
  local src, out = p.party, {}
  local limit = MULTI[p.const] or 6
  -- the Space Center pair keep their strongest three
  if #src > limit then
    local sorted = {}
    for i, m in ipairs(src) do sorted[i] = { m = m, i = i } end
    table.sort(sorted, function(a, b) if a.m.lvl ~= b.m.lvl then return a.m.lvl > b.m.lvl end return a.i > b.i end)
    local keep = {}
    for i = 1, limit do keep[sorted[i].i] = true end
    local trimmed = {}
    for i, m in ipairs(src) do if keep[i] then trimmed[#trimmed + 1] = m end end
    src = trimmed
  end
  local ace = 1
  for i, m in ipairs(src) do if m.lvl >= src[ace].lvl then ace = i end end
  for i, m in ipairs(src) do
    local level
    if p.kind == 'boss' then
      level = (i == ace) and p.cap or clamp(p.cap + m.lvl, p.cap + BAND.boss.lo, p.cap + BAND.boss.hi)
    else
      level = levelFor(p, m.lvl)
    end
    local spec = convert(m, level)
    if spec then out[#out + 1] = spec end
  end
  -- the ace goes last, as in draft 1 (and the cap reads the highest level)
  return out
end

-- partners ----------------------------------------------------------------------------
local NAMES = {
  [0] = { 'ADAM', 'BRAD', 'CARL', 'DREW', 'ERIK', 'FINN', 'GLEN', 'HANK', 'IAN', 'JACK', 'KURT', 'LEON', 'MILO', 'NATE',
    'OTIS', 'PAUL', 'REX', 'SETH', 'TODD', 'VAN', 'WES', 'ZANE', 'ABE', 'BO', 'CODY', 'DEAN', 'ELI', 'FRED', 'GUS',
    'HAL', 'IKE', 'JON', 'KEN', 'LUKE', 'MAX', 'NED', 'OSCAR', 'PETE', 'RAY', 'SAM', 'TOM', 'VIC', 'WILL', 'YURI',
    'AXEL', 'BART', 'CLAY', 'DUKE', 'EZRA', 'FLOYD', 'GRANT', 'HUGO', 'JAKE', 'KANE', 'LYLE', 'MARK', 'NOEL', 'OWEN',
    'REID', 'SID', 'TROY', 'VINCE', 'WADE', 'ZEKE' },
  [1] = { 'ADA', 'BEA', 'CARA', 'DEB', 'EVA', 'FAY', 'GWEN', 'HOPE', 'IDA', 'JUNE', 'KAY', 'LILA', 'MAE', 'NELL',
    'OLGA', 'PAM', 'ROSE', 'SUE', 'TESS', 'UMA', 'VERA', 'WREN', 'ZOE', 'AMY', 'BETH', 'CLEO', 'DORA', 'EDIE',
    'FLO', 'GAIL', 'HEDY', 'IRIS', 'JADE', 'KIM', 'LIV', 'MIA', 'NIA', 'OPAL', 'PIA', 'RUBY', 'SKYE', 'TINA', 'VAL',
    'WYN', 'ALMA', 'BREE', 'CINDI', 'DAWN', 'ELLA', 'FERN', 'GINA', 'HAZEL', 'INEZ', 'JOY', 'KARA', 'LENA', 'MAYA',
    'NORA', 'PEARL', 'RHEA', 'SAGE', 'TARA', 'VIV', 'WILLA' },
}
local DEFEAT = {
  "We lost together, at least...", "You two make a great team!", "Our team-up fell apart!",
  "Next time we'll be in sync!", "I should've covered my partner!", "That combo was too much!",
  "We'll train together and come back!", "Two against two, and we still lost!",
}
local partners, usedNames = {}, {}
for _, c in ipairs(order) do usedNames[c] = true end
local function pickName(p)
  local pool = NAMES[p.gender == 1 and 1 or 0]
  local i = hash(p.const) % #pool
  for k = 0, #pool - 1 do
    local n = pool[(i + k) % #pool + 1]
    if not usedNames[n] then usedNames[n] = true return n end
  end
  return pool[i + 1] .. '2'
end
-- the area's Inclement Pokémon, for partner teams
local areaPool, gymPool = {}, {}
for _, sec in ipairs(inc.sections) do
  local pool, gym = {}, {}
  -- (a gym's own trainers pad a lone gym trainer)
  for _, t in ipairs(sec.trainers) do
    if not CAPS[t.const] then for _, m in ipairs(t.party) do gym[#gym + 1] = m end end
  end
  gymPool[sec.name] = gym
  -- (route trainers' Pokémon only: no boss or gym sets)
  for _, t in ipairs(sec.trainers) do
    local kind = SECTIONS[sec.name] and SECTIONS[sec.name][2]
    if kind == 'route' and not CAPS[t.const] and not t.const:find('^GRUNT_') then
      for _, m in ipairs(t.party) do pool[#pool + 1] = m end
    end
  end
  areaPool[sec.name] = pool
end
local function partnerParty(p, own, count)
  local pool = areaPool[p.section] or {}
  if #pool == 0 then pool = gymPool[p.section] or {} end
  local have, out = {}, {}
  for _, m in ipairs(own) do have[m[1]] = true end
  local start = hash(p.const .. '#') % math.max(1, #pool)
  for k = 0, #pool - 1 do
    if #out >= count then break end
    local m = pool[(start + k * 7) % #pool + 1]
    local level = levelFor(p, m.lvl) - (#out == 0 and 1 or 0)
    local spec = convert(m, level)
    if spec and not have[spec[1]] then have[spec[1]] = true; out[#out + 1] = spec end
  end
  return out
end

-- write ----------------------------------------------------------------------------------
local trainers = {}
for _, c in ipairs(order) do
  local p = plan[c]
  local party = buildParty(p)
  local t = { party = party, tier = LEADER[c] and 'leader' or TIER[p.kind] }
  local alone = p.kind ~= 'route' or p.romDouble or #party >= 4
  if not alone then
    if #party > 3 then for i = #party, 4, -1 do table.remove(party, i) end end
    local key = 'P_' .. c
    local extra = partnerParty(p, party, #party == 1 and 3 or 2)
    if #extra >= 1 then
      partners[key] = { like = c, name = pickName(p), defeat = DEFEAT[hash(c) % #DEFEAT + 1], party = extra, section = p.section }
      t.partner = key
    end
  end
  -- a lone trainer needs two for a double
  if not t.partner and #party < 2 then
    local extra = partnerParty(p, party, 2 - #party)
    for _, s in ipairs(extra) do table.insert(party, 1, s) end
  end
  t.section, t.cap, t.kind = p.section, p.cap, p.kind
  trainers[c] = t
end

local function q(s) return string.format('%q', s) end
local function specText(s)
  local parts = { q(s[1]), tostring(s[2]) }
  if s.ability then parts[#parts + 1] = 'ability = ' .. q(s.ability) end
  if s.nature then parts[#parts + 1] = 'nature = ' .. q(s.nature) end
  if s.spread and s.spread ~= 'atk' then parts[#parts + 1] = 'spread = ' .. q(s.spread) end
  if s.evs then
    parts[#parts + 1] = string.format('evs = { hp = %d, atk = %d, def = %d, spa = %d, spd = %d, spe = %d }',
      s.evs.hp, s.evs.atk, s.evs.def, s.evs.spa, s.evs.spd, s.evs.spe)
  end
  if s.item then parts[#parts + 1] = 'item = ' .. q(s.item) end
  local mv = {}
  for i, m in ipairs(s.moves) do mv[i] = q(m) end
  parts[#parts + 1] = 'moves = { ' .. table.concat(mv, ', ') .. ' }'
  return '      { ' .. table.concat(parts, ', ') .. ' },'
end

local lines = {
  '-- Generated by tools/gen_trainer_teams.lua (draft 2, ' .. os.date('%Y-%m-%d') .. '): every first-fight',
  '-- vanilla trainer campaign/trainer_teams.lua does not author by hand, from',
  "-- Inclement Emerald's team for the same trainer on the campaign's fixed",
  '-- levels and cap schedule. Hand-authored teams win; edit those, or move a',
  '-- trainer there to tune it, rather than editing this file.',
  'return {',
  '  trainers = {',
}
local lastSection
for _, c in ipairs(order) do
  local t = trainers[c]
  if t.section ~= lastSection then
    lines[#lines + 1] = ''
    lines[#lines + 1] = ('    -- %s (cap %d) %s'):format(t.section, t.cap, ('-'):rep(math.max(4, 70 - #t.section)))
    lastSection = t.section
  end
  local head = '    ' .. c .. ' = { '
  if t.partner then head = head .. 'partner = ' .. q(t.partner) .. ', ' end
  if t.tier ~= 'route' then head = head .. 'tier = ' .. q(t.tier) .. ', ' end
  lines[#lines + 1] = head .. 'party = {'
  for _, s in ipairs(t.party) do lines[#lines + 1] = specText(s) end
  lines[#lines + 1] = '    } },'
end
lines[#lines + 1] = '  },'
lines[#lines + 1] = ''
lines[#lines + 1] = '  partners = {'
local pnames = {}
for k in pairs(partners) do pnames[#pnames + 1] = k end
table.sort(pnames, function(a, b)
  local ia, ib
  for i, c in ipairs(order) do if 'P_' .. c == a then ia = i end if 'P_' .. c == b then ib = i end end
  return ia < ib
end)
for _, k in ipairs(pnames) do
  local p = partners[k]
  lines[#lines + 1] = ('    %s = { like = %s, name = %s, defeat = %s, party = {'):format(k, q(p.like), q(p.name), q(p.defeat))
  for _, s in ipairs(p.party) do lines[#lines + 1] = specText(s) end
  lines[#lines + 1] = '    } },'
end
lines[#lines + 1] = '  },'
lines[#lines + 1] = '}'
local f = assert(io.open(OUT, 'w'))
f:write(table.concat(lines, '\n') .. '\n')
f:close()
print(('%d trainers, %d partners, %d mons converted (%d scaled back), %d moves dropped or replaced, %d items dropped -> %s')
  :format(#order, #pnames, stats.converted, stats.scaled, stats.droppedMoves, stats.droppedItems, OUT))
if #stats.missing > 0 then print('species missing from the campaign: ' .. table.concat(stats.missing, ', ')) end
