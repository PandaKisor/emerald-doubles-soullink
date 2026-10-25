-- Inclement's own move animations (campaign/move_anims.lua, made by
-- tools/anim_convert.py), headless on stock 0.3.73 through the built mod:
-- the ROM's animation pack is extracted, Anim.scriptForMove hands battle the
-- converted script for those moves (and the stand-in for the rest), and every
-- converted script runs to its end on the engine's animation VM from both
-- sides without a Lua error or a task/callback error. Run from
-- Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local cache = require('src.core.game3.dataset').cache()
assert(require('src.import.gba.battle_anim_extract').run(F.rom, cache, { cacheRoot = 'data/generated/gba', game = 'emerald' }))
-- the mon-relative callbacks read the battlers' picture sizes
require('src.import.gba.pic_coords_extract').run(F.rom, cache, { cacheRoot = 'data/generated/gba', game = 'emerald' })
local pack = assert(load(cache:read('data/generated/gba/pokemon/battle_anims/pack.lua'), '@pack.lua', 't', {}))()
local own = assert(loadfile('../porting/native/generated/campaign/mods/g3_campaign/campaign/move_anims.lua'))()
local Anim = require('src.core.game3.battle.anim')
local AnimVm = require('src.core.game3.battle.anim_vm')
local AnimTasks = require('src.core.game3.battle.anim_tasks')
local AnimSprites = require('src.core.game3.battle.anim_sprites')
AnimTasks.init()
local moves = F.ids.moves

local count = 0
for _ in pairs(own.moves) do count = count + 1 end
T.check(count > 300, 'more than 300 new moves have their own animation (' .. count .. ')')

-- battle gets them through the mod's scriptForMove
Anim._pack, Anim._packLoaded = pack, true
-- (the mod loaded its own copy of move_anims.lua: compare contents)
local function same(a, b)
  if type(a) ~= type(b) then return false end
  if type(a) ~= 'table' then return a == b end
  for k, v in pairs(a) do if not same(v, b[k]) then return false end end
  for k in pairs(b) do if a[k] == nil then return false end end
  return true
end
T.check(own.moves.MOONBLAST ~= nil, 'Moonblast converted')
T.check(same(Anim.scriptForMove(moves.MOVE_MOONBLAST), own.moves.MOONBLAST), 'Moonblast plays its own animation')
T.check(pack.campaignLabels == true, "the converted subroutines joined the pack's labels")
local someLabel = next(own.labels)
T.check(someLabel == nil or same(pack.labels[someLabel], own.labels[someLabel]), 'with their contents')
T.check(own.moves.DRACO_METEOR == nil, 'Draco Meteor does not convert (its sprite callback is new)')
T.check(same(Anim.scriptForMove(moves.MOVE_DRACO_METEOR), pack.moves[moves.MOVE_OUTRAGE]),
  'so it keeps its stand-in (Outrage)')
T.eq(Anim.scriptForMove(moves.MOVE_POUND), pack.moves[moves.MOVE_POUND], 'vanilla moves keep the ROM animation')
-- donor graphics join the pack's tags beside the ROM's
local donorTag = next(own.tags or {})
T.check(donorTag ~= nil and pack.tags[donorTag] ~= nil, 'donor graphics join the pack (' .. tostring(donorTag) .. ')')
T.check(donorTag ~= nil and pack.tags[donorTag].file:find('^anim_tags/') ~= nil, 'from the mod\'s anim_tags')

-- every callback and task a converted script names exists (no silent
-- fallback to the engine's default sprite or stub task)
local AnimCallbacks = require('src.core.game3.battle.anim_callbacks')
local unresolved = {}
local function scanOps(ops, where)
  for _, op in ipairs(ops or {}) do
    if op.op == 'createsprite' and op.callback and not op.noGfx then
      local clean = op.callback:gsub('^Anim', '')
      if not (AnimCallbacks[op.callback] or AnimCallbacks[clean] or AnimCallbacks['Anim' .. clean]) then
        unresolved[#unresolved + 1] = 'callback ' .. op.callback .. ' @' .. where
      end
    elseif op.op == 'createvisualtask' or op.op == 'createsoundtask' then
      local key = tostring(op.task):gsub('^g', '')
      if not (AnimTasks.REGISTRY[op.task] or AnimTasks.REGISTRY[key] or AnimTasks.REGISTRY['AnimTask_' .. key]) then
        unresolved[#unresolved + 1] = 'task ' .. tostring(op.task) .. ' @' .. where
      end
    end
  end
end
for sym, ops in pairs(own.moves) do scanOps(ops, sym) end
for key, ops in pairs(own.labels) do scanOps(ops, key) end
for i = 1, math.min(#unresolved, 10) do print('  unresolved ' .. unresolved[i]) end
T.eq(#unresolved, 0, 'every callback and task the converted scripts name exists')
T.check(own.moves.AQUA_TAIL ~= nil and AnimCallbacks.AnimKnockOffAquaTail ~= nil, "Aqua Tail runs the campaign's port of its callback")

-- every converted script runs to its end, both sides
for k, ops in pairs(own.labels) do pack.labels[k] = ops end
for k, t in pairs(own.tags or {}) do if pack.tags[k] == nil then pack.tags[k] = t end end
for k, t in pairs(own.bgs or {}) do if pack.animBgs[k] == nil then pack.animBgs[k] = t end end
local rp, logs = print, {}
local errors, timeouts, ran = 0, 0, 0
local function run(label, script, side)
  AnimTasks.reset()
  AnimSprites.reset()
  Anim.reset({ headless = true })
  Anim.loadPack(pack)
  local vm = AnimVm.new()
  vm:setPack(pack)
  print = function(...) logs[#logs + 1] = label .. ': ' .. table.concat({ ... }, ' ') end
  local ok, err = pcall(function()
    vm:launch(script, { attackerSide = side, targetSide = side == 'player' and 'enemy' or 'player',
      isReversed = side == 'enemy', attackerSpecies = 280, targetSpecies = 288 })
    local n = 0
    while vm:busy() and n < 1500 do
      n = n + 1
      vm:update(1 / 60)
      Anim.update(1 / 60)
    end
  end)
  print = rp
  ran = ran + 1
  if not ok then
    errors = errors + 1
    rp('  ' .. label .. ': ' .. tostring(err))
  elseif vm:busy() then
    timeouts = timeouts + 1
    rp('  ' .. label .. ': timeout')
  end
end
local names = {}
for sym in pairs(own.moves) do names[#names + 1] = sym end
table.sort(names)
for _, sym in ipairs(names) do
  run(sym .. '/player', own.moves[sym], 'player')
  run(sym .. '/enemy', own.moves[sym], 'enemy')
end
local taskErrors = 0
for _, l in ipairs(logs) do
  if l:find('[battle.anim]', 1, true) and not l:find('cap', 1, true) then
    taskErrors = taskErrors + 1
    if taskErrors <= 20 then rp('  ' .. l) end
  end
end
T.eq(errors, 0, 'no Lua error across ' .. ran .. ' runs')
T.eq(timeouts, 0, 'every converted animation ends')
T.eq(taskErrors, 0, 'no task/sprite callback error logged')

T.finish('campaign move animations')
