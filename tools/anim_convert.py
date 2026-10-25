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
        self.raw = {"TRUE": "1", "FALSE": "0"}
        for h in HEADERS:
            path = os.path.join(DONOR, "include/constants", h)
            if not os.path.exists(path):
                continue
            # both comment kinds in one pass: a "//" comment may hold "/*"
            text = re.sub(r"//[^\n]*|/\*.*?\*/", "", open(path).read(), flags=re.S)
            text = text.replace("\\\n", " ")
            for m in re.finditer(r"^\s*#define\s+(\w+)(\([^)]*\))?\s+(.+?)\s*(?://.*)?$", text, re.M):
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


class Converter:
    def __init__(self, pack):
        self.pack = pack
        self.c = Consts()
        self.blocks, self.order = parse_script_file()
        self.index = {name: i for i, name in enumerate(self.order)}
        self.tag_names = vanilla_tag_names()
        self.known_tags = set(pack["tags"])
        self.known_tasks = set(pack["tasks"])
        self.templates = pack["templates"]
        self.battlers = battler_names()
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
        raise Unsupported("graphics " + name)

    def task(self, name):
        n = name[len("AnimTask_"):] if name.startswith("AnimTask_") else name
        if n not in self.known_tasks:
            raise Unsupported("task " + name)
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
        ops = self.run(label)
        return ops, self.labels

    def ref(self, label):
        key = "cv:" + label
        if key not in self.labels:
            self.labels[key] = None
            self.labels[key] = self.run(label)
        return key

    def check_args(self, key, args):
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
            info = self.templates.get(tmpl)
            if not info:
                raise Unsupported("template " + tmpl)
            if macro == "createsprite":
                battler = self.num(a[1])
                byte = (0x80 if battler == 1 else 0) | (self.num(a[2]) & 0x7F)
                args = [self.s16(x) for x in a[3:]]
            else:
                byte = self.num(a[1]) & 0xFF
                args = [self.s16(x) for x in a[3:3 + self.num(a[2])]]
            op = {"op": "createsprite", "template": tmpl, "animBattler": "target" if byte >= 0x80 else "attacker",
                  "subpriority": byte % 0x80, "args": args, "w": info.get("w", 32), "h": info.get("h", 32)}
            self.check_args(tmpl, args)
            for k in ("tag", "palTag", "callback", "noGfx"):
                if info.get(k) is not None:
                    op[k] = info[k]
            ops.append(op)
        elif macro in ("createvisualtask", "launchtask"):
            if macro == "createvisualtask":
                pri, args = self.num(a[1]), [self.s16(x) for x in a[2:]]
            else:
                pri, args = self.num(a[1]), [self.s16(x) for x in a[3:3 + self.num(a[2])]]
            name = self.task(a[0])
            self.check_args(name, args)
            ops.append({"op": "createvisualtask", "task": name, "priority": pri, "args": args})
        elif macro == "createsoundtask":
            name, args = self.task(a[0]), [self.s16(x) for x in a[1:]]
            self.check_args(name, args)
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
            ops.append({"op": "setarg", "argId": self.num(a[0]) & 0xFF, "value": self.s16(a[1])})
        elif macro == "choosetwoturnanim":
            ops.append({"op": "choosetwoturnanim", "label1": self.ref(a[0]), "label2": self.ref(a[1])})
        elif macro == "jumpifmoveturn":
            ops.append({"op": "jumpifmoveturn", "turn": self.num(a[0]) & 0xFF, "label": self.ref(a[1])})
        elif macro in ("fadetobg", "changebg"):
            ops.append({"op": macro, "bg": self.num(a[0]) & 0xFF})
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
            ops.append({"op": "fadetobgfromset", "bg1": self.num(a[0]) & 0xFF, "bg2": self.num(a[1]) & 0xFF,
                        "bg3": self.num(a[2]) & 0xFF})
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


def convert_moves(symbols, pack=None):
    """{symbol: {"ops": [...], "labels": {...}}} and {symbol: reason} for the rest."""
    conv = Converter(pack or load_pack())
    labels_of = move_labels()
    done, skipped = {}, {}
    for sym in symbols:
        try:
            ops, labels = conv.convert(labels_of.get(sym, "Move_" + sym))
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
    done, skipped = convert_moves(symbols)
    labels = {}
    for row in done.values():
        labels.update(row["labels"])
    data = {"moves": {sym: row["ops"] for sym, row in done.items()}, "labels": labels}
    text = ("-- Generated by build_campaign.py (tools/anim_convert.py) from Inclement's\n"
            "-- data/battle_anim_scripts.s: the moves whose animation uses only what the\n"
            "-- vanilla ROM has. The rest keep their stand-in (campaign/move_list.lua).\n"
            "return " + to_lua(data) + "\n")
    return text, len(done), skipped


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
