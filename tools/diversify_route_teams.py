#!/usr/bin/env python3
"""More variety on the routes (user, 2026-10-31: "diversity of equal challenge").
A species on more than LIMIT route or partner teams gives up its later slots to a
close stand-in: shares a type, within BST_GAP in total stats, attacks from the same
side, and could have evolved by that level. Moves it can learn stay, the rest are
refilled from its own list. Gyms, bosses and grunts (anything with a tier) stay.
Rewrites campaign/trainer_teams.lua in place. Run once, then edit by hand, and run
tools/gen_rematch_teams.py after it.
"""
import re
from collections import Counter
from pathlib import Path

import teamhelp as H
from raise_route_teams import BLOCK, MON, abilities, power_cap

TEAMS = Path(__file__).resolve().parent.parent / "campaign/trainer_teams.lua"
D, SP, MV = H.D, H.SP, H.MV
LIMIT, ALT_LIMIT, BST_GAP, EARLY = 8, 6, 25, 3
TIED = {"TOXIC_ORB", "FLAME_ORB", "EVIOLITE", "LIGHT_BALL", "THICK_CLUB", "LEEK", "LUCKY_PUNCH"}


def bst(sp):
    return sum(sp["stats"].values())


def physical(sp):
    return sp["stats"]["atk"] >= sp["stats"]["spa"]


def ready(name, level):
    """not an evolved species well before its evolution level"""
    pre = H.PRE.get(str(SP[name]["id"]))
    if not pre:
        return True
    for e in D["species"][pre]["evolutions"]:
        if e.get("target") == SP[name]["id"] and e.get("method") == "EVO_LEVEL":
            return e["param"] <= level + EARLY
    return level >= 25


def stand_in(name, level, team, used):
    sp = SP[name]
    if sp["evolutions"] and any(e.get("method") == "EVO_LEVEL" and e["param"] <= level for e in sp["evolutions"]):
        return None
    options = []
    for other, cand in SP.items():
        if other == name or other in team or cand.get("excluded") or "_" in other or used[other] >= ALT_LIMIT:
            continue
        if not set(cand["types"]) & set(sp["types"]) or abs(bst(cand) - bst(sp)) > BST_GAP:
            continue
        if physical(cand) != physical(sp) or not ready(other, level):
            continue
        options.append((used[other], abs(bst(cand) - bst(sp)), other))
    return min(options)[2] if options else None


def refit(moves, name, level):
    sp = SP[name]
    lvl, other = H.legal(sp, level)
    kept = [m for m in moves if H.MSYM[m] in lvl | other]
    extra = sorted((m for m in lvl if m in MV and MV[m]["category"] != "status" and MV[m]["power"] <= power_cap(level)),
                   key=lambda m: (MV[m]["type"] in sp["types"], MV[m]["power"]), reverse=True)
    for m in extra:
        sym = MV[m]["symbol"][5:]
        if len(kept) >= len(moves):
            break
        if sym not in kept:
            kept.append(sym)
    return kept or moves


def main():
    lines = TEAMS.read_text().split("\n")
    route = []
    i = 0
    while i < len(lines):
        block = BLOCK.match(lines[i])
        i += 1
        if not block:
            continue
        start = i
        while MON.match(lines[i]):
            i += 1
        if "tier =" not in block.group(2):
            route.append((start, i))
    used = Counter(MON.match(lines[n]).group(2) for a, b in route for n in range(a, b))
    seen, swaps = Counter(), 0
    for a, b in route:
        team = {MON.match(lines[n]).group(2) for n in range(a, b)}
        for n in range(a, b):
            head, name, comma, level, rest = MON.match(lines[n]).groups()
            seen[name] += 1
            if seen[name] <= LIMIT:
                continue
            new = stand_in(name, int(level), team, used)
            if not new:
                continue
            found = re.search(r'ability = "(\w+)"', rest)
            if found:
                slot = abilities(name).index(found.group(1)) if found.group(1) in abilities(name) else 0
                rest = rest.replace(found.group(0), f'ability = "{abilities(new)[slot]}"')
            item = re.search(r'item = "(\w+)", ', rest)
            if item and item.group(1) in TIED:
                rest = rest.replace(item.group(0), "")
            moves = re.search(r'moves = \{ (.*?) \}', rest)
            fitted = refit(re.findall(r'"(\w+)"', moves.group(1)), new, int(level))
            rest = rest.replace(moves.group(0), "moves = { " + ", ".join(f'"{x}"' for x in fitted) + " }")
            lines[n] = f"{head}{new}{comma}{level}{rest}"
            used[name] -= 1
            used[new] += 1
            team.add(new)
            swaps += 1
    TEAMS.write_text("\n".join(lines))
    print(swaps, "slots swapped")


if __name__ == "__main__":
    main()
