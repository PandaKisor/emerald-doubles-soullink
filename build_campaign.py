#!/usr/bin/env python3
"""Build the user's campaign mod: vanilla Emerald (maps and story from the
player's ROM) with doubles, co-op battles and shared story progress on stock
Gen1Recomp 0.3.73, plus the expanded content: stats/types/Fairy (0.5.1),
expanded species, art, abilities, items, learning, evolutions and wild
encounters (campaign/content.lua).

Soul Link, level caps and the co-op session come from g3_coop, which the
cart loads beside this mod. The donor port's rebuilt world (full/maps,
full/world) is deliberately not shipped. Every copied source is scrubbed of
the donor's name (build_probe.scrub).

  python3 build_campaign.py            # generated/campaign/mods/g3_campaign
  python3 build_campaign.py --release  # + Gen3Mod/<zip>, cart, field guide HTML, sha256 files
"""
import base64, hashlib, json, re, shutil, subprocess, sys, zipfile
from pathlib import Path

import build_probe as native

HERE = native.HERE
GEN3 = native.GEN3
DEV = native.DEV_MOD
DONOR = GEN3 / "pokeemerald-1.13"
CAMPAIGN = HERE / "campaign"

MOD_ID = "g3_campaign"
TITLE = "Emerald Doubles Soul Link"
VERSION = "0.42.7"
CART_ID = "emerald_doubles_soullink"
COOP_ID, COOP_VERSION = "g3_coop", "0.8.11"
# GitHub repos the launcher checks for updates and the release cart downloads from
REPO, COOP_REPO = "PandaKisor/emerald-doubles-soullink", "PandaKisor/g3-coop"
COOP_SRC = GEN3 / "coop/g3_coop"
OUT = HERE / "generated/campaign/mods" / MOD_ID

MAIN = f'''-- {TITLE}: vanilla Emerald with every battle a double, co-op team
-- battles and shared story progress, and the expanded content.
-- Soul Link and level caps live in g3_coop, which the cart loads beside it.
return function(mod)
  local function source(path)
    return assert(load(assert(mod:read(path)), "@" .. mod.path .. "/" .. path))()
  end
  local SD = require("src.core.SaveData")
  local Version = require("src.core.GameVersion")
  local function active()
    return Version.get() == "emerald" and SD.getCart() == "{CART_ID}"
  end

  -- Patched engine modules (battle, link, co-op, scripting) installed onto
  -- the stock engine from inside the sandbox; see native/swap.lua.
  local Swap = source("native/swap.lua")
  local files = {{}}
  for i, row in ipairs(source("native/files.lua")) do
    files[i] = {{ name = row.name, replaces = row.replaces, source = assert(mod:read("native/engine/" .. row.path)) }}
  end
  mod.exports.nativeModules = Swap.installAll(files)
  source("native/shims.lua").install()

  -- Expanded stats, types, move data and Fairy (port 0.5.1), then the
  -- species, art, abilities, items, learning and wild encounters.
  source("expanded.lua")(mod)
  mod.exports.campaign = source("campaign/content.lua")(mod, active)

  -- Every trainer and field wild battle is a double.
  require("src.core.game3.battle_bridge").allDoubles = active

  -- The story and trainers are vanilla Emerald's, so g3_coop's own
  -- level-cap list (rival, gyms, bosses) applies on this cart.
  mod.exports.coopVanillaStory = true

  -- Shared story progress for g3_coop (no port-only trainers here).
  source("coop_campaign.lua").install(mod, {{ bundle = {{ playtest = {{ trainers = {{}} }} }} }}, active)
  source("coop_progress.lua")(mod, active)
end
'''

MANIFEST = {
    "id": MOD_ID,
    "name": TITLE,
    "version": VERSION,
    "api": 2,
    "entry": "main.lua",
    "games": ["emerald"],
    "profile": "overhaul",
    "category": "GAMEPLAY",
    "priority": 100,
    "permissions": ["engine_internals", "network"],
    # the donor port's own mods, which can't load beside this one
    "conflicts": [f"{native.DONOR.lower()}_{m}" for m in ("battle_test", "battle_core", "stats_proof")],
    "description": "Vanilla Emerald where every battle is a double, with co-op, Soul Link and level caps "
                   "(with Gen 3 Co-op), plus hundreds of new Pokémon, moves, abilities and items.",
    "github": REPO,
}


def expanded_layer():
    """0.5.1's legacy.lua under this mod's event name, without the dev lab."""
    text = (DEV / "legacy.lua").read_text()
    old_event = f'"mod.{native.DONOR.lower()}_battle_test.active"'
    assert text.count(old_event) == 1
    text = text.replace(old_event, f'"mod.{MOD_ID}.active"')
    lab = ('  local lab = source("lib/lab.lua")(source("lib/fixture.lua"), source("lib/emerald_reference.lua"))\n'
           '  lab.mechanics = source("lib/mechanics_lab.lua")()\n'
           '  source("lib/lab_screen.lua")(mod, lab)\n')
    assert text.count(lab) == 1
    return text.replace(lab, "")


# The donor port's content layers that work on the vanilla world. Its maps, map
# animations, scripts/world, centers, shops, gifts and playtest are left out.
FULL_FILES = ("pokemon_data.lua", "species_art.lua", "abilities.lua", "natures.lua", "inventory.lua",
              "learning.lua", "ability_items.lua", "field_items.lua", "evolution_items.lua", "medicine.lua",
              "level_evolution.lua", "restoratives.lua", "tutors.lua", "inventory_ui.lua", "route_moves.lua",
              "save.lua")
FULL_DIRS = ("data", "species-art", "field-items", "evolution-items", "medicine", "restoratives", "inventory-ui")
SAVE_PATCHES = (
    ('local Save = { CART_ID = "expanded_cart", MOD_ID = "expanded_port", SCHEMA = 1 }',
     f'local Save = {{ CART_ID = "{CART_ID}", MOD_ID = "{MOD_ID}", SCHEMA = 1 }}'),
    # saves from before the expanded content (0.1.0) hold only vanilla IDs:
    # they load in the cart and gain the identity stamp on their next save
    ("      if not bridge.api.marked(value) and destination ~= Save.CART_ID then return true end\n",
     "      if not bridge.api.marked(value) then return true end\n"),
    ("      if bridge.api.marked(session) then bridge.stamp(session, bridge.data) end\n",
     "      if bridge.enabled() then bridge.stamp(session, bridge.data) end\n"),
    ("      if bridge.api.marked(value) then bridge.stamp(session, bridge.data) end\n",
     "      if bridge.enabled() then bridge.stamp(session, bridge.data) end\n"),
)
# Hooks for the expanded moves (campaign/moves.lua, campaign/battle/*.lua) in
# the mod's copies of the port's 0.5.1 battle library and the patched
# engine. Every hook reads a campaign* field on the move record or the
# Moves._campaignField bridge, so vanilla moves run unchanged.
CF = 'local CampaignField = require("src.core.game3.battle.moves")._campaignField\n'
ENGINE = "native/engine/src/core/game3/battle/engine.lua"
# Stock engine modules shipped patched (beside the overlay's): the Pokédex
# screen's list holds the campaign's species past 386 (campaign/dex.lua).
STOCK_PATCHES = {
    "src/ui/game3/rse/pokedex.lua": (
        ("local Pokedex = {}\n",
         "local Pokedex = {}\n-- rows the list can hold: the campaign's species run past 386\nlocal MAX_ROWS = 1024\n"),
        ("  if i < 0 or i >= 386 then return NONE end", "  if i < 0 or i >= MAX_ROWS then return NONE end"),
        ("  if entryNum < 0 or entryNum >= 386 then", "  if entryNum < 0 or entryNum >= MAX_ROWS then"),
    ),
}


def stock_modules(native_dir):
    rows = []
    for path, patches in STOCK_PATCHES.items():
        text = (native.STOCK / path).read_text()
        for before, after in patches:
            assert text.count(before) == 1, f"{path}: {before!r}"
            text = text.replace(before, after)
        dest = native_dir / "engine" / path
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(text)
        rows.append(f'  {{ name = "{native.module_name(path)}", path = "{path}", replaces = true }},')
    files = native_dir / "files.lua"
    text = files.read_text()
    assert text.endswith("\n}\n")
    files.write_text(text[:-3] + "\n" + "\n".join(rows) + "\n}\n")


LIB_PATCHES = (
    # The campaign makes Rare Candy reusable in both the party controller
    # (which also learns moves/evolves) and the direct item-use API.
    ("full/restoratives.lua", "      Bag.remove(menu._bag,item,1)\n",
     "      if not (b.reusableCandy and b.reusableCandy()) then Bag.remove(menu._bag,item,1) end\n"),
    ("full/restoratives.lua", '        Bag.remove(bag,item,1);return true,"level"\n',
     '        if not (b.reusableCandy and b.reusableCandy()) then Bag.remove(bag,item,1) end;return true,"level"\n'),
    # drain moves heal the donor's argument percentage of the damage
    ("lib/hit.lua", "  local heal = math.floor((M.hpDealt or 0) / 2)\n",
     "  local heal = math.floor((M.hpDealt or 0) * (tonumber(M.move.drainPercent) or 50) / 100)\n"
     "  -- Big Root\n"
     "  local CampaignRoot = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  if CampaignRoot and CampaignRoot.items then heal = math.floor(heal * CampaignRoot.items.drainBoost(user)) end\n"),
    # before the hit: Throat Chop, then the move's own failure checks
    ("lib/hit.lua", "local function pre_checks(M)\n  local ad, user, target, eff = M.adapter, M.user, M.target, M.effect\n",
     "local function pre_checks(M)\n  local ad, user, target, eff = M.adapter, M.user, M.target, M.effect\n"
     "  " + CF + "  if CampaignField and CampaignField.preMove(M) then fail(M, false); return true end\n"
     "  if M.move.campaignPre and M.move.campaignPre(M, fail) then return true end\n"),
    # damage options: Lucky Chant/Laser Focus for every hit, then the move's own
    ("lib/hit.lua", "  if magnitude then calcExtra.power = magnitude.power end\n",
     "  if magnitude then calcExtra.power = magnitude.power end\n"
     "  " + CF + "  if CampaignField then CampaignField.calcExtra(M, target, calcExtra) end\n"
     "  if M.move.campaignCalc then\n"
     "    for k, v in pairs(M.move.campaignCalc(M, target) or {}) do calcExtra[k] = v end\n"
     "  end\n"),
    ("lib/hit.lua", "  secondary_after(M, policy, descriptor)\n  M:tryFaintTarget()\n  if M.checkUserFaint then M:tryFaintUser() end\nend\n",
     "  secondary_after(M, policy, descriptor)\n"
     "  if M.move.campaignAfter then M.move.campaignAfter(M) end\n"
     "  local CampaignItems = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  CampaignItems = CampaignItems and CampaignItems.active() and CampaignItems.items\n"
     "  if CampaignItems then CampaignItems.afterHit(M) end\n"
     "  local CampaignAbilities = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  CampaignAbilities = CampaignAbilities and CampaignAbilities.active() and CampaignAbilities.abilities\n"
     "  if CampaignAbilities then CampaignAbilities.afterHit(M) end\n"
     "  M:tryFaintTarget()\n"
     "  if M.move.campaignAfterFaint then M.move.campaignAfterFaint(M) end\n"
     "  if CampaignAbilities then CampaignAbilities.afterFaint(M) end\n"
     "  if CampaignItems then CampaignItems.afterFaint(M); CampaignItems.ejectPack(M) end\n"
     "  if M.checkUserFaint then M:tryFaintUser() end\nend\n"),
    # Aurora Veil counts as both screens
    ("lib/hit.lua", "    reflect = defSide and (defSide.expReflectTurns or 0) > 0,\n"
                    "    lightScreen = defSide and (defSide.expLightScreenTurns or 0) > 0,\n",
     "    reflect = defSide and ((defSide.expReflectTurns or 0) > 0 or (defSide.campaignAuroraVeil or 0) > 0),\n"
     "    lightScreen = defSide and ((defSide.expLightScreenTurns or 0) > 0 or (defSide.campaignAuroraVeil or 0) > 0),\n"),
    # Blunder Policy: a miss
    ("lib/hit.lua", "local function on_miss(M)\n",
     "local function on_miss(M)\n"
     "  local CampaignMiss = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  if CampaignMiss and CampaignMiss.items then CampaignMiss.items.afterMiss(M) end\n"),
    # Triple Axel steps 20/40/60
    ("lib/hit.lua", "    power = power + 10\n", "    power = power + (tonumber(M.move.tripleKickStep) or 10)\n"),
    # damage formula: the move's choice of stats and stages
    ("lib/damage.lua", "  local aStages = attacker.stages or {}\n  local dStages = defender.stages or {}\n",
     "  local aStages = attacker.stages or {}\n  local dStages = defender.stages or {}\n"
     "  if move.campaignStats then\n"
     "    attack, defense, spAttack, spDefense, aStages, dStages = move.campaignStats(attacker, defender,\n"
     "      attack, defense, spAttack, spDefense, aStages, dStages)\n"
     "  end\n"
     "  do\n"
     "    local CampaignStages = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignStages and CampaignStages.abilities then\n"
     "      aStages, dStages = CampaignStages.abilities.stages(attacker, defender, move, aStages, dStages, adapter)\n"
     "    end\n"
     "  end\n"),
    # held items' stat boosts (Choice Specs, Assault Vest, Eviolite, Light Ball)
    ("lib/damage.lua", "  local aAb = ability_of(attacker, adapter)\n",
     "  do\n"
     "    local CampaignStats = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignStats and CampaignStats.active() and CampaignStats.items then\n"
     "      attack, defense, spAttack, spDefense = CampaignStats.items.stats(attacker, defender, move, attack, defense, spAttack, spDefense)\n"
     "    end\n"
     "    if CampaignStats and CampaignStats.active() and CampaignStats.abilities then\n"
     "      attack, defense, spAttack, spDefense = CampaignStats.abilities.stats(attacker, defender, move, moveType, physical,\n"
     "        attack, defense, spAttack, spDefense, adapter)\n"
     "    end\n"
     "  end\n"
     "  local aAb = ability_of(attacker, adapter)\n"),
    # held items' final damage (Life Orb, Expert Belt, resist berries)
    ("lib/damage.lua", "    dmg = math.floor(dmg * roll / 100)\n    if dmg == 0 then dmg = 1 end\n  end\n",
     "    dmg = math.floor(dmg * roll / 100)\n    if dmg == 0 then dmg = 1 end\n  end\n"
     "  if CampaignField and CampaignField.items and not opts.deferAdjustment then\n"
     "    dmg = CampaignField.items.finalDamage(attacker, defender, move, moveType, eff, dmg)\n"
     "  end\n"
     "  if CampaignField and CampaignField.abilities and not opts.deferAdjustment then\n"
     "    dmg = CampaignField.abilities.finalDamage(attacker, defender, move, moveType, eff, dmg, crit, opts)\n"
     "  end\n"),
    # held items' accuracy (Wide Lens, Zoom Lens, Micle Berry)
    ("lib/accuracy.lua", "  local moveAcc = tonumber(self.accOverride or self.move.accuracy) or 100\n",
     "  local moveAcc = tonumber(self.accOverride or self.move.accuracy) or 100\n"
     "  do\n"
     "    local CampaignAcc = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignAcc and CampaignAcc.active() and CampaignAcc.items then moveAcc = CampaignAcc.items.accuracy(self, moveAcc) end\n"
     "  end\n"),
    # type effectiveness (third types, Tar Shot, grounding, Freeze-Dry, ...)
    ("lib/damage.lua", "  local _, flags, eff = Types.typeCalc(moveType, dType1, dType2, nil, foresight)\n",
     "  local _, flags, eff = Types.typeCalc(moveType, dType1, dType2, nil, foresight)\n"
     "  " + CF + "  if CampaignField then flags, eff = CampaignField.effectiveness(attacker, defender, move, moveType, flags, eff) end\n"),
    # base power for every move (terrains)
    ("lib/damage.lua", "  local dmg = LiveDamage.base(attacker, defender, move, {\n    power = power,\n",
     "  if CampaignField then power = CampaignField.power(attacker, defender, move, moveType, power, opts) end\n"
     "  local dmg = LiveDamage.base(attacker, defender, move, {\n    power = power,\n"),
    # accuracy: side guards, Psychic Terrain and shields; Phantom Force's
    # vanished state; moves that ignore evasion
    ("lib/accuracy.lua", "local roll = Engine.roll\n",
     "local roll = Engine.roll\n"
     "local function protected(self)\n"
     "  " + CF + "  if CampaignField and CampaignField.active() then\n"
     "    local why = CampaignField.blocked(self)\n"
     "    if why then self.campaignBlockedText = why; return true end\n"
     "    if not self:isProtected() then return false end\n"
     "    return CampaignField.protected(self)\n"
     "  end\n"
     "  return self:isProtected()\n"
     "end\n"),
    ("lib/accuracy.lua", "    if self:isProtected() then\n", "    if protected(self) then\n"),
    ("lib/accuracy.lua", "  if self:isProtected() then\n", "  if protected(self) then\n"),
    ("lib/accuracy.lua", "    if reason == \"protected\" then\n",
     "    if reason == \"protected\" and self.campaignBlockedText then\n"
     "      ad:say(self.campaignBlockedText)\n"
     "      self.campaignBlockedText = nil\n"
     "    elseif reason == \"protected\" then\n"),
    ("lib/accuracy.lua", "  if semi == \"UNDERWATER\" and not self.ignoreUnderwater then failMsg(\"miss\"); return false end\n",
     "  if semi == \"UNDERWATER\" and not self.ignoreUnderwater then failMsg(\"miss\"); return false end\n"
     "  if semi == \"PHANTOM\" then failMsg(\"miss\"); return false end\n"),
    ("lib/accuracy.lua", "  local evaStage = target and target.stages and target.stages.evasion or 0\n",
     "  local evaStage = target and target.stages and target.stages.evasion or 0\n"
     "  if self.move.campaignIgnoreEvasion then evaStage = 0 end\n"
     "  do\n"
     "    local CampaignStage = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignStage and CampaignStage.abilities then accStage, evaStage = CampaignStage.abilities.accStages(self, accStage, evaStage) end\n"
     "  end\n"),
    # No Guard: every move hits, semi-invulnerable targets too
    ("lib/accuracy.lua", "  if self:lockOnActive() then return not self:absorbed() end\n",
     "  if self:lockOnActive() then return not self:absorbed() end\n"
     "  do\n"
     "    local CampaignGuard = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignGuard and CampaignGuard.abilities and CampaignGuard.abilities.noGuard(self) then return not self:absorbed() end\n"
     "  end\n"),
    # accuracy abilities (Wonder Skin, Tangled Feet, Snow Cloak, Victory Star)
    ("lib/accuracy.lua", "  local tHe, tParam = HeldItems.of(target)\n",
     "  do\n"
     "    local CampaignAccAb = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignAccAb and CampaignAccAb.abilities then calc = CampaignAccAb.abilities.accuracy(self, calc) end\n"
     "  end\n"
     "  local tHe, tParam = HeldItems.of(target)\n"),
    # the move's type after -ate abilities, Normalize, Liquid Voice
    ("lib/hit.lua", "function Hit.run(M)\n  local ad, user, eff = M.adapter, M.user, M.effect\n  M.moveType = tonumber(M.move.type)\n",
     "function Hit.run(M)\n  local ad, user, eff = M.adapter, M.user, M.effect\n  M.moveType = tonumber(M.move.type)\n"
     "  do\n"
     "    local CampaignType = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignType and CampaignType.active() and CampaignType.abilities then CampaignType.abilities.moveType(M) end\n"
     "  end\n"),
    ("lib/hit.lua", "  for k, v in pairs(extra or {}) do o[k] = v end\n  return o\nend\n",
     "  do\n"
     "    local CampaignOpts = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "    if CampaignOpts and CampaignOpts.active() and CampaignOpts.abilities then CampaignOpts.abilities.calcOpts(M, o) end\n"
     "  end\n"
     "  for k, v in pairs(extra or {}) do o[k] = v end\n  return o\nend\n"),
    # Infiltrator and sound moves pass through a Substitute
    ("lib/hit.lua", "  if (target.substituteHP or 0) > 0 and not info.ignoreSub then\n",
     "  local CampaignSub = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  if (target.substituteHP or 0) > 0 and not info.ignoreSub\n"
     "      and not (CampaignSub and CampaignSub.abilities and CampaignSub.abilities.ignoresSub(M)) then\n"),
    # Disguise, Ice Face and Sturdy before the hit lands
    ("lib/hit.lua", "  if not adjustment then dmg, hung = Hit.adjustDamage(M, target, dmg) end\n  if opts.onBeforeAnim then opts.onBeforeAnim() end\n",
     "  local CampaignDecoy = require(\"src.core.game3.battle.moves\")._campaignField\n"
     "  CampaignDecoy = CampaignDecoy and CampaignDecoy.active() and CampaignDecoy.abilities\n"
     "  if CampaignDecoy then dmg = CampaignDecoy.decoy(M, target, dmg) end\n"
     "  if not adjustment then dmg, hung = Hit.adjustDamage(M, target, dmg) end\n  if opts.onBeforeAnim then opts.onBeforeAnim() end\n"),
    ("lib/hit.lua", "  if info.critical then ad:sayText(\"STRINGID_CRITICALHIT\") end\n  if M.anim.effectiveness == nil then M.anim.effectiveness = info.effectiveness or 1 end\n",
     "  if info.critical then ad:sayText(\"STRINGID_CRITICALHIT\") end\n"
     "  if CampaignDecoy then CampaignDecoy.afterDamage(M, target) end\n"
     "  if M.anim.effectiveness == nil then M.anim.effectiveness = info.effectiveness or 1 end\n"),
    # moves that thaw their frozen user (Scald, Flare Blitz, Burn Up, ...)
    ("lib/turn_rules.lua", "      if M.effect ~= E.THAW_HIT then\n", "      if M.effect ~= E.THAW_HIT and not M.move.campaignThaw then\n"),
    ("lib/turn_rules.lua", "  if ad:status(user) == \"FRZ\" and M.effect == E.THAW_HIT then\n",
     "  if ad:status(user) == \"FRZ\" and (M.effect == E.THAW_HIT or M.move.campaignThaw) then\n"),
    (ENGINE, "      if M.effect ~= E.THAW_HIT then\n", "      if M.effect ~= E.THAW_HIT and not M.move.campaignThaw then\n"),
    (ENGINE, "  if ad:status(user) == \"FRZ\" and M.effect == E.THAW_HIT then\n",
     "  if ad:status(user) == \"FRZ\" and (M.effect == E.THAW_HIT or M.move.campaignThaw) then\n"),
    # versus battles with the co-op partner keep real levels (field.lua
    # LB.keepLevels), and show the partner as Brendan/May (LB.playerPic)
    ("native/engine/src/core/game3/link/battle.lua",
     "  if not spec then return { strict = true, forceLevel = LB.LINK_LEVEL } end\n",
     "  if not spec then\n"
     "    return { strict = true, forceLevel = not (LB.keepLevels and LB.keepLevels()) and LB.LINK_LEVEL or nil }\n"
     "  end\n"),
    ("native/engine/src/core/game3/link/battle.lua",
     "  if LB.unionRoom and LB.hasUnionRoomClasses() then return LB.unionRoomTrainerPic(setup) end\n",
     "  local pic = LB.playerPic and LB.playerPic(setup and setup.gender)\n"
     "  if pic then return pic end\n"
     "  if LB.unionRoom and LB.hasUnionRoomClasses() then return LB.unionRoomTrainerPic(setup) end\n"),
    ("native/engine/src/core/game3/battle/intro_seq.lua",
     "  local function front(gender) return (gender == 1) and LB.TRAINER_PIC_LEAF or LB.TRAINER_PIC_RED end\n",
     "  local function front(gender)\n"
     "    return (LB.playerPic and LB.playerPic(gender)) or ((gender == 1) and LB.TRAINER_PIC_LEAF or LB.TRAINER_PIC_RED)\n"
     "  end\n"),
    # co-op wild doubles: both players' back sprites, as in co-op trainer battles
    ("native/engine/src/core/game3/battle/intro_seq.lua",
     "    p.darken = 10 / 16\n    IntroSeq._steps = build_wild(st, opts)\n",
     "    p.darken = 10 / 16\n"
     "    s.trainer.player.x, s.trainer.player.gender2, s.trainer.player.x2 = nil, nil, nil\n"
     "    if st.coopTeam and st.linkGenders then\n"
     "      local own = tonumber(st.linkOwn) or 0\n"
     "      s.trainer.player.gender = st.linkGenders[own] or playerGender\n"
     "      s.trainer.player.x = (own == 2) and 90 or 32\n"
     "      s.trainer.player.gender2 = st.linkGenders[(own + 2) % 4] or 0\n"
     "      s.trainer.player.x2 = (own == 2) and 32 or 90\n"
     "    end\n"
     "    IntroSeq._steps = build_wild(st, opts)\n"),
    # co-op wild doubles keep their wild intro ("Wild X and Y appeared!",
    # then the players' send-out); only link battles against trainers or
    # the partner take the link trainer's intro text
    ("native/engine/src/core/game3/battle/init.lua",
     "    -- pokefirered/src/battle_message.c:1564 sText_LinkTrainerWantsToBattle\n    if st.link then\n",
     "    -- pokefirered/src/battle_message.c:1564 sText_LinkTrainerWantsToBattle\n    if st.link and not st.wild then\n"),
    # two-turn moves with their own charge turn (Freeze Shock, Phantom Force, ...)
    ("lib/turn_rules.lua", "  if eff == E.SEMI_INVULNERABLE then\n    local row = SEMI_TEXT[M.mnum]\n",
     "  if M.move.campaignCharge then\n"
     "    M.move.campaignCharge(M)\n"
     "  elseif eff == E.SEMI_INVULNERABLE then\n    local row = SEMI_TEXT[M.mnum]\n"),
    (ENGINE, "  if eff == E.SEMI_INVULNERABLE then\n    local row = SEMI_TEXT[M.mnum]\n",
     "  if M.move.campaignCharge then\n"
     "    M.move.campaignCharge(M)\n"
     "  elseif eff == E.SEMI_INVULNERABLE then\n    local row = SEMI_TEXT[M.mnum]\n"),
)
# The link wire format (stock src/link/Protocol.lua) checks Gen 3's limits:
# 411 species, 354 moves, 374 items, 12 balls, two ability slots and a
# nature fixed by personality. The campaign installs a patched copy (native
# swap) that reads the expanded limits from Protocol.campaign (field.lua), so
# co-op battles and trades carry the expanded content intact.
PROTOCOL_SRC = GEN3 / "gen1recomp-0.3.73/src/link/Protocol.lua"
PROTOCOL_PATCHES = (
    ("local Protocol = {}\n",
     "local Protocol = {}\n\n"
     "-- campaign: the expanded species, moves, items and balls cross the link\n"
     "-- when Protocol.campaign is set and active (g3_campaign field.lua)\n"
     "local function limit(kind, default)\n"
     "  local C = Protocol.campaign\n"
     "  return C and C.active() and C[kind] or default\n"
     "end\n"
     "local function abilityListed(pair, ability)\n"
     "  for i = 1, 3 do\n"
     "    if pair[i] and pair[i] ~= 0 and pair[i] == ability then return true end\n"
     "  end\n"
     "  return false\n"
     "end\n", 1),
    ("    for id = 1, SPECIES_LAST do\n", "    for id = 1, limit(\"species\", SPECIES_LAST) do\n", 1),
    ("  if not species or species < 1 or species > SPECIES_LAST\n",
     "  if not species or species < 1 or species > limit(\"species\", SPECIES_LAST)\n", 1),
    ("    local valid = id and id >= 1 and id <= MOVE_LAST and not seen[id]\n",
     "    local valid = id and id >= 1 and id <= limit(\"moves\", MOVE_LAST) and not seen[id]\n", 1),
    ("  return clampInt(n, 0, ITEM_LAST, 0)\n", "  return clampInt(n, 0, limit(\"items\", ITEM_LAST), 0)\n", 1),
    ("  local item = field(packed.item, 0, ITEM_LAST, 0, true)\n",
     "  local item = field(packed.item, 0, limit(\"items\", ITEM_LAST), 0, true)\n", 1),
    ("    pokeball = clampInt(mon.pokeball, 1, BALL_LAST, 4),\n",
     "    pokeball = clampInt(mon.pokeball, 1, limit(\"balls\", BALL_LAST), 4),\n", 1),
    ("    pokeball = field(packed.pokeball, 1, BALL_LAST, 4),\n",
     "    pokeball = field(packed.pokeball, 1, limit(\"balls\", BALL_LAST), 4),\n", 1),
    ("(ability ~= pair[1] and not (pair[2] ~= 0 and ability == pair[2]))",
     "not abilityListed(pair, ability)", 2),
    ("    abilityNum = clampInt(abilityNum, 0, 1, 0),\n",
     "    abilityNum = clampInt(abilityNum, 0, limit(\"abilitySlots\", 1), 0),\n", 1),
    ("    abilityNum = field(packed.abilityNum, 0, 1, pair[2] ~= 0 and ability == pair[2] and 1 or 0),\n",
     "    abilityNum = field(packed.abilityNum, 0, limit(\"abilitySlots\", 1), pair[2] ~= 0 and ability == pair[2] and 1 or 0),\n", 1),
    ("    nature = personality % 25,\n",
     "    nature = (Protocol.campaign and Protocol.campaign.active() and Protocol.campaign.nature(mon)) or personality % 25,\n", 1),
    ("  local nature = personality % 25\n  if strict and whole(packed.nature) ~= nature then\n",
     "  local nature = personality % 25\n"
     "  -- campaign: a mint's nature travels with the mon\n"
     "  local sent = whole(packed.nature)\n"
     "  if Protocol.campaign and Protocol.campaign.active() and sent and sent >= 0 and sent <= 24 then nature = sent end\n"
     "  if strict and whole(packed.nature) ~= nature then\n", 1),
)


def protocol_module(native_dir):
    text = PROTOCOL_SRC.read_text()
    for before, after, count in PROTOCOL_PATCHES:
        assert text.count(before) == count, f"Protocol: {before!r}"
        text = text.replace(before, after)
    dest = native_dir / "engine/src/link/Protocol.lua"
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(text)
    files = native_dir / "files.lua"
    rows = files.read_text()
    assert rows.startswith("return {\n")
    files.write_text("return {\n  { name = \"src.link.Protocol\", path = \"src/link/Protocol.lua\", replaces = true },\n"
                     + rows[len("return {\n"):])


AREAS = (("land_mons", "land"), ("water_mons", "water"), ("rock_smash_mons", "rocks"), ("fishing_mons", "fishing"))


def lua(value):
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, list):
        return "{" + ", ".join(lua(v) for v in value) + "}"
    return "{" + ", ".join(f"{k} = {lua(v)}" for k, v in value.items()) + "}"


def dex_entries():
    """The donor's Pokédex entries for species past the original 386, keyed by
    national number (src/data/pokemon/pokedex_entries.h and pokedex_text.h)."""
    import re
    root = DONOR / "src/data/pokemon"
    species_h = (DONOR / "include/constants/species.h").read_text()
    nationals = {m[1]: int(m[2]) for m in re.finditer(r"#define (NATIONAL_DEX_\w+)\s+(\d+)\b", species_h)}
    texts = {}
    for m in re.finditer(r'const u8 (\w+)\[\] = _\(((?:\s*"(?:[^"\\]|\\.)*")+)\s*\);', (root / "pokedex_text.h").read_text()):
        parts = re.findall(r'"((?:[^"\\]|\\.)*)"', m[2])
        texts[m[1]] = "".join(parts).replace("\\n", "\n")
    official = json.loads((CAMPAIGN / "canon.json").read_text())["dex"]
    rows = []
    body = (root / "pokedex_entries.h").read_text()
    for m in re.finditer(r"\[(NATIONAL_DEX_\w+)\]\s*=\s*\{(.*?)\n    \}", body, re.S):
        nat = nationals[m[1]]
        if nat <= 386:
            continue
        f = dict(re.findall(r"\.(\w+)\s*=\s*([^,\n]+),", m[2]))
        category = re.fullmatch(r'_\("(.*)"\)', f["categoryName"])[1]
        text = official.get(str(nat), texts[f["description"]])
        rows.append((nat, {"category": category.upper(), "height": int(f["height"]), "weight": int(f["weight"]),
                           "description": text, "description2": text, "pokemonScale": int(f["pokemonScale"]),
                           "pokemonOffset": int(f["pokemonOffset"]), "trainerScale": int(f["trainerScale"]),
                           "trainerOffset": int(f["trainerOffset"])}))
    body = "\n".join(f"  [{nat}] = {lua(row)}," for nat, row in rows)
    return ("-- Generated by build_campaign.py from the donor's Pokédex entries.\n"
            "return {\n" + body + "\n}\n"), len(rows)


def footprints():
    """Pokédex footprints for the species the ROM has none for (ids 413+),
    from the donor's graphics/pokemon/*/footprint.png (16x16, 1 bit), matched
    by species name through the donor's footprint table. Returns
    campaign/footprint_data.lua: id -> 64 hex digits, one bit per pixel."""
    import re
    from PIL import Image
    table = (DONOR / "src/data/pokemon_graphics/footprint_table.h").read_text()
    pics = dict(re.findall(r'const u8 (gMonFootprint_\w+)\[\] = INCBIN_U8\("(graphics/pokemon/[\w/]+)/footprint\.1bpp"\)',
                           (DONOR / "src/data/graphics/pokemon.h").read_text()))
    identity = (DEV / "full/data/identity.lua").read_text()
    identity = identity[identity.index('["species"]'):]
    ours = {k: int(v) for k, v in re.findall(r'\["(SPECIES_\w+)"\]=(\d+)', identity)}
    rows = {}
    for name, label in re.findall(r"\[(SPECIES_\w+)\]\s*=\s*(gMonFootprint_\w+)", table):
        sid = ours.get(name)
        if sid is None or sid <= 412 or label not in pics: continue
        img = Image.open(DONOR / (pics[label] + "/footprint.png")).convert("L")
        assert img.size == (16, 16), name
        bits = "".join("1" if img.getpixel((x, y)) < 128 else "0" for y in range(16) for x in range(16))
        rows[sid] = "%064x" % int(bits, 2)
    body = "".join(f'[{sid}]="{rows[sid]}",\n' for sid in sorted(rows))
    return "-- Generated by build_campaign.py from the donor's footprint.png files.\nreturn {\n" + body + "}\n", len(rows)


def cries():
    """Cries for the species the ROM has none for (ids 413+ here), from
    the donor's sound/direct_sound_samples/cries. Its gCryTable is
    indexed by its own species number, so species are matched by name.
    Returns the index (campaign/cries.lua) and the s8 PCM blob (cries.bin)."""
    import re, struct
    defines = dict(re.findall(r"#define (SPECIES_\w+|FORMS_START)\s+(.+?)\s*(?://.*)?$",
                              (DONOR / "include/constants/species.h").read_text(), re.M))
    numbers = {}
    def number(name):
        if name not in numbers:
            expr = re.sub(r"\b(SPECIES_\w+|FORMS_START)\b", lambda m: str(number(m[1])), defines[name])
            numbers[name] = int(eval(expr, {"__builtins__": {}}))
        return numbers[name]
    table = (DONOR / "sound/cry_tables.inc").read_text()
    table = table[table.index("gCryTable::"):table.index("gCryTable2::")]
    labels = re.findall(r"^\s*cry(?:_uncomp)?\s+(\w+)", table, re.M)
    files = dict(re.findall(r'^(\w+)::\s*\n\s*\.incbin "sound/direct_sound_samples/cries/(\w+)\.bin"',
                            (DONOR / "sound/direct_sound_data.inc").read_text(), re.M))
    identity = (DEV / "full/data/identity.lua").read_text()
    identity = identity[identity.index('["species"]'):]
    ours = {k: int(v) for k, v in re.findall(r'\["(SPECIES_\w+)"\]=(\d+)', identity)}

    def aiff(path):
        b = path.read_bytes()
        chunks, i = {}, 12
        while i + 8 <= len(b):
            n = struct.unpack(">I", b[i + 4:i + 8])[0]
            chunks[b[i:i + 4]] = b[i + 8:i + 8 + n]
            i += 8 + n + (n & 1)
        channels, frames, bits = struct.unpack(">hIh", chunks[b"COMM"][:8])
        exp, mant = struct.unpack(">HQ", chunks[b"COMM"][8:18])
        rate = round(mant * 2.0 ** ((exp & 0x7FFF) - 16383 - 63))
        assert channels == 1 and bits == 8, path
        offset = struct.unpack(">I", chunks[b"SSND"][:4])[0]
        return chunks[b"SSND"][8 + offset:8 + offset + frames], rate

    blob, samples, by_file, species, missing = bytearray(), [], {}, {}, []
    for name, sid in sorted(ours.items(), key=lambda kv: kv[1]):
        if sid <= 412 or re.search(r"_(MEGA|PRIMAL)(_|$)", name):  # the ROM's own cries; no Mega Evolution
            continue
        n = number(name) if name in defines else None
        label = labels[n - 1] if n and n <= len(labels) else None
        stem = files.get(label)
        if not stem:
            missing.append(name)
            continue
        if stem not in by_file:
            pcm, rate = aiff(DONOR / "sound/direct_sound_samples/cries" / (stem + ".aif"))
            samples.append({"offset": len(blob), "size": len(pcm), "freq": rate * 1024})
            blob += pcm
            by_file[stem] = len(samples)
        species[sid] = by_file[stem]
    rows = "\n".join(f"    {lua(s)}," for s in samples)
    ids = "\n".join(f"    [{sid}] = {i}," for sid, i in sorted(species.items()))
    text = ("-- Generated by build_campaign.py from the donor's cries.\n"
            "-- samples: s8 PCM in cries.bin; species: campaign species id -> sample.\n"
            "return {\n  samples = {\n" + rows + "\n  },\n  species = {\n" + ids + "\n  },\n}\n")
    return text, bytes(blob), len(species), missing


def is_gimmick_item(sym, pocket):
    """Mega Evolution and Z-Moves are out of the campaign: their stones,
    crystals and key items are dropped. The Red and Blue Orbs are vanilla
    Emerald items, so they stay (as inert key items)."""
    if sym in ("ITEM_RED_ORB", "ITEM_BLUE_ORB"):
        return False
    return pocket == "MEGA_STONES" or sym.endswith("IUM_Z") or sym in ("ITEM_MEGA_BRACELET", "ITEM_Z_RING")


def strip_gimmicks(full):
    """Drops the Mega/Z items from full/data and the empty Mega Stones bag
    pocket. The ids stay in identity.lua, so the id namespace is unchanged."""
    entry = re.compile(r"^\[\d+\]=\{$", re.M)
    dropped = 0
    for path in sorted((full / "data").glob("items-*.lua")):
        text = path.read_text()
        starts = [m.start() for m in entry.finditer(text)]
        if not starts:
            continue
        end = text.rindex("\n}")
        head, chunks = text[:starts[0]], []
        for a, b in zip(starts, starts[1:] + [end + 1]):
            chunk = text[a:b]
            sym = re.search(r'\["symbol"\]="(\w+)"', chunk).group(1)
            pocket = re.search(r'\["pocket"\]="(\w+)"', chunk).group(1)
            if is_gimmick_item(sym, pocket):
                dropped += 1
                continue
            if pocket == "MEGA_STONES":
                chunk = chunk.replace('["pocket"]="MEGA_STONES"', '["pocket"]="KEY_ITEMS"', 1)
            chunks.append(chunk if chunk.endswith(",\n") else chunk.rstrip("\n") + ",\n")
        path.write_text(head + "".join(chunks) + text[end + 1:])
    for name in ("data/manifest.lua", "inventory-ui/model.lua"):
        path = full / name
        text = path.read_text().replace(',"MEGA_STONES"}', "}")
        text = re.sub(r'^\["MEGA_STONES"\]=.*\n', "", text, flags=re.M)
        assert "MEGA_STONES" not in text, name
        path.write_text(text)
    return dropped


def natural_gift():
    """Natural Gift's type and power for each berry (battle_util.c
    gNaturalGiftTable), keyed by item symbol."""
    import re
    text = (DONOR / "src/battle_util.c").read_text()
    body = text[text.index("const struct TypePower gNaturalGiftTable[] ="):]
    body = body[:body.index("};")]
    rows = re.findall(r"\[ITEM_TO_BERRY\((ITEM_\w+)\)\]\s*=\s*\{TYPE_(\w+),\s*(\d+)\}", body)
    assert len(rows) > 60, len(rows)
    lines = "\n".join(f'  {sym} = {{ "{t}", {p} }},' for sym, t, p in rows)
    return "-- Generated by build_campaign.py from the donor's gNaturalGiftTable.\nreturn {\n" + lines + "\n}\n"


def apply_canon():
    """campaign/canon.json (tools/canon_data.py) over the donor-derived data."""
    canon = json.loads((CAMPAIGN / "canon.json").read_text())
    def numeric(rows):
        return {int(k): v for k, v in rows.items()}
    table = {k: numeric(canon[k]) for k in ("species", "moves", "abilities", "moveText")}
    table["learnsets"] = {int(k): {int(a): b for a, b in v.items()} for k, v in canon["learnsets"].items()}
    table["strip"] = numeric(canon["strip"])
    path = OUT / "campaign/canon_table.lua"
    def keyed(value):
        if isinstance(value, dict):
            return "{" + ", ".join(f"[{json.dumps(k)}] = {keyed(v)}" for k, v in value.items()) + "}"
        return lua(value)
    path.write_text("return " + keyed(table) + "\n")
    subprocess.run(["luajit", str(HERE / "tools/apply_canon.lua"), str(OUT), str(path)], check=True)
    path.unlink()
    (OUT / "campaign/canon.json").unlink()


def build():
    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)
    (OUT / "main.lua").write_text(MAIN)
    (OUT / "manifest.json").write_text(json.dumps(MANIFEST, indent=2) + "\n")
    (OUT / "expanded.lua").write_text(expanded_layer())
    shutil.copytree(DEV / "lib", OUT / "lib",
                    ignore=shutil.ignore_patterns("lab.lua", "lab_screen.lua", "mechanics_lab.lua",
                                                  "fixture.lua", "emerald_reference.lua"))
    for name in ("coop_campaign.lua", "coop_progress.lua"):
        shutil.copy(DEV / "full" / name, OUT / name)
    shutil.copy(HERE / "LICENSE.MD", OUT / "LICENSE.MD")
    (OUT / "full").mkdir()
    for name in FULL_FILES:
        shutil.copy(DEV / "full" / name, OUT / "full" / name)
    for name in FULL_DIRS:
        shutil.copytree(DEV / "full" / name, OUT / "full" / name)
    # the patches below are written against the scrubbed sources
    native.scrub(OUT, TITLE, keep={"manifest.json"})
    print(f"{strip_gimmicks(OUT / 'full')} Mega/Z items dropped")
    save =(OUT / "full/save.lua").read_text()
    for before, after in SAVE_PATCHES:
        assert before in save, before
        save = save.replace(before, after)
    (OUT / "full/save.lua").write_text(save)
    shutil.copytree(CAMPAIGN, OUT / "campaign")
    apply_canon()
    (OUT / "campaign/natural_gift.lua").write_text(natural_gift())
    text, count = dex_entries()
    (OUT / "campaign/dex_entries.lua").write_text(text)
    print(f"{count} Pokédex entries")
    sys.path.insert(0, str(HERE / "tools"))
    import anim_convert
    symbols = re.findall(r"^  ([A-Z_0-9]+) = \{", (CAMPAIGN / "move_list.lua").read_text(), re.M)
    text, count, skipped, files = anim_convert.generate(symbols)
    (OUT / "campaign/move_anims.lua").write_text(text)
    for rel, data in files.items():  # donor sprite sheets (tools/anim_gfx.py)
        (OUT / rel).parent.mkdir(parents=True, exist_ok=True)
        (OUT / rel).write_bytes(data)
    print(f"{count} of {len(symbols)} new moves with their own animation")
    text, count = footprints()
    (OUT / "campaign/footprint_data.lua").write_text(text)
    print(f"{count} new species footprints")
    text, blob, count, missing = cries()
    assert not missing, missing
    (OUT / "campaign/cry_index.lua").write_text(text)
    (OUT / "cries.bin").write_bytes(blob)
    print(f"{count} species cries ({len(blob) // 1024} KiB)")
    native.write_native(OUT / "native", native.pick_modules(True))
    protocol_module(OUT / "native")
    stock_modules(OUT / "native")
    for path, before, after in LIB_PATCHES:
        text = (OUT / path).read_text()
        assert text.count(before) == 1, f"{path}: {before!r}"
        (OUT / path).write_text(text.replace(before, after))
    # g3_coop and the cart the headless fixture loads beside the mod (campaign_fixture.lua)
    coop = OUT.parent / COOP_ID
    if coop.exists():
        shutil.rmtree(coop)
    shutil.copytree(COOP_SRC, coop)
    carts = OUT.parent.parent / "carts"
    carts.mkdir(exist_ok=True)
    (carts / f"{CART_ID}.g1rcart").write_text(cart_text())
    # the patched engine modules are the donor port's too
    native.scrub(OUT / "native", TITLE)
    print(f"{MOD_ID} {VERSION} -> {OUT}")


LABEL = HERE / "cart_label.png"  # tools/make_cart_label.py


def cart_text(hashes=None):
    """The cart pins both mods. With `hashes` (the release zips' sha256) the
    pins are GitHub ones, so importing the cart downloads the mods; without,
    they are local, for the headless fixture."""
    def pin(mod_id, version, repo):
        if not hashes:
            return f'["id"]="{mod_id}",\n["source"]="local",\n["version"]="{version}"'
        return (f'["id"]="{mod_id}",\n["source"]="github",\n["repo"]="{repo}",\n'
                f'["version"]="{version}",\n["sha256"]="{hashes[mod_id]}"')
    # the launcher draws the label art on the cartridge (CartManifest.parseLabelArt)
    art = LABEL.read_bytes()
    label = (f'["labelArt"]={{\n["name"]="label.png",\n["encoding"]="base64",\n["bytes"]={len(art)},\n'
             f'["data"]="{base64.b64encode(art).decode()}"\n}},\n')
    return ('return {\n["format"]="g1rcart",\n["formatVersion"]=1,\n' + label + '["cart"]={\n'
            f'["id"]="{CART_ID}",\n["title"]="{TITLE}",\n["version"]="{VERSION}",\n'
            '["author"]="Aeryk Kisor",\n'
            '["summary"]="Vanilla Emerald with hundreds of new Pokémon, every battle a double, co-op with Soul Link and level caps.",\n'
            '["base"]="emerald",\n["engine"]=">=0.3.73",\n["shell"]="#26734D",\n["seal"]="open",\n'
            f'["mods"]={{\n[1]={{\n{pin(MOD_ID, VERSION, REPO)}\n}},\n'
            f'[2]={{\n{pin(COOP_ID, COOP_VERSION, COOP_REPO)},\n'
            # Cart defaults; the open cart also permits player preferences
            # and additional enabled mods after the campaign/co-op pair.
            '["options"]={\n["soullink"]=true,\n["sl_caps"]=true\n}\n}\n},\n'
            f'["load_order"]={{\n[1]="{MOD_ID}",\n[2]="{COOP_ID}"\n}}\n}}\n}}\n')


def pack_coop():
    """g3_coop's release zip, named <id>-<version>.zip so the launcher's
    GitHub lookup picks it (ModUpdate.pickZipAsset)."""
    manifest = json.loads((COOP_SRC / "manifest.json").read_text())
    assert manifest["version"] == COOP_VERSION, manifest["version"]
    assert manifest.get("github") == COOP_REPO, manifest.get("github")
    zpath = GEN3 / f"{COOP_ID}-{COOP_VERSION}.zip"
    # a version is packed once: modkit's zips aren't byte-for-byte
    # reproducible, and the cart pins the published one's hash
    if zpath.exists():
        return zpath
    subprocess.run([sys.executable, str(native.STOCK / "tools/modkit.py"), "pack", "--quiet",
                    str(COOP_SRC), "-o", str(zpath)], check=True)
    return zpath


def field_guide():
    """The offline field guide for this version (tools/handbook): export the
    built campaign's facts, embed them in one HTML file, then check the
    calculator against the runtime's rolls and the data's references."""
    tools = HERE / "tools/handbook"
    subprocess.run([sys.executable, str(tools / "export.py")], check=True, stdout=subprocess.DEVNULL)
    subprocess.run(["luajit", str(tools / "damage_reference.lua")], cwd=native.STOCK, check=True, stdout=subprocess.DEVNULL)
    subprocess.run([sys.executable, str(tools / "build.py")], check=True)
    subprocess.run(["node", str(tools / "verify.js")], check=True)
    return GEN3 / f"emerald-field-guide-{VERSION}.html"


def release():
    coop = pack_coop()
    zpath = GEN3 / f"{MOD_ID}-{VERSION}.zip"
    with zipfile.ZipFile(zpath, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(p for p in OUT.rglob("*") if p.is_file()):
            info = zipfile.ZipInfo(f.relative_to(OUT).as_posix(), (1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            z.writestr(info, f.read_bytes())
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    cpath = GEN3 / f"{CART_ID}.g1rcart"
    cpath.write_text(cart_text({MOD_ID: sha(zpath), COOP_ID: sha(coop)}))
    guide = field_guide()
    print(guide)
    for p in (coop, zpath, cpath):
        (p.parent / (p.name + ".sha256")).write_text(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.name}\n")
        print(p)


if __name__ == "__main__":
    build()
    if "--release" in sys.argv:
        release()
