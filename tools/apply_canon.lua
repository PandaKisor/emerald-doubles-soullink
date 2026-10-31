-- Applies campaign/canon.json to the built mod's data (build_campaign.py runs it;
-- see tools/canon_data.py). Run: luajit apply_canon.lua <mod folder> <canon.lua>
-- with canon as a Lua table, since the build has no JSON reader here.
local out, canonPath = arg[1], arg[2]
local canon = dofile(canonPath)

local function ser(v)
  if type(v) == "string" then return string.format("%q", v):gsub("\\\n", "\\n") end
  if type(v) ~= "table" then return tostring(v) end
  local size = 0
  for _ in pairs(v) do size = size + 1 end
  if size > 0 and size == #v then
    local parts = {}
    for i, x in ipairs(v) do parts[i] = ser(x) end
    return "{" .. table.concat(parts, ",") .. "}"
  end
  local keys = {}
  for k in pairs(v) do keys[#keys + 1] = k end
  table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
  local parts = {}
  for i, k in ipairs(keys) do parts[i] = "[" .. ser(k) .. "]=" .. ser(v[k]) end
  return "{\n" .. table.concat(parts, ",\n") .. "\n}"
end
local function write(path, head, t)
  local f = assert(io.open(path, "w"))
  f:write(head, "\nreturn ", ser(t), "\n")
  f:close()
end
local function files(prefix, count)
  local list = {}
  for i = 1, count do
    local p = ("%s/full/data/%s-%03d.lua"):format(out, prefix, i)
    local f = io.open(p)
    if f then f:close() list[#list + 1] = p end
  end
  return list
end

local symbols, moveSymbols = {}, {}
for _, p in ipairs(files("species", 99)) do
  local t = dofile(p)
  for id, row in pairs(t) do
    symbols[id] = row.symbol
    local patch = canon.species[id]
    if patch then
      row.stats = patch.stats or row.stats
      row.types = patch.types or row.types
      row.abilities = patch.abilities or row.abilities
    end
    local swaps = canon.learnsets[id]
    if swaps then
      for _, r in ipairs(row.learnset or {}) do r[2] = swaps[r[2]] or r[2] end
    end
    for kind, entries in pairs(canon.strip[id] or {}) do
      local drop, kept = {}, {}
      for _, e in ipairs(entries) do drop[e] = true end
      for _, e in ipairs(row[kind] or {}) do if not drop[e] then kept[#kept + 1] = e end end
      row[kind] = kept
    end
  end
  write(p, "-- Official data over the generated rows (tools/apply_canon.lua).", t)
end
for _, p in ipairs(files("moves", 99)) do
  local t = dofile(p)
  for id, row in pairs(t) do
    moveSymbols[id] = row.symbol
    for k, v in pairs(canon.moves[id] or {}) do row[k] = v end
  end
  write(p, "-- Official data over the generated rows (tools/apply_canon.lua).", t)
end
for _, p in ipairs(files("abilities", 99)) do
  local t = dofile(p)
  for id, row in pairs(t) do row.description = canon.abilities[id] or row.description end
  write(p, "-- Official text over the generated rows (tools/apply_canon.lua).", t)
end

-- the battle layer's own copy of the first 386 species and 354 moves
local path = out .. "/lib/content.lua"
local c = dofile(path)
local typeName = {}
for name, id in pairs(c.typeIds) do typeName[id] = name end
local KEYS = { hp = "hp", atk = "attack", def = "defense", spe = "speed", spa = "specialAttack", spd = "specialDefense" }
for id, patch in pairs(canon.species) do
  local name = symbols[id] and symbols[id]:gsub("^SPECIES_", "")
  if name and c.stats[name] then
    for from, to in pairs(KEYS) do
      if patch.stats then c.stats[name][to] = patch.stats[from] end
    end
    if patch.types then
      local a, b = typeName[patch.types[1]], typeName[patch.types[2]]
      c.typings[name] = a == b and { a } or { a, b }
    end
  end
end
for id, patch in pairs(canon.moves) do
  local name = moveSymbols[id] and moveSymbols[id]:gsub("^MOVE_", "")
  local row = name and c.moves[name]
  if row then
    for k, v in pairs(patch) do
      row[k] = k == "type" and typeName[v] or v
    end
  end
end
write(path, "-- Official data over the generated content (tools/apply_canon.lua).", c)

path = out .. "/full/inventory-ui/model.lua"
local m = dofile(path)
for id, text in pairs(canon.moveText) do m.moveDescriptions[id] = text end
write(path, "-- Official text over the generated model (tools/apply_canon.lua).", m)
