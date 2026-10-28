-- The donor's wild encounter tables on the vanilla Emerald maps. The ROM's
-- tables load as usual; each map the donor defines then has its land, water,
-- rock smash and fishing tables replaced under every key the engine looks up
-- ("ROUTE101", "EM_ROUTE101" and "group:num"). Levels are the donor's fixed
-- ranges; nothing scales with either player's party.
return function(Encounters, data, maps, active)
  local species = data.identity.namespaces.species
  local function area(rows)
    if not rows then return nil end
    local slots = {}
    for i, slot in ipairs(rows.slots) do
      slots[i] = { species = assert(species[slot[1]], slot[1]), minLevel = slot[2], maxLevel = slot[3] }
    end
    return { rate = rows.rate, slots = slots }
  end
  local function table_of(row)
    return { land = area(row.land), water = area(row.water), rocks = area(row.rocks), fishing = area(row.fishing) }
  end
  local function apply(tables)
    for _, row in ipairs(maps) do
      local vanilla = tables["EM_" .. row.map] or tables[row.map]
      local entry
      if row.variants then
        entry = { variants = {} }
        for i, variant in ipairs(row.variants) do entry.variants[i] = table_of(variant) end
        entry.land = entry.variants[1].land
      else
        entry = table_of(row)
      end
      if vanilla then entry.mapGroup, entry.mapNum = vanilla.mapGroup, vanilla.mapNum end
      tables[row.map], tables["EM_" .. row.map] = entry, entry
      if entry.mapGroup and entry.mapNum then tables[entry.mapGroup .. ":" .. entry.mapNum] = entry end
    end
  end
  local bridge = Encounters._campaignWild
  if not bridge then
    bridge = {}
    Encounters._campaignWild = bridge
    local load = Encounters.loadFromMod
    Encounters.loadFromMod = function(...)
      local result = load(...)
      if bridge.active() then bridge.apply(Encounters._tables) end
      return result
    end
  end
  bridge.apply, bridge.active = apply, active
  -- tables loaded before this install still hold the ROM's encounters
  Encounters._loaded = false
  return bridge
end
