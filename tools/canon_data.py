#!/usr/bin/env python3
"""campaign/canon.json: the official numbers and text the campaign uses in place
of the donor's rebalance (user, 2026-10-30). Compares the game's data with
PokeAPI's CSV export (github.com/PokeAPI/pokeapi, data/v2/csv) and keeps only what
differs: base-form and regional stats, types and abilities, move power, accuracy,
PP, type and category, and move/ability/Pokedex text where official text fits the
screen. tools/apply_canon.lua applies it at build time, so edit canon.json by hand
to keep a change of ours. Run: canon_data.py <folder of PokeAPI CSVs>
"""
import csv
import json
import re
import sys
from pathlib import Path

NATIVE = Path(__file__).resolve().parent.parent
# the handbook export of a build WITHOUT canon.json: this compares with the donor,
# so remove canon.json, build and export before running it again
D = json.loads((NATIVE / "generated/handbook/data.json").read_text())
ENGLISH = "9"
MOVE_WIDTH, MOVE_LINES, ABILITY_TEXT, DEX_WIDTH, DEX_LINES = 28, 2, 29, 38, 4
STATS = {"1": "hp", "2": "atk", "3": "def", "4": "spa", "5": "spd", "6": "spe"}
# official replacements for moves another line owns; first one the species lacks
SIGNATURE = {"TAIL_GLOW": ["CALM_MIND", "AGILITY"], "FIERY_DANCE": ["QUIVER_DANCE", "PETAL_BLIZZARD"],
             "SEED_FLARE": ["LEAF_STORM", "ENERGY_BALL"], "PSYCHO_BOOST": ["PSYCHIC", "EXTRASENSORY"],
             "SHORE_UP": ["IRON_DEFENSE", "STOCKPILE"], "TOPSY_TURVY": ["DETECT", "FEINT"],
             "LOVELY_KISS": ["SWEET_KISS", "ATTRACT"], "CLAMP": ["WHIRLPOOL", "BITE"],
             "V_CREATE": ["OUTRAGE", "HYPER_BEAM"], "VOLT_TACKLE": ["WILD_CHARGE", "SPARK"],
             "ACCELEROCK": ["ROCK_SLIDE", "ROCK_THROW"], "PLASMA_FISTS": ["THUNDER_PUNCH", "THUNDERBOLT"],
             "MAGMA_STORM": ["FIRE_BLAST", "FLAMETHROWER"], "FUSION_BOLT": ["WILD_CHARGE", "SPARK"],
             "FUSION_FLARE": ["FIRE_BLAST", "FLAMETHROWER"], "GLACIATE": ["ICY_WIND", "ICE_BEAM"],
             "BOLT_STRIKE": ["THUNDER", "THUNDERBOLT"], "BLUE_FLARE": ["OVERHEAT", "FLARE_BLITZ"],
             "SECRET_SWORD": ["SACRED_SWORD", "RAZOR_SHELL"], "DIAMOND_STORM": ["POWER_GEM", "ROCK_SLIDE"]}
# species still holding a donor-only ability after the official rows (forms) ->
CUSTOM_ABILITY = {"CHLOROPLAST": "CHLOROPHYLL", "WHITEOUT": "SNOW_WARNING", "PYROMANCY": "FLARE_BOOST",
                  "KEEN_EDGE": "TECHNICIAN", "PRISM_SCALES": "MULTISCALE", "POWER_FISTS": "IRON_FIST",
                  "SAND_SONG": "SAND_FORCE", "RAMPAGE": "MOXIE", "VENGEANCE": "JUSTIFIED", "BLITZ_BOXER": "IRON_FIST"}


def rows(folder, name):
    with open(f"{folder}/{name}.csv", encoding="utf8") as f:
        return list(csv.DictReader(f))


def slug(symbol):
    return symbol.lower().replace("_", "-")


def clean(text):
    text = " ".join(text.replace("­", "").split())
    return text.replace("’", "'").replace("POKéMON", "Pokémon")


def shortest(texts, limit):
    fits = [t for t in texts if len(t) <= limit and re.fullmatch(r"[ -~é—…]+", t)]
    return min(fits, key=len) if fits else None


def wrap(text, width=DEX_WIDTH):
    lines, line = [], ""
    for word in text.split():
        if line and len(line) + 1 + len(word) > width:
            lines.append(line)
            line = word
        else:
            line = f"{line} {word}".strip()
    return "\n".join(lines + [line]) if line else None


def main():
    folder = sys.argv[1]
    species_rows = {r["id"]: r for r in rows(folder, "pokemon_species")}
    default, by_name = {}, {r["identifier"]: r for r in rows(folder, "pokemon")}
    for r in by_name.values():
        if r["is_default"] == "1":
            default[species_rows[r["species_id"]]["identifier"]] = r
    stats, kinds, abilities = {}, {}, {}
    types = {r["id"]: r["identifier"].upper() for r in rows(folder, "types")}
    type_id = {v.upper(): int(k) for k, v in D["types"].items()}
    ability_name = {r["id"]: r["identifier"] for r in rows(folder, "abilities")}
    ability_id = {slug(v["symbol"][8:]): int(k) for k, v in D["abilities"].items()}
    for r in rows(folder, "pokemon_stats"):
        stats.setdefault(r["pokemon_id"], {})[STATS[r["stat_id"]]] = int(r["base_stat"])
    for r in rows(folder, "pokemon_types"):
        kinds.setdefault(r["pokemon_id"], []).append(type_id[types[r["type_id"]]])
    for r in rows(folder, "pokemon_abilities"):
        abilities.setdefault(r["pokemon_id"], {})[int(r["slot"])] = ability_id.get(ability_name[r["ability_id"]])
    move_row = {r["identifier"]: r for r in rows(folder, "moves")}
    move_row["vise-grip"] = move_row["vice-grip"]

    move_name = {r["id"]: r["identifier"] for r in rows(folder, "moves")}
    learns = {}
    for r in rows(folder, "pokemon_moves"):
        learns.setdefault(r["pokemon_id"], set()).add(move_name[r["move_id"]])

    out = {"species": {}, "moves": {}, "abilities": {}, "dex": {}, "learnsets": {}}
    move_id = {v["symbol"][5:]: int(k) for k, v in D["moves"].items()}
    custom = {int(k) for k, v in D["abilities"].items() if v["symbol"][8:] in CUSTOM_ABILITY}
    for key, mon in D["species"].items():
        sym = mon["symbol"][8:]
        name = slug(sym).replace("-alolan", "-alola").replace("-galarian", "-galar")
        row = default.get(name) or (by_name.get(name) if "alola" in name or "galar" in name else None)
        patch = {}
        if row and "_" not in sym.replace("_ALOLAN", "").replace("_GALARIAN", "").replace("MR_MIME", "").replace("MIME_JR", ""):
            i = row["id"]
            if stats[i] != mon["stats"]:
                patch["stats"] = stats[i]
            t = kinds[i] + kinds[i][:1] if len(kinds[i]) == 1 else kinds[i]
            if set(t) != set(mon["types"]) and all(x is not None for x in t):
                patch["types"] = t
            a = abilities[i]
            slots = [a.get(1), a.get(2) or a.get(1), a.get(3) or a.get(1)]
            if None not in slots and set(slots) != set(mon["abilities"]):
                patch["abilities"] = slots
        now = patch.get("abilities", mon["abilities"])
        if set(now) & custom:
            symbol = {int(k): v["symbol"][8:] for k, v in D["abilities"].items()}
            sym_id = {v: k for k, v in symbol.items()}
            patch["abilities"] = [sym_id[CUSTOM_ABILITY[symbol[a]]] if a in custom else a for a in now]
        if patch:
            out["species"][key] = patch
        have = {m for _, m in mon["learnset"]}
        swaps = {}
        for _, m in mon["learnset"]:
            s = D["moves"][str(m)]["symbol"][5:]
            if s in SIGNATURE and row and slug(s) not in learns.get(row["id"], ()):
                new = next((move_id[c] for c in SIGNATURE[s] if move_id[c] not in have), None)
                if new:
                    have.add(new)
                    swaps[str(m)] = new
        if swaps:
            out["learnsets"][key] = swaps

    classes = {"1": "status", "2": "physical", "3": "special"}
    for key, m in D["moves"].items():
        sym = slug(m["symbol"][5:])
        c = move_row.get(sym)
        if not c or sym == "curse":
            continue
        patch = {}
        for field in ("power", "accuracy", "pp"):
            official = int(c[field]) if c[field] else 0
            if official and official != (m[field] or 0) and not (field == "power" and (m[field] or 0) <= 1):
                patch[field] = official
        if D["types"][str(m["type"])].upper() != types[c["type_id"]]:
            patch["type"] = type_id[types[c["type_id"]]]
        if classes[c["damage_class_id"]] != m["category"]:
            patch["category"] = classes[c["damage_class_id"]]
        if patch:
            out["moves"][key] = patch

    def texts(name, id_field):
        by = {}
        for r in rows(folder, name):
            if r["language_id"] == ENGLISH:
                by.setdefault(r[id_field], []).append(clean(r["flavor_text"]))
        return by

    move_ids = {r["identifier"]: r["id"] for r in rows(folder, "moves")}
    move_ids["vise-grip"] = move_ids["vice-grip"]
    official = texts("move_flavor_text", "move_id")
    out["moveText"] = {}
    for key, m in D["moves"].items():
        t = shortest(official.get(move_ids.get(slug(m["symbol"][5:])), []), MOVE_WIDTH * MOVE_LINES)
        t = t and wrap(t, MOVE_WIDTH)
        if t and t.count("\n") < MOVE_LINES and " ".join(t.split()) != m.get("description"):
            out["moveText"][key] = t
    official = texts("ability_flavor_text", "ability_id")
    ids = {v: k for k, v in ability_name.items()}
    for key, a in D["abilities"].items():
        t = shortest(official.get(ids.get(slug(a["symbol"][8:])), []), ABILITY_TEXT)
        if t and t != a.get("description"):
            out["abilities"][key] = t
    official = texts("pokemon_species_flavor_text", "species_id")
    national = {r["id"]: int(r["id"]) for r in species_rows.values()}
    for sid, lines in official.items():
        n = national.get(sid)
        if not n or n <= 386:
            continue
        for t in reversed(lines):
            w = wrap(t)
            if w and w.count("\n") < DEX_LINES and re.fullmatch(r"[ -~é—…\n]+", w):
                out["dex"][n] = w
                break
    (NATIVE / "campaign/canon.json").write_text(json.dumps(out, indent=0, sort_keys=True) + "\n")
    print({k: len(v) for k, v in out.items()})


if __name__ == "__main__":
    main()
