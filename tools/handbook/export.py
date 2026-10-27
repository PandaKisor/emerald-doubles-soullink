#!/usr/bin/env python3
"""Export resolved campaign facts for the offline handbook (standard library only).

Run after build_campaign.py. The fixture reads the owner's local Emerald ROM and
vanilla script cache; only gameplay facts are written. The output has no ROM,
scripts, artwork, player data, or network dependency. See schema.md beside this file.
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
NATIVE = HERE.parent.parent
PROJECT = NATIVE.parent.parent
ENGINE = PROJECT / "gen1recomp-0.3.73"
BUILT = NATIVE / "generated/campaign/mods"
DEFAULT_SCRIPTS = PROJECT / "porting/full_port/generated/playtest/userdata/love/inclement-playtest/emerald/data/generated/gba/scripts"
TYPES = ["Normal", "Fighting", "Flying", "Poison", "Ground", "Rock", "Bug", "Ghost", "Steel", "???", "Fire", "Water", "Grass", "Electric", "Psychic", "Ice", "Dragon", "Dark", "Fairy"]
STATS = ["atk", "def", "spe", "spa", "spd"]


def friendly(text):
    text = re.sub(r"([a-z])([A-Z])", r"\1 \2", str(text))
    text = re.sub(r"(Route)(\d)", r"\1 \2", text)
    text = text.replace("_", " · ")
    return text.replace("Pokemon", "Pokémon").replace("SSTicket", "S.S. Ticket")


def normalize(raw, manifest, coop):
    data = {key: raw[key] for key in ("species", "moves", "items", "abilities", "typeChart", "tutorMoves")}
    data["types"] = {str(i): name for i, name in enumerate(TYPES)}
    data["natures"] = {
        key: {"name": name, "effects": dict(zip(STATS, raw["natures"]["stats"][key]))}
        for key, name in raw["natures"]["names"].items()
    }
    maps = raw["maps"]
    for row in maps.values():
        row["name"] = friendly(row["name"])
    data["maps"] = maps

    def place(row):
        row["mapName"] = maps.get(row.get("map"), {}).get("name", "Shared event / location not resolved")
        return row

    def symbol_item(symbol):
        return item_ids[symbol]

    data["trainers"] = raw["trainers"]
    trainer_index = {t["id"]: t for t in data["trainers"]}
    for trainer in data["trainers"]:
        trainer["maps"] = [{"id": mid, "name": maps[mid]["name"]} for mid in trainer["maps"]]
        trainer["name"] = trainer["name"].title()
        trainer["className"] = trainer["className"].title()
        trainer["displayName"] = f'{trainer["className"]} {trainer["name"]}'
    for trainer in data["trainers"]:
        if trainer.get("partnerId"):
            partner = trainer_index[trainer["partnerId"]]
            partner["maps"] = trainer["maps"]
            partner["partnerOf"] = trainer["id"]
    # Rematches are a separate stored team; use their first match's location
    # only when the trainer's event has no direct map label.
    by_symbol = {t["symbol"]: t for t in data["trainers"]}
    for trainer in data["trainers"]:
        if not trainer["maps"]:
            original = by_symbol.get(re.sub(r"_\d+$", "_1", trainer["symbol"]))
            if original and original["maps"]:
                trainer["maps"] = original["maps"]
                trainer["mapNote"] = "Location inherited from this trainer's first meeting; rematch availability depends on story/Match Call."

    national_bases = {}
    for key, sp in data["species"].items():
        nat = sp["dex"]["national"]
        if nat and (nat not in national_bases or int(key) < int(national_bases[nat])):
            national_bases[nat] = key
    for key, sp in data["species"].items():
        sp["id"] = int(key)
        base = data["species"].get(national_bases.get(sp["dex"]["national"]))
        suffix = sp["symbol"].removeprefix(base["symbol"] + "_") if base and base is not sp else ""
        sp["displayName"] = sp["name"] + (" (" + suffix.replace("_", " ").title() + ")" if suffix and suffix != sp["symbol"] else "")
        sp["excluded"] = bool(re.search(r"_(MEGA(?:_|$)|PRIMAL$|GIGANTAMAX$)", sp["symbol"]))
        sp["evolutions"] = raw["evolutions"].get(key, [])
        sp["itemEvolutions"] = raw["itemEvolutions"].get(key, [])
    data["nectarForms"] = raw["nectarForms"]
    for key, move in data["moves"].items():
        move["id"] = int(key)
        # Flat fields describe the move the engine actually uses. Source fields
        # remain separately labeled for auditing differences (Surf, Tackle, etc.).
        source = {}
        for name in ("power", "accuracy", "pp", "priority", "type", "category", "secondaryChance", "argument"):
            if name in move["runtime"] and move["runtime"][name] != move[name]:
                source[name] = move[name]
            if name in move["runtime"]:
                move[name] = move["runtime"][name]
        if source:
            move["sourceDifferences"] = source
        move["target"] = move["runtime"].get("target", 0)
        move["flags"] = move["runtime"].get("flags", 0)
        move["description"] = " ".join(move["description"].split())
    item_ids = {row["symbol"]: int(key) for key, row in data["items"].items()}
    for key, row in data["items"].items():
        row["id"] = int(key)
        row["description"] = " ".join(row["description"].split())
        if row["symbol"] in raw["itemSources"]["prices"]:
            row["price"] = raw["itemSources"]["prices"][row["symbol"]]
        source_fields = row.pop("sourceFields", {})
        row["holdEffect"] = source_fields.get("holdEffect")
        row["holdEffectParam"] = source_fields.get("holdEffectParam")
    for key, row in data["abilities"].items():
        row["id"] = int(key)
        row["description"] = " ".join(row["description"].split())

    wild = []
    for mid, table in raw["wild"].items():
        for variant, area in enumerate(table.get("variants", [table])):
            for method in ("land", "water", "rocks", "fishing"):
                if method not in area:
                    continue
                entry = area[method]
                groups = [(method, range(len(entry["slots"])), [20,20,10,10,10,10,5,5,4,4,1,1] if method == "land" else [60,30,5,4,1])]
                if method == "fishing":
                    groups = [("Old Rod", range(0,2), [70,30]), ("Good Rod", range(2,5), [60,20,20]), ("Super Rod", range(5,10), [40,40,15,4,1])]
                for name, indexes, weights in groups:
                    row = place({"map": mid, "method": {"land":"Grass / cave", "water":"Surf", "rocks":"Rock Smash"}.get(name,name), "rate":entry["rate"], "slots":[]})
                    if "variants" in table:
                        row["variant"] = variant
                        row["note"] = "Altering Cave state " + str(variant) + " (0 is the default)."
                    for i, weight in zip(indexes,weights):
                        if i < len(entry["slots"]):
                            slot = entry["slots"][i].copy()
                            slot.update(slot=i+1, weight=weight)
                            row["slots"].append(slot)
                    row["emptyWeight"] = 100-sum(s["weight"] for s in row["slots"])
                    if row["emptyWeight"]:
                        row["note"] = (row.get("note", "") + f' {row["emptyWeight"]}% of slot rolls have no entry in the current runtime table.').strip()
                    wild.append(row)
    data["wild"] = sorted(wild, key=lambda x:(x["mapName"],x["method"],x.get("variant",0)))

    sources = []
    for src in raw["sources"]:
        src = place(src.copy())
        label = src.get("label", "")
        if label.startswith("PlayersHouse_"):
            src.update(map="EM_LITTLEROOT_TOWN_BRENDANS_HOUSE_1F", mapName="Littleroot Town · Player's house · 1F")
        elif label.startswith("BerryBlender_"):
            src["mapName"] = "Contest halls · Berry Blender"
        elif label.startswith("CableClub_"):
            src["mapName"] = "Pokémon Center · Cable Club event"
        if src["kind"] == "Gift":
            title = re.split(r"_EventScript_",label)[-1]
            src["note"] = "Script reward: " + friendly(title) + ". Exact trigger/story condition is not evaluated."
        else:
            src["note"] = "Map tile coordinates (x, y); access may require story progress or field moves."
        sources.append(src)
    shops = []
    tiers = [[symbol_item(s) for s in tier] for tier in raw["itemSources"]["tiers"]]
    for entry in raw["shops"]:
        campaign = entry.get("campaign") or {}
        kind = campaign.get("kind", "vanilla")
        stocks = []
        for badge in range(9):
            if kind == "general":
                items = entry["vanillaItems"] + tiers[min(badge,len(tiers)-1)] + [symbol_item(s) for s in campaign.get("extra",[])]
            elif kind == "fixed" and campaign.get("items"):
                items = [symbol_item(s) for s in campaign["items"]]
            else:
                items = entry["vanillaItems"]
            stocks.append(list(dict.fromkeys(i for i in items if i)))
        row = place({"map":entry.get("map"),"label":entry["label"],"kind":kind,"stockByBadges":stocks})
        shops.append(row)
        all_items = dict.fromkeys(i for stock in stocks for i in stock)
        for item in all_items:
            badges = [b for b,stock in enumerate(stocks) if item in stock]
            sources.append(place({"item":item,"map":entry.get("map"),"kind":"Poké Mart" if kind=="general" else "Specialty shop",
                "label":entry["label"],"minBadges":min(badges),"badges":badges,
                "note":"Stock at badge counts: " + ", ".join(str(b) for b in badges)}))
    # These menu services are actual campaign sources and deliberately have no
    # map coordinates; they must remain discoverable in the handbook.
    sources.append({"item":item_ids["ITEM_RARE_CANDY"],"kind":"Menu service","mapName":"Anywhere outside battle","note":"START → RARE CANDY supplies one reusable candy; current level cap applies."})
    data["sources"] = sorted(sources,key=lambda x:(x["mapName"],x["kind"],x["item"],x.get("x",-1),x.get("y",-1),x.get("label","")))
    data["shops"] = sorted(shops,key=lambda x:(x["mapName"],x["label"]))
    kinds = collections.Counter(s["kind"] for s in sources)
    counts = {k:len(data[k]) for k in ("species","moves","items","abilities","trainers","wild","sources","shops")}
    counts.update(phantomPartners=sum(t["phantom"] for t in data["trainers"]),authoredTrainers=sum(t["authored"] and not t["phantom"] for t in data["trainers"]),wildMaps=len(raw["wild"]),itemBalls=kinds["Item ball"],hiddenItems=kinds["Hidden item"],gifts=kinds["Gift"],excludedForms=sum(s["excluded"] for s in data["species"].values()))
    data["meta"] = {
        "schema":1,"campaignVersion":manifest["version"],"coopVersion":coop["version"],"engineVersion":"0.3.73","counts":counts,
        "provenance":"Resolved built campaign through stock campaign_fixture.lua; native trainer/encounter extraction and vanilla script facts with campaign item substitutions.",
        "limitations":[
            "Species metadata includes forms that are not obtainable. Mega and Primal forms are marked excluded; Mega Evolution and Z-Moves are not part of this campaign.",
            "Trainer teams are the stored definitions, not a playthrough guarantee. Dynamic Battle Frontier teams, imported teams, and other extra mods are outside this data.",
            "Wild weights are base slot weights before Repel, lead abilities, story flags, outbreak/roamer overrides, special Feebas tiles, or other encounter gates. The rate is the runtime rate field, not a literal per-step percentage.",
            "Four-slot water/rock tables retain the engine's fifth-slot 1% empty roll; percentages are deliberately not renormalized.",
            "Item balls and hidden-item coordinates are native map tiles. Gift/script names are search clues, not evaluated story conditions, quantities, or guarantees that every source is currently accessible.",
            "Items from variables, scripted specialty services, trades, Pickup, held wild items, berry plants, repeatable minigame rewards, and dynamically generated gifts are not exhaustively indexed.",
            "Shop badge lists describe actual stock at each badge count; some lower-tier items leave the tier list later. Item descriptions are source text and may omit campaign-specific behavior.",
            "Weights come from the runtime Pokédex reader, which uses national-species weights for some alternate forms. Stored unused/placeholder trainer entries remain listed; entries without resolved maps are not a claim of accessible battles.",
        ],
    }
    return data


def validate(data):
    assert data["typeChart"]["18"]["16"] == 2
    assert data["typeChart"]["16"]["18"] == 0
    assert all(len(t["party"]) <= 6 for t in data["trainers"])
    for t in data["trainers"]:
        for mon in t["party"]:
            assert str(mon["species"]) in data["species"], (t["id"],mon)
            assert str(mon["ability"]) in data["abilities"], (t["id"],mon)
            assert all(m == 0 or str(m) in data["moves"] for m in mon["moves"]), (t["id"],mon)
    for row in data["wild"]:
        assert row["emptyWeight"] + sum(s["weight"] for s in row["slots"]) == 100, row
        assert all(str(s["species"]) in data["species"] for s in row["slots"]), row
    for src in data["sources"]:
        assert str(src["item"]) in data["items"], src
    assert any(s["kind"]=="Gift" and s["map"]=="EM_OLDALE_TOWN" and data["items"][str(s["item"])]["symbol"]=="ITEM_FOCUS_SASH" for s in data["sources"] if "map" in s)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scripts",type=Path,default=DEFAULT_SCRIPTS)
    parser.add_argument("--out",type=Path,default=NATIVE/"generated/handbook/data.json")
    parser.add_argument("--reuse-runtime",action="store_true",help="Normalize the previous runtime extraction (development only).")
    args=parser.parse_args()
    args.out.parent.mkdir(parents=True,exist_ok=True)
    runtime=args.out.parent/"runtime.json"
    if not args.reuse_runtime:
        subprocess.run(["luajit",str(HERE/"export_runtime.lua"),str(runtime),str(args.scripts.resolve())],cwd=ENGINE,check=True)
    raw=json.loads(runtime.read_text())
    data=normalize(raw,json.loads((BUILT/"g3_campaign/manifest.json").read_text()),json.loads((BUILT/"g3_coop/manifest.json").read_text()))
    validate(data)
    encoded=json.dumps(data,ensure_ascii=False,separators=(",",":"),sort_keys=True).encode()+b"\n"
    args.out.write_bytes(encoded)
    print(json.dumps({"output":str(args.out),"bytes":len(encoded),"sha256":hashlib.sha256(encoded).hexdigest(),"counts":data["meta"]["counts"]},ensure_ascii=False))


if __name__ == "__main__":
    main()
