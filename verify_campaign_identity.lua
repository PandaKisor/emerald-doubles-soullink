-- The campaign's own name (campaign/identity.lua) and the official forms and
-- learnset strip (tools/canon_extras.py) in the built mod. Run from
-- Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T, I = F.T, F.campaign.identity

local manifest = { pages = { { { text = 'ROM' } } }, pageCount = 1 }
I.addCredits(manifest)
T.check(manifest.pageCount == 1 + #I.PAGES, 'credit pages follow the ROM pages')
T.check(manifest.pages[1][1].text == 'ROM', 'the ROM page stays first')
T.check(manifest.pages[3][2].isTitle == true, 'each page has a title row')
I.addCredits(manifest)
T.check(manifest.pageCount == 1 + #I.PAGES, 'a second credits run adds nothing')
for _, lines in ipairs(I.PAGES) do T.check(#lines == 5, 'a credit page fills the 5 rows') end
for line in (I.BIRCH_LINES .. '\n'):gmatch('([^\n\f]+)') do
  T.check(#line <= 34, 'Birch line fits: ' .. line)
end

local row = {}
for i = 1, 99 do
  local path = ('../porting/native/generated/campaign/mods/g3_campaign/full/data/species-%03d.lua'):format(i)
  local f = io.open(path)
  if f then
    f:close()
    for _, r in pairs(dofile(path)) do row[r.symbol] = r end
  end
end
T.check(row.SPECIES_SAWSBUCK_SUMMER.stats.atk == row.SPECIES_SAWSBUCK.stats.atk, 'a seasonal form has the base stats')
T.check(row.SPECIES_ORICORIO_PAU.stats.spa == row.SPECIES_ORICORIO.stats.spa, 'Oricorio styles share official stats')
T.check(row.SPECIES_PUMPKABOO_SUPER.stats.hp > row.SPECIES_PUMPKABOO_SMALL.stats.hp, 'Pumpkaboo sizes differ again')
T.finish('campaign identity, forms and learnsets')
