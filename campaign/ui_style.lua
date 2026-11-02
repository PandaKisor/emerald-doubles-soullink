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
    -- a submenu's line about it (CO-OP's connection, TEAMS' question), in a
    -- window beside the list
    local info = StartMenu._g3info
    if type(info) == "string" and info ~= "" then
      local maxW = x - 2 * S.EDGE - 14
      local lines = {}
      for para in (info .. "\n"):gmatch("(.-)\n") do
        local line = ""
        for word in para:gmatch("%S+") do
          local try = line == "" and word or (line .. " " .. word)
          if line ~= "" and (FrlgFont.measure(try, { small = true }) or 0) > maxW - PAD * 2 then
            lines[#lines + 1] = line
            line = word
          else
            line = try
          end
        end
        lines[#lines + 1] = line
      end
      local iw = 0
      for _, l in ipairs(lines) do iw = math.max(iw, FrlgFont.measure(l, { small = true }) or 0) end
      iw = math.min(maxW, iw + PAD * 2 + 2)
      local ih = #lines * PITCH + PAD * 2 - 1
      local ix = x - S.EDGE * 2 - 4 - iw
      S.framePx(ix, y, iw, ih)
      for i, l in ipairs(lines) do
        FrlgFont.draw(l, ix + PAD + 1, y + PAD - 1 + (i - 1) * PITCH, { small = true, colors = FrlgFont.COLOR.NORMAL })
      end
    end
    love.graphics.setColor(1, 1, 1, 1)
  end

  -- --------------------------------------------------------------- Options
  -- Emerald's own colours stay; the shared frames, and a soft bar on the
  -- chosen row in place of dimming every other row
  local okO, RseOpt = pcall(require, "src.ui.game3.rse.option_menu")
  local okK, Kit = pcall(require, "src.ui.game3.rse.scene_kit")
  if okO and okK and RseOpt.draw then
    local optDraw = RseOpt.draw
    RseOpt.draw = function(...)
      local st = RseOpt._st
      local p = st and st.pages and st.pages[#st.pages]
      local fx = package.loaded["src.ui.game3.shaderfx_menu"]
      if not (active() and p) or (fx and fx.isOpen and fx.isOpen()) then return optDraw(...) end
      local g = love.graphics
      local setColor, userFrame, frames = g.setColor, Kit.userFrame, 0
      g.setColor = function(r, gg, b, a, ...)
        if r == 0 and gg == 0 and b == 0 and a == 4 / 16 then return setColor(0, 0, 0, 0) end
        return setColor(r, gg, b, a, ...)
      end
      Kit.userFrame = function(tx, ty, tw, th, ft, fill)
        userFrame(tx, ty, tw, th, ft, fill)
        frames = frames + 1
        if frames == 2 then
          local y = ty * 8 + (p.index - p.scroll - 1) * 16
          rounded(C.soft, tx * 8, y, tw * 8, 16, 1)
          rect(C.accent, tx * 8, y + 1, 2, 14)
          setColor(1, 1, 1, 1)
        end
      end
      local ok, err = pcall(optDraw, ...)
      g.setColor, Kit.userFrame = setColor, userFrame
      if not ok then error(err, 0) end
    end
  end

  -- --------------------------------------------------------------- Summary
  -- the stats page marks what the nature raises (red) and lowers (blue)
  local okS, RseSum = pcall(require, "src.ui.game3.rse.summary_menu")
  if okS and okK and RseSum.draw then
    local sumDraw = RseSum.draw
    local SummaryData = require("src.core.game3.summary_data")
    -- nature order: Atk, Def, Spe, SpA, SpD -> { window, row }
    local AT = { { 10, 2 }, { 10, 3 }, { 11, 3 }, { 11, 1 }, { 11, 2 } }
    local function mark(m, which, up)
      local at = AT[which + 1]
      local w = m.windows and m.windows[at[1] + 1]
      if not w then return end
      local cw = at[1] == 10 and 48 or 40
      local x, y = w.left * 8, w.top * 8 + (at[2] - 1) * 16
      local c = up and { 0.86, 0.2, 0.18 } or { 0.2, 0.4, 0.86 }
      rect({ c[1], c[2], c[3], 0.22 }, x, y, cw, 16)
      local ax, ay = x + cw + 1, y + 6
      for i = 0, 2 do
        local row = up and i or (2 - i)
        rect({ c[1], c[2], c[3], 1 }, ax + 2 - i, ay + row, 1 + i * 2, 1)
      end
    end
    RseSum.draw = function(Sm, ...)
      sumDraw(Sm, ...)
      if not active() then return end
      Sm = Sm or require("src.ui.game3.summary_menu")
      local okP, page, egg = pcall(RseSum.page, Sm)
      if not (okP and page == 1 and not egg and Sm.open) then return end
      local mon = Sm._party and Sm._party[Sm._cursor]
      local m = Kit.manifest(RseSum.SUB)
      local okN, n = pcall(SummaryData.nature, mon)
      n = okN and tonumber(n)
      if not (m and n) then return end
      local up, down = math.floor(n / 5), n % 5
      if up == down then return end
      mark(m, up, true)
      mark(m, down, false)
      love.graphics.setColor(1, 1, 1, 1)
    end
  end

  mod.exports.uiColors = C
  mod.exports.uiFrame = S.framePx
  return S
end
