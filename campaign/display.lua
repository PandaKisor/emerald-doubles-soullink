-- The campaign's look (user, 2026-11-02). Close to the original screens, a
-- little cleaner:
--   * an optional display mode, a shader over the finished frame: SOFT lifts
--     colour and depth, LCD adds a faint pixel grid. F9 or TOOLS > LOOK cycles it,
--     and it's off by default. Purely visual, so linked games needn't match.
--   * your HP as numbers while you choose in a double, the bar while the turn
--     plays (the same swap START does in Gen 3, made automatic; START still
--     flips it)
return function(mod, active)
  local D = {}
  local SHADER = [[
    extern float grid;
    extern vec2 size;
    extern float cell;
    vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
      vec3 c = Texel(tex, tc).rgb;
      float l = dot(c, vec3(0.299, 0.587, 0.114));
      c = mix(vec3(l), c, 1.12);                        // a little more colour
      c = pow(max(c, vec3(0.0)), vec3(0.94));           // lift the shadows
      c = (c - 0.5) * 1.05 + 0.5;
      vec2 p = (tc * size) / cell;
      vec2 f = abs(fract(p) - 0.5) * 2.0;
      float line = smoothstep(0.72, 1.0, max(f.x, f.y));
      c *= 1.0 - grid * line;
      vec2 v = tc - 0.5;
      c *= 1.0 - dot(v, v) * 0.22;                      // the faintest vignette
      return vec4(clamp(c, 0.0, 1.0), 1.0) * color;
    }
  ]]
  local shader, failed

  -- OFF, SOFT, LCD; saved for this game
  D.LEVELS = { "OFF", "SOFT", "LCD" }
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
    local w, h = ctx.canvas:getDimensions()
    shader:send("grid", D.level >= 2 and 0.10 or 0)
    shader:send("size", { w, h })
    shader:send("cell", math.max(2, tonumber(ctx.scale) or 4))
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
