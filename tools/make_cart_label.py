#!/usr/bin/env python3
"""The cart's label art (porting/native/cart_label.png): Rayquaza over an
emerald field, Latios and Latias linked in front (the Soul Link pair), and
the title. 1024x520, the launcher's GBA label shape (512x260 at 2x).
Sprites come from pokeemerald-1.13's graphics; build_campaign.py --release
embeds the PNG in the .g1rcart."""
import math, os, random
from PIL import Image, ImageDraw, ImageFilter, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
GFX = os.path.join(HERE, '../../../pokeemerald-1.13/graphics/pokemon')
OUT = os.path.join(HERE, '../cart_label.png')
W, H = 1024, 520
FONT = '/usr/share/fonts/TTF/FiraSans-Heavy.ttf'
FONT2 = '/usr/share/fonts/TTF/FiraSans-ExtraBold.ttf'


def sprite(name, scale, flip=False):
    im = Image.open(os.path.join(GFX, name, 'front.png'))
    # palette index 0 is the transparent colour
    im = im.convert('P')
    rgba = im.convert('RGBA')
    px, src = rgba.load(), im.load()
    for y in range(im.height):
        for x in range(im.width):
            if src[x, y] == 0:
                px[x, y] = (0, 0, 0, 0)
    rgba = rgba.crop(rgba.getbbox())
    if flip:
        rgba = rgba.transpose(Image.FLIP_LEFT_RIGHT)
    return rgba.resize((rgba.width * scale, rgba.height * scale), Image.NEAREST)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def background():
    img = Image.new('RGB', (W, H))
    top, bottom = (24, 160, 92), (14, 62, 96)
    px = img.load()
    for y in range(H):
        for x in range(W):
            t = min(1, max(0, (x * 0.55 + y) / (W * 0.55 + H)))
            px[x, y] = lerp(top, bottom, t)
    # faceted shards, like the stock labels
    rnd = random.Random(3)
    shards = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(shards)
    for _ in range(26):
        cx, cy = rnd.randrange(-100, W + 100), rnd.randrange(-100, H + 100)
        r = rnd.randrange(80, 260)
        pts = [(cx + r * math.cos(a), cy + r * math.sin(a))
               for a in sorted(rnd.uniform(0, math.tau) for _ in range(3))]
        shade = rnd.choice([(255, 255, 255, rnd.randrange(10, 34)), (0, 30, 40, rnd.randrange(18, 46))])
        d.polygon(pts, fill=shade)
    return Image.alpha_composite(img.convert('RGBA'), shards)


def glow(img, sprite_img, pos, color, radius):
    mask = Image.new('L', img.size, 0)
    mask.paste(sprite_img.getchannel('A'), pos)
    mask = mask.filter(ImageFilter.GaussianBlur(radius))
    layer = Image.new('RGBA', img.size, color + (0,))
    layer.putalpha(mask.point(lambda v: min(255, v * 2)))
    return Image.alpha_composite(img, layer)


def outlined(draw, xy, text, font, fill, stroke, width):
    draw.text(xy, text, font=font, fill=fill, stroke_width=width, stroke_fill=stroke)


def link(draw, cx, cy, s, color, edge):
    # two interlocked rounded links, tilted
    for dx, dy in ((-s * 0.55, -s * 0.18), (s * 0.55, s * 0.18)):
        box = [cx + dx - s * 0.8, cy + dy - s * 0.42, cx + dx + s * 0.8, cy + dy + s * 0.42]
        draw.rounded_rectangle(box, radius=s * 0.42, outline=edge, width=int(s * 0.36))
        draw.rounded_rectangle(box, radius=s * 0.42, outline=color, width=int(s * 0.22))


def main():
    img = background()

    ray = sprite('rayquaza', 7, flip=True)
    rpos = (W - ray.width + 40, -40)
    img = glow(img, ray, rpos, (120, 255, 190), 26)
    shadow = Image.new('RGBA', ray.size, (0, 0, 0, 0))
    shadow.putalpha(ray.getchannel('A').point(lambda v: 90 if v else 0))
    img.alpha_composite(shadow, (rpos[0] + 10, rpos[1] + 12))
    img.alpha_composite(ray, rpos)

    # Latios (left) and Latias (right) facing each other, linked
    los = sprite('latios', 4, flip=True)
    las = sprite('latias', 4)
    base = H - 22
    lpos = (40, base - los.height)
    apos = (40 + los.width + 150, base - las.height)
    img = glow(img, los, lpos, (150, 200, 255), 12)
    img = glow(img, las, apos, (255, 170, 190), 12)
    img.alpha_composite(los, lpos)
    img.alpha_composite(las, apos)
    d = ImageDraw.Draw(img)
    link(d, lpos[0] + los.width + 75, base - 130, 46, (255, 214, 64), (36, 52, 40))

    title = ImageFont.truetype(FONT, 132)
    sub = ImageFont.truetype(FONT2, 46)
    outlined(d, (44, 22), 'EMERALD', title, (255, 255, 255), (16, 70, 46), 10)
    outlined(d, (52, 168), 'DOUBLES', sub, (255, 214, 64), (36, 52, 40), 6)
    sw = d.textlength('DOUBLES ', font=sub)
    d.ellipse([52 + sw - 4, 192, 52 + sw + 10, 206], fill=(255, 255, 255), outline=(36, 52, 40), width=3)
    outlined(d, (52 + sw + 26, 168), 'SOUL LINK', sub, (255, 214, 64), (36, 52, 40), 6)

    img.convert('RGB').save(OUT, optimize=True)
    print(OUT, os.path.getsize(OUT), 'bytes')


main()
