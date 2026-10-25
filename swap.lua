-- Installs patched copies of Gen1Recomp engine modules from inside a mod.
--
-- Runs in the mod sandbox (src/mods/Sandbox.lua): no package, debug, io or
-- love.filesystem.  A patched module is compiled with the mod's load() and
-- its `local X = {}` table is swapped for the engine's live module table, so
-- every engine caller that reaches the module through require sees the new
-- functions.  Modules the engine does not ship (co-op additions) live in a
-- registry only this mod's require can see.
--
-- The patched sources only ever read package.loaded and call
-- debug.traceback; both are stood in for below.  Anything else blocked fails
-- loudly at compile or first use.

local Swap = {}

local engineRequire = require
local sources = {}    -- module name -> source text
local replaces = {}   -- module name -> true when it patches an engine module
local done = {}       -- module name -> installed table
local installing = {} -- module name -> table while its chunk runs

local function swapRequire(name, ...)
  if done[name] ~= nil then return done[name] end
  if installing[name] ~= nil then return installing[name] end
  if sources[name] then return Swap.install(name) end
  return engineRequire(name, ...)
end

-- package.loaded[name] answers nil for a module nobody has required yet.
-- The patched code only asks to find an already-open UI or engine table;
-- requiring it on demand is what the engine's own lazyReq does.
local loadedProxy = setmetatable({}, { __index = function(_, name)
  if done[name] ~= nil then return done[name] end
  if installing[name] ~= nil then return installing[name] end
  if sources[name] then return Swap.install(name) end
  local ok, mod = pcall(engineRequire, name)
  if ok then return mod end
  return nil
end })

local function traceback(a, b)
  if type(a) == "thread" then return tostring(b) end
  return tostring(a)
end

-- Rewrites the module's own `local X = {...}` declaration (X being what the
-- file returns) into a call that hands back the engine's live table, with
-- the constructor's fields copied onto it.
local function adoptSource(name, src)
  local var = src:match("\nreturn ([%a_][%w_]*)%s*$")
  if not var then error(("swap %s: no trailing `return X`"):format(name), 0) end
  local head = "local " .. var .. " = "
  local at
  if src:sub(1, #head) == head then at = 1
  else at = src:find("\n" .. head .. "{", 1, true); at = at and at + 1 end
  local ctor = at and src:match("^%b{}", at + #head)
  if not ctor then error(("swap %s: no `%s{...}` to adopt"):format(name, head), 0) end
  return src:sub(1, at - 1) .. head .. "__swapAdopt(" .. ("%q"):format(name) .. ", " .. ctor .. ")"
    .. src:sub(at + #head + #ctor)
end

function Swap.install(name)
  if done[name] ~= nil then return done[name] end
  local src = sources[name]
  local live
  if replaces[name] then
    live = engineRequire(name)
    if type(live) ~= "table" then error(("swap %s: engine module is not a table"):format(name), 0) end
    src = adoptSource(name, src)
  end
  local chunk, err = load(src, "@native/" .. name:gsub("%.", "/") .. ".lua")
  if not chunk then error(err, 0) end
  installing[name] = live or {}
  local adopt = function(want, init)
    if want ~= name then error(("swap %s: adopt asked for %s"):format(name, tostring(want)), 0) end
    for k, v in pairs(init) do live[k] = v end
    return live
  end
  local prevAdopt = __swapAdopt
  __swapAdopt = adopt
  local ok, result = pcall(chunk)
  __swapAdopt = prevAdopt
  installing[name] = nil
  if not ok then error(("swap %s: %s"):format(name, tostring(result)), 0) end
  if live and result ~= live then error(("swap %s: chunk returned a different table"):format(name), 0) end
  done[name] = result
  return result
end

-- files: list of { name = "src.core.game3.battle", source = "...",
-- replaces = true|false }.  Installs in list order; requires between them
-- resolve to the patched copies whatever the order.
function Swap.installAll(files)
  for _, f in ipairs(files) do
    sources[f.name] = f.source
    replaces[f.name] = f.replaces and true or nil
  end
  -- the patched chunks run in this mod's environment, so these become what
  -- they see as require, package.loaded and debug.traceback
  require = swapRequire
  package = { loaded = loadedProxy }
  debug = { traceback = traceback }
  local out = {}
  for _, f in ipairs(files) do out[f.name] = Swap.install(f.name) end
  return out
end

Swap.require = swapRequire

return Swap
