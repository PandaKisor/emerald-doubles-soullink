-- The campaign's own name in the game (user, 2026-10-31): a subtitle on the
-- title screen once the logo has settled, a few lines from Birch before his
-- "are you ready?", and credit pages after the ROM's. The ROM's own text stays:
-- Birch's lines go in front of it, the pages after it.
return function(mod, active)
  local FrlgFont = require("src.ui.game3.frlg_font")
  local TextIR = require("src.core.game3.scripting.text_ir")
  local RomText = require("src.core.game3.rom_text")
  local Title = require("src.ui.game3.rse.title_rse")
  local Birch = require("src.ui.game3.rse.birch_speech")
  local Credits = require("src.ui.game3.rse.credits")
  local I = {}

  I.SUBTITLE = "DOUBLES SOUL LINK"
  I.SUBTITLE_Y = 84
  I.BIRCH_KEY = "gText_Birch_AreYouReady"
  I.BIRCH_LINES = "Out here, nobody battles alone.\nEvery fight is a double.\f"
    .. "Bring a partner, and look after\neach other. Bonds run deep here.\f"
  I.PAGES = {
    { "", "EMERALD DOUBLES SOUL LINK", "Campaign, Co-op and Soul Link", "Aeryk Kisor", "" },
    { "", "Added POKéMON, Moves and Items", "Adapted from Inclement Emerald", "Buffel Saft and contributors", "" },
    { "", "Runs on", "Gen1Recomp", "BOIS CLUB GAMES, LLC", "" },
  }
  local TITLED = { [2] = true }

  local SUBTITLE_TEXT = { colors = { fg = { 1, 1, 1, 1 }, shadow = { 0.03, 0.2, 0.12, 1 }, bg = { 0, 0, 0, 0 } }, letterSpacing = 1 }
  local draw = Title.draw
  function Title:draw()
    draw(self)
    if active() and self.phase == "phase3" then
      local w = FrlgFont.measure(I.SUBTITLE, SUBTITLE_TEXT)
      local x = math.floor((240 - w) / 2)
      love.graphics.setColor(0.03, 0.2, 0.12, 0.8)
      love.graphics.rectangle("fill", x - 6, I.SUBTITLE_Y - 1, w + 12, 16, 3, 3)
      love.graphics.setColor(1, 1, 1, 1)
      FrlgFont.draw(I.SUBTITLE, x, I.SUBTITLE_Y, SUBTITLE_TEXT)
    end
  end

  -- the ROM's text is only there once the game has started
  function I.birchText()
    RomText.overrides[I.BIRCH_KEY] = nil
    if not active() then return end
    local ir = {}
    for _, seg in ipairs(TextIR.fromAscii(I.BIRCH_LINES)) do
      if seg.t ~= "eos" then ir[#ir + 1] = seg end
    end
    for _, seg in ipairs(RomText.ir(I.BIRCH_KEY)) do ir[#ir + 1] = seg end
    RomText.overrides[I.BIRCH_KEY] = ir
  end
  local newBirch = Birch.new
  function Birch.new(...)
    I.birchText()
    return newBirch(...)
  end

  function I.addCredits(manifest)
    if manifest.campaignPages then return end
    manifest.campaignPages = true
    for _, lines in ipairs(I.PAGES) do
      local page = {}
      for row, text in ipairs(lines) do page[row] = { text = text, isTitle = TITLED[row] == true } end
      manifest.pages[#manifest.pages + 1] = page
    end
    manifest.pageCount = #manifest.pages
  end
  local newCredits = Credits.new
  function Credits.new(opts)
    local self = newCredits(opts)
    if active() then I.addCredits(self.m:manifest(Credits.MANIFEST)) end
    return self
  end
  return I
end
