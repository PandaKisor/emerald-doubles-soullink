#!/usr/bin/env python3
"""Authoring aid for campaign/trainer_teams.lua (reads the field guide's
generated/handbook/data.json, so run tools/handbook/export.py first).

  teamhelp.py mon SPECIES[:LEVEL] ...   types, stats, abilities, legal moves
  teamhelp.py area MAP_ID ...           wild species there (any method)
  teamhelp.py check                     moves in trainer_teams.lua a species
                                        can't learn by level-up (at its level),
                                        egg, TM/HM or tutor
"""
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
D = json.loads((HERE.parent / 'generated/handbook/data.json').read_text())
SP = {v['symbol'][8:]: v for v in D['species'].values()}
MV = {int(k): v for k, v in D['moves'].items()}
MSYM = {v['symbol'][5:]: int(k) for k, v in D['moves'].items()}
TYPES = D["types"]
WEAK = {'BIDE', 'SPLASH', 'MIMIC', 'DOUBLE_TEAM', 'ATTRACT', 'SWAGGER', 'FRUSTRATION', 'RETURN', 'SECRET_POWER',
        'HIDDEN_POWER', 'CURSE', 'SLEEP_TALK', 'SUBSTITUTE', 'REST', 'TOXIC', 'CONFIDE', 'NATURAL_GIFT', 'ROUND', 'FLING', 'CAPTIVATE'}
SLACK = 3  # a trainer mon may know a level-up move a few levels early


PRE = {}  # species id -> its pre-evolution's id
for k, v in D['species'].items():
    for e in v['evolutions'] + v.get('itemEvolutions', []):
        if isinstance(e, dict) and 'target' in e:
            PRE.setdefault(str(e['target']), k)


def egg_moves(sp):
    moves, key = set(sp['eggMoves']), str(sp['id'])
    while key in PRE:
        key = PRE[key]
        moves |= set(D['species'][key]['eggMoves'])
    return moves


def legal(sp, level):
    lvl, key = {m for l, m in sp["learnset"] if l <= level + SLACK}, str(sp['id'])
    while key in PRE:  # moves a pre-evolution learns by this level carry over
        key = PRE[key]
        lvl |= {m for l, m in D['species'][key]['learnset'] if l <= level + SLACK}
    other = egg_moves(sp) | {D['items'][str(i)].get('machineMove') for i in sp['machines']
                                   if str(i) in D['items']} | {D['tutorMoves'][str(t)] for t in sp['tutors']
                                                                if str(t) in D['tutorMoves']}
    return lvl, {m for m in other if m}


def mon(arg):
    name, _, level = arg.partition(':')
    sp = SP[name.upper()]
    level = int(level or 100)
    lvl, other = legal(sp, level)
    st = sp['stats']
    abil = [D['abilities'][str(a)]['symbol'][8:] for a in sp['abilities'] if a]
    types = '/'.join(dict.fromkeys(TYPES[str(t)] for t in sp['types']))
    print(f"{sp['symbol'][8:]} {types}  {st['hp']}/{st['atk']}/{st['def']}/{st['spa']}/{st['spd']}/{st['spe']}  "
          f"[{', '.join(abil)}]  evo: {', '.join(str(e) for e in sp['evolutions'])[:60]}")
    def fmt(ids):
        ids = {m for m in ids if m in MV and MV[m]['symbol'][5:] not in WEAK}
        rows = sorted((MV[m] for m in ids if m in MV), key=lambda m: (m['category'] == 'status', -(m['power'] or 0)))
        return ', '.join(f"{m['symbol'][5:]}({TYPES[str(m['type'])][:3]}{m['power'] or ''}{'*' if m['target'] in (8, 32) else ''})" for m in rows)
    print('  lvl<=%d: %s' % (level, fmt(lvl)))
    # TM/egg/tutor attacks at this level: nothing much stronger than the
    # level's own moves (status moves always shown)
    cap = 30 + 2.5 * level
    print('  other: %s' % fmt({m for m in other - lvl if m in MV and (MV[m]['power'] or 0) <= cap}))


def area(map_id):
    mid = map_id if map_id.startswith('EM_') else 'EM_' + map_id
    for w in D['wild']:
        if w['map'] == mid:
            names = sorted({D['species'][str(s['species'])]['symbol'][8:] for s in w['slots']})
            print(f"{w['method']:12} {' '.join(names)}")


def check():
    text = (HERE.parent / 'campaign/trainer_teams.lua').read_text()
    bad = 0
    for m in re.finditer(r'\{ "([A-Z0-9_]+)", (\d+),.*?moves = \{([^}]*)\}', text):
        name, level = m.group(1), int(m.group(2))
        sp = SP.get(name)
        if not sp:
            print('unknown species', name); bad += 1; continue
        lvl, other = legal(sp, level)
        ab = re.search(r'ability = "([A-Z_]+)"', m.group(0))
        abil = {D['abilities'][str(a)]['symbol'][8:] for a in sp['abilities'] if a}
        if ab and ab.group(1) not in abil:
            print(f'{name} {level}: ability {ab.group(1)} not one of {sorted(abil)}'); bad += 1
        for mv in re.findall(r'"([A-Z0-9_]+)"', m.group(3)):
            if MSYM.get(mv) not in lvl | other:
                print(f'{name} {level}: {mv} not learnable'); bad += 1
    print(f'{bad} unlearnable move(s)')


if __name__ == '__main__':
    cmd, args = sys.argv[1], sys.argv[2:]
    if cmd == 'mon':
        for a in args: mon(a)
    elif cmd == 'area':
        for a in args: print('==', a); area(a)
    elif cmd == 'check':
        check()
