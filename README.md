# Emerald Doubles Soul Link

A custom cart for [Gen1Recomp](https://github.com/bryanthaboi/gen1recomp) 0.3.73:
vanilla Pokémon Emerald where every battle is a double (wild ones too), played
in two-player co-op with Soul Link and level caps, plus hundreds of new
Pokémon (Gen 4 to 7), moves, abilities and items.

Based on the Pokemon Gen 1 Recompilation Project by BOIS CLUB GAMES, LLC
(https://github.com/bryanthaboi/gen1recomp).

## How it plays

- **Every battle is a double**, wild ones included, solo or with a partner.
- **Co-op:** you and a partner share the world, fight story battles together and
  each keep your own team. You can also play alone; story fights only wait for a
  partner while co-op is on.
- **Soul Link:** one encounter per area, and each of your catches is linked to your
  partner's. When one falls, so does the other.
- **Level caps:** the cap is the ace of the next big fight. **F7** shows it, your
  links, the fallen and your rules.
- **Trainers** are hand-picked for doubles and use items, switch and focus fire.
  Hard fights have answers in the wild tables nearby.
- **HM moves in the field** need only the HM and its badge: no Pokémon has to learn them.
  Fly and Flash appear on every Pokémon in the party menu.

Mega Evolution and Z-Moves are left out.

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

Each release has a new cart. Import it over the old one, then press **Install
required mods** again. Both players must be on the same release to play together.
Saves usually carry over; when a release needs a new game, its notes say so.

## Playing together

One player hosts and the other joins by address (direct connection, port 7777 by
default). Set it up from **START > CO-OP**. Soul Link and level caps start on; each
player can change their rules in **F7 > RULES**.

## START > TOOLS

- **RARE CANDY:** a reusable candy that stops at the level cap. It keeps the normal
  move-learning and evolution prompts.
- **REPEL:** an unlimited toggle. Wild Pokémon below your first healthy Pokémon's
  level stay away. Save to keep your choice.
- **HEAL TEAM:** restores HP, status and PP for free. With hard rules on, dead
  Pokémon stay excluded.
- **RELEARN MOVE:** free and unlimited.
- **IV / EV:** shows IVs, EVs, nature and Hidden Power type. UP/DOWN picks a stat, LEFT/RIGHT takes or adds 4, A fills or clears
  it, and L/R changes Pokémon.
- **GUIDE SYNC:** writes your progress for the field guide (it also happens on every save).
- **MOVE ANIMS:** a practice battle for viewing move animations.

The starter counts as Littleroot Town's Soul Link encounter. Birch's rescue battle,
Norman's borrowed Zigzagoon and Wally's catching tutorial use no encounters.

## Field guide

`emerald-field-guide-<version>.html`, attached to each release, is a self-contained
companion: open it in a modern browser and send the same file to your partner.

- **Route guide:** the story in nine chapters, one per level cap, with each stop's
  trainers, wild tables and items. Spoilers stay hidden until you reach them.
- **Load game:** reads your guide sync for badges, beaten trainers, both teams and
  your Soul Link log.
- **Battle plans:** your two teams against any trainer, with damage, KOs, spread
  hits and speed order.
- **Pokédex, search and calculator**, plus notes you can export and share.

## Other mods

The cart is **open**: enable other Emerald/Gen 3 mods in the launcher's **MODS**
screen and they load after the campaign and co-op mods. Compatibility depends on
the mod, and both co-op players should use matching gameplay mods.

## Building

`python3 build_campaign.py` builds the mod; `--release` adds the zips, the cart and
the field guide. Building needs inputs that aren't in this repo yet: the stock
0.3.73 engine tree, the expanded port's generated data (linked under
`porting/inputs/`) and the donor hack's pokeemerald-1.13 source. The `verify_*.lua`
suites run headless from the engine tree with luajit.

No ROM or ROM data is included; the game reads its maps and story from your own ROM.

## Credits

- Campaign, co-op and Soul Link by Aeryk Kisor.
- Some species, moves, trainer and item data, the Pokémon icons, cries and move animations are adapted from
  [Inclement Emerald](https://www.pokecommunity.com/threads/pok%C3%A9mon-inclement-emerald-a-decomp-difficulty-hack-version-1-13.457039/)
  by Buffel Saft and contributors (the "donor hack" in this repo's sources).
- Gen1Recomp by BOIS CLUB GAMES, LLC.
- Pokémon © Nintendo / Creatures / GAME FREAK. This project is unofficial and not
  affiliated with them.

Official Pokédex text, base data and rare-move learnsets checked against [PokeAPI](https://github.com/PokeAPI/pokeapi).

## License

GPLv3 with the Additional Terms in [LICENSE.MD](LICENSE.MD), the same terms
as Gen1Recomp, which this mod modifies.
