# Emerald Doubles Soul Link

A custom cart for [Gen1Recomp](https://github.com/bryanthaboi/gen1recomp) 0.3.73:
vanilla Pokémon Emerald where every battle is a double (wild ones too), played
in two-player co-op with Soul Link and level caps, plus Inclement Emerald's
Pokémon, moves, abilities and items.

Based on the Pokemon Gen 1 Recompilation Project by BOIS CLUB GAMES, LLC
(https://github.com/bryanthaboi/gen1recomp).

## Install

You need Gen1Recomp 0.3.73 with your own Emerald ROM already imported.

1. Download `emerald_doubles_soullink.g1rcart` from the
   [latest release](https://github.com/PandaKisor/emerald-doubles-soullink/releases/latest).
2. Drop it onto the launcher window to import it.
3. On the cart's card, press **Install 2 required mods**. The launcher downloads
   `g3_campaign` (this repo) and `g3_coop` ([PandaKisor/g3-coop](https://github.com/PandaKisor/g3-coop))
   at the exact versions the cart names, and checks each download's hash.
4. Start Emerald on the cart. Saves on the cart are separate from vanilla.

## Updating

Each release has a new cart. Download it and import it over the old one, then
press **Install required mods** again. Your save carries over. Both players
must be on the same release to play together.

## Additional mods

The cart is **open**: enable other Emerald/Gen 3 mods in the launcher's
**MODS** screen and they load after the campaign and co-op mods. You do not
need to break the cart's seal or add them to its manifest. Gen 1-only mods
still need Gen 3 support, and compatibility depends on the individual mod.
Both co-op players should use matching gameplay mods.

## Co-op

One player hosts and the other joins by address (direct connection, port 7777
by default). Set it up in game from **START > CO-OP**. Soul Link and level caps
start on; each player can change their rules in **F7 > RULES**.

## Leveling without grinding

Choose **START > RARE CANDY** to receive a reusable Rare Candy and pick a
Pokémon. It also works from **BAG > MEDICINE**, never runs out when used,
and keeps the normal move-learning and evolution prompts. With level caps
on, it stops at the current cap; turn caps off in **F7 > RULES** to level
up to 100. Existing saves can use it immediately.

**START > REPEL: OFF/ON** toggles unlimited Repel for this save. While on,
wild Pokémon below your first healthy Pokémon's level are repelled, without
using items or running out of steps. Save the game to keep your choice.
The starter counts as Littleroot Town's Soul Link encounter, including in
existing run records, so it does not use Route 101's encounter.

**START > HEAL TEAM** restores your entire party's HP, status and PP for free.
With Soul Link hard rules on, dead or disallowed Pokémon remain excluded.
Birch's rescue battle and Norman's borrowed Zigzagoon/Wally's catching tutorial
do not consume encounters. Recognizable old tutorial records are excluded from
the run view too; real wild encounters and real faint history remain intact.

## Offline field guide

`emerald-field-guide-0.26.0.html` is a self-contained companion: open it in a
modern browser and send the same file to your partner. It includes a direct-hit
damage calculator, searchable trainer teams (including doubles partners), wild
encounter tables, item sources and badge-dependent shops. Trainer Pokémon can
be loaded directly into either calculator slot.

The route planner offers an early-game path and a Hoenn story itinerary, plus
custom stops, return visits, reordering, completion tracking, notes and planned
encounters for both players. Routes save in the browser. Use Export/Import to
share the route itself or move it to another browser; copying the HTML alone
does not copy browser storage. Calculations and reference coverage have explicit
limits in the guide's About panel.

Rebuild after building the campaign (from this repository):

```sh
python3 tools/handbook/export.py
python3 tools/handbook/build.py
```

Generate native calculation references from the stock engine directory with
`luajit ../porting/native/tools/handbook/damage_reference.lua`, then run
`node tools/handbook/verify.js` here. `python3 tools/handbook/browser_smoke.py`
exercises the local HTML in an isolated Firefox profile and writes its report
and desktop/mobile screenshots under `generated/handbook/browser/`.

## What's in this repo

The campaign mod's source: `build_campaign.py` (builds the mod, the release
zips and the cart), `campaign/` (content, battle effects, trainer teams, AI),
`tools/` (generators for trainer teams, items and the cart label) and the
headless `verify_*.lua` suites.

Building needs inputs that aren't in this repo: the stock 0.3.73 engine tree,
the Inclement Emerald port's generated data and the pokeemerald-1.13 source.
No ROM or ROM data is included; the game reads its maps and story from your
own ROM.

## License

GPLv3 with the Additional Terms in [LICENSE.MD](LICENSE.MD), the same terms
as Gen1Recomp, which this mod modifies.
