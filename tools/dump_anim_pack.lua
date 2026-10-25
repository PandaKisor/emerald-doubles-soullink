-- Dumps the ROM-extracted battle animation pack as JSON for anim_convert.py:
-- every move's script and the labels it calls, plus what the vanilla scripts
-- use (sprite templates with their tag, palette, callback and size; tasks;
-- graphics tags). Usage: luajit dump_anim_pack.lua <battle_anims/pack.lua>
local pack = dofile(assert(arg[1], "pack.lua"))

local function json(v)
  local t = type(v)
  if t == "table" then
    local n = 0
    for _ in pairs(v) do n = n + 1 end
    if n == #v then
      local out = {}
      for i, x in ipairs(v) do out[i] = json(x) end
      return "[" .. table.concat(out, ",") .. "]"
    end
    local keys = {}
    for k in pairs(v) do keys[#keys + 1] = k end
    table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
    local out = {}
    for _, k in ipairs(keys) do out[#out + 1] = string.format("%q", tostring(k)) .. ":" .. json(v[k]) end
    return "{" .. table.concat(out, ",") .. "}"
  elseif t == "string" then return (string.format("%q", v):gsub("\\\n", "\\n"))
  elseif t == "boolean" then return tostring(v)
  elseif v == nil then return "null" end
  return tostring(v)
end

local templates, tasks = {}, {}
local function scan(ops)
  for _, op in ipairs(ops or {}) do
    if op.op == "createsprite" and op.template then
      templates[op.template] = templates[op.template] or { tag = op.tag, palTag = op.palTag, callback = op.callback,
        noGfx = op.noGfx, w = op.w, h = op.h }
    elseif (op.op == "createvisualtask" or op.op == "createsoundtask") and op.task then
      tasks[op.task] = true
    end
  end
end
for _, ops in pairs(pack.moves or {}) do scan(ops) end
for _, ops in pairs(pack.labels or {}) do scan(ops) end
for _, kind in ipairs({ "general", "special", "status" }) do
  for _, ops in pairs(pack[kind] or {}) do scan(ops) end
end
local tags = {}
for name in pairs(pack.tags or {}) do tags[#tags + 1] = name end
table.sort(tags)
local taskList = {}
for name in pairs(tasks) do taskList[#taskList + 1] = name end
table.sort(taskList)
local moves = {}
for id, ops in pairs(pack.moves or {}) do moves[tostring(id)] = ops end
io.write(json({ moves = moves, labels = pack.labels or {}, templates = templates, tasks = taskList, tags = tags }))
