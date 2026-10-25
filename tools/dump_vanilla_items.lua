-- Dumps where vanilla Emerald hands out items, from the ROM-extracted script
-- cache: item balls (map, x, y, item), hidden items, scripted gifts (label,
-- items in order) and marts (label, mart key, items). Output: JSON on stdout.
-- Usage: luajit dump_vanilla_items.lua <scripts dir>
local dir = assert(arg[1], "scripts dir")
local E = dofile(dir .. "/events.lua")
local S = dofile(dir .. "/scripts.lua")
local L = dofile(dir .. "/labels.lua")
local M = dofile(dir .. "/marts.lua")
local labelOf = {}
for label, key in pairs(L) do if not labelOf[key] or #label < #labelOf[key] then labelOf[key] = label end end

local function json(v)
  local t = type(v)
  if t == "table" then
    if #v > 0 or next(v) == nil then
      local out = {}
      for i, x in ipairs(v) do out[i] = json(x) end
      return "[" .. table.concat(out, ",") .. "]"
    end
    local keys = {}
    for k in pairs(v) do keys[#keys + 1] = tostring(k) end
    table.sort(keys)
    local out = {}
    for _, k in ipairs(keys) do out[#out + 1] = string.format("%q", k) .. ":" .. json(v[k] == nil and v[tonumber(k)] or v[k]) end
    return "{" .. table.concat(out, ",") .. "}"
  elseif t == "string" then return string.format("%q", v)
  elseif t == "boolean" then return tostring(v)
  elseif v == nil then return "null" end
  return tostring(v)
end

-- items a script hands out: setorcopyvar 0x8000 X ... callstd 0 (obtain) / 1 (find)
local function handouts(key)
  local ops = S[key]
  local out, pending = {}, nil
  for _, op in ipairs(ops or {}) do
    if op.op == "setorcopyvar" and tonumber(op[1]) == 0x8000 and tonumber(op[2]) and tonumber(op[2]) < 0x4000 then
      pending = tonumber(op[2])
    elseif op.op == "callstd" and pending and (tonumber(op[1]) == 0 or tonumber(op[1]) == 1) then
      out[#out + 1] = { std = tonumber(op[1]), item = pending }
      pending = nil
    end
  end
  return out
end

local balls, hidden, gifts, marts = {}, {}, {}, {}
for map, ev in pairs(E) do
  if type(ev) == "table" and ev.objects then
    for _, o in ipairs(ev.objects) do
      local h = handouts(o.scriptKey)
      if #h == 1 and h[1].std == 1 then
        balls[#balls + 1] = { map = map, x = o.x, y = o.y, localId = o.localId, item = h[1].item, flag = o.flag }
      end
    end
    for _, b in ipairs(ev.bgEvents or {}) do
      if b.type == "hidden_item" then hidden[#hidden + 1] = { map = map, x = b.x, y = b.y, item = b.item, flag = b.flag } end
    end
  end
end
for key, ops in pairs(S) do
  local label = labelOf[key]
  local h = handouts(key)
  local gives = {}
  for _, x in ipairs(h) do if x.std == 0 then gives[#gives + 1] = x.item end end
  if label and #gives > 0 then gifts[#gifts + 1] = { label = label, key = key, items = gives } end
  for _, op in ipairs(ops) do
    if op.op == "pokemart" or op.op == "pokemartdecoration" or op.op == "pokemartdecoration2" then
      local mk = op[1]
      local m = M.marts and (M.marts[mk] or M.marts[tonumber(tostring(mk):match("g3:(%x+)") or "", 16)])
      if not m then for _, row in pairs(M.marts or {}) do if row.key == mk then m = row end end end
      marts[#marts + 1] = { label = label or key, key = mk, decor = op.op ~= "pokemart" or (m and m.kind == "decorations") or false,
        items = m and m.items or {} }
    end
  end
end
table.sort(balls, function(a, b) return a.map .. a.x .. "," .. a.y < b.map .. b.x .. "," .. b.y end)
table.sort(hidden, function(a, b) return a.map .. a.x .. "," .. a.y < b.map .. b.x .. "," .. b.y end)
table.sort(gifts, function(a, b) return a.label < b.label end)
table.sort(marts, function(a, b) return a.label < b.label end)
io.write(json({ balls = balls, hidden = hidden, gifts = gifts, marts = marts }))
