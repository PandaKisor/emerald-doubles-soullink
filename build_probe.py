#!/usr/bin/env python3
"""Build the test-only native probe of the campaign mod.

Copies the dev.25 development campaign mod to generated/probe/ and makes it
install the engine overlay's battle, link and co-op modules onto stock
Gen1Recomp 0.3.73 from inside the mod sandbox (see swap.lua) before anything
else in the mod runs. Overlay sources are copied unchanged.
"""
import json, re, shutil, sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
GEN3 = HERE.parents[1]
FULL = GEN3 / "porting/full_port/generated"
OVERLAY = FULL / "engine-overlay"
STOCK = GEN3 / "gen1recomp-0.3.73"
# the donor port's development mod and playtest data pack (Gen3Mod/porting/inputs)
INPUTS = GEN3 / "porting/inputs"
DEV_MOD = INPUTS / "dev-mod"
MOD = "expanded_port"
OUT = HERE / "generated/probe/mods" / MOD

# Battle and link modules (the co-op team-battle path), the party and bag
# menus (paused-battle input), plus the overlay's new modules, which exist
# nowhere in stock.
PATTERN = re.compile(r"^src/(core/game3/(battle/|link/|battle_bridge\.lua)|link/Wire\.lua|battle/g3u/Hash\.lua"
                     r"|ui/game3/(party_menu|bag_menu)\.lua)")

# Overlay files that need APIs the mod sandbox withholds (io, os,
# love.filesystem, package writes). --all installs everything else.
BLOCKED = {
    "conf.lua", "src/core/SaveData.lua", "src/core/Game3.lua", "src/core/game3/dataset.lua",
    "src/core/game3/pokemon.lua", "src/ui/game3/egg_hatch.lua",
}

# Native-only edits on top of the overlay sources: (path, old, new), each old
# text must occur exactly once.  D1: every battle is a double, solo too.
PATCHES = [
    # Battle.start: a solo wild battle may bring a second wild mon.
    ("src/core/game3/battle/init.lua",
     "  local double = (opts.double == true) and (not opts.wild or (linkBattle and opts.coopTeam))\n",
     "  if opts.wild and opts.wildPartner and foeMon and not linkBattle then\n"
     "    foeParty = { foeMon, foe_mon_from(opts.wildPartner) }\n"
     "  end\n"
     "  local double = (opts.double == true)\n"
     "    and (not opts.wild or (linkBattle and opts.coopTeam) or (foeParty and #foeParty >= 2 and not linkBattle))\n"),
    # Solo wild double: a ball asks which wild mon to aim at.
    ("src/core/game3/battle/init.lua",
     "  if cmd.kind == \"move\" then\n    if cmd.target == nil and cmd.move ~= \"STRUGGLE\" then\n",
     "  if Coop.soloWild(st) and (cmd.kind == \"bag\" or cmd.kind == \"ball\")\n"
     "      and require(\"src.core.game3.battle.catching\").isBall(cmd.itemId) then\n"
     "    if require(\"src.ui.game3.bag_menu\").partyAndStorageFull(st.session) then\n"
     "      Ui.push(\"The party and PC are full.\", function() D.openMenu(id) end)\n"
     "      return\n"
     "    end\n"
     "    local function commitBall(target)\n"
     "      sel.targeting = false\n"
     "      if target == nil then return D.openMenu(id) end\n"
     "      return D.commit({ kind = \"ball\", battler = id, itemId = cmd.itemId, target = target })\n"
     "    end\n"
     "    sel.targeting = true\n"
     "    Ui.chooseBallTarget(st, id, commitBall)\n"
     "    return\n"
     "  end\n"
     "  if cmd.kind == \"move\" then\n    if cmd.target == nil and cmd.move ~= \"STRUGGLE\" then\n"),
    # Balls in wild doubles (solo or co-op): the throw is decided and stored
    # first, then the Gen 3 throw/shake/capture animation replays it at the
    # targeted wild mon (D.ballShow). Headless runs keep the text.
    ("src/core/game3/battle/init.lua",
     "    Coop.useBall(st, act, function(text) Ui.push(text) end)\n"
     "    Anim.syncDisplayFromState(st)\n"
     "    return D.afterEach()\n",
     "    local Audio = require(\"src.core.game3.audio\")\n"
     "    local song = Audio._currentSong and Audio._currentSong.id\n"
     "    local show = not (Battle._headless or Ui._headless)\n"
     "    -- the animation prints its own throw and result lines\n"
     "    local say = function(text)\n"
     "      if not show or text == \"There are no balls left.\" then Ui.push(text) end\n"
     "    end\n"
     "    local caught, shakes, res, target, finish\n"
     "    act.deferFinish = show\n"
     "    if Coop.soloWild(st) then\n"
     "      caught, shakes, res, target, finish = Coop.useSoloBall(st, act, say)\n"
     "    else\n"
     "      caught, shakes, res, finish = Coop.useBall(st, act, say)\n"
     "      target = act.target\n"
     "    end\n"
     "    act.deferFinish = nil\n"
     "    if show and shakes ~= nil then return D.ballShow(act, caught, shakes, res, target, song, finish) end\n"
     "    if finish then finish() end\n"
     "    Anim.syncDisplayFromState(st)\n"
     "    return D.afterEach()\n"),
    ("src/core/game3/battle/init.lua",
     "-- pokefirered/src/battle_main.c:2953\nfunction D.afterActions()\n",
     r"""-- Native D1: replays a decided wild-double throw with the catch animation,
-- aimed at the wild mon it targeted. The capture is already stored, so the
-- animation's own store is answered with that result (Catching._replay).
function D.ballShow(act, caught, shakes, res, target, song, finish)
  local st = Battle._st
  local Catching = require("src.core.game3.battle.catching")
  Battle._ballShow = { enemy = st.enemy, playerName = st.playerName, caught = caught, song = song, finish = finish,
    target = target }
  st.enemy = State.battler(st, target)
  -- a partner's throw is announced with the partner's name
  local thrower = st.link and st.linkNames and st.linkNames[act.battler]
  if thrower then st.playerName = thrower end
  Catching._replay = res or { success = true, location = "party", firstTimeCaught = false }
  CatchSeq.begin(st, act.itemId, caught, shakes, {
    pushMsg = function(text, wait) if wait then Ui.pushTimed(text, wait) else Ui.push(text) end end,
    session = st.session, target = target,
  })
  Battle._phase = "ball_show"
end

local function ball_show_update()
  local st, show = Battle._st, Battle._ballShow
  if not show.seqDone then
    if Anim.busy() then return end
    if not Ui.pump() then return end
    if not CatchSeq.update() then return end
    show.seqDone = true
  end
  -- the capture jingle starts the caught song when it ends (Audio.waitSe);
  -- let that happen now, not later in this battle or in the next one
  local Audio = require("src.core.game3.audio")
  if show.caught and Audio._waitSe and #Audio._waitSe > 0 then return end
  Battle._ballShow = nil
  require("src.core.game3.battle.catching")._replay = nil
  st.enemy, st.playerName = show.enemy, show.playerName
  if show.finish then show.finish() end
  Anim.syncDisplayFromState(st)
  -- the caught mon's sprite and healthbox leave with it, as a fainted one's
  if show.caught then
    local stage = Anim.stage()
    local hb = stage and stage.healthbox and stage.healthbox[show.target]
    if hb then hb.visible = false end
    local p = Anim.present(show.target)
    if p then p.visible = false end
  end
  -- the capture fanfare replaced the battle music; bring it back while a
  -- wild mon is still out
  if show.caught and show.song and (State.isAlive(st, 1) or State.isAlive(st, 3)) then
    require("src.core.game3.audio").playSong(show.song)
  end
  Battle._phase = "actions"
  return D.afterEach()
end

-- pokefirered/src/battle_main.c:2953
function D.afterActions()
"""),
    ("src/core/game3/battle/init.lua",
     "  -- Poké Ball catch presentation\n",
     "  if Battle._phase == \"ball_show\" then return ball_show_update() end\n\n"
     "  -- Poké Ball catch presentation\n"),
    ("src/core/game3/battle/catching.lua",
     "function Catching.storeCaught(session, foeBattler, ballId, opts)\n",
     "function Catching.storeCaught(session, foeBattler, ballId, opts)\n"
     "  -- native D1: a wild-double capture replayed by the catch animation was\n"
     "  -- stored when the throw resolved\n"
     "  if Catching._replay then return Catching._replay end\n"),
    # Wild doubles: the victory music waits until no wild mon is left.
    ("src/core/game3/battle/init.lua",
     "  if not (awards and #awards > 0) then return end\n"
     "  local lead = State.battler and State.battler(st, 0) or st.player\n",
     "  if not (awards and #awards > 0) then return end\n"
     "  if st.double and (State.isAlive(st, 1) or State.isAlive(st, 3)) then return end\n"
     "  local lead = State.battler and State.battler(st, 0) or st.player\n"),
    ("src/core/game3/battle/init.lua",
     "local function begin_trainer_win(st)\n  if Coop.wild(st) then\n",
     "local function begin_trainer_win(st)\n  if Coop.wild(st) or Coop.soloWild(st) then\n"),
    ("src/core/game3/battle/coop.lua",
     "\nreturn Coop\n",
     r"""
-- Native D1: a solo wild double (two wild mons, one trainer, no link).
function Coop.soloWild(st)
  return st and st.wild and st.double and not st.link and not st.multi and true or false
end

-- Same capture bookkeeping as useBall, with the local save as the catcher.
function Coop.useSoloBall(st, act, say)
  local State = require("src.core.game3.battle.state")
  local Engine = require("src.core.game3.battle.engine")
  local Catching = require("src.core.game3.battle.catching")
  local Bag = require("src.core.game3.bag")
  local Pokemon = require("src.core.game3.pokemon")
  local session = st.session
  local target = State.isAlive(st, act.target) and act.target or nil
  if not target then
    for _, id in ipairs({ 1, 3 }) do if State.isAlive(st, id) then target = id; break end end
  end
  if not target then return false end
  if not (session and Bag.remove(session.bag, act.itemId, 1)) then
    if say then say("There are no balls left.") end
    return false
  end
  local foe = State.battler(st, target)
  if say then
    say((session.name or "You") .. " threw a " .. require("src.core.game3.items_data").displayName(act.itemId) .. "!")
  end
  local caught, shakes = Catching.tryCatch(act.itemId, foe, st, session, st.rng)
  if not caught then
    if say then say(Pokemon.displayMonName(foe.mon) .. " broke free!") end
    return false, shakes, nil, target
  end
  local res = Catching.storeCaught(session, foe, act.itemId)
  st.coopCaptures = st.coopCaptures or {}
  st.coopCaptures[#st.coopCaptures + 1] = { target = target, species = foe.species,
    partyIndex = foe.partyIndex, ball = act.itemId }
  if say then say(Pokemon.displayMonName(foe.mon) .. " was caught!") end
  -- the caught mon leaves the field; with act.deferFinish the catch
  -- animation does this once the ball has closed (init.lua D.ballShow)
  local function finish()
    foe._expGiven, foe.mon.coopCaptured = true, true
    foe.mon.hp = 0
    State.syncBattlerToParty(foe, st.foeParty)
    Engine.markAbsent(st, target)
  end
  if act.deferFinish then return true, shakes, res, target, finish end
  finish()
  return true, shakes, res, target
end

return Coop
"""),
    ("src/core/game3/battle/coop.lua",
     "  if say then say(require(\"src.core.game3.pokemon\").displayMonName(target.mon) .. \" was caught!\") end\n"
     "  target._expGiven, target.mon.coopCaptured = true, true\n"
     "  target.mon.hp = 0\n"
     "  State.syncBattlerToParty(target, st.foeParty)\n"
     "  Engine.markAbsent(st, act.target)\n"
     "  return true, shakes, res\n",
     "  if say then say(require(\"src.core.game3.pokemon\").displayMonName(target.mon) .. \" was caught!\") end\n"
     "  -- native D1: with act.deferFinish the catch animation takes the caught\n"
     "  -- mon off the field once the ball has closed (init.lua D.ballShow)\n"
     "  local function finish()\n"
     "    target._expGiven, target.mon.coopCaptured = true, true\n"
     "    target.mon.hp = 0\n"
     "    State.syncBattlerToParty(target, st.foeParty)\n"
     "    Engine.markAbsent(st, act.target)\n"
     "  end\n"
     "  if act.deferFinish then return true, shakes, res, finish end\n"
     "  finish()\n"
     "  return true, shakes, res\n"),
    # Wild double intro: both wild mons slide in and undarken, both
    # healthboxes, then both player mons are sent out.
    ("src/core/game3/battle/intro_seq.lua",
     '    if d.slideEnemyMon then\n      local p = Anim.present("enemy")\n      p.visible = true\n      p.ox = d.enemyMonFrom or d.from or -240\n      p.darken = d.darken or (10 / 16)\n',
     '    if d.slideEnemyMon then\n      for _, key in ipairs(d.enemyMonIds or { "enemy" }) do\n        local p = present_of(key)\n        p.visible = true\n        p.ox = d.enemyMonFrom or d.from or -240\n        p.darken = d.darken or (10 / 16)\n      end\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '        if d.slideEnemyMon then\n          local p = Anim.present("enemy")\n          p.ox = mFrom + (mTo - mFrom) * u\n',
     '        if d.slideEnemyMon then\n          for _, key in ipairs(d.enemyMonIds or { "enemy" }) do present_of(key).ox = mFrom + (mTo - mFrom) * u end\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '        if d.slideEnemyMon then\n          Anim.present("enemy").ox = mTo\n',
     '        if d.slideEnemyMon then\n          for _, key in ipairs(d.enemyMonIds or { "enemy" }) do present_of(key).ox = mTo end\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '  if kind == "undarken" then\n    local p = Anim.present(d.side or "enemy")\n    local from = p.darken or 0\n    wait_busy()\n    Anim.tweenStage(d.frames or 10, function(u)\n      p.darken = from * (1 - u)\n    end, function()\n      p.darken = 0\n',
     '  if kind == "undarken" then\n    local ps = {}\n    for _, key in ipairs(d.ids or { d.side or "enemy" }) do ps[#ps + 1] = present_of(key) end\n    local from = ps[1].darken or 0\n    wait_busy()\n    Anim.tweenStage(d.frames or 10, function(u)\n      for _, p in ipairs(ps) do p.darken = from * (1 - u) end\n    end, function()\n      for _, p in ipairs(ps) do p.darken = 0 end\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '  local playerGender = (st.oldManTutorial and 5) or (st.backPicOverride) or opts.playerGender or 0\n  add("fade", { mode = "FROM_BLACK", instant = true })\n',
     '  local playerGender = (st.oldManTutorial and 5) or (st.backPicOverride) or opts.playerGender or 0\n'
     '  -- native D1: a wild double shows both wild mons and sends out two\n'
     '  local foeIds = st.double and present_ids(st, { 1, 3 }) or nil\n'
     '  local plIds = st.double and present_ids(st, { 0, 2 }) or nil\n'
     '  if foeIds and #foeIds < 2 then foeIds = nil end\n'
     '  add("fade", { mode = "FROM_BLACK", instant = true })\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '    darken = 10 / 16,\n    gender = playerGender,\n  })\n  add("shiny_check", { side = "enemy" })\n',
     '    darken = 10 / 16,\n    gender = playerGender,\n    enemyMonIds = foeIds,\n  })\n  add("shiny_check", foeIds and { ids = foeIds } or { side = "enemy" })\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '  add("cry", { side = "enemy" })  add("undarken", { side = "enemy", frames = 10 })\n  add("healthbox", { side = "enemy", frames = 23, from = -115 })\n',
     '  add("cry", { side = "enemy" })  add("undarken", { side = "enemy", ids = foeIds, frames = 10 })\n'
     '  add("healthbox", { side = "enemy", frames = 23, from = -115, ids = foeIds })\n'),
    ("src/core/game3/battle/intro_seq.lua",
     '  add("player_throw", {})\n  add("shiny_check", { side = "player" })\n  add("healthbox", { side = "player", frames = 23, from = 115 })\n  add("wait", { frames = 3 })\n  return steps\nend\n\nfunction IntroSeq.sendOutText(st, side)\n',
     '  if plIds and #plIds > 0 then\n'
     '    add("player_throw", { ids = plIds })\n'
     '    add("shiny_check", { ids = plIds })\n'
     '    add("healthbox", { side = "player", frames = 23, from = 115, ids = plIds })\n'
     '  else\n'
     '    add("player_throw", {})\n    add("shiny_check", { side = "player" })\n    add("healthbox", { side = "player", frames = 23, from = 115 })\n'
     '  end\n'
     '  add("wait", { frames = 3 })\n  return steps\nend\n\nfunction IntroSeq.sendOutText(st, side)\n'),
    # Solo wild double: running uses the normal speed odds (stock refuses
    # every flee in a double, battle_main.c:4259, since vanilla has no wild
    # doubles to run from).
    ("src/core/game3/battle/engine.lua",
     "    if st.double and not st.coopSolo then\n",
     "    if st.double and not st.coopSolo and not (st.wild and not st.link and not st.multi) then\n"),
    # BattleBridge: every trainer battle and plain field wild battle is a
    # double while the campaign says so (allDoubles, set by the mod).
    ("src/core/game3/battle_bridge.lua",
     "  local isDouble = (not opts.wild or (opts.link and opts.coopTeam))\n"
     "    and (opts.double or foeHalf or (foe and foe.doubleBattle)) and true or false\n",
     "  local allDoubles = not opts.link and BattleBridge.allDoubles and BattleBridge.allDoubles(session) or false\n"
     "  local isDouble\n"
     "  if allDoubles then\n"
     "    isDouble = not opts.wild or opts.wildPartner ~= nil\n"
     "  else\n"
     "    isDouble = (not opts.wild or (opts.link and opts.coopTeam))\n"
     "      and (opts.double or foeHalf or (foe and foe.doubleBattle)) and true or false\n"
     "  end\n"),
    ("src/core/game3/battle_bridge.lua",
     "  if isDouble and Party.monsStateToDoubles(",
     "  if isDouble and not allDoubles and Party.monsStateToDoubles("),
    ("src/core/game3/battle_bridge.lua",
     "    wild = opts.wild,\n    wildScripted = wildScripted,\n",
     "    wild = opts.wild,\n    wildPartner = opts.wildPartner,\n    wildScripted = wildScripted,\n"),
    ("src/core/game3/battle_bridge.lua",
     "function BattleBridge.startWild(mod, game, encounter, opts)\n  opts = opts or {}\n  opts.wild = true\n",
     "-- Native D1: a second wild mon from the same terrain, by the same rules\n"
     "-- (Sweet Scent's roll always produces a mon when the area has any).\n"
     "local function roll_wild_partner(session)\n"
     "  local okE, Encounters = pcall(require, \"src.core.game3.encounters\")\n"
     "  local Player = package.loaded[\"src.core.game3.player\"]\n"
     "  if not (okE and Encounters and Encounters.rollSweetScent and Player and session) then return nil end\n"
     "  local terrain = Encounters.terrainAt(Player.cellX, Player.cellY)\n"
     "  if terrain ~= \"water\" then terrain = \"land\" end\n"
     "  local ok, enc = pcall(Encounters.rollSweetScent, session.map, terrain)\n"
     "  return ok and enc or nil\n"
     "end\n\n"
     "function BattleBridge.startWild(mod, game, encounter, opts)\n  opts = opts or {}\n"
     "  local plain = next(opts) == nil\n"
     "  opts.wild = true\n"
     "  if plain and BattleBridge.allDoubles then\n"
     "    local session = require(\"src.core.game3.runtime\").getSession()\n"
     "    if BattleBridge.allDoubles(session) then opts.wildPartner = roll_wild_partner(session) end\n"
     "  end\n"),
]

POSTLUDE = '''  -- native D1: every battle is a double while the campaign is active
  local port = mod.exports.fullPort
  require("src.core.game3.battle_bridge").allDoubles = function()
    return port ~= nil and port.active() == true
  end
'''

PRELUDE = '''return function(mod)
  do -- native 0.3.73 probe: install patched engine modules first
    local Swap = assert(load(assert(mod:read("native/swap.lua")), "@" .. mod.path .. "/native/swap.lua"))()
    local list = assert(load(assert(mod:read("native/files.lua")), "@" .. mod.path .. "/native/files.lua"))()
    local files = {}
    for i, row in ipairs(list) do
      files[i] = { name = row.name, replaces = row.replaces, source = assert(mod:read("native/engine/" .. row.path)) }
    end
    mod.exports.nativeModules = Swap.installAll(files)
    assert(load(assert(mod:read("native/shims.lua")), "@" .. mod.path .. "/native/shims.lua"))().install()
  end
'''


# The donor port's name, spelled out so the scrub can find it, and its own
# mod/cart IDs, which become the probe's (the campaign keeps only the
# names in its manifest's conflicts list, so the old mods can't load beside it).
DONOR = "Inclement"
DONOR_IDS = {DONOR.lower() + "_battle_test": MOD, DONOR.lower() + "_emerald": "expanded_cart"}
WORD = re.compile(r"[A-Za-z0-9_]*" + DONOR + r"[A-Za-z0-9_]*", re.I)


def scrub_text(text, title):
    """The donor's name out of copied sources: its IDs become the probe's,
    user-facing names the campaign's title, prose the donor's, identifiers
    `expanded` (case kept)."""
    for old, new in DONOR_IDS.items():
        text = text.replace(old, new)
    text = text.replace(f"the {DONOR} Emerald cartridge", f"the {title} cart")
    text = text.replace(f"{DONOR} Emerald could not start", f"{title} could not start")
    text = text.replace(f"{DONOR} Emerald's", "the donor's").replace(f"{DONOR} Emerald", "the donor hack")
    text = re.sub(rf"\b{DONOR}'s\b", "the donor's", text)

    def word(m):
        w = m.group(0)
        return w.replace(DONOR, "Expanded").replace(DONOR.lower(), "expanded").replace(DONOR.upper(), "EXPANDED")
    return WORD.sub(word, text)


def scrub(root, title, keep=()):
    """scrub_text over every text file under `root` (files named after the
    donor renamed too), checking first that no renamed identifier lands on
    one that already exists. `keep` lists relative paths left as they are."""
    texts = {}
    for f in sorted(p for p in root.rglob("*") if p.is_file()):
        if f.relative_to(root).as_posix() in keep:
            continue
        try:
            texts[f] = f.read_bytes().decode("utf-8")
        except UnicodeDecodeError:
            continue
    words = {w for t in texts.values() for w in WORD.findall(t)}
    # (only in the donor's files: ours already use the new names)
    present = {w for t in texts.values() if WORD.search(t)
               for w in re.findall(r"[A-Za-z0-9_]*[Ee]xpanded[A-Za-z0-9_]*", t)}
    clash = sorted(w for w in words if w.lower() != DONOR.lower() and scrub_text(w, title) in present)
    assert not clash, f"renamed identifiers already exist: {clash}"
    for f, text in texts.items():
        new = scrub_text(text, title)
        if new != text:
            f.write_text(new)
    for f in sorted((p for p in root.rglob("*") if DONOR.lower() in p.name.lower()), reverse=True):
        f.rename(f.with_name(scrub_text(f.name, title)))
    left = [f for f in root.rglob("*") if f.is_file() and f.relative_to(root).as_posix() not in keep
            and DONOR.lower() in f.read_bytes().decode("utf-8", "replace").lower()]
    assert not left, left


def module_name(path):
    name = path[:-4].replace("/", ".")
    return name[:-5] if name.endswith(".init") else name


def pick_modules(all_files=True):
    paths = sorted(p.relative_to(OVERLAY).as_posix() for p in OVERLAY.rglob("*.lua"))
    if all_files:
        picked = [p for p in paths if p not in BLOCKED]
    else:
        picked = [p for p in paths if PATTERN.match(p) or not (STOCK / p).exists()]
    return [p for p in picked if p != "conf.lua"]


def write_native(native, picked):
    """The mod's native/ tree: installer, wrappers, patched engine modules."""
    native.mkdir(parents=True)
    shutil.copy(HERE / "swap.lua", native / "swap.lua")
    shutil.copy(HERE / "shims.lua", native / "shims.lua")
    rows = []
    for p in picked:
        dest = native / "engine" / p
        dest.parent.mkdir(parents=True, exist_ok=True)
        text = (OVERLAY / p).read_text()
        for path, before, after in PATCHES:
            if path == p:
                assert text.count(before) == 1, f"{p}: patch anchor not found once: {before!r}"
                text = text.replace(before, after)
        dest.write_text(text)
        replaces = (STOCK / p).exists()
        rows.append(f'  {{ name = "{module_name(p)}", path = "{p}", replaces = {str(replaces).lower()} }},')
    (native / "files.lua").write_text("return {\n" + "\n".join(rows) + "\n}\n")


def main():
    picked = pick_modules("--all" in sys.argv)
    if OUT.exists():
        shutil.rmtree(OUT)
    shutil.copytree(DEV_MOD, OUT)
    main_lua = (OUT / "main.lua").read_text()
    head = "return function(mod)\n"
    assert main_lua.startswith(head)
    body = main_lua[len(head):]
    assert body.endswith("end\n")
    (OUT / "main.lua").write_text(PRELUDE + body[:-len("end\n")] + POSTLUDE + "end\n")
    native = OUT / "native"
    write_native(native, picked)
    manifest = json.loads((OUT / "manifest.json").read_text())
    if "network" not in manifest.setdefault("permissions", []):
        manifest["permissions"].append("network")  # patched link modules require src.link.Wire
    (OUT / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    # the development cart and the shared test fixture, under the probe's IDs
    root = OUT.parent.parent
    shutil.rmtree(root / "carts", ignore_errors=True)
    (root / "carts").mkdir()
    for cart in (FULL / "development/carts").glob("*.g1rcart"):
        shutil.copy(cart, root / "carts" / cart.name)
    shutil.copy(GEN3 / "porting/full_port/inventory_fixture.lua", root / "inventory_fixture.lua")
    scrub(root, "Expanded Port", keep={"files.txt"})
    listing = sorted(f.relative_to(root).as_posix() for d in (OUT, root / "carts") for f in d.rglob("*") if f.is_file())
    (root / "files.txt").write_text("\n".join(listing) + "\n")
    print(f"{len(picked)} modules -> {OUT}")


if __name__ == "__main__":
    main()
