-- Targeted wrappers for the overlay edits that live in engine files the mod
-- sandbox can't load whole (their stock code uses io/os/love.filesystem).
-- Each wrapper reads the port's bridge at call time, so it is inert until
-- the port installs it, exactly like the overlay edit it replaces.
--
-- Not reproduced here: expanded_guard calls in Game3/SaveData (they guard
-- the separate engine copy; the cart's sealed mod list does that job on
-- stock), conf.lua's identity, and egg_hatch's personality argument.

local Shims = {}

-- overlay src/core/game3/dataset.lua: the port serves its own map geometry.
-- Every cache read/exists for a versioned path goes through CacheFs.readAt /
-- existsAt with the cache prefix in front, and the shared cache answers the
-- asset worker; the overlay hooked those three spots.
local function datasetBridge()
  local Dataset = require("src.core.game3.dataset")
  local CacheFs = require("src.import.CacheFs")
  local Version = require("src.core.GameVersion")
  local function owned(path)
    local port = Dataset._expandedMaps
    if not port then return nil end
    local prefix = Version.cachePrefix()
    if type(path) ~= "string" or path:sub(1, #prefix) ~= prefix then return nil end
    local rel = path:sub(#prefix + 1)
    if port.owns(rel) then return port, rel end
  end
  local readAt, existsAt = CacheFs.readAt, CacheFs.existsAt
  CacheFs.readAt = function(path, ...)
    local port, rel = owned(path)
    if port then return port.read(rel) end
    return readAt(path, ...)
  end
  CacheFs.existsAt = function(path, ...)
    local port, rel = owned(path)
    if port then return port.exists(rel) end
    return existsAt(path, ...)
  end
  local cache = Dataset.cache()
  local spec = cache.assetWorkerSpec
  cache.assetWorkerSpec = function(self, root, kind, key, ...)
    local port = Dataset._expandedMaps
    local rel = root .. "/" .. tostring(key) .. (kind == "pair" and "/mids.idx" or ".meta")
    if port and port.owns(rel) then return nil end
    return spec(self, root, kind, key, ...)
  end
end

-- overlay src/core/game3/pokemon.lua: port natures and HM forgetting.
local function pokemonHooks()
  local Pokemon = require("src.core.game3.pokemon")
  function Pokemon.natureOf(mon)
    local port = Pokemon._expandedNatures
    if port and port.active() then return port.read(mon) end
    return Pokemon.natureId(mon and mon.personality)
  end
  function Pokemon.canForgetMove(moveId)
    local port = Pokemon._expandedLearning
    return (port and port.active()) or not Pokemon.isHmMove(moveId)
  end
  -- applyStats calls Pokemon.calcStats without a nature; the overlay passes
  -- natureOf(mon) as calcStats' sixth argument
  local applyStats = Pokemon.applyStats
  Pokemon.applyStats = function(mon, session)
    if type(mon) ~= "table" then return applyStats(mon, session) end
    local calc = Pokemon.calcStats
    Pokemon.calcStats = function(species, level, ivs, evs, personality)
      return calc(species, level, ivs, evs, personality, Pokemon.natureOf(mon))
    end
    local ok, result = pcall(applyStats, mon, session)
    Pokemon.calcStats = calc
    if not ok then error(result, 0) end
    return result
  end
  local replaceMove = Pokemon.replaceMove
  Pokemon.replaceMove = function(mon, slot, newMoveId)
    local port = Pokemon._expandedLearning
    if not (port and port.active()) then return replaceMove(mon, slot, newMoveId) end
    local s, id = tonumber(slot), tonumber(newMoveId)
    if not mon or not s or s < 1 or s > 4 or not id then return nil end
    port.prepareReplacement(mon, s)
    local isHm = Pokemon.isHmMove
    Pokemon.isHmMove = function() return false end
    local ok, a, b = pcall(replaceMove, mon, slot, newMoveId)
    Pokemon.isHmMove = isHm
    if not ok then error(a, 0) end
    return a, b
  end
end

function Shims.install()
  datasetBridge()
  pokemonHooks()
end

return Shims
