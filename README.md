# Emerald Doubles Soul Link

A custom cart for [Gen1Recomp](https://github.com/bryanthaboi/gen1recomp) 0.3.73:
vanilla Pokémon Emerald where every battle is a double (wild ones too), played
in two-player co-op with Soul Link and level caps, plus hundreds of new
Pokémon (Gen 4 to 7), moves, abilities and items.

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

**START > TOOLS > IV / EV** shows each party member's IVs, EVs, nature and Hidden
Power type, and lets you set its EVs directly: UP/DOWN picks a stat, LEFT/RIGHT
takes or adds 4, A fills it (252 at most, 510 in all) or clears it, and L/R
flips through the party. Stats update at once.

**START > HEAL TEAM** restores your entire party's HP, status and PP for free.
With Soul Link hard rules on, dead or disallowed Pokémon remain excluded.
Birch's rescue battle and Norman's borrowed Zigzagoon/Wally's catching tutorial
do not consume encounters. Recognizable old tutorial records are excluded from
the run view too; real wild encounters and real faint history remain intact.

## Offline field guide

`emerald-field-guide-<version>.html` (attached to each GitHub release) is a
self-contained companion: open it in any modern browser and send the same file
to your partner. It has:

- **Route guide:** vanilla Emerald's story in nine chapters, one per level cap.
  Each stop lists its trainers (with tag partners and Pokémon icons), wild
  tables and items; rival cards follow your starter. Tick stops off as you go.
- **Trainers, wild Pokémon and items:** searchable, with badge-dependent shop stock.
- **Damage calculator:** load any trainer's Pokémon into either slot.
- **Our plan:** your own stops with both players' planned encounters; export and
  import a plan file to share it.

`python3 build_campaign.py --release` rebuilds and verifies the guide with every
release. By hand, after building the campaign:

```sh
python3 tools/handbook/export.py
(cd ../../gen1recomp-0.3.73 && luajit ../porting/native/tools/handbook/damage_reference.lua)
python3 tools/handbook/build.py
node tools/handbook/verify.js
python3 tools/handbook/browser_smoke.py   # Firefox, screenshots in generated/handbook/browser/
```

The route guide's chapters live in `tools/handbook/route_guide.py`; the icons
come from the donor hack's party icons (`tools/handbook/icons.py`).

## What's in this repo

The campaign mod's source: `build_campaign.py` (builds the mod, the release
zips and the cart), `campaign/` (content, battle effects, trainer teams, AI),
`tools/` (generators for trainer teams, items and the cart label) and the
headless `verify_*.lua` suites.

Building needs inputs that aren't in this repo: the stock 0.3.73 engine tree,
the expanded port's generated data (linked under `porting/inputs/`) and the
donor hack's pokeemerald-1.13 source.
No ROM or ROM data is included; the game reads its maps and story from your
own ROM.

## Credits

- Campaign, co-op and Soul Link by Aeryk Kisor.
- Some species, moves, trainer and item data and the Pokémon icons are adapted from
  [Inclement Emerald](https://www.pokecommunity.com/threads/pok%C3%A9mon-inclement-emerald-a-decomp-difficulty-hack-version-1-13.457039/)
  by Buffel Saft and contributors (the "donor hack" in this repo's sources).
- Gen1Recomp by BOIS CLUB GAMES, LLC.
- Pokémon © Nintendo / Creatures / GAME FREAK. This project is unofficial and not
  affiliated with them.

## License

GPLv3 with the Additional Terms in [LICENSE.MD](LICENSE.MD), the same terms
as Gen1Recomp, which this mod modifies.
