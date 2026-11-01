#!/usr/bin/env python3
"""Route trainers as a real threat (user, 2026-10-31). From Rustboro to Fortree and
in Victory Road, each route trainer and tag partner gains up to RAISE levels (never
past MARGIN under the next boss's ace), gets 128 EVs, evolves once its level allows
and swaps its weakest attack for a stronger same-type move it can learn (POWER caps
that by level). Chapter 1 stays (playtested: "decent challenge") and chapter 8 stays
(already the hardest stretch). Rewrites campaign/trainer_teams.lua in place. Run once,
then edit by hand, and run tools/gen_rematch_teams.py after it.
"""
import re
from pathlib import Path

import teamhelp as H

TEAMS = Path(__file__).resolve().parent.parent / "campaign/trainer_teams.lua"
D, SP, MV = H.D, H.SP, H.MV
RAISE, MARGIN, EV = 4, 2, 128
SKIP_CHAPTERS = {0, 7}
ROUTE_EV = 84
NO_MOVE = {"SKY_ATTACK", "SOLAR_BEAM", "FOCUS_PUNCH", "BIDE", "RAZOR_WIND", "SKULL_BASH", "HYPER_BEAM", "GIGA_IMPACT",
           "DREAM_EATER", "SYNCHRONOISE", "LAST_RESORT", "FAKE_OUT", "FIRST_IMPRESSION", "BELCH", "EXPLOSION",
           "SELF_DESTRUCT", "FUTURE_SIGHT", "DOOM_DESIRE", "SUCKER_PUNCH", "FEINT", "SNORE", "OUTRAGE", "THRASH",
           "PETAL_DANCE", "UPROAR", "OVERHEAT", "LEAF_STORM", "DRACO_METEOR", "PSYCHO_BOOST", "SUPERPOWER",
           "CLOSE_COMBAT", "HAMMER_ARM"}
BLOCK = re.compile(r'^\s+(\w+) = \{(.*)party = \{\s*$')
MON = re.compile(r'^(\s+\{ ")(\w+)(", )(\d+)(,.*)$')


def power_cap(level):
    return 40 + level * 1.2


def ace(trainer):
    return max(m["level"] for m in trainer["party"])


def bounds():
    """party signature -> the level this team may reach, first place it appears"""
    by_id = {t["id"]: t for t in D["trainers"]}
    out = {}
    for ci, chapter in enumerate(D["routeGuide"]):
        if ci in SKIP_CHAPTERS:
            continue
        bosses = set(chapter["bosses"])
        order = [x for step in chapter["steps"] for x in step["trainers"]]
        for pos, tid in enumerate(order):
            if tid in bosses:
                continue
            nxt = next((ace(by_id[x]) for x in order[pos:] if x in bosses), chapter["cap"])
            nxt = min(nxt, 50) if ci == 8 else nxt  # Sidney's ace; his cap holds Victory Road
            for t in (by_id[tid], by_id.get(by_id[tid].get("partnerId"))):
                if t:
                    sig = tuple((D["species"][str(m["species"])]["symbol"][8:], m["level"]) for m in t["party"])
                    out.setdefault(sig, nxt - MARGIN)
    return out


def evolve(name, level):
    for _ in range(2):
        nxt = [e for e in SP[name]["evolutions"] if e.get("method") == "EVO_LEVEL" and e["param"] <= level]
        if not nxt:
            break
        target = D["species"][str(nxt[0]["target"])]
        if target.get("excluded"):
            break
        name = target["symbol"][8:]
    return name


def stronger(name, level, moves):
    """moves with the weakest attack traded for the strongest fitting same-type one"""
    sp = SP[name]
    types = set(sp["types"])
    category = "physical" if sp["stats"]["atk"] >= sp["stats"]["spa"] else "special"
    lvl, other = H.legal(sp, level)
    fits = [(MV[m]["power"], m) for m in lvl | other
            if m in MV and MV[m]["category"] == category and MV[m]["type"] in types and 1 < MV[m]["power"] <= power_cap(level)
            and (MV[m]["accuracy"] or 100) >= 85 and MV[m]["symbol"][5:] not in NO_MOVE]
    if not fits:
        return moves
    power, best = max(fits)
    sym = MV[best]["symbol"][5:]
    ids = [H.MSYM[m] for m in moves]
    held = [MV[i]["power"] for i in ids if MV[i]["category"] == category and MV[i]["type"] in types]
    if sym in moves or power <= max(held + [0]) + 5:
        return moves
    if len(moves) < 4:
        return moves + [sym]
    attacks = [(MV[i]["power"], n) for n, i in enumerate(ids) if MV[i]["category"] != "status"]
    moves = list(moves)
    moves[min(attacks)[1] if attacks else 3] = sym
    return moves


def abilities(name):
    return [D["abilities"][str(a)]["symbol"][8:] for a in SP[name]["abilities"]]


def raise_line(line, limit):
    m = MON.match(line)
    head, name, comma, level, rest = m.groups()
    new_level = max(int(level), min(limit, int(level) + RAISE))
    new_name = evolve(name, new_level)
    if new_name != name:
        rest = rest.replace('item = "EVIOLITE", ', "")
        found = re.search(r'ability = "(\w+)"', rest)
        if found and found.group(1) in abilities(name):
            slot = abilities(name).index(found.group(1))
            rest = rest.replace(found.group(0), f'ability = "{abilities(new_name)[slot]}"')
    moves = re.search(r'moves = \{ (.*?) \}', rest)
    names = re.findall(r'"(\w+)"', moves.group(1))
    swapped = stronger(new_name, new_level, names)
    rest = rest.replace(moves.group(0), "moves = { " + ", ".join(f'"{x}"' for x in swapped) + " }")
    if " ev = " not in rest:
        rest = rest.replace("moves = {", f"ev = {EV}, moves = {{")
    return f"{head}{new_name}{comma}{new_level}{rest}"


def main():
    limits = bounds()
    lines = TEAMS.read_text().split("\n")
    teams = 0
    i = 0
    while i < len(lines):
        block = BLOCK.match(lines[i])
        i += 1
        if not block:
            continue
        start = i
        while MON.match(lines[i]):
            i += 1
        if "tier =" in block.group(2):
            continue
        sig = tuple((MON.match(x).group(2), int(MON.match(x).group(4))) for x in lines[start:i])
        if sig in limits:
            teams += 1
            lines[start:i] = [raise_line(x, limits[sig]) for x in lines[start:i]]
    TEAMS.write_text("\n".join(lines))
    print(teams, "teams raised")


if __name__ == "__main__":
    main()
