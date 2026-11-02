-- The campaign's window style (user, 2026-11-02): the original shapes, smaller
-- where possible, a little more modern.
--   * one frame for every window the engine draws with the shared helpers
--     (message box, Start menu, YES/NO, shops, save, PC menus, party prompts
--     and the rest): a rounded box with a dark edge, a thin Emerald-green
--     inner line and a clean paper fill. It sits 4 pixels outside the text,
--     where the old tile frames took 8, so every window is a little smaller.
--   * the Start menu shows every entry at once in the small font, with a
--     soft bar behind the choice, so nothing scrolls.
-- Screens with their own art (summary, bag, Pokédex...) keep it; their own
-- passes come after. Purely visual, so linked games needn't match.
return function(mod, active)
  local S = {}
  local function hex(h, a)
    return { math.floor(h / 65536) / 255, math.floor(h / 256) % 256 / 255, h % 256 / 255, a or 1 }
  end
  -- the palette, shared with display.lua and co-op's panels through mod.exports
  S.COLORS = {
    ink = hex(0x2a323c),     -- frame edge
    accent = hex(0x46b89c),  -- Emerald green inner line
    soft = hex(0xd8efe8),    -- the chosen row
    paper = hex(0xfbfbf7),   -- window fill
    shade = hex(0x2a323c, 0.18),
  }
  local C = S.COLORS
  S.EDGE = 4 -- pixels of frame outside the content

  local function rect(c, x, y, w, h)
    love.graphics.setColor(c[1], c[2], c[3], c[4] or 1)
    love.graphics.rectangle("fill", x, y, w, h)
  end
  -- a box with its corner pixels cut, so it reads as rounded at any scale
  local function rounded(c, x, y, w, h, cut)
    rect(c, x + cut, y, w - 2 * cut, h)
    rect(c, x, y + cut, cut, h - 2 * cut)
    rect(c, x + w - cut, y + cut, cut, h - 2 * cut)
    if cut > 1 then
      rect(c, x + 1, y + 1, cut - 1, cut - 1)
      rect(c, x + w - cut, y + 1, cut - 1, cut - 1)
      rect(c, x + 1, y + h - cut, cut - 1, cut - 1)
      rect(c, x + w - cut, y + h - cut, cut - 1, cut - 1)
    end
  end

  --- The frame around a content rectangle in pixels.
  function S.framePx(x, y, w, h)
    local e = S.EDGE
    local g = love.graphics
    local r, gg, b, a = g.getColor()
    rounded(C.shade, x - e + 1, y - e + 2, w + 2 * e, h + 2 * e, 2) -- a faint drop shadow
    rounded(C.ink, x - e, y - e, w + 2 * e, h + 2 * e, 2)
    rounded(C.accent, x - e + 1, y - e + 1, w + 2 * e - 2, h + 2 * e - 2, 2)
    rect(C.paper, x - e + 2, y - e + 2, w + 2 * e - 4, h + 2 * e - 4)
    g.setColor(r, gg, b, a)
    g.setColor(1, 1, 1, 1)
  end
  function S.frame(tx, ty, tw, th) S.framePx(tx * 8, ty * 8, tw * 8, th * 8) end

  local Chrome = require("src.ui.game3.chrome")
  local base = {
    std = Chrome.stdFrame, user = Chrome.userFrame, fixed = Chrome.fixedStdFrame,
    dialogue = Chrome.dialogueFrame,
  }
  Chrome.stdFrame = function(tx, ty, tw, th, ...)
    if not active() then return base.std(tx, ty, tw, th, ...) end
    S.frame(tx, ty, tw, th)
  end
  Chrome.fixedStdFrame = function(tx, ty, tw, th, ...)
    if not active() then return base.fixed(tx, ty, tw, th, ...) end
    S.frame(tx, ty, tw, th)
  end
  Chrome.userFrame = function(ft, tx, ty, tw, th, ...)
    if not active() then return base.user(ft, tx, ty, tw, th, ...) end
    S.frame(tx, ty, tw, th)
  end
  -- the message box keeps its place and size: two lines of this font need it
  Chrome.dialogueFrame = function(...)
    if not active() then return base.dialogue(...) end
    local L, Top, W, H = Chrome.dialogueWindow()
    S.framePx(L * 8 - 4, Top * 8 - 2, W * 8 + 8, H * 8 + 4)
  end

  -- ------------------------------------------------------------ Start menu
  local StartMenu = require("src.ui.game3.start_menu")
  local FrlgFont = require("src.ui.game3.frlg_font")
  local Window = require("src.ui.game3.window")
  local startDraw = StartMenu.draw
  local PITCH, PAD = 13, 3
  S.START_ROWS = 10
  StartMenu.draw = function(...)
    if not (active() and StartMenu.open) or StartMenu._confirmExit then return startDraw(...) end
    local d = StartMenu._data
    if d and d.extraWindow and StartMenu._ctx and d.extraWindow(StartMenu._kind, StartMenu._ctx) then
      return startDraw(...) -- Safari and Pyramid menus show a second window
    end
    local entries = StartMenu.ENTRIES
    local n = #entries
    if n == 0 then return startDraw(...) end
    local rows = math.min(n, S.START_ROWS)
    local first = 0
    if n > rows then first = math.max(0, math.min(n - rows, StartMenu.cursor - math.ceil(rows / 2))) end
    local width = 0
    for _, e in ipairs(entries) do
      width = math.max(width, FrlgFont.measure(tostring(e.label or ""), { small = true }) or 0)
    end
    local w = math.min(96, width + 10 + PAD * 2)
    local h = rows * PITCH + PAD * 2 - 1
    local x = 240 - w - S.EDGE - 3
    local y = S.EDGE + 3
    S.framePx(x, y, w, h)
    for r = 1, rows do
      local i = first + r
      local e = entries[i]
      local ry = y + PAD + (r - 1) * PITCH
      if i == StartMenu.cursor then
        rounded(C.soft, x + 1, ry - 1, w - 2, PITCH, 1)
        rect(C.accent, x + 1, ry, 2, PITCH - 2)
        love.graphics.setColor(1, 1, 1, 1)
      end
      FrlgFont.draw(tostring(e.label or ""), x + PAD + 7, ry - 1, { small = true, colors = FrlgFont.COLOR.NORMAL, maxWidth = w - 10 })
    end
    -- arrows when a long list runs past the window
    if first > 0 then rect(C.accent, x + w / 2 - 3, y - 2, 6, 1); rect(C.accent, x + w / 2 - 2, y - 3, 4, 1) end
    if first + rows < n then rect(C.accent, x + w / 2 - 3, y + h + 1, 6, 1); rect(C.accent, x + w / 2 - 2, y + h + 2, 4, 1) end
    love.graphics.setColor(1, 1, 1, 1)
  end

  mod.exports.uiColors = C
  mod.exports.uiFrame = S.framePx
  return S
end
