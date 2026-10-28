-- Cries for the species past the ROM's 411 (the donor's samples, built by
-- build_campaign.py into cries.bin + campaign/cry_index.lua). They are added to
-- the ROM's sound pack as extra samples and cries, so the engine's cry modes,
-- pitch and caching treat them like the native ones.
return function(mod, source)
  local Player = require("src.core.game3.m4a_player")
  local Audio = require("src.core.game3.audio")
  local index = source("campaign/cry_index.lua")
  local blob = assert(mod:read("cries.bin"), "cries.bin missing")

  local function top(t)
    local n = -1
    for k in pairs(t) do
      k = tonumber(k)
      if k and k > n then n = k end
    end
    return n
  end

  local function extend(pack)
    if type(pack) ~= "table" or type(pack.index) ~= "table" or pack.campaignCries then return pack end
    local cries, cryIds = pack.index.cries, pack.index.cryIds
    if type(cries) ~= "table" or type(cryIds) ~= "table" or type(pack.samples) ~= "table" then return pack end
    local template = cries[0] or cries[1] or {}
    local base = #(pack.samplesBin or "")
    pack.samplesBin = (pack.samplesBin or "") .. blob
    -- cries start at 10000: an unmapped species falls back to cry (species - 1)
    local firstSample, firstCry = top(pack.samples) + 1, math.max(top(cries) + 1, 10000)
    for i, s in ipairs(index.samples) do
      local sid = firstSample + i - 1
      pack.samples[sid] = { compressed = false, freq = s.freq, id = sid, loopStart = 0,
                            offset = base + s.offset, size = s.size, status = 0, type = 0 }
      local cry = {}
      for k, v in pairs(template) do cry[k] = v end
      cry.sampleId = sid
      cries[firstCry + i - 1] = cry
    end
    for species, i in pairs(index.species) do
      if cryIds[species] == nil then cryIds[species] = firstCry + i - 1 end
    end
    pack.campaignCries = true
    return pack
  end

  -- the pack loads when the audio installs, which can be before or after this mod
  local loadPack = Player.loadPack
  Player.loadPack = function(...)
    local pack, err = loadPack(...)
    return extend(pack), err
  end
  if Audio._pack then extend(Audio._pack) end
end
