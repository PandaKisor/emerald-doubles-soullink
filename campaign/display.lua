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

  -- OFF, VIVID, LCD; saved for this game
  D.LEVELS = { "OFF", "VIVID", "LCD" }
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
