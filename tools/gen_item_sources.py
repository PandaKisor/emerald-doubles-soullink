#!/usr/bin/env python3
"""Where the campaign's items come from on the vanilla world: Inclement's
item placements, gifts and shop stock, matched onto vanilla Emerald's.
  balls / hidden  same map and tile as a vanilla item ball / hidden item
  gifts           a vanilla script (same label) handing out a different item
  marts           town marts sell Inclement's badge-tier stock plus the town's
                  own Inclement stock; specialty shops take the Inclement list
                  on the same map that overlaps them most
  orphans         items Inclement gives through NPCs vanilla doesn't have:
                  sold at that town's mart instead
Writes campaign/item_sources.lua. Usage: gen_item_sources.py <vanilla.json>"""
import json, re, glob, os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
DONOR = os.path.join(HERE, '../../../pokeemerald-1.13/data')
OUT = os.path.join(HERE, '../campaign/item_sources.lua')
vanilla = json.load(open(sys.argv[1]))

# item ids and pockets from the port's generated item data (the donor's
# constants are expressions)
import subprocess
DATA = os.path.join(HERE, '../../full_port/generated/development/mods/inclement_battle_test/full/data/')
dump = subprocess.run(['luajit', '-', DATA], input='''
local D=arg[1]
local man=dofile(D.."manifest.lua") local out={}
for _,f in ipairs(man.files.items) do for id,row in pairs(dofile(D..f)) do
  out[#out+1]=string.format("%q:[%d,%q]", row.symbol, id, tostring(row.pocket)) end end
print("{"..table.concat(out,",").."}")''', capture_output=True, text=True, check=True).stdout
ITEMS = json.loads(dump)
ID = {k: v[0] for k, v in ITEMS.items()}
NAME = {v: k for k, v in ID.items()}
def useless(sym):
    pocket = ITEMS.get(sym, [0, ''])[1]
    return (pocket == 'MEGA_STONES' or sym.endswith('IUM_Z') or sym in ('ITEM_BOTTLE_CAP', 'ITEM_GOLD_BOTTLE_CAP', 'ITEM_NONE')
            or sym in ('ITEM_RED_ORB', 'ITEM_BLUE_ORB'))
mega = set()
def usable(sym): return sym in ID and not useless(sym) and sym not in mega

# donor maps: directory -> map id, item balls, hidden items
dir_map = {}
for f in glob.glob(os.path.join(DONOR, 'maps/*/map.json')):
    j = json.load(open(f))
    dir_map[os.path.basename(os.path.dirname(f))] = 'EM_' + j['id'].replace('MAP_', '')
scripts = {}
gift_labels = {}
for f in glob.glob(os.path.join(DONOR, 'maps/*/scripts.inc')) + glob.glob(os.path.join(DONOR, 'scripts/*.inc')):
    txt = open(f, errors='ignore').read()
    for m in re.finditer(r'^(\w+)::[^\n]*\n((?:[ \t].*\n|\n)+?)(?=^\w+::|\Z)', txt, re.M):
        body = m.group(2)
        it = re.search(r'finditem (ITEM_\w+)', body)
        if it: scripts[m.group(1)] = it.group(1)
        gives = re.findall(r'giveitem (ITEM_\w+)', body)
        if gives: gift_labels[m.group(1)] = gives
inc_balls, inc_hidden = {}, {}
for f in glob.glob(os.path.join(DONOR, 'maps/*/map.json')):
    j = json.load(open(f))
    mp = 'EM_' + j['id'].replace('MAP_', '')
    for o in j.get('object_events', []):
        if o.get('script') in scripts:
            inc_balls[(mp, o['x'], o['y'])] = scripts[o['script']]
    for b in j.get('bg_events', []):
        if b.get('type') == 'hidden_item':
            inc_hidden[(mp, b['x'], b['y'])] = b['item']

def sub_table(rows, inc, by_local=False):
    out, matched, changed = {}, 0, 0
    for r in rows:
        k = (r['map'], r['x'], r['y'])
        if k not in inc: continue
        matched += 1
        sym = inc[k]
        if usable(sym) and ID.get(sym) != r['item']:
            slot = str(r['localId']) if by_local else '%d,%d' % (r['x'], r['y'])
            out.setdefault(r['map'], {})[slot] = sym
            changed += 1
    return out, matched, changed
balls, bm, bc = sub_table(vanilla['balls'], inc_balls, True)
hidden, hm, hc = sub_table(vanilla['hidden'], inc_hidden)

# gifts: same label, different item
def label_map(label):
    best = None
    for d, mp in dir_map.items():
        if label.startswith(d + '_') and (best is None or len(d) > len(best[0])): best = (d, mp)
    return best
gifts, gift_count = {}, 0
vanilla_gift_labels = set()
for g in vanilla['gifts']:
    vanilla_gift_labels.add(g['label'])
    inc = gift_labels.get(g['label'])
    lm = label_map(g['label'])
    if not inc or not lm or len(inc) != len(g['items']): continue
    for v, i in zip(g['items'], inc):
        if usable(i) and ID.get(i) != v:
            gifts.setdefault(g['key'], {})[str(v)] = i
            gift_count += 1
# orphan gifts: Inclement labels with no vanilla script
orphans = {}
vanilla_labels_all = set(x['label'] for x in vanilla['gifts']) | set(x['label'] for x in vanilla['marts'])
for label, items in gift_labels.items():
    if label in vanilla_gift_labels: continue
    lm = label_map(label)
    if not lm: continue
    town = re.match(r'([A-Z][a-z]+(?:[A-Z][a-z]+)*?(?:City|Town))', lm[0])
    if not town: continue
    for i in items:
        if usable(i) and ITEMS[i][1] != 'KEY_ITEMS' and not i.startswith('ITEM_HM'):
            orphans.setdefault(town.group(1), []).append(i)

# marts
inc_marts = {}
for f in sorted(glob.glob(os.path.join(DONOR, 'maps/*/scripts.inc'))):
    d = os.path.basename(os.path.dirname(f))
    txt = open(f, errors='ignore').read()
    refs = re.findall(r'pokemart\s+(\w+)', txt)
    lists = {}
    for m in re.finditer(r'^(\w+):[^\n]*\n((?:\s*(?:\.2byte\s+ITEM_\w+|\.align\s+\d+)\s*\n)+)', txt, re.M):
        lst = [x for x in re.findall(r'ITEM_\w+', m.group(2)) if x != 'ITEM_NONE']
        if lst: lists[m.group(1)] = lst
    inc_marts[d] = [lists[r] for r in refs if r in lists]
general_txt = open(os.path.join(DONOR, 'scripts/poke_mart.inc')).read() + open(os.path.join(DONOR, 'scripts/general_mart.inc')).read()
general = {}
for m in re.finditer(r'^(\w+):[^\n]*\n((?:\s*(?:\.2byte\s+ITEM_\w+|\.align\s+\d+)\s*\n)+)', general_txt, re.M):
    general[m.group(1)] = [x for x in re.findall(r'ITEM_\w+', m.group(2)) if x != 'ITEM_NONE']
TIERS = ['No_Badges', 'Stone_Badge', 'Knuckle_Badge', 'Dynamo_Badge', 'Heat_Badge', 'Balance_Badge', 'Feather_Badge', 'Mind_Badge']
def tier_list(prefix, i):
    for j in range(i, -1, -1):
        lst = general.get(prefix + TIERS[j])
        if lst: return lst
    return []
tiers = []
for i, t in enumerate(TIERS):
    tiers.append([x for x in tier_list('PokeMart_Poke_Center_', i) + tier_list('PokeMart_', i) if usable(x)])
marts = {}
for vm in vanilla['marts']:
    if vm['decor']: continue
    lm = label_map(vm['label'])
    if not lm: continue
    d = lm[0]
    if re.search(r'(City|Town)_Mart$', d):
        town = d[:-len('_Mart')]
        extra = []
        for lst in inc_marts.get(d, []) + inc_marts.get(town + '_PokemonCenter_1F', []):
            extra += [x for x in lst if usable(x)]
        extra += orphans.get(town, [])
        seen, ex = set(), []
        for x in extra:
            if x not in seen: seen.add(x); ex.append(x)
        # vanilla's own stock stays (Poké Balls before the first badge, ...)
        marts[vm['key']] = {'kind': 'general', 'extra': ex, 'label': vm['label']}
    else:
        best, score = None, 0
        vset = set(vm['items'])
        for lst in inc_marts.get(d, []):
            s = len(vset & set(ID.get(x, -1) for x in lst)) + 0.1
            if s > score: best, score = lst, s
        if best:
            marts[vm['key']] = {'kind': 'fixed', 'items': [x for x in best if usable(x)], 'label': vm['label']}

def lua(v, ind=''):
    if isinstance(v, dict):
        items = []
        for k in sorted(v, key=str):
            key = ('[%s]' % k) if isinstance(k, int) else ('["%s"]' % k)
            items.append('%s  %s = %s' % (ind, key, lua(v[k], ind + '  ')))
        return '{\n' + ',\n'.join(items) + '\n' + ind + '}'
    if isinstance(v, list): return '{ ' + ', '.join(lua(x, ind) for x in v) + ' }'
    if isinstance(v, str): return json.dumps(v)
    return str(v)
data = {'balls': balls, 'hidden': hidden, 'gifts': gifts, 'tiers': tiers, 'marts': marts}
open(OUT, 'w').write('-- Generated by tools/gen_item_sources.py from Inclement Emerald\'s maps and\n'
                     '-- scripts and the vanilla ROM\'s (item balls, hidden items, gifts, marts).\n'
                     'return ' + lua(data) + '\n')
print('balls: %d vanilla, %d matched by tile, %d changed' % (len(vanilla['balls']), bm, bc))
print('hidden: %d vanilla, %d matched, %d changed' % (len(vanilla['hidden']), hm, hc))
print('gifts changed: %d; orphan items moved to marts: %s' % (gift_count, {k: v for k, v in orphans.items()}))
print('marts: %d general, %d specialty' % (sum(1 for m in marts.values() if m['kind'] == 'general'), sum(1 for m in marts.values() if m['kind'] == 'fixed')))
print('tier sizes', [len(t) for t in tiers])

# audit: evolution items with no source on the campaign's world
evo = subprocess.run(['luajit', '-', os.path.join(DATA, '..')], input='''
local F=arg[1].."/"
local lv=dofile(F.."restoratives/model.lua")
local it=dofile(F.."evolution-items/model.lua")
local out={}
for sp,rs in pairs(lv.rules) do for _,r in ipairs(rs) do
  if r.method:find("ITEM_HOLD") then out[#out+1]=string.format("[%d,%d]", r.param, sp) end end end
for sp,rs in pairs(it.rules) do for _,r in ipairs(rs) do if r.item~=0 then out[#out+1]=string.format("[%d,%d]", r.item, sp) end end end
print("["..table.concat(out,",").."]")''', capture_output=True, text=True, check=True).stdout
need = {}
for item, sp in json.loads(evo): need.setdefault(item, set()).add(sp)
have = set()
for r in vanilla['balls'] + vanilla['hidden']: have.add(r['item'])
for g in vanilla['gifts']: have.update(g['items'])
for m in vanilla['marts']: have.update(m['items'])
for t in (balls, hidden):
    for mp in t.values(): have.update(ID[s] for s in mp.values())
for mp in gifts.values(): have.update(ID[s] for s in mp.values())
for t in tiers: have.update(ID[s] for s in t)
for m in marts.values(): have.update(ID[s] for s in (m.get('extra') or m.get('items') or []))
missing = sorted((NAME.get(i, i), len(sps)) for i, sps in need.items() if i not in have)
print('evolution items with no source: %d of %d' % (len(missing), len(need)))
for n, c in missing: print('  ', n, c, 'species')
