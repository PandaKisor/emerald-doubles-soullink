-- The campaign's cries (campaign/cries.lua + cries.bin), headless on stock
-- 0.3.73 through the built mod: the ROM's sound pack is extracted, the new
-- species' cries join it, and Audio.playCry renders them through the engine's
-- own cry path while the ROM's species keep theirs. Run from
-- Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local cache = require('src.core.game3.dataset').cache()
assert(require('src.import.gba.extract_audio').run(F.rom, cache, { root = 'data/generated/gba/audio' }))
local Audio = require('src.core.game3.audio')
local Player = require('src.core.game3.m4a_player')
local S = F.ids.species

-- the mod hooked loadPack before the audio installed, as at boot
local pack = assert(Player.loadPack(cache, 'data/generated/gba/audio'))
T.check(pack.campaignCries == true, 'the campaign extends the ROM sound pack')
Audio._pack, Audio._meta, Audio._ready = pack, pack.index, true
Audio.isReady = function() return true end

local function cryOf(species)
  local slot = Player.startCry(pack, species, { pitch = 1.0 })
  return slot and slot.info.cryIndex, slot
end

for _, name in ipairs({ 'SPECIES_TURTWIG', 'SPECIES_GARCHOMP', 'SPECIES_SYLVEON', 'SPECIES_CALYREX',
                        'SPECIES_RATTATA_ALOLAN', 'SPECIES_UNOWN_B' }) do
  local idx = cryOf(S[name])
  T.check(idx and idx >= 10000, name .. ' has a campaign cry (' .. tostring(idx) .. ')')
end
local treecko = cryOf(S.SPECIES_TREECKO)
T.check(treecko and treecko < 10000, 'Treecko keeps the ROM cry (' .. tostring(treecko) .. ')')
T.eq(cryOf(S.SPECIES_ROTOM_WASH), cryOf(S.SPECIES_ROTOM), 'Wash Rotom shares Rotom\'s cry')
T.check(cryOf(S.SPECIES_TURTWIG) ~= cryOf(S.SPECIES_GROTLE), 'Turtwig and Grotle differ')

-- every species past the ROM's range has one
local without = {}
for name, id in pairs(S) do
  if id > 412 and not name:find('_MEGA') and not name:find('_PRIMAL') and not cryOf(id) then
    without[#without + 1] = name
  end
end
T.eq(#without, 0, 'no species past 412 is silent (' .. table.concat(without, ', ', 1, math.min(#without, 8)) .. ')')

-- rendered through the engine's cry path, in normal and fainting modes
local rendered = {}
love.audio = { newSource = function(sd) rendered[#rendered + 1] = sd
  return { setVolume = function() end, play = function() end, isPlaying = function() return false end } end }
for _, mode in ipairs({ 0, 1 }) do
  T.check(Audio.playCry(S.SPECIES_GARCHOMP, mode), 'Garchomp\'s cry plays in mode ' .. mode)
end
T.eq(#rendered, 2, 'both cries rendered a sound')
T.check(rendered[1] and rendered[1]:getSampleCount() > 4000, 'with real length (' ..
  tostring(rendered[1] and rendered[1]:getSampleCount()) .. ' samples)')

T.finish('campaign cries')
