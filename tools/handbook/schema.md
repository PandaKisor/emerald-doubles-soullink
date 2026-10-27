# Handbook data schema 1

`python3 tools/handbook/export.py` runs from any working directory after the
campaign build. It uses Python's standard library, LuaJIT, the stock campaign
fixture, the locally supplied Emerald ROM, and the existing vanilla script cache.
`--scripts DIR` selects another extracted vanilla cache. Nothing is installed into
the player's game. Outputs are `generated/handbook/runtime.json` (intermediate
gameplay facts) and `generated/handbook/data.json` (compact handbook data). The HTML
builder should embed only `data.json`, never a ROM, script cache, or save.

All numeric-ID dictionaries have **string JSON keys**. Data is tied to the built
campaign/co-op manifests in `meta`, rather than a hand-maintained version constant.

| Key | Shape / meaning |
| --- | --- |
| `meta` | `schema`, `campaignVersion`, `coopVersion`, `engineVersion`, `counts`, `provenance`, and explicit `limitations`. |
| `species[id]` | `id`, `symbol`, `name`, `displayName`, `stats:{hp,atk,def,spa,spd,spe}`, `types:[type IDs]`, `abilities:[ability IDs in slot order]`, `weightKg?`, `dex:{national,hoenn}`, `meta`, `excluded`, `learnset:[[level,move ID]]`, `eggMoves:[move IDs]`, `machines:[item IDs]`, `tutors:[tutor indices]`, `evolutions`, `itemEvolutions`. Two equal type IDs mean one type. An ability slot of 0 means no ability in that slot. |
| `moves[id]` | Actual runtime `power`, `accuracy`, `pp`, `priority`, `type`, `category`, numeric `target`, numeric `flags`; `id`, `symbol`, `name`, `description`; `runtime` (additional battle metadata); `hooks:[custom hook names]`; `sourceEffect`, `sourceFlags:[donor flag symbols]`, `sourceTarget`, `argument`, `secondaryChance`, and optional `sourceDifferences`. Only moves accepted by the campaign's learnset gate are exported. |
| `items[id]` | `id`, `symbol`, `name`, `description`, `pocket`, effective shop `price`, optional `machine`, `machineNumber`, `machineMove`, `berryNumber`, `holdEffect`, and `holdEffectParam`. Hold-effect fields are donor symbols/expressions; they are not an implemented calculator contract. |
| `abilities[id]` | `id`, `symbol`, `name`, `description`. Descriptions are source text, not a guarantee that every niche interaction is implemented. |
| `types[id]` | Type name; IDs 0–18, with the legacy unknown type at 9 and Fairy at 18. |
| `typeChart[attack ID][defense ID]` | Actual runtime single-type multiplier after campaign installation. For two distinct defender types, multiply both entries. |
| `natures[id]` | `name`, `effects:{atk,def,spe,spa,spd}`. Effects are -1, 0, or +1, corresponding to 90%, 100%, or 110%. IDs are 0–24. |
| `trainers` | Array of `{id,symbol,name,className,displayName,maps:[{id,name}],authored,phantom,partnerId?,partnerOf?,nativeDouble,items:[bag item IDs],party:[mon],mapNote?}`. `nativeDouble` is the stored vanilla flag; this campaign forces doubles separately. `partnerId` refers to another row in this same array. Phantom partners must be included with the linked trainer. |
| Trainer `party` mon | `{species,level,moves:[IDs],item,ability,nature,ivs:{hp,atk,def,spa,spd,spe},evs:{...},stats:{...},personality,gender?}`. Resolved through actual `Trainers.foeFromId` and `State.makeBattler`. The resulting stats include nature but exclude in-battle stages, status, ability/item multipliers, weather, and field effects. |
| `wild` | Array of `{map,mapName,method,rate,variant?,slots:[{species,minLevel,maxLevel,slot,weight}],emptyWeight,note?}`. Methods are `Grass / cave`, `Surf`, `Rock Smash`, `Old Rod`, `Good Rod`, and `Super Rod`. Weights are base percentage points per slot roll, before encounter gates. Fishing percentages are conditional on the selected rod. `rate` is the runtime encounter-rate field, **not** a literal per-step percentage. |
| `sources` | Array of `{item,kind,map?,mapName,x?,y?,localId?,label?,maps?,minBadges?,badges?,note}`. Kinds include `Item ball`, `Hidden item`, `Gift`, `Poké Mart`, `Specialty shop`, `Menu service`. Ball/hidden coordinates are native map tiles, not screen pixels. Script `label` is a search/audit clue and may name the original item replaced by the campaign. `maps` optionally identifies shared script callers. |
| `shops` | Array of `{map?,mapName,label,kind,stockByBadges:[9 arrays of item IDs]}`. Array index 0 corresponds to zero badges; index 8 to eight badges. General stock merges native stock, current badge tier, and town extras with duplicates removed. Specialty shops use the actual campaign replacement list. |
| `maps[id]` | Native map ID dictionary with `{id,name,group,num}`. Display labels retain interior/floor detail. |
| `tutorMoves[index]` | Move ID for a tutor index. |
| `nectarForms[item ID]` | Species ID for the corresponding nectar form. |

The species catalog preserves metadata for every loaded record, but marks Mega
and Primal forms `excluded:true` for selector filtering. Catalog presence is not
a claim that a Pokémon can be obtained in normal play. Alternate forms may use
the runtime's national Pokédex weight rather than a separate form-specific weight.

Wild tables include the vanilla tables that the campaign leaves unchanged and all
campaign replacements, including Altering Cave variants. Four-slot water/rock
tables currently have a 1% empty fifth-slot roll in the engine. `emptyWeight`
preserves this behavior instead of silently changing the probabilities. Roamers,
outbreaks, special Feebas tiles, scripted encounters, and other dynamic overrides
are outside this static encounter index.

Item indexing covers literal native script handouts, every native item-ball and
hidden-item object, replacement gifts, general mart tiers, and specialty shop
stock. It does not evaluate story branches, movement access, eligibility, reward
quantity, or repeatability. Dynamic variable gifts, berry plants, held wild items,
trades, Pickup, scripted specialty services, and minigame rewards are not
exhaustively indexed. These limits also appear in `meta.limitations` for the UI.

Exporter assertions check references, trainer move legality, the Fairy chart,
encounter-weight totals, item-source IDs, and the Oldale Focus Sash substitution.
The existing campaign fixture is the authority for resolved content; these checks
do not replace a full campaign playthrough.
