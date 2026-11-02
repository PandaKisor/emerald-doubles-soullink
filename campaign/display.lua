-- The campaign's look (user, 2026-11-02). Close to the original screens, a
-- little cleaner:
--   * an optional display mode, a shader over the game's picture that never
--     dims it: VIVID boosts colour with a soft glow, LCD adds a pixel grid. F9 or TOOLS > LOOK cycles it,
--     and it's off by default. Purely visual, so linked games needn't match.
--   * a slimmer battle panel, with the scene running down to it
--   * your HP as numbers while you choose in a double, the bar while the turn
--     plays (the same swap START does in Gen 3, made automatic; START still
--     flips it)
return function(mod, active)
  local D = {}
  local SHADER = [[
    extern float grid;      // 0 for VIVID, 1 for LCD
    extern vec2 texel;      // one canvas pixel in texture units
    extern vec2 origin;     // the game's picture starts here, in window pixels
    extern float cell;      // one game pixel, in window pixels
    vec3 grade(vec3 c) {
      float l = dot(c, vec3(0.299, 0.587, 0.114));
      c = mix(vec3(l), c, 1.16);                      // colour, without pushing it neon
      return clamp(c, 0.0, 1.0);
    }
    vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
      vec3 src = Texel(tex, tc).rgb;
      vec3 c = grade(src);
      // a soft glow from the bright parts around this pixel
      vec3 glow = vec3(0.0);
      float r = cell * 1.5;
      for (int i = 0; i < 8; i++) {
        float a = float(i) * 0.7854;
        vec3 s = Texel(tex, tc + vec2(cos(a), sin(a)) * r * texel).rgb;
        glow += max(s - 0.75, vec3(0.0));
      }
      c += glow / 8.0 * 0.12;
      if (grid > 0.5) {
        // each game pixel keeps a thin dark edge, and the rest is lifted to pay for it
        vec2 p = fract((sc - origin) / cell);
        vec2 e = smoothstep(0.0, 0.16, p) * (1.0 - smoothstep(0.84, 1.0, p));
        float m = mix(0.80, 1.0, e.x * e.y);
        c = pow(max(c, vec3(0.0)), vec3(0.92)) * m * 1.05;
      }
      return vec4(clamp(c, 0.0, 1.0), 1.0) * color;
    }
  ]]
  local shader, failed
  -- CINEMATIC: light and weather, not a filter. Clouds drift across the map and
  -- stay put as you walk, water and plants move, highlights bloom, and the sky
  -- follows your clock, down to a dark night with a light around you. It works
  -- from what pixels look like, since the game has no depth. In battles and
  -- menus the moving parts fade out, so text stays clean.
  local CINEMA = [[
    extern vec2 texel;
    extern float cell;
    extern float time;
    extern vec2 world;     // the player, in game pixels
    extern vec2 center;    // the player on screen, in window pixels
    extern float fx;       // world effects: 1 on the field, 0 under menus and battles
    extern float outdoor;
    extern vec3 sky;       // tint of the light
    extern float night;    // 0 day .. 1 night
    extern float gold;     // 0 .. 1 low sun
    float hash(vec2 p) { return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453); }
    float noise(vec2 p) {
      vec2 i = floor(p), f = fract(p);
      f = f * f * (3.0 - 2.0 * f);
      return mix(mix(hash(i), hash(i + vec2(1.0, 0.0)), f.x), mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), f.x), f.y);
    }
    float fbm(vec2 p) {
      float v = 0.0, a = 0.5;
      for (int i = 0; i < 4; i++) { v += a * noise(p); p = p * 2.03 + vec2(13.0, 7.0); a *= 0.5; }
      return v;
    }
    vec3 curve(vec3 c) {                    // a filmic S-curve
      c = (c * (2.51 * c + vec3(0.03))) / (c * (2.43 * c + vec3(0.59)) + vec3(0.14));
      return clamp(c, 0.0, 1.0);
    }
    vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
      vec2 w = sc / cell + world;           // this pixel on the map
      vec3 base = Texel(tex, tc).rgb;
      float out_ = outdoor * fx;
      float isWater = smoothstep(0.06, 0.2, base.b - max(base.r, base.g * 0.92)) * out_;
      float isLeaf = smoothstep(0.05, 0.18, base.g - max(base.r, base.b)) * out_;
      // water ripples and leaves stir
      vec2 uv = tc;
      uv.x += sin(w.y * 0.55 + time * 2.2) * cell * 0.9 * texel.x * isWater;
      uv.y += sin(w.x * 0.33 + time * 1.7) * cell * 0.6 * texel.y * isWater;
      uv.x += sin(w.y * 0.9 + w.x * 0.2 + time * 1.3) * cell * 0.35 * texel.x * isLeaf;
      vec3 c = Texel(tex, uv).rgb;
      // bloom: two rings gathered from the bright parts
      vec3 glow = vec3(0.0);
      for (int i = 0; i < 12; i++) {
        float a = float(i) * 0.5236;
        float r = (mod(float(i), 2.0) < 0.5 ? 2.5 : 5.5) * cell;
        vec3 t = Texel(tex, tc + vec2(cos(a), sin(a)) * r * texel).rgb;
        glow += max(t - 0.72, vec3(0.0));
      }
      glow /= 12.0;
      // saturation and film response
      float l = dot(c, vec3(0.299, 0.587, 0.114));
      c = mix(vec3(l), c, mix(1.10, 1.28, fx));
      c = mix(c, curve(c * 0.95), fx);
      // cloud shadows, moving with the wind and fixed to the map
      float cloud = fbm(w * 0.0065 + vec2(time * 0.018, time * 0.007));
      float shade = smoothstep(0.44, 0.62, cloud);
      c *= mix(1.0, mix(0.70, 0.92, gold), shade * out_ * (1.0 - night));
      // shafts of light where the sun gets through
      float beam = pow(0.5 + 0.5 * sin((w.x + w.y * 0.6) * 0.022 + time * 0.12 + cloud * 5.0), 6.0);
      c += sky * beam * (1.0 - shade) * out_ * (1.0 - night) * (0.10 + gold * 0.18);
      // sun on the water
      float sparkle = pow(noise(w * 0.9 + vec2(time * 1.4, -time)), 9.0);
      c += (sky * 0.8 + vec3(0.2)) * sparkle * isWater * 1.6 * (1.0 - night * 0.6);
      c = mix(c, c * vec3(0.92, 1.0, 1.12), isWater * 0.5);
      // the light itself
      c *= mix(vec3(1.0), sky, mix(0.25, 0.75, fx));
      float lamp = 0.0;
      if (night > 0.0 || outdoor < 0.5) {
        float d = length((sc - center) / cell) / 90.0;
        lamp = exp(-d * d * 2.4);
      }
      if (outdoor > 0.5) {
        c = mix(c, c * (vec3(0.26) + lamp * vec3(1.05, 0.86, 0.60)), night * fx);
        c = mix(c, c * 0.92, night * (1.0 - fx));
      } else {
        c *= mix(vec3(1.0), vec3(0.72) + lamp * vec3(0.46, 0.36, 0.22), fx);
      }
      c += glow * (sky * 0.8 + vec3(0.3)) * (1.1 + night * 2.2) * fx;   // never over text
      return vec4(clamp(c, 0.0, 1.0), 1.0) * color;
    }
  ]]
  local cinema, startedAt

  -- the sky from the clock: tint, night 0..1, low sun 0..1
  function D.skyAt(hour)
    local function ramp(a, b, x) return math.max(0, math.min(1, (x - a) / (b - a))) end
    local night = math.max(1 - ramp(5, 7, hour), ramp(19, 21, hour))
    local gold = math.max(ramp(5, 7, hour) * (1 - ramp(7, 9.5, hour)), ramp(16, 18.5, hour) * (1 - ramp(19.5, 21, hour)))
    local r = 1.0 + gold * 0.20 - night * 0.42
    local g = 1.0 - gold * 0.02 - night * 0.30
    local b = 1.0 - gold * 0.24 + night * 0.06
    return { r, g, b }, night, gold
  end
  function D.hour()
    if D.forceHour then return D.forceHour end
    local t = os.date("*t")
    return t.hour + t.min / 60
  end
  local function fieldState()
    local Hud = package.loaded["src.ui.game3.hud"]
    local busy = Hud and Hud.busy and Hud.busy()
    local outdoor = 1
    pcall(function()
      local Map = require("src.core.game3.map")
      local def = Map.currentDef and Map.currentDef() or Map.def
      local Dataset = require("src.core.game3.dataset")
      if def and def.mapType and not Dataset.isOutdoorMapType(def.mapType) then outdoor = 0 end
    end)
    return busy and 0 or 1, outdoor
  end
  local fxLevel = 0
  local function drawCinema(ctx)
    if not cinema then
      local ok, s = pcall(love.graphics.newShader, CINEMA)
      if not ok then failed = true; mod.log:warn("cinema shader: %s", tostring(s)); return false end
      cinema = s
    end
    local g = love.graphics
    local w, h = ctx.canvas:getPixelDimensions()
    local dx = tonumber(ctx.dpiX) or 1
    local cell = math.max(1, (tonumber(ctx.scale) or 4) * dx)
    local want, outdoor = fieldState()
    fxLevel = fxLevel + (want - fxLevel) * 0.12
    local sky, night, gold = D.skyAt(D.hour())
    local P = package.loaded["src.core.game3.player"] or {}
    local gx, gy = (ctx.gameX or 0) * dx, (ctx.gameY or 0) * dx
    local gw, gh = (ctx.gameWidth or w) * dx, (ctx.gameHeight or h) * dx
    local center = { gx + gw / 2, gy + gh / 2 }
    startedAt = startedAt or love.timer.getTime()
    cinema:send("texel", { 1 / w, 1 / h })
    cinema:send("cell", cell)
    cinema:send("time", (love.timer.getTime() - startedAt) % 3600)
    cinema:send("world", { (tonumber(P.px) or 0) - center[1] / cell, (tonumber(P.py) or 0) - center[2] / cell })
    cinema:send("center", center)
    cinema:send("fx", fxLevel)
    cinema:send("outdoor", outdoor)
    cinema:send("sky", sky)
    cinema:send("night", night)
    cinema:send("gold", gold)
    g.push("all")
    g.setShader(cinema)
    g.setColor(1, 1, 1, 1)
    g.draw(ctx.canvas, 0, 0)
    g.pop()
    return true
  end

  -- OFF, VIVID, LCD; saved for this game
  D.LEVELS = { "OFF", "VIVID", "LCD", "CINEMATIC" }
  D.level = 0
  local game
  local function load()
    if D.loaded or not game then return end
    D.loaded = true
    local ok, v = pcall(mod.storage.read, mod.storage, game, "display")
    if ok and type(v) == "table" then D.level = tonumber(v.level) or 0 end
  end
  function D.set(level)
    D.level = level % #D.LEVELS
    if game then pcall(mod.storage.write, mod.storage, game, "display", { level = D.level }) end
  end

  local function compile()
    if shader or failed then return shader end
    local ok, s = pcall(love.graphics.newShader, SHADER)
    if not ok then failed = true; mod.log:warn("display shader: %s", tostring(s)); return nil end
    shader = s
    return s
  end

  -- render.output: the finished frame comes here, ahead of the HUD
  mod.hooks:wrap("render.output_enabled", function(next, ...)
    if active() and D.level > 0 and not failed then return true end
    return next(...)
  end)
  mod.hooks:wrap("render.output", function(next, ctx)
    if active() and D.level == 3 and ctx and ctx.canvas and drawCinema(ctx) then return true end
    if not (active() and D.level > 0 and ctx and ctx.canvas) or not compile() then return next(ctx) end
    local g = love.graphics
    local w, h = ctx.canvas:getPixelDimensions()
    local dx, dy = tonumber(ctx.dpiX) or 1, tonumber(ctx.dpiY) or 1
    shader:send("grid", D.level >= 2 and 1 or 0)
    shader:send("texel", { 1 / w, 1 / h })
    shader:send("origin", { (ctx.gameX or 0) * dx, (ctx.gameY or 0) * dy })
    shader:send("cell", math.max(1, (tonumber(ctx.scale) or 4) * dx))
    g.push("all")
    g.setShader(shader)
    g.setColor(1, 1, 1, 1)
    g.draw(ctx.canvas, 0, 0)
    g.pop()
    return true
  end)

  mod.hooks:wrap("input.step", function(next, g2, dt)
    next(g2, dt)
    game = g2
    load()
  end)
  mod.hooks:wrap("input.key", function(next, g2, ev)
    if active() and ev and ev.phase == "pressed" and ev.key == "f9" then
      D.set(D.level + 1)
      return true
    end
    return next(g2, ev)
  end)
  mod.hooks:wrap("ui.start_menu.items", function(next, g2, items)
    local out = next(g2, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_look", label = "LOOK: " .. D.LEVELS[D.level + 1], onSelect = function()
      D.set(D.level + 1)
      require("src.ui.game3.start_menu").close(true)
      require("src.ui.game3.message").show("The look is now " .. D.LEVELS[D.level + 1] .. ".")
    end })
    return copy
  end)

  -- move type colours, dark enough to read on the move box
  local function rgb(hex)
    return { math.floor(hex / 65536) / 255, math.floor(hex / 256) % 256 / 255, hex % 256 / 255, 1 }
  end
  local TINT = { 0x6a6a55, 0xa02820, 0x5f4fc0, 0x7f2f8f, 0xa8802a, 0x8a7418, 0x6f8010, 0x4f3f80, 0x60607f, nil,
    0xc8440c, 0x2f5fd0, 0x3f8a2a, 0xb08a00, 0xc02860, 0x3a9090, 0x4a20d0, 0x4a3a30, 0xc04a80 }
  local tints = {}
  for i = 1, 19 do if TINT[i] then tints[i - 1] = rgb(TINT[i]) end end
  require("src.core.game3.battle.ui").TYPE_TINT = tints

  -- A slimmer battle panel: 40 pixels, not 48. The original art with 8 rows cut
  -- from its middle, so its frame keeps its shape and the scene shows beneath.
  local BC = require("src.ui.game3.battle_chrome")
  local SLIM, TOP = 8, 24
  local drawPanel, windowOf, frames = BC.drawPanel, BC.window, BC.menuFrameRects
  local slimQuads = {}
  BC.drawPanel = function(mode, ...)
    if not (active() and BC._textbox and love and love.graphics) then return drawPanel(mode, ...) end
    local scroll = (mode == "menu" and 160) or (mode == "moves" and 320) or 0
    local q = slimQuads[scroll]
    if not q then
      local m = BC._manifest or {}
      local tw, th = m.textboxW or 256, m.textboxH or 512
      local y = 112 + scroll
      if y + 48 > th then y = math.max(0, th - 48) end
      q = { love.graphics.newQuad(0, y, 240, TOP, tw, th),
            love.graphics.newQuad(0, y + TOP + SLIM, 240, 48 - TOP - SLIM, tw, th) }
      slimQuads[scroll] = q
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(BC._textbox, q[1], 0, 112 + SLIM)
    love.graphics.draw(BC._textbox, q[2], 0, 112 + SLIM + TOP)
  end
  -- the art stops where the old panel began, so its last rows run on underneath
  local stripQuads = {}
  local function extendScene(key)
    local entry = BC.terrain(key or "building") or BC.terrain("building") or BC.terrain("grass")
    local img = entry and (entry.bgImage or entry.image)
    if not (active() and img and love and love.graphics) then return end
    local q = stripQuads[img]
    if not q then
      q = love.graphics.newQuad(0, 110, 240, 2, img:getDimensions())
      stripQuads[img] = q
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(img, q, 0, 112, 0, 1, SLIM / 2)
  end
  for _, name in ipairs({ "drawTerrain", "drawCleanBg", "drawPostDexBg" }) do
    local draw = BC[name]
    BC[name] = function(key, ...)
      local r = draw(key, ...)
      extendScene(key)
      return r
    end
  end
  BC.window = function(id, ...)
    local w = windowOf(id, ...)
    if active() and w.y >= 112 then w.y = w.y + 2 end
    return w
  end
  BC.menuFrameRects = function(mode, layout, ...)
    local rects = frames(mode, layout, ...)
    if not (active() and rects) then return rects end
    local out = {}
    for i, r in ipairs(rects) do out[i] = { r[1], r[2] + 1, r[3], r[4] - 1 } end
    return out
  end

  -- the party screen: a link dot on each Pokémon. g3_coop answers with
  -- mod.exports.coopLinkState(mon): "linked", "fallen" or nil
  local DOT = { linked = { 0.25, 0.72, 0.35 }, fallen = { 0.82, 0.22, 0.2 }, none = { 0.55, 0.57, 0.6 } }
  local PartyMenu = require("src.ui.game3.party_menu")
  local partyDraw = PartyMenu.draw
  -- the dot's spot in each slot window: the single layout, and the doubles
  -- one the battle's party screen uses (two big slots on the left)
  local SLOTS = { { 76, 28 }, { 230, 11 }, { 230, 35 }, { 230, 59 }, { 230, 83 }, { 230, 107 } }
  local SLOTS_DOUBLE = { { 76, 12 }, { 76, 68 }, { 230, 11 }, { 230, 43 }, { 230, 75 }, { 230, 107 } }
  -- only while choosing: the action menu, messages and YES/NO sit over the slots
  local DOT_MODES = { list = true, switch = true, use = true, give = true, choose = true,
    choose_multi = true, move_tutor = true }
  PartyMenu.draw = function(...)
    partyDraw(...)
    if not (active() and PartyMenu.open and DOT_MODES[PartyMenu.mode] and game and love and love.graphics) then return end
    local Sm = package.loaded["src.ui.game3.summary_menu"]
    if Sm and Sm.isOpen and Sm.isOpen() then return end
    local ex = game.mods and game.mods.exports and game.mods.exports.g3_coop
    local state = ex and ex.coopLinkState
    local party = PartyMenu._party or (PartyMenu._session and PartyMenu._session.party)
    if not (state and party) then return end
    for i, xy in ipairs(PartyMenu._layout == "double" and SLOTS_DOUBLE or SLOTS) do
      local mon = party[i]
      if mon then
        local c = DOT[state(mon) or "none"]
        love.graphics.setColor(0.1, 0.12, 0.16, 1)
        love.graphics.rectangle("fill", xy[1] - 1, xy[2] - 1, 6, 6)
        love.graphics.setColor(c[1], c[2], c[3], 1)
        love.graphics.rectangle("fill", xy[1], xy[2], 4, 4)
      end
    end
    love.graphics.setColor(1, 1, 1, 1)
  end

  -- the panel is 8 pixels shorter, so your side comes down to meet it: your
  -- health boxes, and the Pokémon whose feet stopped short of the panel
  -- (doubles' right one already stands on it). Animations aim at the same
  -- coordinates, so they follow. The campaign cart only loads this mod.
  do
    local HB = require("src.core.game3.battle.healthbox")
    local AC = require("src.core.game3.battle.anim_coords")
    if not HB._campaignLowered then
      HB._campaignLowered = true
      local function down(p, by) if p then p.y = p.y + by; if p[2] then p[2] = p.y end end end
      down(HB.PLAYER_CENTER, SLIM)
      down(HB.CENTERS[true][0], SLIM)
      down(HB.CENTERS[true][2], SLIM)
      down(AC.SINGLES[0], SLIM)
      down(AC.DOUBLES[0], SLIM)
    end
  end

  local Healthbox = require("src.core.game3.battle.healthbox")
  local shown = Healthbox.hpTextShown
  Healthbox.hpTextShown = function(st, id, ...)
    local base = shown(st, id, ...)
    if not (active() and st and st.double and tonumber(id) and id % 2 == 0) then return base end
    local Ui = require("src.core.game3.battle.ui")
    if Ui._mode == "menu" or Ui._mode == "moves" or Ui._mode == "target" then return not base end
    return base
  end
  return D
end
