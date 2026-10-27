#!/usr/bin/env python3
"""Rematch teams from the hand-picked first fights (user, 2026-10-25: "rematches
get new teams, generated, capped per tier"). Writes campaign/trainer_teams_rematch.lua;
campaign/content.lua layers it under the hand-picked teams and over the draft.

Each rematch takes its first fight's team (and the tag partner, for route
trainers): the levels shift so the top Pokémon reaches the tier's level, each
Pokémon evolves once it can, keeps its ability slot, trades weak attacks for its
strongest same-type level-up move it knows by then, and Oran Berry / Eviolite
become Sitrus Berry where they no longer fit. Emerald offers rematches in order
(_2, _3, ...) once the player has five badges; gym leaders and Wally rematch
after the Hall of Fame. Reads generated/handbook/data.json (tools/handbook/export.py).
"""
import json
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
NATIVE = HERE.parent
D = json.loads((NATIVE / 'generated/handbook/data.json').read_text())
TEAMS = (NATIVE / 'campaign/trainer_teams.lua').read_text()

SP = {v['symbol'][8:]: v for v in D['species'].values()}
BY_ID = {int(k): v for k, v in D['species'].items()}
MV = {v['symbol'][5:]: v for v in D['moves'].values()}
MV_ID = {int(k): v for k, v in D['moves'].items()}
AB = {int(k): v['symbol'][8:] for k, v in D['abilities'].items()}

# the top level each rematch tier reaches (route trainers: after five badges, in
# order; leaders and Wally: after the Hall of Fame)
ROUTE_TOP = {2: 33, 3: 38, 4: 43, 5: 48, 6: 50}
POST_TOP = {2: 60, 3: 64, 4: 68, 5: 72}
POST = re.compile(r'^(ROXANNE|BRAWLY|WATTSON|FLANNERY|NORMAN|WINONA|TATE_AND_LIZA|JUAN|WALLY_VR)_')
# attacks worth keeping however weak (priority, utility, fixed damage, multi-hit)
# early speed-control attacks: kept below level 50, upgraded after
EARLY = {'ROCK_TOMB', 'MUD_SHOT', 'BULLDOZE', 'LOW_SWEEP', 'ICY_WIND', 'ELECTROWEB', 'SNARL', 'ICE_BALL', 'ROLLOUT',
         'FLAME_CHARGE', 'STRUGGLE_BUG', 'FAIRY_WIND', 'DISARMING_VOICE', 'INCINERATE', 'SMACK_DOWN', 'PURSUIT',
         'THIEF', 'COVET', 'INFESTATION', 'ARM_THRUST', 'DOUBLE_SLAP', 'FURY_SWIPES', 'TAIL_SLAP', 'PIN_MISSILE'}
# filler status moves a rematch swaps for Protect when it can learn it
FILLER = {'LEER', 'GROWL', 'TAIL_WHIP', 'SAND_ATTACK', 'HARDEN', 'WITHDRAW', 'SMOKESCREEN', 'STRING_SHOT',
          'SWEET_SCENT', 'BABY_DOLL_EYES', 'PLAY_NICE', 'ODOR_SLEUTH', 'FORESIGHT', 'HOWL', 'SUPERSONIC',
          'MIST', 'WATER_SPORT', 'MUD_SPORT', 'SPLASH', 'CHARM', 'TICKLE', 'MINIMIZE', 'DOUBLE_TEAM', 'LUCKY_CHANT'}
KEEP = {'FAKE_OUT', 'QUICK_ATTACK', 'AQUA_JET', 'MACH_PUNCH', 'BULLET_PUNCH', 'ICE_SHARD', 'SHADOW_SNEAK',
        'VACUUM_WAVE', 'SUCKER_PUNCH', 'EXTREME_SPEED', 'ACCELEROCK', 'FEINT', 'NUZZLE', 'ICY_WIND', 'ELECTROWEB',
        'SNARL', 'ROCK_TOMB', 'MUD_SHOT', 'BULLDOZE', 'LOW_SWEEP', 'U_TURN', 'VOLT_SWITCH', 'FLIP_TURN', 'KNOCK_OFF',
        'SEISMIC_TOSS', 'NIGHT_SHADE', 'DRAGON_RAGE', 'SUPER_FANG', 'LOW_KICK', 'GRASS_KNOT', 'ICICLE_SPEAR',
        'ROCK_BLAST', 'BULLET_SEED', 'PIN_MISSILE', 'DOUBLE_HIT', 'DOUBLE_KICK', 'ARM_THRUST', 'FURY_SWIPES',
        'TAIL_SLAP', 'DOUBLE_SLAP', 'COUNTER', 'MIRROR_COAT', 'ELECTRO_BALL', 'GYRO_BALL', 'FLAIL', 'REVERSAL',
        'ACROBATICS', 'FACADE', 'FOUL_PLAY', 'VENOSHOCK', 'HEX', 'STORED_POWER', 'WATER_SPOUT', 'ERUPTION',
        'INCINERATE', 'BRUTAL_SWING', 'DISARMING_VOICE', 'FAIRY_WIND', 'STRUGGLE_BUG', 'INFESTATION', 'FELL_STINGER',
        'PURSUIT', 'FIRST_IMPRESSION', 'WEATHER_BALL', 'FLAME_CHARGE', 'DRAINING_KISS', 'GIGA_DRAIN', 'ICE_BALL',
        'ROLLOUT', 'SMACK_DOWN', 'THIEF', 'COVET', 'HELPING_HAND'}
NO_UPGRADE_TO = {'EXPLOSION', 'SELF_DESTRUCT', 'FINAL_GAMBIT', 'MEMENTO', 'LAST_RESORT', 'BELCH', 'SYNCHRONOISE',
                 'FUTURE_SIGHT', 'DREAM_EATER', 'SOLAR_BEAM', 'SKY_ATTACK', 'RAZOR_WIND', 'HYPER_BEAM', 'GIGA_IMPACT',
                 'FOCUS_PUNCH', 'THRASH', 'OUTRAGE', 'PETAL_DANCE', 'UPROAR', 'BIDE', 'SNORE', 'DIG', 'DIVE', 'FLY',
                 'BOUNCE', 'SKULL_BASH', 'SOLAR_BLADE', 'METEOR_BEAM', 'SKY_DROP', 'SHELL_TRAP', 'HEAD_SMASH',
                 'DOUBLE_EDGE', 'TAKE_DOWN', 'MEGA_KICK', 'FLARE_BLITZ', 'BRAVE_BIRD', 'WOOD_HAMMER', 'VOLT_TACKLE'}


def parse_mon(line):
    m = re.match(r'\s*\{ "([A-Z0-9_]+)", (\d+),(.*)\},?\s*$', line)
    sp, lv, rest = m.group(1), int(m.group(2)), m.group(3)
    get = lambda k: (re.search(k + r' = "([A-Z0-9_]+)"', rest) or [None, None])[1]
    moves = re.findall(r'"([A-Z0-9_]+)"', re.search(r'moves = \{([^}]*)\}', rest).group(1))
    return {'sp': sp, 'lv': lv, 'ability': get('ability'), 'nature': get('nature'), 'spread': get('spread'),
            'item': get('item'), 'moves': moves}


def parse(block_name):
    """name -> (opts dict, [mons]) from a block of trainer_teams.lua."""
    start = TEAMS.index(f'\n  {block_name} = {{')
    body = TEAMS[start:]
    out = {}
    for m in re.finditer(r'\n    ([A-Z0-9_]+) = \{ ([^\n]*?)party = \{\n(.*?)\n    \} \},', body, re.S):
        if block_name == 'trainers' and '\n  partners = {' in body[:m.start()]:
            break
        name, head, mons = m.group(1), m.group(2), m.group(3)
        if name in out:
            continue
        opts = dict(re.findall(r'(\w+) = "([^"]*)"', head))
        out[name] = (opts, [parse_mon(l) for l in mons.split('\n') if l.strip().startswith('{')])
    return out


TRAINERS = parse('trainers')
PARTNERS = parse('partners')


def evolve(sp, level):
    """Follow level evolutions the Pokémon has reached; other methods (stones,
    friendship, trade) happen once a trainer's Pokémon is 36 or higher."""
    cur = SP[sp]
    while True:
        nxt = None
        for e in cur['evolutions'] + cur.get('itemEvolutions', []):
            if not isinstance(e, dict) or 'target' not in e or e['target'] not in BY_ID:
                continue
            tgt = BY_ID[e['target']]
            if tgt.get('excluded'):
                continue
            method = e.get('method', 'EVO_ITEM')
            need = e.get('param', 0) if method.startswith('EVO_LEVEL') else 36
            if level >= need:
                nxt = tgt
                break
        if not nxt:
            return cur['symbol'][8:]
        cur = nxt


def ability_for(old_sp, new_sp, ability):
    old = [AB.get(a) for a in SP[old_sp]['abilities']]
    new = [AB.get(a) for a in SP[new_sp]['abilities']]
    if ability in new:
        return ability
    slot = old.index(ability) if ability in old else 0
    pick = new[slot] if slot < len(new) and new[slot] else next(a for a in new if a)
    return pick


def learnable(sp_sym, level):
    """Level-up moves this species (and its pre-evolutions) knows by `level`."""
    pre = {}
    for k, v in D['species'].items():
        for e in v['evolutions'] + v.get('itemEvolutions', []):
            if isinstance(e, dict) and 'target' in e:
                pre.setdefault(e['target'], int(k))
    moves, cur = set(), SP[sp_sym]['id']
    while cur:
        moves |= {MV_ID[m]['symbol'][5:] for l, m in BY_ID[cur]['learnset'] if l <= level and m in MV_ID}
        cur = pre.get(cur)
    return moves


def can_protect(sp_sym):
    sp = SP[sp_sym]
    machines = {D['items'][str(i)].get('machineMove') for i in sp['machines'] if str(i) in D['items']}
    return MV['PROTECT']['id'] in machines or 'PROTECT' in learnable(sp_sym, 100)


def upgrade(sp_sym, level, moves):
    out, have = [], set(moves)
    pool = learnable(sp_sym, level)
    for mv in moves:
        info = MV.get(mv)
        if mv in FILLER and 'PROTECT' not in have and can_protect(sp_sym):
            have.add('PROTECT')
            out.append('PROTECT')
            continue
        keep = mv in KEEP and not (mv in EARLY and level >= 50)
        if not info or keep or info['category'] == 'status' or (info['power'] or 0) >= 70:
            out.append(mv)
            continue
        best = None
        for cand in pool - have:
            c = MV.get(cand)
            if (not c or cand in NO_UPGRADE_TO or c['category'] == 'status' or c['type'] != info['type']
                    or (c['power'] or 0) <= (info['power'] or 0) or (c['accuracy'] or 100) < 80
                    or (c['power'] or 0) > 30 + 2.5 * level):
                continue
            if not best or c['power'] > MV[best]['power']:
                best = cand
        if best:
            have.add(best)
            out.append(best)
        else:
            out.append(mv)
    return out


def scale(mons, top_target, tier):
    shift = top_target - max(m['lv'] for m in mons)
    out = []
    for m in mons:
        lv = max(2, min(100, m['lv'] + max(0, shift)))
        sp = evolve(m['sp'], lv)
        n = dict(m, sp=sp, lv=lv)
        n['ability'] = ability_for(m['sp'], sp, m['ability']) if m['ability'] else None
        n['moves'] = upgrade(sp, lv, m['moves'])
        fully = not any(isinstance(e, dict) and 'target' in e for e in SP[sp]['evolutions'] + SP[sp].get('itemEvolutions', []))
        if n['item'] == 'EVIOLITE' and fully:
            n['item'] = 'SITRUS_BERRY'
        if n['item'] == 'ORAN_BERRY' and lv >= 30:
            n['item'] = 'SITRUS_BERRY'
        out.append(n)
    return out


def lua_mon(m):
    s = f', spread = "{m["spread"]}"' if m['spread'] else ''
    ab = f', ability = "{m["ability"]}"' if m['ability'] else ''
    nat = f', nature = "{m["nature"]}"' if m['nature'] else ''
    item = f', item = "{m["item"]}"' if m['item'] else ''
    mv = ', '.join(f'"{x}"' for x in m['moves'])
    return f'      {{ "{m["sp"]}", {m["lv"]}{ab}{nat}{s}{item}, moves = {{ {mv} }} }},'


def main():
    vanilla = {t['symbol'][8:] for t in D['trainers'] if not t['phantom']}
    rows, partners = [], []
    for name in sorted(vanilla):
        m = re.match(r'(.+)_([2-9])$', name)
        if not m:
            continue
        base, tier = m.group(1), int(m.group(2))
        first = TRAINERS.get(base + '_1') or (TRAINERS.get(base) if base.startswith('WALLY_VR') else None)
        if base == 'WALLY_VR':
            first = TRAINERS.get('WALLY_VR_1')
        if not first or name in TRAINERS:
            continue
        opts, mons = first
        post = bool(POST.match(name))
        top0 = max(x['lv'] for x in mons)
        top = POST_TOP.get(tier, 72) if post else max(top0 + 2 * (tier - 1), ROUTE_TOP.get(tier, 50))
        team = scale(mons, top, tier)
        o = {k: v for k, v in opts.items() if k in ('tier',)}
        if post:
            o['tier'] = 'leader'
        if opts.get('partner') and opts['partner'] in PARTNERS:
            popts, pmons = PARTNERS[opts['partner']]
            pkey = f'RM{tier}_{opts["partner"]}'
            o['partner'] = pkey
            ptop = top - (top0 - max(x['lv'] for x in pmons))
            partners.append((pkey, popts, scale(pmons, ptop, tier), name))
        rows.append((name, o, team))
    lines = ['-- Generated by tools/gen_rematch_teams.py from the hand-picked first fights in',
             '-- campaign/trainer_teams.lua; edit that file (or move a rematch there) rather',
             '-- than this one. Route rematches top out at 33/38/43/48 by tier, leaders and',
             '-- Wally at 60/64/68/72 after the Hall of Fame.',
             'return {', '  trainers = {']
    for name, o, team in rows:
        head = ''.join(f'{k} = "{v}", ' for k, v in sorted(o.items()))
        lines.append(f'    {name} = {{ {head}party = {{')
        lines += [lua_mon(x) for x in team]
        lines.append('    } },')
    lines += ['  },', '', '  partners = {']
    for pkey, popts, team, like in partners:
        lines.append(f'    {pkey} = {{ like = "{popts.get("like", like)}", name = "{popts.get("name", "PAL")}", defeat = "{popts.get("defeat", "Beaten again!")}", party = {{')
        lines += [lua_mon(x) for x in team]
        lines.append('    } },')
    lines += ['  },', '}', '']
    (NATIVE / 'campaign/trainer_teams_rematch.lua').write_text('\n'.join(lines))
    print(f'{len(rows)} rematch teams, {len(partners)} partners')


if __name__ == '__main__':
    main()
