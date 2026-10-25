#!/usr/bin/env python3
"""Inclement's battle animation scripts (pokeemerald-1.13
data/battle_anim_scripts.s) as the IR the stock engine's animation VM runs,
the same shape src/import/gba/battle_anim_extract.lua decodes from the ROM.

A move converts only when everything it uses already exists in the vanilla
ROM's pack: opcodes, sprite templates (their tag, palette, callback and size
come from the vanilla scripts that use them), tasks and graphics tags.
Anything else keeps its stand-in animation (campaign/move_list.lua).

    python3 tools/anim_convert.py --check   # converts vanilla's moves and diffs them against the ROM's
"""
import json, os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import anim_gfx

HERE = os.path.dirname(os.path.abspath(__file__))
GEN3 = os.path.normpath(os.path.join(HERE, "../../.."))
DONOR = os.path.join(GEN3, "pokeemerald-1.13")
STOCK = os.path.join(GEN3, "gen1recomp-0.3.73")
PACK = os.path.join(GEN3, "porting/full_port/generated/playtest/userdata/love/inclement-playtest/emerald"
                    "/data/generated/gba/pokemon/battle_anims/pack.lua")
HEADERS = ["battle.h", "battle_anim.h", "rgb.h", "songs.h", "moves.h", "pokemon.h", "items.h", "battle_config.h"]
SPRITES_START = 10000
BATTLERS = {0: "attacker", 1: "target", 2: "attacker_partner", 3: "target_partner"}


class Unsupported(Exception):
    pass


def strip_comments(text):
    """C comments out, scanning left to right (a "//" inside /* */, or "/*"
    after //, is not a comment start)"""
    out, i, n = [], 0, len(text)
    while i < n:
        if text.startswith("/*", i):
            j = text.find("*/", i + 2)
            i = n if j < 0 else j + 2
            out.append(" ")
        elif text.startswith("//", i):
            j = text.find("\n", i)
            i = n if j < 0 else j
        elif text[i] == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            out.append(text[i:j + 1])
            i = j + 1
        else:
            out.append(text[i])
            i += 1
    return "".join(out)


def load_pack():
    out = subprocess.run(["luajit", os.path.join(HERE, "dump_anim_pack.lua"), PACK],
                         check=True, capture_output=True, text=True).stdout
    return json.loads(out)


def vanilla_tag_names():
    src = open(os.path.join(STOCK, "src/import/gba/anim_names_emerald.lua")).read()
    body = src[src.index("tagNames = {"):]
    body = body[:body.index("\n  },")]
    return {int(i): n for i, n in re.findall(r'\[(\d+)\] = "(\w+)"', body)}


def battler_names():
    src = open(os.path.join(STOCK, "src/import/gba/battle_anim_extract.lua")).read()
    m = re.search(r"BATTLER_NAMES\s*=\s*\{(.*?)\}", src, re.S)
    return {int(i): n for i, n in re.findall(r'\[(\d+)\]\s*=\s*"(\w+)"', m[1])} if m else BATTLERS


class Consts:
    """#defines from the headers the script file includes, evaluated as C."""

    def __init__(self):
        # ANIM_ATTCKER: a typo in the donor's Hammer Arm / Wake-Up Slap scripts
        self.raw = {"TRUE": "1", "FALSE": "0", "ANIM_ATTCKER": "ANIM_ATTACKER"}
        for h in HEADERS:
            path = os.path.join(DONOR, "include/constants", h)
            if not os.path.exists(path):
                continue
            text = strip_comments(open(path).read())
            text = text.replace("\\\n", " ")
            # [ \t], not \s: a value-less define must not take the next line as its value
            for m in re.finditer(r"^[ \t]*#define[ \t]+(\w+)(\([^)]*\))?[ \t]+(.+?)[ \t]*$", text, re.M):
                if m[2]:
                    continue  # function-like: only RGB is handled
                self.raw.setdefault(m[1], m[3])
        self.cache = {}

    def value(self, expr, depth=0):
        expr = expr.strip()
        if expr in self.cache:
            return self.cache[expr]
        if depth > 20:
            raise Unsupported("constant recursion: " + expr)
        e = re.sub(r"\bRGB\s*\(", "_rgb(", expr)
        e = re.sub(r"(?<![\w.])(0x[0-9A-Fa-f]+|\d+)[uU]?[lL]*\b", r"\1", e)

        def sub(m):
            name = m[1]
            if name == "_rgb":
                return name
            if name not in self.raw:
                raise Unsupported("unknown constant " + name)
            return "(" + str(self.value(self.raw[name], depth + 1)) + ")"
        e = re.sub(r"\b([A-Za-z_]\w*)\b", sub, e)
        e = e.replace("&&", " and ").replace("||", " or ").replace("!", " not ").replace(" not =", "!=")
        e = re.sub(r"(?<![<>=!])/(?!/)", "//", e)
        try:
            v = int(eval(e, {"__builtins__": {}}, {"_rgb": lambda r, g, b: r | (g << 5) | (b << 10)}))
        except Exception as x:
            raise Unsupported(f"bad expression {expr!r}: {x}")
        self.cache[expr] = v
        return v


def split_args(text):
    out, depth, cur = [], 0, ""
    for ch in text:
        if ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        out.append(cur.strip())
    # GAS also separates macro arguments by spaces ("SOUND_PAN_TARGET 11"),
    # where the space isn't part of an expression
    split = []
    out = [a.rstrip(";").strip() for a in out]  # "goto ParabolicChargeHeal;"
    for arg in out:
        split.extend(x for x in re.split(r"(?<=[\w)])\s+(?=[\w(])", arg) if x)
    return split


def parse_script_file():
    """[(label, [(macro, args)])] in file order; a block runs into the next
    unless it ends."""
    src = open(os.path.join(DONOR, "data/battle_anim_scripts.s")).read()
    src = src[src.index("gBattleAnims_Moves::"):]
    blocks, order, cur = {}, [], None
    for raw in src.splitlines():
        line = re.sub(r"@.*|//.*", "", raw).rstrip()
        if not line.strip():
            continue
        m = re.match(r"^([A-Za-z_][\w.]*)::?\s*$", line)
        if m:
            cur = m[1]
            blocks[cur] = []
            order.append(cur)
            continue
        if cur is None or line.strip().startswith("."):
            if cur is not None and line.strip().startswith((".if", ".else", ".endif", ".elseif")):
                blocks[cur].append((".cond", []))
            continue
        parts = line.strip().split(None, 1)
        blocks[cur].append((parts[0], split_args(parts[1]) if len(parts) > 1 else []))
    return blocks, order


CB_KEYS = os.path.join(HERE, "dump_anim_registry.lua")


def engine_registry():
    """the engine's sprite callbacks and visual/sound tasks, by name"""
    out = subprocess.run(["luajit", CB_KEYS], cwd=STOCK, check=True, capture_output=True, text=True).stdout
    cbs = {l[3:] for l in out.splitlines() if l.startswith("cb ")}
    tasks = {l[5:] for l in out.splitlines() if l.startswith("task ")}
    # the campaign's own (campaign/anim_code.lua): "CB.X = ", "NEW.X = ",
    # "CB.X, CB.Y = ", "TASK.X = "
    own = open(os.path.join(HERE, "../campaign/anim_code.lua")).read()
    for line in re.findall(r"^  ((?:(?:CB|NEW)\.\w+(?:, )?)+) = ", own, re.M):
        cbs |= set(re.findall(r"(?:CB|NEW)\.(\w+)", line))
    for line in re.findall(r"^  ((?:TASK\.\w+(?:, )?)+) = ", own, re.M):
        tasks |= set(re.findall(r"TASK\.(\w+)", line))
    return cbs, tasks


def c_sources():
    files = [os.path.join(DONOR, "src", f) for f in sorted(os.listdir(os.path.join(DONOR, "src")))
             if f.startswith("battle_anim") and f.endswith(".c")]
    files.append(os.path.join(DONOR, "gflib/sprite.c"))
    text = ""
    for f in files:
        text += strip_comments(open(f).read()) + "\n"
    return text


class CData:
    """Sprite templates, OAM shapes and frame/affine tables from the donor's C."""

    def __init__(self, consts):
        self.c = consts
        text = c_sources()
        self.templates = {}
        for m in re.finditer(r"const struct SpriteTemplate (\w+)\s*=\s*\{(.*?)\};", text, re.S):
            self.templates[m[1]] = dict(re.findall(r"\.(\w+)\s*=\s*([^,]+?)\s*(?:,|$)", m[2].strip()))
        self.oams = {}
        for m in re.finditer(r"const struct OamData (\w+)\s*=\s*\{(.*?)\};", text, re.S):
            self.oams[m[1]] = dict(re.findall(r"\.(\w+)\s*=\s*([^,]+?)\s*(?:,|$)", m[2].strip()))
        # OAM written as raw attribute words (static const u16 sX[] = {a0, a1, a2, 0})
        self.raw_oams = {}
        dims = {0: ((8, 8), (16, 16), (32, 32), (64, 64)), 1: ((16, 8), (32, 8), (32, 16), (64, 32)),
                2: ((8, 16), (8, 32), (16, 32), (32, 64))}
        for m in re.finditer(r"const u16 (\w+)\[\]\s*=\s*\{([^}]*)\}", text):
            words = [int(x, 0) for x in re.findall(r"0x[0-9A-Fa-f]+|\d+", m[2])]
            if len(words) >= 3 and (words[0] >> 14) in dims:
                w, h = dims[words[0] >> 14][(words[1] >> 14) & 3]
                self.raw_oams[m[1]] = {"w": w, "h": h, "affineMode": (words[0] >> 8) & 3,
                                       "objBlend": ((words[0] >> 10) & 3) == 1, "priority": (words[2] >> 10) & 3}
        self.seqs, self.tables = {}, {}
        for kind in ("AnimCmd", "AffineAnimCmd"):
            for m in re.finditer(r"const union %s (\w+)\[\]\s*=\s*\{(.*?)\};" % kind, text, re.S):
                self.seqs[(kind, m[1])] = m[2]
            # single commands: static const union AnimCmd sDummyAnim = ANIMCMD_END;
            for m in re.finditer(r"const union %s (\w+)\s*=\s*\{?\s*([A-Z_]+(?:\([^;]*?\))?)\s*\}?\s*;" % kind, text):
                self.seqs[(kind, m[1])] = m[2]
            for m in re.finditer(r"const union %s\s*\*\s*const (\w+)\[\w*\]\s*=\s*\{(.*?)\};" % kind, text, re.S):
                self.tables[(kind, m[1])] = m[2]

    def oam(self, name):
        name = re.sub(r"^\([^)]*\)\s*", "", name.strip())  # (const struct OamData *) &sX
        o = self.oams.get(name.lstrip("&").strip())
        if o is None and name.lstrip("&").strip() in self.raw_oams:
            return self.raw_oams[name.lstrip("&").strip()]
        if o is None:
            raise Unsupported("oam " + name)
        shape = re.search(r"(\d+)x(\d+)", o.get("shape", "") + o.get("size", ""))
        if not shape:
            raise Unsupported("oam shape " + name)
        affine = {"ST_OAM_AFFINE_OFF": 0, "ST_OAM_AFFINE_NORMAL": 1, "ST_OAM_AFFINE_ERASE": 2,
                  "ST_OAM_AFFINE_DOUBLE": 3}.get(o.get("affineMode", "ST_OAM_AFFINE_OFF"), 0)
        return {"w": int(shape[1]), "h": int(shape[2]), "affineMode": affine,
                "objBlend": o.get("objMode") == "ST_OAM_OBJ_BLEND",
                "priority": self.c.value(o["priority"]) if "priority" in o else 0}

    def seq(self, kind, name):
        body = self.seqs.get((kind, name))
        if body is None:
            raise Unsupported(kind + " " + name)
        out = []
        for cmd in re.findall(r"(\w+)\s*(\((?:[^()]|\([^()]*\))*\))?", body):
            op, args = cmd[0], split_args(cmd[1][1:-1]) if cmd[1] else []
            if op == "ANIMCMD_FRAME":
                row = {"f": self.c.value(args[0]), "d": self.c.value(args[1])}
                for extra in args[2:]:
                    k, _, v = extra.partition("=")
                    if self.c.value(v):
                        row[{".hFlip": "h", ".vFlip": "v"}.get(k.strip(), "x")] = True
                out.append(row)
            elif op == "AFFINEANIMCMD_FRAME":
                def sx(v, bits):
                    v = self.c.value(v) & ((1 << bits) - 1)
                    return v - (1 << bits) if v >= 1 << (bits - 1) else v
                out.append({"xs": sx(args[0], 16), "ys": sx(args[1], 16), "r": sx(args[2], 8),
                            "d": self.c.value(args[3]) & 0xFF})
            elif op in ("ANIMCMD_JUMP", "AFFINEANIMCMD_JUMP"):
                out.append({"jump": self.c.value(args[0])})
            elif op in ("ANIMCMD_LOOP", "AFFINEANIMCMD_LOOP"):
                out.append({"loop": self.c.value(args[0])})
            elif op in ("ANIMCMD_END", "AFFINEANIMCMD_END", "AFFINEANIMCMD_END_ALT", "ANIM_END", "AFFINE_ANIM_END"):
                out.append({"e": True})
            else:
                raise Unsupported(f"{kind} command {op} in {name}")
        return out

    def table(self, kind, name):
        if name in ("NULL", "0"):
            return None
        body = self.tables.get((kind, name))
        if body is None:
            raise Unsupported(kind + " table " + name)
        out, i = {}, 0
        for item in split_args(body):
            m = re.match(r"\[(.+?)\]\s*=\s*(\w+)", item)
            if m:
                i = self.c.value(m[1])
                item = m[2]
            out[i] = self.seq(kind, item.strip().lstrip("&").strip())
            i += 1
        return out


# Vanilla tasks and templates the donor calls with a different argument
# count. Checked against the donor's C:
# COMPATIBLE: the donor's function reads no argument vanilla's doesn't (extra
#   trailing arguments it ignores), or relies on an argument it doesn't pass
#   keeping its last value. Only sprites see that last value (they copy the
#   VM's args, as the GBA's gBattleAnimArgs); a task reads its own argument
#   list, so a task called with fewer is refused (Aqua Ring's BlendColorCycle
#   never ended)
COMPATIBLE = {
    "ShakeMonInPlace", "ShakeMon", "SoundTask_LoopSEAdjustPanning", "BlendColorCycle",
    "gHorizontalLungeSpriteTemplate", "BlendBattleAnimPalExclude", "Splash", "StretchTargetUp",
    "RockMonBackAndForth", "gFireSpreadSpriteTemplate", "gGrantingStarsSpriteTemplate",
    "gSlideMonToOriginalPosSpriteTemplate", "StartSlidingBg", "AlphaFadeIn", "WindUpLunge",
    "SoundTask_PlayCryWithEcho", "SmokescreenImpact", "gLeerSpriteTemplate",
    "SoundTask_WaitForCry", "StartSinAnimTimer", "GetAttackerSide", "Rollout", "StretchAttackerUp",
    "RotateMonSpriteToSide", "MoonlightEndFade", "ShakeTargetBasedOnMovePowerOrDmg", "DragonDanceWaver",
    "BlendPalInAndOutByTag", "BlendBattleAnimPal",
}


def _invert_flags(a):
    # donor: one bit field (1 bg, 2 attacker, 4 target, 8/16 partners);
    # vanilla: bg, attacker, target each 0x100 when inverted (0x101 as the
    # ROM's scripts write it; partners dropped)
    return {"args": [0x101 if a[0] & bit else 0 for bit in (1, 2, 4)]}


def _electricity(a):
    # donor arg 4: the battler the spark sits on; vanilla always the target
    return {"args": a[:4]} if a[4] == 1 else {"callback": "IncElectricity"}


def _acid_bubble(a):
    # donor arg 6: aim at the target pair's average position; FALSE is vanilla
    if a[6] != 0:
        raise Unsupported("gAcidPoisonBubbleSpriteTemplate aimed at the average position")
    return {"args": a[:6]}


def _acid_droplet(a):
    # donor arg 5: start from the target pair's average position; FALSE is vanilla
    if a[5] != 0:
        raise Unsupported("gAcidPoisonDropletSpriteTemplate from the average position")
    return {"args": a[:5]}


def _shock_wave(a):
    # donor arg 0: which battler the bolt runs to; ANIM_TARGET is vanilla, any
    # other runs the campaign's IncShockWaveProgressingBolt
    if a[0] != 1:
        return {"task": "IncShockWaveProgressingBolt"}
    return {"args": []}


# ADAPT: the donor gave the call a new meaning; (name, donor count) -> how to
# run it with vanilla's arguments, or the campaign's own version
# (campaign/anim_code.lua)
ADAPT = {
    ("InvertScreenColor", 1): _invert_flags,
    ("gElectricitySpriteTemplate", 5): _electricity,
    ("gAcidPoisonBubbleSpriteTemplate", 7): _acid_bubble,
    ("ShockWaveProgressingBolt", 1): _shock_wave,
    ("ShockWaveLightning", 1): lambda a: {"args": []} if a[0] == 1 else {"task": "IncShockWaveLightning"},
    ("gAcidPoisonDropletSpriteTemplate", 6): _acid_droplet,
    # donor arg 1: leave the attacker invisible (U-turn switching out); only
    # passed TRUE on the branch AnimTask_CanBattlerSwitch opens, which the
    # campaign's version never does (campaign/anim_code.lua)
    ("gFlyBallAttackSpriteTemplate", 2): lambda a: {"args": a[:1]},
    # Aqua Ring passes BlendColorCycle (selector, delay, blends, target, colour),
    # one short: the starting blend amount goes back in as 0 (two flashes from
    # 0 to 10 towards white); left as it was, the colour lands on a blend
    # amount and the cycle never ends
    ("BlendColorCycle", 5): lambda a: {"args": a[:3] + [0] + a[3:]},
    # donor: x/y offsets, and TRUE to centre on the target pair; 0, 0, FALSE is vanilla
    ("gSpiderWebSpriteTemplate", 3): lambda a: {"args": []} if a == [0, 0, 0] else {"callback": "IncSpiderWeb"},
}


# Donor templates campaign tasks create directly (no script names them)
TASK_TEMPLATES = ["gSteelBeamSmallOrbSpriteTemplate"]

# Moves that convert but don't run right on the engine; they keep their stand-in.
EXCLUDE = {}

# Giga Impact waits for its background fade after the attacker's dip and
# slide, which the engine runs ~10 frames slower than the GBA: the fade has
# finished by then and waitbgfadeout would wait forever. The fade is always
# done at that point, so the wait is dropped (waitbgfadein still syncs).
NO_BG_FADE_OUT_WAIT = {"GIGA_IMPACT"}


class Converter:
    def __init__(self, pack):
        self.pack = pack
        self.c = Consts()
        self.blocks, self.order = parse_script_file()
        self.index = {name: i for i, name in enumerate(self.order)}
        self.tag_names = vanilla_tag_names()
        self.known_tags = set(pack["tags"])
        self.known_tasks = set(pack["tasks"])
        self.known_bgs = set(pack.get("bgs", []))
        self.templates = pack["templates"]
        self.battlers = battler_names()
        self.cdata = CData(self.c)
        self.callbacks, engine_tasks = engine_registry()
        # tasks the engine registers beyond what vanilla's moves use
        self.known_tasks |= engine_tasks
        self.new_templates = {}
        self.new_tags = {}
        self.new_bgs = set()
        # how many arguments vanilla passes each task and template: the donor
        # changed some (InvertScreenColor takes one, not three), and the
        # engine implements vanilla's
        self.arity = {}
        def scan(seq):
            for op in seq or []:
                key = op.get("template") or op.get("task")
                if key and op["op"] in ("createsprite", "createvisualtask", "createsoundtask"):
                    self.arity.setdefault(key, set()).add(len(op.get("args") or []))
        for seq in pack["moves"].values():
            scan(seq)
        for seq in pack["labels"].values():
            scan(seq)

    def tag(self, expr):
        name = expr.strip()
        if name.startswith("ANIM_TAG_"):
            idx = self.c.value(name) - SPRITES_START
            vanilla = self.tag_names.get(idx)
            if vanilla and vanilla in self.known_tags:
                return vanilla, idx
            # a donor tag: its sheet is built from the donor's art (anim_gfx.py)
            short = name[len("ANIM_TAG_"):]
            if short not in self.known_tags and short in anim_gfx.PIC_OF and short in anim_gfx.PAL_OF:
                self.new_tags.setdefault(short, {"idx": idx})
                return short, idx
        raise Unsupported("graphics " + name)

    def size_tag(self, tag, w, h):
        """a donor sheet is laid out at the frame size of the first sprite drawing it"""
        t = self.new_tags.get(tag)
        if t is not None and "w" not in t:
            t["w"], t["h"] = w, h

    def task(self, name):
        n = name[len("AnimTask_"):] if name.startswith("AnimTask_") else name
        if n not in self.known_tasks:
            raise Unsupported("task " + name)
        return n

    def bg(self, expr):
        """a battle background the ROM has (the donor added its own past vanilla's)"""
        n = self.num(expr) & 0xFF
        if n not in self.known_bgs:
            # a donor background, built from its art (anim_gfx.background)
            try:
                anim_gfx.background(n)
            except (anim_gfx.Unsupported, OSError) as x:
                raise Unsupported(f"background {expr.strip()}: {x}")
            self.new_bgs.add(n)
        return n

    def num(self, expr):
        return self.c.value(expr)

    def s8(self, expr):
        v = self.num(expr) & 0xFF
        return v - 256 if v >= 128 else v

    def s16(self, expr):
        v = self.num(expr) & 0xFFFF
        return v - 65536 if v >= 32768 else v

    def convert(self, label):
        """(ops, labels) for the script starting at `label`."""
        self.labels = {}
        # gBattleAnimArgs as the script leaves them: a call sets only the
        # arguments it passes, the rest keep their last value
        self.argstate = [0] * 8
        ops = self.run(label)
        return ops, self.labels

    def ref(self, label):
        key = "cv:" + label
        if key not in self.labels:
            self.labels[key] = None
            self.labels[key] = self.run(label)
        return key

    def new_template(self, name):
        """A donor template vanilla doesn't have, built from its C when its
        graphics are vanilla's and the engine has its callback: the IR fields
        plus the engine template-table entry (anim_port/g1_templates.lua)."""
        if name in self.new_templates:
            return self.new_templates[name]["ir"]
        t = self.cdata.templates.get(name)
        if t is None:
            raise Unsupported("template " + name)
        def tagname(expr):
            expr = expr.strip()
            if expr in ("0", "TAG_NONE", "0xFFFF"):
                return None
            return self.tag(expr)[0]
        tag, pal = tagname(t.get("tileTag", "0")), tagname(t.get("paletteTag", "0"))
        cb = t.get("callback", "SpriteCallbackDummy").strip()
        short = cb[4:] if cb.startswith("Anim") and cb[4:] in self.callbacks else cb
        if short not in self.callbacks:
            raise Unsupported("callback " + cb)
        oam = self.cdata.oam(t.get("oam", "").strip())
        entry = dict(oam, tag=tag, pal=pal or tag,
                     anims=self.cdata.table("AnimCmd", t.get("anims", "gDummySpriteAnimTable").strip())
                     or {0: [{"e": True}]},
                     affine=self.cdata.table("AffineAnimCmd", t.get("affineAnims", "gDummySpriteAffineAnimTable").strip())
                     or {0: [{"e": True}]})
        ir = {"tag": tag, "callback": short, "w": oam["w"], "h": oam["h"]}
        if pal and pal != tag:
            ir["palTag"] = pal
        if tag is None:
            ir["noGfx"] = True
        self.new_templates[name] = {"ir": ir, "entry": entry}
        return ir

    def adapt(self, key, args):
        """ADAPT's rewrite for a donor call vanilla runs differently, else None"""
        rule = ADAPT.get((key, len(args)))
        return rule(args) if rule else None

    def remember(self, args):
        for i, v in enumerate(args[:8]):
            self.argstate[i] = v

    def pad_task(self, key, args):
        """a task called with fewer arguments than vanilla passes reads the
        rest as the GBA left them (Aqua Ring's BlendColorCycle); the engine's
        tasks read only their own list, so pass them explicitly"""
        need = max(self.arity.get(key, {0}))
        if key in COMPATIBLE and len(args) < need:
            return args + self.argstate[len(args):need]
        return args

    def check_args(self, key, args):
        if key in self.new_templates or (key not in self.arity and key in self.known_tasks):
            return  # no vanilla use to compare with
        if key in COMPATIBLE and (len(args) > max(self.arity.get(key, {0})) or key.endswith("Template")):
            return
        if len(args) not in self.arity.get(key, ()):
            raise Unsupported(f"{key} with {len(args)} arguments (vanilla: {sorted(self.arity.get(key, ()))})")

    def run(self, label):
        if label not in self.index:
            raise Unsupported("no script " + label)
        ops = []
        i = self.index[label]
        while i < len(self.order):
            for macro, args in self.blocks[self.order[i]]:
                try:
                    done = self.emit(ops, macro, args)
                except (IndexError, ValueError) as x:
                    raise Unsupported(f"{macro} {args}: {x}")
                if done:
                    return ops
            i += 1
        ops.append({"op": "end"})
        return ops

    def emit(self, ops, macro, a):
        """Appends the IR for one line; True when the script stops here."""
        if macro == ".cond":
            raise Unsupported("conditional assembly")
        if macro in ("createsprite", "launchtemplate"):
            tmpl = a[0]
            info = self.templates.get(tmpl) or self.new_template(tmpl)
            if macro == "createsprite":
                battler = self.num(a[1])
                byte = (0x80 if battler == 1 else 0) | (self.num(a[2]) & 0x7F)
                args = [self.s16(x) for x in a[3:]]
            else:
                byte = self.num(a[1]) & 0xFF
                args = [self.s16(x) for x in a[3:3 + self.num(a[2])]]
            change = self.adapt(tmpl, args)
            if change:
                args = change.get("args", args)
            else:
                self.check_args(tmpl, args)
            self.remember(args)
            op = {"op": "createsprite", "template": tmpl, "animBattler": "target" if byte >= 0x80 else "attacker",
                  "subpriority": byte % 0x80, "args": args, "w": info.get("w", 32), "h": info.get("h", 32)}
            if info.get("tag"):
                self.size_tag(info["tag"], info.get("w", 32), info.get("h", 32))
            for k in ("tag", "palTag", "callback", "noGfx"):
                if info.get(k) is not None:
                    op[k] = info[k]
            if change and "callback" in change:
                op["callback"] = change["callback"]
            ops.append(op)
        elif macro in ("createvisualtask", "launchtask"):
            if macro == "createvisualtask":
                pri, args = self.num(a[1]), [self.s16(x) for x in a[2:]]
            else:
                pri, args = self.num(a[1]), [self.s16(x) for x in a[3:3 + self.num(a[2])]]
            name = self.task(a[0])
            change = self.adapt(name, args)
            if change:
                args, name = change.get("args", args), change.get("task", name)
            else:
                args = self.pad_task(name, args)
                self.check_args(name, args)
            self.remember(args)
            ops.append({"op": "createvisualtask", "task": name, "priority": pri, "args": args})
        elif macro == "createsoundtask":
            name, args = self.task(a[0]), [self.s16(x) for x in a[1:]]
            args = self.pad_task(name, args)
            self.check_args(name, args)
            self.remember(args)
            ops.append({"op": "createsoundtask", "task": name, "args": args})
        elif macro == "jumpifdoublebattle":
            # every battle in the campaign is a double
            ops.extend([{"op": "goto", "label": self.ref(a[0])}, {"op": "end"}])
            return True
        elif macro in ("loadspritegfx", "unloadspritegfx"):
            name, idx = self.tag(a[0])
            ops.append({"op": macro, "tag": name, "tag_idx": idx} if macro == "loadspritegfx" else {"op": macro, "tag": name})
        elif macro == "delay":
            ops.append({"op": "delay", "frames": self.num(a[0]) & 0xFF})
        elif macro in ("waitforvisualfinish", "blendoff", "restorebg", "waitbgfadeout", "waitbgfadein", "waitsound", "stopsound"):
            ops.append({"op": macro})
        elif macro in ("hang1", "hang2"):
            ops.append({"op": "nop"})
        elif macro == "end":
            ops.append({"op": "end"})
            return True
        elif macro == "return":
            ops.append({"op": "return"})
            return True
        elif macro == "playse":
            ops.append({"op": "playse", "se": self.num(a[0]) & 0xFFFF})
        elif macro in ("monbg", "clearmonbg"):
            ops.append({"op": macro, "battler": self.battlers.get(self.num(a[0]) & 0xFF, "target")})
        elif macro in ("monbg_22", "clearmonbg_23", "monbg_static", "clearmonbg_static"):
            name = "monbg_static" if macro in ("monbg_22", "monbg_static") else "clearmonbg_static"
            ops.append({"op": name, "battler": self.battlers.get(self.num(a[0]) & 0xFF, "target")})
        elif macro in ("setalpha", "setblends"):
            if macro == "setalpha":
                eva, evb = self.num(a[0]) & 0xFF, self.num(a[1]) & 0xFF
            else:
                v = self.num(a[0]) & 0xFFFF
                eva, evb = v % 256, (v // 256) % 256
            ops.append({"op": "setalpha", "eva": eva, "evb": evb})
        elif macro == "call":
            ops.append({"op": "call", "label": self.ref(a[0])})
        elif macro == "goto":
            # the ROM decoder closes a script that ends in a goto with an end
            ops.extend([{"op": "goto", "label": self.ref(a[0])}, {"op": "end"}])
            return True
        elif macro == "setarg":
            arg_id, value = self.num(a[0]) & 0xFF, self.s16(a[1])
            if arg_id < 8:
                self.argstate[arg_id] = value
            ops.append({"op": "setarg", "argId": arg_id, "value": value})
        elif macro == "choosetwoturnanim":
            ops.append({"op": "choosetwoturnanim", "label1": self.ref(a[0]), "label2": self.ref(a[1])})
        elif macro == "jumpifmoveturn":
            ops.append({"op": "jumpifmoveturn", "turn": self.num(a[0]) & 0xFF, "label": self.ref(a[1])})
        elif macro in ("fadetobg", "changebg"):
            ops.append({"op": macro, "bg": self.bg(a[0])})
        elif macro == "playsewithpan":
            ops.append({"op": "playsewithpan", "se": self.num(a[0]) & 0xFFFF, "pan": self.s8(a[1])})
        elif macro == "setpan":
            ops.append({"op": "setpan", "pan": self.s8(a[0])})
        elif macro in ("panse_1B", "panse", "panse_26", "panse_27", "panse_adjustnone", "panse_adjustall"):
            op = {"op": "panse", "se": self.num(a[0]) & 0xFFFF, "pan": self.s8(a[1]), "targetPan": self.s8(a[2]),
                  "step": self.s8(a[3]), "wait": self.num(a[4]) & 0xFF}
            if macro in ("panse_26", "panse_adjustnone"):
                op["mode"] = "adjustnone"
            elif macro in ("panse_27", "panse_adjustall"):
                op["mode"] = "adjustall"
            ops.append(op)
        elif macro == "loopsewithpan":
            ops.append({"op": "loopsewithpan", "se": self.num(a[0]) & 0xFFFF, "pan": self.s8(a[1]),
                        "wait": self.num(a[2]) & 0xFF, "times": self.num(a[3]) & 0xFF})
        elif macro == "waitplaysewithpan":
            ops.append({"op": "waitplaysewithpan", "se": self.num(a[0]) & 0xFFFF, "pan": self.s8(a[1]),
                        "wait": self.num(a[2]) & 0xFF})
        elif macro == "setbldcnt":
            ops.append({"op": "setbldcnt", "value": self.num(a[0]) & 0xFFFF})
        elif macro in ("jumpargeq", "jumpreteq", "jumprettrue", "jumpretfalse"):
            if macro == "jumpargeq":
                arg, val, ptr = self.num(a[0]) & 0xFF, self.s16(a[1]), a[2]
            elif macro == "jumpreteq":
                arg, val, ptr = 7, self.s16(a[0]), a[1]
            else:
                arg, val, ptr = 7, 1 if macro == "jumprettrue" else 0, a[0]
            ops.append({"op": "jumpargeq", "argId": arg, "value": val, "label": self.ref(ptr)})
        elif macro == "jumpifcontest":
            ops.append({"op": "jumpifcontest", "label": self.ref(a[0])})
        elif macro == "fadetobgfromset":
            ops.append({"op": "fadetobgfromset", "bg1": self.bg(a[0]), "bg2": self.bg(a[1]), "bg3": self.bg(a[2])})
        elif macro in ("monbgprio_28", "monbgprio_2A", "splitbgprio", "splitbgprio_foes"):
            op = {"op": "splitbgprio", "battler": self.battlers.get(self.num(a[0]) & 0xFF, "target")}
            if macro in ("monbgprio_2A", "splitbgprio_foes"):
                op["mode"] = "foes"
            ops.append(op)
        elif macro in ("monbgprio_29", "splitbgprio_all"):
            ops.append({"op": "splitbgprio", "battler": "target", "mode": "all"})
        elif macro in ("invisible", "visible"):
            ops.append({"op": macro, "battler": self.battlers.get(self.num(a[0]) & 0xFF, "attacker")})
        elif macro in ("doublebattle_2D", "doublebattle_2E", "teamattack_moveback", "teamattack_movefwd"):
            ops.append({"op": "nop"})  # the decoder emits nop for these too
        else:
            raise Unsupported("macro " + macro)
        return False


def move_labels():
    """move symbol -> its script label, through gBattleAnims_Moves (some
    labels are spelled differently: Move_XSCISSOR, Move_ETERNA_BEAM)"""
    src = open(os.path.join(DONOR, "data/battle_anim_scripts.s")).read()
    table = src[src.index("gBattleAnims_Moves::"):]
    table = re.findall(r"\.4byte (\w+)", table[:table.index("\n\n")])
    ids = {m[1]: int(m[2]) for m in re.finditer(r"#define MOVE_(\w+)\s+(\d+)\b",
                                                open(os.path.join(DONOR, "include/constants/moves.h")).read())}
    return {sym: table[n] for sym, n in ids.items() if n < len(table)}


def convert_moves(symbols, pack=None, conv=None):
    """{symbol: {"ops": [...], "labels": {...}}} and {symbol: reason} for the rest."""
    conv = conv or Converter(pack or load_pack())
    labels_of = move_labels()
    done, skipped = {}, {}
    for sym in symbols:
        if sym in EXCLUDE:
            skipped[sym] = "excluded: " + EXCLUDE[sym]
            continue
        try:
            ops, labels = conv.convert(labels_of.get(sym, "Move_" + sym))
            if sym in NO_BG_FADE_OUT_WAIT:
                for seq in [ops] + list(labels.values()):
                    for op in seq:
                        if op["op"] == "waitbgfadeout":
                            op.clear()
                            op["op"] = "nop"
            done[sym] = {"ops": ops, "labels": labels}
        except Unsupported as x:
            skipped[sym] = str(x)
    return done, skipped


def to_lua(v, ind=""):
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return str(v)
    if isinstance(v, str):
        return json.dumps(v)
    if isinstance(v, list):
        return "{" + ", ".join(to_lua(x, ind) for x in v) + "}"
    inner = ind + "  "
    rows = [f"{inner}[{json.dumps(k)}] = {to_lua(x, inner)}," for k, x in sorted(v.items())]
    return "{\n" + "\n".join(rows) + "\n" + ind + "}"


def generate(symbols):
    """campaign/move_anims.lua: {moves = {SYMBOL = ops}, labels = {...}},
    the skipped moves and why"""
    conv = Converter(load_pack())
    done, skipped = convert_moves(symbols, conv=conv)
    labels, used = {}, set()
    for row in done.values():
        labels.update(row["labels"])
        for seq in [row["ops"]] + list(row["labels"].values()):
            used.update(op["template"] for op in seq or [] if op.get("op") == "createsprite")
    # templates a campaign task creates itself (campaign/anim_code.lua)
    for name in TASK_TEMPLATES:
        conv.new_template(name)
        used.add(name)
    templates = {name: t["entry"] for name, t in conv.new_templates.items() if name in used}
    # donor graphics the converted moves load or draw
    want = set()
    for row in done.values():
        for seq in [row["ops"]] + list(row["labels"].values()):
            for op in seq or []:
                want.update(op[k] for k in ("tag", "palTag") if op.get(k) in conv.new_tags)
    for t in templates.values():
        want.update(x for x in (t.get("tag"), t.get("pal")) if x in conv.new_tags)
    tags, files = {}, {}
    for name in sorted(want):
        size = conv.new_tags[name]
        rgba, ipng, entry = anim_gfx.sheet(name, size.get("w"), size.get("h"))
        entry["file"], entry["idxFile"] = f"anim_tags/{name}.png", f"anim_tags/{name}.idx.png"
        files[entry["file"]], files[entry["idxFile"]] = rgba, ipng
        tags[name] = entry
    bgs = {}
    for row in done.values():
        for seq in [row["ops"]] + list(row["labels"].values()):
            for op in seq or []:
                for k in ("bg", "bg1", "bg2", "bg3"):
                    if op.get(k) in conv.new_bgs and op[k] not in bgs:
                        rgba, ipng, entry = anim_gfx.background(op[k])
                        entry["file"], entry["idxFile"] = f"anim_bgs/{op[k]}.png", f"anim_bgs/{op[k]}.idx.png"
                        files[entry["file"]], files[entry["idxFile"]] = rgba, ipng
                        bgs[op[k]] = entry
    data = {"moves": {sym: row["ops"] for sym, row in done.items()}, "labels": labels, "templates": templates,
            "tags": tags, "bgs": bgs}
    text = ("-- Generated by build_campaign.py (tools/anim_convert.py) from Inclement's\n"
            "-- data/battle_anim_scripts.s: the moves whose animation uses only what the\n"
            "-- vanilla ROM has (templates: donor sprite templates, built from its C, for\n"
            "-- anim_port/g1_templates.lua). The rest keep their stand-in (move_list.lua).\n"
            "return " + to_lua(data) + "\n")
    return text, len(done), skipped, files


def check():
    """Convert vanilla's own moves and compare with the ROM's decoded scripts."""
    pack = load_pack()
    moves_h = open(os.path.join(DONOR, "include/constants/moves.h")).read()
    ids = {m[1]: int(m[2]) for m in re.finditer(r"#define MOVE_(\w+)\s+(\d+)\b", moves_h)}
    vanilla = {sym: n for sym, n in ids.items() if 1 <= n <= 354}
    done, skipped = convert_moves(vanilla, pack)

    def flat(ops, labels, rom):
        """the script with its labels numbered in order of first use, for
        comparing (label keys differ: ROM offsets vs donor names)"""
        table = rom["labels"] if rom else labels
        ids, queue, out = {}, [], []
        def canon(seq):
            res = []
            for op in seq or []:
                op = dict(op)
                op.pop("tag_idx", None)
                for k in ("label", "label1", "label2"):
                    if k in op:
                        lab = op[k]
                        if lab not in ids:
                            ids[lab] = len(ids)
                            queue.append(lab)
                        op[k] = ids[lab]
                res.append(op)
            return res
        out.append(canon(ops))
        while queue:
            out.append(canon(table.get(queue.pop(0))))
        return out
    same, diff = 0, []
    for sym, row in done.items():
        mine = flat(row["ops"], row["labels"], None)
        theirs = flat(pack["moves"].get(str(vanilla[sym])), None, pack)
        if mine == theirs:
            same += 1
        else:
            diff.append(sym)
    print(f"vanilla moves: {len(done)} converted, {same} identical to the ROM, {len(diff)} differ, {len(skipped)} skipped")
    print("differ:", " ".join(sorted(diff)[:40]))
    reasons = {}
    for sym, why in skipped.items():
        reasons.setdefault(why, []).append(sym)
    for why, syms in sorted(reasons.items(), key=lambda kv: -len(kv[1]))[:15]:
        print(f"  skipped {len(syms):3d}: {why}  ({' '.join(syms[:5])})")
    return done, diff, pack, vanilla


if __name__ == "__main__":
    if "--check" in sys.argv:
        check()
