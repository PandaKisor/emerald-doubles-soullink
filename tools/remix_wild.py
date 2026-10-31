#!/usr/bin/env python3
"""The campaign's own wild tables (user, 2026-10-30: "keep the same general
typings in the route encounters, but change the mons up a bit").

Starts from the donor's tables and swaps whole evolution lines: every line that
was never wild in vanilla Emerald trades places with another line (usually one
already wild elsewhere, since the donor uses nearly every line) that shares a
type, has the same number of stages and a similar final power, so a slot keeps
its feel, level and rarity. Writes campaign/wild_maps.lua (the build ships it as
is; edit it by hand from here on) and tools/line_swaps.json (remix_route_teams.py
reads it). Only needed again to redo the swap from scratch. Reads
generated/handbook/data.json and tools/vanilla_wild.tsv (the ROM's tables).
"""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NATIVE = HERE.parent
DONOR = NATIVE.parents[1] / "pokeemerald-1.13"
D = json.loads((NATIVE / "generated/handbook/data.json").read_text())
SP = {int(k): v for k, v in D["species"].items()}
BY_SYM = {v["symbol"]: k for k, v in SP.items()}

AREAS = (("land_mons", "land"), ("water_mons", "water"), ("rock_smash_mons", "rocks"), ("fishing_mons", "fishing"))
# ours, before any swap: early answers to Roxanne
EDITS = {"ROUTE101": {"land": {"SPECIES_WURMPLE": "SPECIES_POLIWAG"}},
         "ROUTE103": {"land": {"SPECIES_KRICKETOT": "SPECIES_MACHOP"}},
         "ROUTE104": {"land": {"SPECIES_SENTRET": "SPECIES_WOOPER"}}}
# the lines the player needs for those answers stay put
KEEP = {"SPECIES_POLIWAG", "SPECIES_MACHOP", "SPECIES_WOOPER"}
# never a stand-in: gifts, fossils, ultra beasts and other one-off finds
NOT_WILD = {"BULBASAUR", "CHARMANDER", "SQUIRTLE", "CHIKORITA", "CYNDAQUIL", "TOTODILE", "TREECKO", "TORCHIC", "MUDKIP",
            "TURTWIG", "CHIMCHAR", "PIPLUP", "SNIVY", "TEPIG", "OSHAWOTT", "CHESPIN", "FENNEKIN", "FROAKIE", "ROWLET",
            "LITTEN", "POPPLIO", "GROOKEY", "SCORBUNNY", "SOBBLE", "OMANYTE", "KABUTO", "AERODACTYL", "LILEEP",
            "ANORITH", "CRANIDOS", "SHIELDON", "TIRTOUGA", "ARCHEN", "TYRUNT", "AMAURA", "DRACOZOLT", "ARCTOZOLT",
            "DRACOVISH", "ARCTOVISH", "POIPOLE", "PHIONE", "MANAPHY", "COSMOG", "TYPE_NULL", "MELTAN", "KUBFU",
            "SILVALLY", "PIKACHU", "EEVEE"}
MAX_POWER_GAP = 50


def evolutions(v):
    return [e for e in v["evolutions"] + v.get("itemEvolutions", []) if isinstance(e, dict) and "target" in e]


PRE = {}
for k, v in SP.items():
    for e in evolutions(v):
        PRE.setdefault(int(e["target"]), k)


def root(i):
    while i in PRE:
        i = PRE[i]
    return i


def stages(r):
    """The line as a list of stages (each a list of species)."""
    out, cur = [], [r]
    while cur:
        out.append(cur)
        cur = [int(e["target"]) for i in cur for e in evolutions(SP[i]) if int(e["target"]) in SP]
    return out


def bst(i):
    return sum(SP[i]["stats"].values())


def types(i):
    return set(SP[i]["types"])


def evo_level(r):
    levels = [e["param"] for e in evolutions(SP[r]) if e.get("method") == "EVO_LEVEL"]
    return levels[0] if levels else None


def plain(i):
    sym = SP[i]["symbol"][8:]
    return "_" not in sym or sym in ("MR_MIME", "MIME_JR", "PORYGON_Z", "MR_RIME")


def legendary(r):
    last = stages(r)[-1][0]
    return SP[r]["meta"].get("eggGroup1") == 15 and len(stages(r)) == 1 and bst(last) >= 570 \
        or SP[r]["meta"].get("catchRate", 255) <= 3


def eligible(r):
    if SP[r]["excluded"] or not plain(r) or legendary(r) or SP[r]["symbol"][8:] in NOT_WILD:
        return False
    return all(plain(i) and not SP[i]["excluded"] for s in stages(r) for i in s)


def score(a, b):
    """Lower is closer; None when b can't stand in for a."""
    sa, sb = stages(a), stages(b)
    if a == b or len(sa) != len(sb) or not (types(a) & types(b)):
        return None
    fa, fb = sa[-1][0], sb[-1][0]
    if not (types(fa) & types(fb)):
        return None
    gap = abs(bst(fa) - bst(fb))
    if gap > MAX_POWER_GAP:
        return None
    cost = gap + abs(bst(a) - bst(b)) / 2
    if SP[a]["types"][0] != SP[b]["types"][0]:
        cost += 25
    if types(a) != types(b):
        cost += 15
    la, lb = evo_level(a), evo_level(b)
    if (la is None) != (lb is None):
        cost += 20
    elif la is not None:
        cost += abs(la - lb) * 2
    return cost


def read_tables():
    wild = json.loads((DONOR / "src/data/wild_encounters.json").read_text())
    group = next(g for g in wild["wild_encounter_groups"] if g["label"] == "gWildMonHeaders")
    rows, variants = [], {}
    for entry in group["encounters"]:
        name = entry["map"].removeprefix("MAP_")
        areas = {}
        for key, area in AREAS:
            if key in entry:
                swap = EDITS.get(name, {}).get(area, {})
                areas[area] = {"rate": entry[key]["encounter_rate"],
                               "slots": [[swap.get(m["species"], m["species"]), m["min_level"], m["max_level"]]
                                         for m in entry[key]["mons"]]}
        if not areas:
            continue
        if name == "ALTERING_CAVE":
            if name not in variants:
                variants[name] = {"map": name, "variants": []}
                rows.append(variants[name])
            variants[name]["variants"].append(areas)
        else:
            rows.append({"map": name, **areas})
    return rows


def all_slots(rows):
    for row in rows:
        for areas in row.get("variants", [row]):
            for area in ("land", "water", "rocks", "fishing"):
                if area in areas:
                    yield from areas[area]["slots"]


def lua(v):
    if isinstance(v, str):
        return '"' + v + '"'
    if isinstance(v, list):
        return "{" + ", ".join(lua(x) for x in v) + "}"
    if isinstance(v, dict):
        return "{" + ", ".join(f"{k} = {lua(x)}" for k, x in v.items()) + "}"
    return str(v)


def main():
    vanilla = set()
    for line in (HERE / "vanilla_wild.tsv").read_text().splitlines():
        vanilla |= {root(int(s)) for s in line.split("\t")[1].split(",") if s}
    rows = read_tables()
    used = {root(BY_SYM[s[0]]) for s in all_slots(rows)}
    keep = {root(BY_SYM[s]) for s in KEEP}
    swap = sorted(r for r in used if r not in vanilla and r not in keep and eligible(r))
    pool = sorted(r for r in {root(i) for i in SP} if r not in vanilla and eligible(r))
    # the hardest lines to place choose first; each line is used once
    options = {a: sorted((c, b) for b in pool if (c := score(a, b)) is not None) for a in swap}
    picked, taken = {}, set()
    for a in sorted(swap, key=lambda r: len(options[r])):
        for _, b in options[a]:
            if b not in taken:
                picked[a] = b
                taken.add(b)
                break
    species = {}
    for a, b in picked.items():
        sb = stages(b)
        for depth, stage in enumerate(stages(a)):
            for i in stage:
                best = max(sb[depth], key=lambda c: (len(types(c) & types(i)), -abs(bst(c) - bst(i))))
                species[i] = best
    for s in all_slots(rows):
        i = BY_SYM[s[0]]
        if i in species:
            s[0] = SP[species[i]]["symbol"]
    body = ",\n".join("  " + lua(r) for r in rows)
    (NATIVE / "campaign/wild_maps.lua").write_text(
        "-- The campaign's wild tables, by map. Made by tools/remix_wild.py; edit by hand.\n"
        "return {\n" + body + "\n}\n")
    (HERE / "line_swaps.json").write_text(json.dumps(
        {SP[a]["symbol"][8:]: SP[b]["symbol"][8:] for a, b in sorted(species.items())}, indent=0) + "\n")
    print(len(swap), "lines to swap,", len(picked), "swapped;", len(pool), "in the pool")
    print("kept (no fit):", [SP[r]["name"] for r in swap if r not in picked])
    for a, b in sorted(picked.items(), key=lambda p: SP[p[0]]["name"]):
        print(f'  {SP[a]["name"]:<14}-> {SP[b]["name"]:<14}{score(a, b):6.0f}')


if __name__ == "__main__":
    main()
