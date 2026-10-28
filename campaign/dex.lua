-- Pokédex entries for the donor's species past the original 386. The ROM's
-- entry pack is keyed by species; the donor's entries are keyed by national
-- number and added under the species each number resolves to. Battle reads
-- the same entries for weights.
--
-- The new species also join the Pokédex screen's lists: the HOENN dex goes
-- on past its 202 with them (203, 204, ... in national order), the NATIONAL
-- dex runs to the last new number, and the A-to-Z, weight and height orders
-- take them in. (The screen's own 386-row limit is lifted in the patched
-- ui/game3/rse/pokedex.lua, build_campaign.py STOCK_PATCHES.)
return function(Mapsec, Pokemon, entries, active)
  local bridge = Mapsec._campaignDex
  -- the new national numbers that resolve to a species, in order
  local function newNationals()
    local out = {}
    for national in pairs(bridge.entries) do
      local species = Pokemon.speciesFromNational(national)
      if national > 386 and species and species > 0 then out[#out + 1] = national end
    end
    table.sort(out)
    return out
  end

  if not bridge then
    bridge = {}
    Mapsec._campaignDex = bridge
    local readLua = Mapsec.readLua
    Mapsec.readLua = function(path, ...)
      local pack = readLua(path, ...)
      if type(pack) ~= "table" or not bridge.active() then return pack end
      if path == "pokemon/pokedex/entries.lua" then
        local out = {}
        for k, v in pairs(pack) do out[k] = v end
        for national, row in pairs(bridge.entries) do
          local species = Pokemon.speciesFromNational(national)
          if species and species > 0 and out[species] == nil then out[species] = row end
        end
        return out
      elseif path == "pokemon/pokedex/regional.lua" and type(pack.nationalToRegional) == "table" then
        -- the HOENN dex numbers past 202
        local out = {}
        for k, v in pairs(pack) do out[k] = v end
        out.numerical, out.nationalToRegional = {}, {}
        for i, nat in ipairs(pack.numerical or {}) do out.numerical[i] = nat end
        for nat, n in pairs(pack.nationalToRegional) do out.nationalToRegional[nat] = n end
        local n = tonumber(pack.count) or #out.numerical
        for _, nat in ipairs(newNationals()) do
          n = n + 1
          out.numerical[n], out.nationalToRegional[nat] = nat, n
        end
        out.count = n
        return out
      end
      return pack
    end
    -- battle reads weights (Low Kick, Grass Knot) through Pokemon.dexEntry
    local dexEntry = Pokemon.dexEntry
    Pokemon.dexEntry = function(species, ...)
      local entry = dexEntry(species, ...)
      if entry ~= nil or not bridge.active() then return entry end
      local national = Pokemon.national(species)
      return national and bridge.entries[national] or nil
    end

    -- the screen's sort orders (rse/pokedex/orders.lua), extended once per
    -- loaded copy
    local okG, Gfx = pcall(require, "src.ui.game3.rse.pokedex_gfx")
    if okG and type(Gfx) == "table" and Gfx.orders then
      local orders = Gfx.orders
      local made = setmetatable({}, { __mode = "k" })
      Gfx.orders = function(...)
        local base = orders(...)
        if type(base) ~= "table" or not bridge.active() then return base end
        if made[base] then return made[base] end
        local out = {}
        for k, v in pairs(base) do out[k] = v end
        local added = newNationals()
        local function copy(list)
          local t = {}
          for i, v in ipairs(list or {}) do t[i] = v end
          return t
        end
        out.numerical_hoenn = copy(base.numerical_hoenn)
        for _, nat in ipairs(added) do out.numerical_hoenn[#out.numerical_hoenn + 1] = nat end
        out.numerical_national = copy(base.numerical_national)
        local last = added[#added] or 0
        for nat = #out.numerical_national + 1, last do out.numerical_national[nat] = nat end
        local function entry(nat)
          local sp = Pokemon.speciesFromNational(nat)
          return (sp and Pokemon.dexEntry(sp)) or bridge.entries[nat] or {}
        end
        local function name(nat)
          local ok, n = pcall(Pokemon.name, Pokemon.speciesFromNational(nat))
          return ok and tostring(n or "") or ""
        end
        local function merged(list, key)
          local t = copy(list)
          for _, nat in ipairs(added) do t[#t + 1] = nat end
          local keyOf = {}
          for _, nat in ipairs(t) do keyOf[nat] = key(nat) end
          table.sort(t, function(a, b)
            if keyOf[a] ~= keyOf[b] then return keyOf[a] < keyOf[b] end
            return a < b
          end)
          return t
        end
        out.atoz = merged(base.atoz, name)
        out.lightest = merged(base.lightest, function(nat) return tonumber(entry(nat).weight) or 0 end)
        out.smallest = merged(base.smallest, function(nat) return tonumber(entry(nat).height) or 0 end)
        made[base] = out
        return out
      end
    end
  end
  bridge.entries, bridge.active = entries, active
  return bridge
end
