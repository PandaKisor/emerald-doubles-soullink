-- The campaign's own key gifts, over campaign/item_sources.lua (generated). Hand-edited.
--   gifts  script key -> vanilla item id -> item given
--   sold   mart label prefix -> items added to that shop: a gift's old item stays
--          obtainable, and TMs and weather rocks no one handed out get a home
--   text   ROM text key -> line naming the new gift (\n new line, \f new box)
-- The script keys are the ROM's, so they hold for any Emerald (U) cache.
local TWO = function(a, b, from, item) return { a, from, item }, { b, from, item } end
local rows = {
  { TWO("g3:081fc855", "g3:081fc878", 296, "ITEM_TM88_LOW_SWEEP") },     -- Brawly (was Bulk Up)
  { TWO("g3:0820dfb1", "g3:0820df8d", 322, "ITEM_TM73_THUNDER_WAVE") },  -- Wattson (was Volt Switch)
  { { "g3:081f25d1", 293, "ITEM_TM78_BULLDOZE" } },                      -- Route 114 (was Roar)
  { { "g3:08208a3d", 329, "ITEM_TM03_WATER_PULSE" } },                   -- Slateport tent (was Torment)
  { { "g3:08201a7b", 333, "ITEM_TM57_CHARGE_BEAM" } },                   -- Verdanturf tent (was Attract)
  { { "g3:08200f38", 315, "ITEM_TM83_FLAME_CHARGE" } },                  -- Cozmo (was Return; Pacifidlog still gives it)
  { { "g3:0820a1a3", 184, "ITEM_THROAT_SPRAY" } },                       -- Fan Club (was Love Ball)
  { { "g3:08217cd8", 185, "ITEM_SAFETY_GOGGLES" } },                     -- Fortree Wingull (was Choice Scarf; sold there)
  { TWO("g3:0826adc0", "g3:08269f1b", 10, "ITEM_WISE_GLASSES") },        -- Trick House 2 (was Smoke Ball)
  { TWO("g3:0826aeb0", "g3:08269fcb", 208, "ITEM_MUSCLE_BAND") },        -- Trick House 6 (was Magnet)
}
local sold = {
  MauvilleCity_Mart = { "ITEM_TM72_VOLT_SWITCH", "ITEM_TM31_BRICK_BREAK", "ITEM_NATURE_MINT" },
  VerdanturfTown_Mart = { "ITEM_TM08_BULK_UP" },
  FortreeCity_Mart = { "ITEM_NATURE_MINT", "ITEM_HEAT_ROCK", "ITEM_DAMP_ROCK", "ITEM_SMOOTH_ROCK", "ITEM_ICY_ROCK" },
  LilycoveCity_DepartmentStore_4F = { "ITEM_TM05_ROAR", "ITEM_TM41_TORMENT", "ITEM_TM45_ATTRACT",
    "ITEM_TM34_SLUDGE_WAVE", "ITEM_TM82_DRAGON_TAIL", "ITEM_TM67_RECYCLE",
    "ITEM_WIDE_FIGHTING_GEM", "ITEM_WIDE_POISON_GEM", "ITEM_WIDE_GHOST_GEM", "ITEM_WIDE_STEEL_GEM", "ITEM_WIDE_DARK_GEM",
    "ITEM_ABILITY_CAPSULE", "ITEM_ABILITY_PATCH" },
}
local text = {
  ["g3:081fd181"] = "That TM88 contains LOW SWEEP.\fIt strikes both foes at the legs and\nlowers their SPEED.\f… … … … … …",
  ["g3:0820e844"] = "That TM73 there contains THUNDER WAVE.\fIt paralyzes the target! Slow a foe\nand you control the battle!\f… … … … … …",
  ["g3:08216fec"] = "TM51 contains ROOST.\fIt lets a POKéMON land and recover\nhalf of its HP.\f… … … … … …",
  ["g3:082256c1"] = "The TECHNICAL MACHINE I handed you\ncontains SCALD.\fIts scalding water may leave\nthe target with a burn.\f… … … … … …",
  ["g3:081f2809"] = "My POKéMON stomped so hard the\nground shook…\fNo one dares to come near me…\fSigh… If you would, please take\nthis TM away…",
  ["g3:081f2872"] = "TM78 contains BULLDOZE.\nIt shakes the ground under everyone!",
  ["g3:08208c5c"] = "That's, like, TM03, you know?\nHey, it's WATER PULSE, you hearing me?\fLike, it might confuse the other guy\nwith, like, sound waves, see?\fHey, now, you listen here, like,\nno bad vibes, man!",
  ["g3:08201d9e"] = "My feelings toward my POKéMON…\nThey're positively electric…\fOh, hi, you didn't see that, did you?\nWell, it doesn't matter.\fHow would you like this TM for\nyour POKéMON?",
  ["g3:08201e43"] = "That TM contains CHARGE BEAM.\fIt may raise the user's SP. ATK\nevery time it's used!",
  ["g3:08217e05"] = "Good!\nWelcome back, WINGULL!\fHuh? What is this?\nWhat is it holding?\fSAFETY GOGGLES?\nThey must have blown in on the wind.\fBut I'm not a TRAINER, so you can\nhave them.",
  ["g3:08212a9e"] = "MR. STONE: A POKéMON holding that\nSCOPE LENS lands critical hits\nmore often.\fI would say it is quite useful\nfor a TRAINER like you.",
  ["g3:082269a1"] = "For thirty years I've remained in\nSOOTOPOLIS honing my skills.\fI developed a razor-sharp TM.\nI bequeath it to you!",
  ["g3:08226a13"] = "TM75 contains SWORDS DANCE! A move\nso sharp that I can't describe it.",
}
return function(sources)
  for _, row in ipairs(rows) do
    for _, g in ipairs(row) do
      sources.gifts[g[1]] = sources.gifts[g[1]] or {}
      sources.gifts[g[1]][tostring(g[2])] = g[3]
    end
  end
  for prefix, items in pairs(sold) do
    local found = false
    for _, mart in pairs(sources.marts) do
      if tostring(mart.label):sub(1, #prefix) == prefix then
        found = true
        local list = mart.kind == "general" and "extra" or "items"
        mart[list] = mart[list] or {}
        for _, item in ipairs(items) do mart[list][#mart[list] + 1] = item end
      end
    end
    assert(found, "no mart " .. prefix)
  end
  sources.giftText = text
  return sources
end
