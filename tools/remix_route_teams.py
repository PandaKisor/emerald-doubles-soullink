#!/usr/bin/env python3
"""Route trainers and tag partners get their own teams (user, 2026-10-30:
"changing the teams across the board for the route trainers ... nothing too
drastic"). Same concept as tools/remix_wild.py: a team keeps its levels, size,
types, role and item idea; a Pokemon the ROM's trainer never had takes its
evolution line's stand-in (tools/line_swaps.json) at the stage its level allows.
A team with nothing left to swap trades one Pokemon for a close same-type line.

Moves that the new Pokemon can learn stay; the rest are refilled from its own
level-up list. Rewrites campaign/trainer_teams.lua in place: gyms, bosses, grunts
and rivals (anything with a tier) aren't touched. Run once, then edit by hand.
Run tools/gen_rematch_teams.py after it.
"""
import json
import re
import zlib
from pathlib import Path

import teamhelp as H
import remix_wild as W

HERE = Path(__file__).resolve().parent
TEAMS = HERE.parent / "campaign/trainer_teams.lua"
SWAPS = json.loads((HERE / "line_swaps.json").read_text())
VANILLA = json.loads((HERE / "vanilla_trainers.json").read_text())
SP, D, MV, MSYM = H.SP, H.D, H.MV, H.MSYM

# type-boosting items by type name, for a stand-in of another type
BOOST = {"Normal": "SILK_SCARF", "Fighting": "BLACK_BELT", "Flying": "SHARP_BEAK", "Poison": "POISON_BARB",
         "Ground": "SOFT_SAND", "Rock": "HARD_STONE", "Bug": "SILVER_POWDER", "Ghost": "SPELL_TAG",
         "Steel": "METAL_COAT", "Fire": "CHARCOAL", "Water": "MYSTIC_WATER", "Grass": "MIRACLE_SEED",
         "Electric": "MAGNET", "Psychic": "TWISTED_SPOON", "Ice": "NEVER_MELT_ICE", "Dragon": "DRAGON_FANG",
         "Dark": "BLACK_GLASSES", "Fairy": "PIXIE_PLATE"}
ITEM_TYPE = {v: k for k, v in BOOST.items()}
# held for an ability or a mechanic the stand-in may not share
TIED = {"TOXIC_ORB", "FLAME_ORB", "EVIOLITE", "LIGHT_BALL", "THICK_CLUB", "STICK", "LEEK", "LUCKY_PUNCH"}
SWAP_NATURE = {"ADAMANT": "MODEST", "MODEST": "ADAMANT", "JOLLY": "TIMID", "TIMID": "JOLLY",
               "NAUGHTY": "RASH", "RASH": "NAUGHTY", "BRAVE": "QUIET", "QUIET": "BRAVE"}
SWAP_SPREAD = {"atk": "spa", "spa": "atk", "tank": "stank", "stank": "tank"}
USEFUL_STATUS_MIN = 1

ID = {v["symbol"][8:]: int(k) for k, v in D["species"].items()}
NAME = {int(k): v["symbol"][8:] for k, v in D["species"].items()}


def line_of(name):
    return W.root(ID[name])


def need_level(name):
    """The level a Pokemon can have evolved into this species, 0 if it's a base."""
    pre = H.PRE.get(str(ID[name]))
    if not pre:
        return 0
    for e in W.evolutions(D["species"][pre] if False else W.SP[int(pre)]):
        if int(e["target"]) == ID[name]:
            return int(e["param"]) if e.get("method") == "EVO_LEVEL" else 20
    return 0


def at_level(name, level):
    """name, or its pre-evolution when the level is too low for it."""
    while need_level(name) > level + 2:
        name = NAME[int(H.PRE[str(ID[name])])]
    return name


def type_names(name):
    return {H.TYPES[str(t)] for t in SP[name]["types"]}


def physical(name):
    st = SP[name]["stats"]
    return st["atk"] >= st["spa"]


def stand_in(name, level, salt):
    """A close same-type line for a Pokemon the swap list leaves alone."""
    a = line_of(name)
    stage = next(i for i, s in enumerate(W.stages(a)) if ID[name] in s)
    rows = sorted((c, b) for b in {W.root(i) for i in W.SP} if W.eligible(b) and (c := W.score(a, b)) is not None)
    rows = rows[:6]
    if not rows:
        return None
    b = rows[zlib.crc32(salt.encode()) % len(rows)][1]
    return at_level(NAME[W.stages(b)[stage][0]], level)


def new_moves(old, name, level):
    lvl, other = H.legal(SP[name], level)
    legal = lvl | other
    keep = [m for m in old if MSYM.get(m) in legal]
    def strong(ids, want):
        rows = [MV[m] for m in ids if m in MV and MV[m]["symbol"][5:] not in H.WEAK and (MV[m]["power"] or 0) > 1
                and MV[m]["category"] == want]
        return sorted(rows, key=lambda m: -(m["power"] * (1.5 if H.TYPES[str(m["type"])] in type_names(name) else 1)))
    own = {m for lv, m in SP[name]["learnset"] if lv <= level}
    pre = str(ID[name])
    while pre in H.PRE:
        pre = H.PRE[pre]
        own |= {m for lv, m in D["species"][pre]["learnset"] if lv <= level}
    attacks = strong(own, "physical" if physical(name) else "special") + \
        strong(own, "special" if physical(name) else "physical")
    support = [MV[m] for m in sorted(own) if m in MV and MV[m]["category"] == "status" and MV[m]["symbol"][5:] not in H.WEAK]
    def have_stab():
        return any(MV[MSYM[m]]["power"] and H.TYPES[str(MV[MSYM[m]]["type"])] in type_names(name) for m in keep)
    fill = []
    if not have_stab():
        fill += [m for m in attacks if H.TYPES[str(m["type"])] in type_names(name)]
    fill += attacks[:2] + support[-2:] + attacks[2:]
    for m in fill:
        sym = m["symbol"][5:]
        if len(keep) >= 4:
            break
        if sym not in keep:
            keep.append(sym)
    return keep[:4]


def rewrite(line, old, name, level):
    abil_old = [D["abilities"][str(a)]["symbol"][8:] for a in SP[old]["abilities"]]
    abil_new = [D["abilities"][str(a)]["symbol"][8:] for a in SP[name]["abilities"]]
    ab = re.search(r'ability = "([A-Z0-9_]+)"', line)
    slot = abil_old.index(ab.group(1)) if ab and ab.group(1) in abil_old else 0
    ability = abil_new[slot] if slot < len(abil_new) and abil_new[slot] != "NONE" else abil_new[0]
    line = re.sub(r'ability = "[A-Z0-9_]+"', f'ability = "{ability}"', line) if ab else line
    if physical(old) != physical(name):
        line = re.sub(r'nature = "([A-Z]+)"', lambda m: f'nature = "{SWAP_NATURE.get(m[1], m[1])}"', line)
        line = re.sub(r'spread = "([a-z]+)"', lambda m: f'spread = "{SWAP_SPREAD.get(m[1], m[1])}"', line)
    it = re.search(r'item = "([A-Z0-9_]+)"', line)
    if it:
        item, types = it.group(1), type_names(name)
        if item in TIED:
            line = line.replace(f' item = "{item}",', "")
        elif item in ITEM_TYPE and ITEM_TYPE[item] not in types:
            line = line.replace(f'item = "{item}"', f'item = "{BOOST[sorted(types)[0]]}"')
    old_moves = re.findall(r'"([A-Z0-9_]+)"', re.search(r'moves = \{([^}]*)\}', line).group(1))
    moves = new_moves(old_moves, name, level)
    line = re.sub(r'moves = \{[^}]*\}', "moves = { " + ", ".join(f'"{m}"' for m in moves) + " }", line)
    return line.replace(f'{{ "{old}", ', f'{{ "{name}", ', 1)


def main():
    lines = TEAMS.read_text().split("\n")
    head = re.compile(r"^    ([A-Z0-9_]+) = \{(.*)party = \{\s*$")
    mon = re.compile(r'^      \{ "([A-Z0-9_]+)", (\d+),')
    i, teams, changed, untouched = 0, 0, 0, []
    while i < len(lines):
        m = head.match(lines[i])
        i += 1
        if not m or "tier =" in m[2] or m[1].startswith(("BRENDAN", "MAY_", "WALLY")):
            continue
        key, start = m[1], i
        while mon.match(lines[i]):
            i += 1
        teams += 1
        ours = {line_of(n) for n in map(lambda s: s.upper().replace(" ", "_").replace("'", "").replace(".", "").replace("-", "_"),
                                        VANILLA.get(key, [])) if n in ID}
        did = 0
        for k in range(start, i):
            g = mon.match(lines[k])
            old, level = g[1], int(g[2])
            if old not in ID or line_of(old) in ours or old not in SWAPS:
                continue
            new = at_level(SWAPS[old], level)
            if new != old:
                lines[k] = rewrite(lines[k], old, new, level)
                did += 1
        if not did:
            # the lowest-level Pokemon goes, so the ace stays the trainer's
            k = min(range(start, i), key=lambda n: int(mon.match(lines[n])[2]))
            g = mon.match(lines[k])
            new = g[1] in ID and stand_in(g[1], int(g[2]), key)
            if new and new != g[1]:
                lines[k] = rewrite(lines[k], g[1], new, int(g[2]))
                did = 1
        if did:
            changed += 1
        else:
            untouched.append(key)
    TEAMS.write_text("\n".join(lines))
    print(teams, "teams,", changed, "changed; unchanged:", untouched)


if __name__ == "__main__":
    main()
