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

## Co-op

One player hosts and the other joins by address (direct connection, port 7777
by default). Set it up in game from **START > CO-OP**. Soul Link and level caps
start on; each player can change their rules in **F7 > RULES**.

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
