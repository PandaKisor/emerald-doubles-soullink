#!/usr/bin/env python3
"""Adds to campaign/canon.json what tools/canon_data.py leaves out (user, 2026-10-31):
forms with their own official row, and "strip": rare TM, tutor and egg moves the donor
handed out widely, taken off every species whose evolution line never learns them
officially. Common extras stay, as the added level-up moves did. Reads the handbook
export of the current build, so run it after canon_data.py and an export; running it
again keeps what is already in canon.json. Run: canon_extras.py <folder of PokeAPI CSVs>
"""
import csv
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

NATIVE = Path(__file__).resolve().parent.parent
D = json.loads((NATIVE / "generated/handbook/data.json").read_text())
STATS = {"1": "hp", "2": "atk", "3": "def", "4": "spa", "5": "spd", "6": "spe"}
# our form -> the official row with its stats
FORMS = {"WORMADAM_SANDY_CLOAK": "wormadam-sandy", "WORMADAM_TRASH_CLOAK": "wormadam-trash", "CHERRIM_SUNSHINE": "cherrim",
         "BASCULIN_BLUE_STRIPED": "basculin-blue-striped", "SAWSBUCK_SUMMER": "sawsbuck", "SAWSBUCK_AUTUMN": "sawsbuck",
         "SAWSBUCK_WINTER": "sawsbuck", "MEOWSTIC_FEMALE": "meowstic-female", "PUMPKABOO_SMALL": "pumpkaboo-small",
         "PUMPKABOO_LARGE": "pumpkaboo-large", "PUMPKABOO_SUPER": "pumpkaboo-super", "GOURGEIST_SMALL": "gourgeist-small",
         "GOURGEIST_LARGE": "gourgeist-large", "GOURGEIST_SUPER": "gourgeist-super", "ORICORIO_POM_POM": "oricorio-pom-pom",
         "ORICORIO_PAU": "oricorio-pau", "ORICORIO_SENSU": "oricorio-sensu", "LYCANROC_MIDNIGHT": "lycanroc-midnight",
         "LYCANROC_DUSK": "lycanroc-dusk", "ZACIAN_CROWNED_SWORD": "zacian-crowned", "ZAMAZENTA_CROWNED_SHIELD": "zamazenta-crowned"}
RARE_LINES = 20  # a move this few evolution lines learn officially isn't for handing out
ALSO_STRIP = {"aura-sphere", "dragon-dance"}
ANY_MOVE = {"MEW"}


def rows(folder, name):
    with open(Path(folder) / f"{name}.csv", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def slug(symbol):
    return symbol.lower().replace("_", "-")


def main():
    folder = sys.argv[1]
    canon = json.loads((NATIVE / "campaign/canon.json").read_text())
    pokemon = rows(folder, "pokemon")
    stats = defaultdict(dict)
    for r in rows(folder, "pokemon_stats"):
        stats[r["pokemon_id"]][STATS[r["stat_id"]]] = int(r["base_stat"])
    by_name = {r["identifier"]: r for r in pokemon}
    forms = 0
    for key, mon in D["species"].items():
        name = FORMS.get(mon["symbol"][8:])
        if name and stats[by_name[name]["id"]] != mon["stats"]:
            canon["species"].setdefault(key, {})["stats"] = stats[by_name[name]["id"]]
            forms += 1

    species = {r["identifier"]: r for r in rows(folder, "pokemon_species")}
    names = sorted(species, key=len, reverse=True)
    line_of = {r["id"]: species_row["evolution_chain_id"] for r in pokemon
               for species_row in [next(s for s in species.values() if s["id"] == r["species_id"])]}
    move_name = {r["id"]: r["identifier"] for r in rows(folder, "moves")}
    line_moves, move_lines = defaultdict(set), defaultdict(set)
    for r in rows(folder, "pokemon_moves"):
        line = line_of[r["pokemon_id"]]
        line_moves[line].add(move_name[r["move_id"]])
        move_lines[move_name[r["move_id"]]].add(line)

    def teaches(kind, entry):
        if kind == "machines":
            return D["items"][str(entry)].get("machineMove")
        return D["tutorMoves"].get(str(entry)) if kind == "tutors" else entry

    strip = canon.setdefault("strip", {})
    count = 0
    for key, mon in D["species"].items():
        symbol = mon["symbol"][8:]
        if symbol in ANY_MOVE or re.search("MEGA|PRIMAL|GMAX", symbol):
            continue
        base = next((n for n in names if slug(symbol) == n or slug(symbol).startswith(n + "-")), None)
        if not base:
            continue
        own = line_moves[species[base]["evolution_chain_id"]]
        for kind in ("machines", "tutors", "eggMoves"):
            for entry in mon.get(kind, []):
                move = D["moves"].get(str(teaches(kind, entry)))
                name = move and slug(move["symbol"][5:])
                if name and name not in own and (len(move_lines[name]) <= RARE_LINES or name in ALSO_STRIP) \
                        and name in move_lines:
                    strip.setdefault(key, {}).setdefault(kind, []).append(entry)
                    count += 1
    (NATIVE / "campaign/canon.json").write_text(json.dumps(canon, indent=0, sort_keys=True) + "\n")
    print(f"{forms} forms, {count} moves stripped from {len(strip)} species")


if __name__ == "__main__":
    main()
