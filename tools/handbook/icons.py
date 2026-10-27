#!/usr/bin/env python3
"""Party icons for the field guide: one PNG sheet (first frame of each species'
icon, its real icon palette) plus a species-id -> cell index, from the donor's
pokemon_icon.c tables and graphics/pokemon/*/icon.png."""
import base64
import io
import re
from pathlib import Path

from PIL import Image

GEN3 = Path(__file__).resolve().parents[4]
DONOR = GEN3 / 'pokeemerald-1.13'
CELL, COLUMNS = 32, 40


def tables():
    src = (DONOR / 'src/pokemon_icon.c').read_text()
    gfx = (DONOR / 'src/data/graphics/pokemon.h').read_text()
    paths = dict(re.findall(r'const u8 (gMonIcon_\w+)\[\] = INCBIN_U8\(\s*"([^"]+)\.4bpp"\)', gfx))
    icon_table = src[src.index('const u8 *const gMonIconTable[]'):]
    icon_table = icon_table[:icon_table.index('};')]
    icons = dict(re.findall(r'\[(SPECIES_\w+)\]\s*=\s*(gMonIcon_\w+)', icon_table))
    pal_table = src[src.index('const u8 gMonIconPaletteIndices[]'):]
    pal_table = pal_table[:pal_table.index('};')]
    pals = {k: int(v) for k, v in re.findall(r'\[(SPECIES_\w+)\]\s*=\s*(\d+)', pal_table)}
    return icons, paths, pals


def palette(index):
    lines = (DONOR / f'graphics/pokemon/icon_palettes/pal{index}.pal').read_text().split('\n')[3:19]
    return [tuple(int(x) for x in line.split()) for line in lines]


def build(species):
    """species: {id: symbol}. Returns {'sheet': data URI, 'cell', 'columns', 'index': {id: n}}."""
    icons, paths, pals = tables()
    pal_cache = {}
    cells, index = [], {}
    for sid, symbol in sorted(species.items(), key=lambda kv: int(kv[0])):
        name = icons.get(symbol)
        path = name and paths.get(name)
        if not path or not (DONOR / (path + '.png')).exists():
            continue
        img = Image.open(DONOR / (path + '.png'))
        frame = img.crop((0, 0, CELL, CELL))
        p = pal_cache.setdefault(pals.get(symbol, 0), palette(pals.get(symbol, 0)))
        rgba = Image.new('RGBA', (CELL, CELL))
        px = frame.load()
        out = rgba.load()
        for y in range(CELL):
            for x in range(CELL):
                c = px[x, y]
                if c:
                    out[x, y] = p[c] + (255,)
        index[str(sid)] = len(cells)
        cells.append(rgba)
    rows = (len(cells) + COLUMNS - 1) // COLUMNS
    sheet = Image.new('RGBA', (COLUMNS * CELL, rows * CELL))
    for n, cell in enumerate(cells):
        sheet.paste(cell, ((n % COLUMNS) * CELL, (n // COLUMNS) * CELL))
    buf = io.BytesIO()
    sheet.save(buf, 'PNG', optimize=True)
    return {'sheet': 'data:image/png;base64,' + base64.b64encode(buf.getvalue()).decode(),
            'cell': CELL, 'columns': COLUMNS, 'index': index}
