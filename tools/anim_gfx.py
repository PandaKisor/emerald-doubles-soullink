#!/usr/bin/env python3
"""Battle animation sprite sheets for graphics tags vanilla Emerald doesn't
have, from the donor's source art (pokeemerald-1.13 graphics/battle_anims/
sprites), laid out as src/import/gba/battle_anim_extract.lua writes the ROM's:
the 4bpp tiles (gbagfx order: 8x8 tiles row-major, composite sheets
concatenated) re-tiled at the sheet's frame width, an RGBA sheet (index 0
transparent) and an index sheet (grey = index * 17), plus the tag entry
(file, idxFile, pal as BGR555 ints, w, h, frameW, frameH).

    python3 tools/anim_gfx.py --check   # rebuilds vanilla's sheets and compares them with the ROM's
"""
import io, os, re, sys

from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
GEN3 = os.path.normpath(os.path.join(HERE, "../../.."))
DONOR = os.path.join(GEN3, "pokeemerald-1.13")
CACHE_TAGS = os.path.join(GEN3, "porting/full_port/generated/playtest/userdata/love/inclement-playtest/emerald"
                          "/data/generated/gba/pokemon/battle_anims")


class Unsupported(Exception):
    pass


def _tables():
    src = open(os.path.join(DONOR, "src/battle_anim.c")).read()
    pics = re.findall(r"\{(gBattleAnimSpriteGfx_\w+),\s*[^,]+,\s*ANIM_TAG_(\w+)\}",
                      src[src.index("gBattleAnimPicTable[]"):src.index("gBattleAnimPaletteTable[]")])
    pals = re.findall(r"\{(gBattleAnimSpritePal_\w+),\s*ANIM_TAG_(\w+)\}", src[src.index("gBattleAnimPaletteTable[]"):])
    gfx = dict(re.findall(r"const u\d+ (\w+)\[\]\s*=\s*INCBIN_U\d+\(\"([^\"]+)\"\)",
                          open(os.path.join(DONOR, "src/graphics.c")).read()))
    rules = open(os.path.join(DONOR, "graphics_file_rules.mk")).read().replace("\\\n", " ")
    parts = {}
    for m in re.finditer(r"\$\(BTLANMSPRGFXDIR\)/(\w+)\.4bpp:\s*((?:\$\(BTLANMSPRGFXDIR\)/\w+\.4bpp\s*)+)\n\s*@?cat", rules):
        parts[m[1]] = re.findall(r"/(\w+)\.4bpp", m[2])
    return ({tag: sym for sym, tag in pics}, {tag: sym for sym, tag in pals}, gfx, parts)


PIC_OF, PAL_OF, GFX, PARTS = _tables()
SPRITES = os.path.join(DONOR, "graphics/battle_anims/sprites")


def _base(sym):
    path = GFX.get(sym)
    if not path:
        raise Unsupported("no file for " + sym)
    return os.path.join(DONOR, re.sub(r"\.(4bpp|gbapal)(\.lz)?$", "", path))


def tiles_of(tag):
    """the sheet's 4bpp tiles as lists of 64 palette indices, in ROM order"""
    sym = PIC_OF.get(tag)
    if not sym:
        raise Unsupported("no pic for tag " + tag)
    base = _base(sym)
    name = os.path.basename(base)
    files = [os.path.join(os.path.dirname(base), p + ".png") for p in PARTS.get(name, [name])]
    tiles = []
    for f in files:
        if not os.path.exists(f):
            raise Unsupported("missing " + f)
        im = Image.open(f)
        if im.mode != "P":
            raise Unsupported(f"{f} is {im.mode}, not indexed")
        w, h = im.size
        px = im.load()
        for ty in range(h // 8):
            for tx in range(w // 8):
                tiles.append([px[tx * 8 + x, ty * 8 + y] & 0xF for y in range(8) for x in range(8)])
    return tiles


def palette_of(tag):
    """16 BGR555 colours, as gbagfx makes the .gbapal (a .pal file, else the PNG's)"""
    sym = PAL_OF.get(tag)
    if not sym:
        raise Unsupported("no palette for tag " + tag)
    base = _base(sym)
    if os.path.exists(base + ".pal"):
        lines = open(base + ".pal").read().split()
        n = int(lines[2])
        rgb = [tuple(int(v) for v in lines[3 + i * 3:6 + i * 3]) for i in range(n)]
    else:
        im = Image.open(base + ".png")
        flat = im.getpalette() or []
        rgb = [tuple(flat[i * 3:i * 3 + 3]) for i in range(len(flat) // 3)]
    rgb = (rgb + [(0, 0, 0)] * 16)[:16]
    return [(r >> 3) | ((g >> 3) << 5) | ((b >> 3) << 10) for r, g, b in rgb]


def sheet(tag, frame_w=None, frame_h=None):
    """(rgba PNG bytes, index PNG bytes, tag entry) laid out as the extractor does"""
    tiles = tiles_of(tag)
    pal = palette_of(tag)
    count = len(tiles)
    if count == 0:
        raise Unsupported("empty sheet " + tag)
    best = max(1, frame_w // 8) if frame_w else None
    if not best:
        best = 4
        for w in (1, 2, 4, 8, 16):
            if w * w <= count:
                best = w
    img_w, img_h = best * 8, -(-count // best) * 8
    colours = [((v & 31) * 8, ((v >> 5) & 31) * 8, ((v >> 10) & 31) * 8, 0 if i == 0 else 255) for i, v in enumerate(pal)]
    rgba = Image.new("RGBA", (img_w, img_h), (0, 0, 0, 0))
    idx = Image.new("RGBA", (img_w, img_h), (0, 0, 0, 255))
    rp, ip = rgba.load(), idx.load()
    for ti, tile in enumerate(tiles):
        ox, oy = (ti % best) * 8, (ti // best) * 8
        for i, c in enumerate(tile):
            x, y = ox + i % 8, oy + i // 8
            rp[x, y] = colours[c]
            ip[x, y] = (c * 17, c * 17, c * 17, 255)
    out = []
    for im in (rgba, idx):
        buf = io.BytesIO()
        im.save(buf, "PNG")
        out.append(buf.getvalue())
    entry = {"pal": pal, "w": img_w, "h": img_h, "frameW": frame_w or best * 8, "frameH": frame_h or best * 8}
    return out[0], out[1], entry


def check():
    """Rebuild vanilla's sheets from the donor art and compare with the ROM's."""
    import json, subprocess
    sys.path.insert(0, HERE)
    import anim_convert
    pack = subprocess.run(["luajit", "-e", f"""
      local p = dofile({json.dumps(os.path.join(CACHE_TAGS, 'pack.lua'))})
      for name, t in pairs(p.tags) do print(name, t.w, t.frameW or 0, t.frameH or 0) end"""],
        check=True, capture_output=True, text=True).stdout.split("\n")
    same, diff, skipped = 0, [], {}
    for line in pack:
        if not line.strip():
            continue
        name, w, fw, fh = line.split("\t")
        try:
            rgba, ipng, entry = sheet(name, int(fw) or None, int(fh) or None)
        except Unsupported as x:
            skipped[name] = str(x)
            continue
        mine = Image.open(io.BytesIO(rgba)).convert("RGBA")
        rom = Image.open(os.path.join(CACHE_TAGS, "tags", name + ".png")).convert("RGBA")
        def norm(im):
            # transparent pixels compare equal whatever their colour
            return [p if p[3] else (0, 0, 0, 0) for p in im.get_flattened_data()]
        if mine.size == rom.size and norm(mine) == norm(rom):
            same += 1
        else:
            diff.append(f"{name} {mine.size} vs {rom.size}")
    print(f"vanilla sheets: {same} identical to the ROM, {len(diff)} differ, {len(skipped)} skipped")
    for d in diff[:15]:
        print("  differ:", d)
    for k, v in list(skipped.items())[:8]:
        print("  skipped:", k, v)


if __name__ == "__main__":
    if "--check" in sys.argv:
        check()
