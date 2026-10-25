#!/usr/bin/env python3
"""Trainer data-entry worksheet: every vanilla Emerald trainer in story order
(Inclement's trainer_parties.h sections), with the vanilla team, Inclement's
team for the same trainer, the next level-cap boss and a suggested level
band, and whether campaign/trainer_teams.lua has drafted it yet.
Writes Gen3Mod/TRAINER-WORKSHEET.md.
Usage: gen_trainer_worksheet.py <vanilla_trainers.json>"""
import json, re, os, sys, subprocess
HERE = os.path.dirname(os.path.abspath(__file__))
DONOR = os.path.join(HERE, '../../../pokeemerald-1.13/src/data')
OUT = os.path.join(HERE, '../../../TRAINER-WORKSHEET.md')
vanilla = {t['const']: t for t in json.load(open(sys.argv[1]))}

# Inclement: trainer constant -> party label, and sections of party labels
trainers_h = open(os.path.join(DONOR, 'trainers.h')).read()
label_of = {}
for m in re.finditer(r'\[(TRAINER_\w+)\]\s*=\s*\{(.*?)\n    \},', trainers_h, re.S):
    p = re.search(r'(sParty_\w+)', m.group(2))
    if p: label_of[p.group(1)] = label_of.get(p.group(1), m.group(1))
const_of_label = {}
for m in re.finditer(r'\[(TRAINER_\w+)\]\s*=\s*\{(.*?)\n    \},', trainers_h, re.S):
    p = re.search(r'(sParty_\w+)', m.group(2))
    if p: const_of_label.setdefault(p.group(1), []).append(m.group(1))
parties_h = open(os.path.join(DONOR, 'trainer_parties.h')).read()
sections, cur, inc_team = [], None, {}
for line_m in re.finditer(r'^(// [^\n]*|static const struct TrainerMon\w* (sParty_\w+)\[\] = \{(.*?)\n\};)', parties_h, re.M | re.S):
    text = line_m.group(1)
    if text.startswith('//'):
        cur = text[3:].strip()
        sections.append((cur, []))
        continue
    label, body = line_m.group(2), line_m.group(3)
    mons = []
    for mm in re.finditer(r'\.lvl\s*=\s*(-?\d+).*?\.species\s*=\s*SPECIES_(\w+)', body, re.S):
        lvl = int(mm.group(1))
        mons.append('%s %s' % (mm.group(2).title(), ('cap%+d' % lvl) if lvl <= 0 else ('cap+%d' % lvl)))
    if sections:
        sections[-1][1].append(label)
    inc_team[label] = mons

# drafted trainers
teams = open(os.path.join(HERE, '../campaign/trainer_teams.lua')).read()
drafted = set(re.findall(r'^    ([A-Z0-9_]+) = \{', teams, re.M))
# draft 2 (tools/gen_trainer_teams.lua) covers the rest
generated = open(os.path.join(HERE, '../campaign/trainer_teams_gen.lua')).read()
generated = set(re.findall(r'^    ([A-Z0-9_]+) = \{', generated.split('partners = {')[0], re.M))

# level-cap bosses in story order (g3_coop lib/levelcap.lua), first section
# each falls in, and the vanilla ace (provisional cap until authored)
lc = open(os.path.join(HERE, '../../../coop/g3_coop/lib/levelcap.lua')).read()
emerald = lc[lc.index('LevelCap.EMERALD'):]
emerald = emerald[:emerald.index('\n}')]
bosses = []
for m in re.finditer(r'rival\("([^"]+)", "(\w+)"\)|one\("([^"]+)", ([^)]*)\)', emerald):
    if m.group(1):
        names = ['TRAINER_%s_%s_%s' % (w, m.group(2), s) for w in ('BRENDAN', 'MAY') for s in ('MUDKIP', 'TREECKO', 'TORCHIC')]
        bosses.append(('RIVAL, ' + m.group(1), names))
    else:
        bosses.append((m.group(3), re.findall(r'"(TRAINER_\w+)"', m.group(4))))
def ace(names):
    best = 0
    for n in names:
        t = vanilla.get(n)
        if t: best = max(best, max(p['level'] for p in t['party']))
    return best
# authored caps override (Roxanne 15, ...)
for name, lvl in re.findall(r'^    ([A-Z0-9_]+) = \{ tier = "leader".*?\n((?:      \{.*\n)+)', teams, re.M):
    pass
authored_ace = {}
for m in re.finditer(r'^    ([A-Z0-9_]+) = \{[^\n]*\n((?:      \{[^\n]*\n)+)', teams, re.M):
    lv = [int(x) for x in re.findall(r'\{ "\w+", (\d+)', m.group(2))]
    if lv: authored_ace['TRAINER_' + m.group(1)] = max(lv)
def cap_of(names):
    vals = [authored_ace[n] for n in names if n in authored_ace]
    return max(vals) if vals else ace(names)

# which boss each section leads up to: the first boss whose trainers appear
# in that section or a later one
section_of_const = {}
for i, (sec, labels) in enumerate(sections):
    for lb in labels:
        for c in const_of_label.get(lb, []): section_of_const.setdefault(c, i)
# bosses Inclement files under character sections: the area the fight is in
BOSS_AT = {
    'RIVAL, ROUTE 103': None, 'RIVAL, RUSTBORO': 'Route 106 (Dewford Town Access)',
    'RIVAL, ROUTE 110': 'Route 110 (player level ~28)', 'WALLY, MAUVILLE': 'Mauville Gym',
    'TABITHA, MT. CHIMNEY': 'Mt. Chimney', 'MAXIE, MT. CHIMNEY': 'Mt. Chimney',
    'SHELLY, WEATHER INST.': 'Weather Institute', 'RIVAL, ROUTE 119': 'Route 120',
    'RIVAL, LILYCOVE': 'Route 121', 'TABITHA, MAGMA HIDEOUT': 'Magma Hideout', 'MAXIE, MAGMA HIDEOUT': 'Magma Hideout',
    'MATT, AQUA HIDEOUT': 'Aqua Hideout', 'MAXIE & TABITHA': 'Mossdeep Space Center',
    'SHELLY, SEAFLOOR CAVERN': 'Seafloor Cavern', 'ARCHIE': 'Seafloor Cavern',
}
sec_index = {name: i for i, (name, _) in enumerate(sections)}
boss_section = []
for order, (label, names) in enumerate(bosses):
    if label in BOSS_AT and BOSS_AT[label] is None:
        idx = -1  # before the first route (the Route 103 rival)
    elif label in BOSS_AT and BOSS_AT[label] in sec_index:
        idx = sec_index[BOSS_AT[label]]
    else:
        idx = min([section_of_const[n] for n in names if n in section_of_const] or [10**6])
    boss_section.append((idx, order, label, names))
# Inclement groups these by character, not area: no section-wide boss
CHARACTER = ('Wally', 'Brendan and May', 'Grunts start', 'Aqua and Magma bosses')
boss_cap = {}
for _, _, label, names in boss_section:
    for n in names: boss_cap[n] = (label, cap_of(names))
SKIP = ('Placeholders', 'Frontier Brains', 'League rematches', 'Post Game', 'Cut rematches', 'Unused Trainers',
        'Trick House 8: Post Game')
def next_boss(i):
    after = [b for b in boss_section if b[0] >= i]
    if not after: return None
    return min(after)

lines = ['# Trainer worksheet', '',
         'Generated by `porting/native/tools/gen_trainer_worksheet.py`. Every vanilla trainer in story order, using Inclement\'s areas.',
         'Per trainer: vanilla team, Inclement\'s team for the same trainer (levels relative to the cap), and whether `campaign/trainer_teams.lua` has it yet.',
         '',
         '- **Caps:** a boss\'s ace is the level cap. Caps for bosses not yet authored are vanilla\'s aces, so treat them as provisional.',
         '- **Next boss:** taken from Inclement\'s area order, which only roughly follows the story (Mauville and its gym come before Routes 117 and 111 in play). Check the boss when authoring an area.',
         '- **Suggested bands:** route trainers sit at cap-4 to cap-1; gym trainers at cap-3 to cap-2; the boss\'s other Pokémon a few below its ace.',
         '- **Draft rules:** route trainers get a tag partner; story fights and gym trainers fight alone; bosses can be 2-vs-1. See `NATIVE-0.3.73-PLAN.md`, "Decisions for the next waves".', '']
seen = set()
total = done = 0
for i, (sec, labels) in enumerate(sections):
    if sec in SKIP or not labels: continue
    rows = []
    for lb in labels:
        for c in const_of_label.get(lb, []):
            if c in seen or c not in vanilla: continue
            seen.add(c)
            if re.search(r'_[2-5]$', c) and not c.startswith('TRAINER_GRUNT_'):
                continue
            t = vanilla[c]
            short = c.replace('TRAINER_', '')
            status = 'drafted' if short in drafted else ('generated' if short in generated else '')
            total += 1; done += 1 if status else 0
            v = ', '.join('%s %d' % (p['species'].title(), p['level']) for p in t['party'])
            inc = ', '.join(inc_team.get(lb, []))
            flags = []
            if t['double']: flags.append('double')
            if c in boss_cap: flags.append('**cap boss** (ace %d)' % boss_cap[c][1])
            rows.append('| %s | %d | %s %s | %s | %s | %s |' % (short, t['id'], t['class'].title(), t['name'].title(), v, inc, ' '.join(flags + ([status] if status else []))))
    if not rows: continue
    nb = None if sec in CHARACTER else next_boss(i)
    if nb:
        cap = cap_of(nb[3])
        head = '## %s (next boss: %s, cap %d)' % (sec, nb[2].title(), cap)
        band = 'Suggested route levels: %d-%d.' % (max(1, cap - 4), max(1, cap - 1))
    else:
        head, band = '## %s' % sec, ('Story characters: their fights happen across the game; level each by the cap of the boss that follows that fight.' if sec in CHARACTER else '')
    lines += [head, '', band, '', '| Trainer | Id | Who | Vanilla | Inclement | Notes |', '|---|---|---|---|---|---|'] + rows + ['']
rematch = sorted(c for c in vanilla if re.search(r'_[2-5]$', c) and not c.startswith('TRAINER_GRUNT_'))
missing = sorted(c for c in vanilla if c not in seen and c not in rematch)
lines += ['## Rematches (later)', '', '%d rematch teams, still vanilla.' % len(rematch), '',
          '## Not placed by Inclement\'s areas', '', 'These are mostly Battle Frontier, Trainer Hill, unused and duplicate entries. Check before authoring:', '',
          ', '.join(x.replace('TRAINER_', '') for x in missing), '']
lines.insert(4, '**Progress: %d of %d first-fight trainers have teams: %d hand-drafted, the rest generated from Inclement (draft 2, `tools/gen_trainer_teams.lua`; caps there override the provisional ones below).**' % (done, total, sum(1 for c in seen if c.replace('TRAINER_', '') in drafted)))
lines.insert(5, '')
open(OUT, 'w').write('\n'.join(lines) + '\n')
print('%d trainers in story order, %d drafted, %d rematches, %d unplaced' % (total, done, len(rematch), len(missing)))
