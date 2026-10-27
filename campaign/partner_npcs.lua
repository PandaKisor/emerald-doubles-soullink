-- Route tag partners stand on the map (user, 2026-10-27). For every trainer
-- with a campaign partner (campaign/trainers.lua) the map gets one more
-- object beside it, added to the object list for that load only:
--   * it looks like the vanilla trainer the partner borrows (`like`), found
--     on whichever map that trainer stands; else it copies its trainer
--   * it stands next to its trainer (up to two tiles out): behind it first,
--     then beside it; on land for a land trainer and on water for a swimmer,
--     never on a warp, a ledge, another object, or the trainer's line of
--     sight (that last only when nothing else is free; the sheet flags it)
--   * it is walk-through (eo.passable), so a tight spot can't block a path
--   * talking to it runs its trainer's script (the same battle; afterwards
--     the trainer's post-battle line), it hides with its trainer (same flag)
--   * when its trainer spots the player, it turns to face them with its own
--     "!" (world.trainer_engaged)
-- Placement is deterministic, so both co-op games put partners on the same
-- tiles. P.placements keeps every map's result for the review sheet.
return function(mod, trainers, active)
  local Objects = require("src.core.game3.objects")
  local TrainerSight = require("src.core.game3.trainer_sight")
  local Collision = require("src.core.game3.collision")
  local Space = require("src.core.game3.scripting.space")
  local P = { BASE = 200, placements = {}, byMap = {} }
  local DIRS = { up = { 0, -1 }, down = { 0, 1 }, left = { -1, 0 }, right = { 1, 0 } }
  local OPPOSITE = { up = "down", down = "up", left = "right", right = "left" }
  local SIDE = { up = { "left", "right" }, down = { "right", "left" }, left = { "up", "down" }, right = { "down", "up" } }

  local function facingOf(def)
    local r = tostring(def.range or def.facing or "DOWN"):lower()
    return DIRS[r] and r or "down"
  end
  -- every way a trainer looks: rotating movement types turn through several
  -- (constants/emerald/movement.lua MOVEMENT_TYPE_*)
  local ALL = { "up", "down", "left", "right" }
  local LOOKS = {
    [1] = ALL, [13] = { "down", "up" }, [14] = { "left", "right" }, [15] = { "up", "left" }, [16] = { "up", "right" },
    [17] = { "down", "left" }, [18] = { "down", "right" }, [19] = { "down", "up", "left" }, [20] = { "down", "up", "right" },
    [21] = { "up", "left", "right" }, [22] = { "down", "left", "right" }, [23] = ALL, [24] = ALL,
  }
  local function looks(def)
    return LOOKS[tonumber(def.movementType)] or { facingOf(def) }
  end

  local function trainerOf(def)
    local ok, tid = pcall(TrainerSight.getTrainerId, { def = def, scriptKey = def.scriptKey })
    return ok and tid or nil
  end

  -- the graphics of each vanilla trainer that stands on some map
  local gfxIndex
  local function gfxOf(tid)
    if not gfxIndex then
      gfxIndex = {}
      local events = Space.bundle and Space.bundle.events or {}
      local maps = {}
      for mapId in pairs(events) do maps[#maps + 1] = mapId end
      table.sort(maps)
      for _, mapId in ipairs(maps) do
        for _, def in ipairs(events[mapId].objects or events[mapId].objectEvents or {}) do
          if (tonumber(def.trainerType) or 0) ~= 0 then
            local t = trainerOf(def)
            if t and gfxIndex[t] == nil then gfxIndex[t] = tonumber(def.graphicsId or def.graphics) end
          end
        end
      end
    end
    return gfxIndex[tid]
  end

  local function surfable(x, y)
    local ok, beh = pcall(Collision.behavior, x, y)
    return ok and Collision.isSurfable and Collision.isSurfable(beh) or false
  end
  -- a tile the partner may stand on: land for a land trainer, water for a
  -- swimmer (sea routes), never a warp
  local function standable(x, y, onWater)
    local ok, beh = pcall(Collision.behavior, x, y)
    if not ok then return false end
    if Collision.isWarpMetatileBehavior and Collision.isWarpMetatileBehavior(beh) then return false end
    if onWater then return surfable(x, y) end
    local okW, walk = pcall(Collision.isWalkable, x, y)
    return okW and walk and not surfable(x, y)
  end

  -- the tile for a partner beside `def`, or nil; `taken` holds occupied tiles
  local function place(def, taken)
    local x, y = tonumber(def.x), tonumber(def.y)
    local face = facingOf(def)
    local onWater = surfable(x, y)
    local sight = {}
    local range = math.max(1, tonumber(def.trainerRange or def.sight) or 1)
    for _, f in ipairs(looks(def)) do
      local d = DIRS[f]
      for i = 1, range do sight[(x + d[1] * i) .. "," .. (y + d[2] * i)] = true end
    end
    -- one step out first (behind, then the sides, then the back corners),
    -- then two steps out in the same order
    local back, s = DIRS[OPPOSITE[face]], SIDE[face]
    local a, b = DIRS[s[1]], DIRS[s[2]]
    local order = { back, a, b, { back[1] + a[1], back[2] + a[2] }, { back[1] + b[1], back[2] + b[2] } }
    local near = #order
    for i = 1, near do order[#order + 1] = { order[i][1] * 2, order[i][2] * 2 } end
    order[#order + 1] = { back[1] * 2 + a[1], back[2] * 2 + a[2] }
    order[#order + 1] = { back[1] * 2 + b[1], back[2] * 2 + b[2] }
    order[#order + 1] = { a[1] * 2 + back[1], a[2] * 2 + back[2] }
    order[#order + 1] = { b[1] * 2 + back[1], b[2] * 2 + back[2] }
    -- pass 1: out of its sight line; 2: in it; 3: any height (bridges)
    local NOTE = { nil, "in sight line", "different height" }
    for pass = 1, 3 do
      for _, d in ipairs(order) do
        local tx, ty = x + d[1], y + d[2]
        local k = tx .. "," .. ty
        local elev = Collision.elevationAt and Collision.elevationAt(tx, ty)
        local elevOk = pass == 3 or not elev or elev == 0 or elev == 15 or tonumber(def.elevation) == nil or elev == tonumber(def.elevation)
        if not taken[k] and standable(tx, ty, onWater) and elevOk and (pass ~= 1 or not sight[k]) then
          return tx, ty, NOTE[pass]
        end
      end
    end
    return nil
  end

  -- the partner objects for one map's object list
  function P.plan(mapId, defs)
    local out, taken, rows = {}, {}, {}
    -- the Battle Pyramid's floors are generated (Frontier, not the campaign)
    if tostring(mapId):find("^EM_BATTLE_PYRAMID") then return out end
    for _, def in ipairs(defs) do taken[tonumber(def.x) .. "," .. tonumber(def.y)] = true end
    trainers.resolve()
    local n = 0
    for _, def in ipairs(defs) do
      local tid = (tonumber(def.trainerType) or 0) ~= 0 and trainerOf(def)
      local t = tid and trainers.byId[tid]
      local partner = t and t.partner and trainers.partners[t.partner]
      if partner then
        local x, y, note = place(def, taken)
        local row = { map = mapId, trainer = tid, partner = partner.name, x = x, y = y, note = note or (not x and "no free tile") or nil }
        rows[#rows + 1] = row
        if x then
          taken[x .. "," .. y] = true
          n = n + 1
          local copy = {}
          for k, v in pairs(def) do copy[k] = v end
          copy.localId, copy.index = P.BASE + n, P.BASE + n
          copy.x, copy.y = x, y
          copy.trainerType, copy.trainerRange, copy.sight = 0, 0, 0
          copy.trainerId = nil
          local gfx = gfxOf(partner.like)
          if gfx then copy.graphicsId, copy.graphics = gfx, gfx else row.note = "looks like its trainer" end
          copy.campaignPartnerOf = tonumber(def.localId or def.index)
          out[#out + 1] = copy
        end
      end
    end
    P.placements[mapId] = rows
    return out
  end

  -- add them for this load only: the ROM's list is put back right after
  local loadMap = Objects.loadMap
  Objects.loadMap = function(game, mapId, mapDef, ...)
    if not active() then P.byMap = {} return loadMap(game, mapId, mapDef, ...) end
    local ev = Space.bundle and Space.bundle.events and Space.bundle.events[mapId]
    local key = ev and (ev.objects and "objects" or ev.objectEvents and "objectEvents")
    local defs = key and ev[key] or (mapDef and mapDef.objects)
    if type(defs) ~= "table" then return loadMap(game, mapId, mapDef, ...) end
    local ok, extra = pcall(P.plan, mapId, defs)
    if not ok then print("[g3_campaign/partners] " .. tostring(extra)) extra = {} end
    if #extra == 0 then P.byMap = {} return loadMap(game, mapId, mapDef, ...) end
    local list = {}
    for i, d in ipairs(defs) do list[i] = d end
    for _, d in ipairs(extra) do list[#list + 1] = d end
    if key then ev[key] = list elseif mapDef then mapDef.objects = list end
    local ok2, r1, r2, r3 = pcall(loadMap, game, mapId, mapDef, ...)
    if key then ev[key] = defs elseif mapDef then mapDef.objects = defs end
    if not ok2 then error(r1, 0) end
    -- walk-through, and who stands beside whom
    P.byMap = {}
    for _, d in ipairs(extra) do
      local eo = Objects.find(d.localId)
      if eo then
        eo.passable = true
        P.byMap[d.campaignPartnerOf] = eo
      end
    end
    return r1, r2, r3
  end

  -- the spotted scene: the partner turns to the player with its own "!"
  mod.events:on("world.trainer_engaged", function(ev)
    if not active() or type(ev) ~= "table" or not ev.npc then return end
    local eo = P.byMap[tonumber(ev.npc.localId)]
    if not eo or eo.hidden then return end
    local Player = package.loaded["src.core.game3.player"]
    if Player and Player.cellX then
      local dx, dy = Player.cellX - eo.cellX, Player.cellY - eo.cellY
      if math.abs(dx) >= math.abs(dy) then eo.facing = dx < 0 and "left" or "right" else eo.facing = dy < 0 and "up" or "down" end
    end
    P.spotted = (P.spotted or 0) + 1
    pcall(require("src.core.game3.field_effects").startExclamation, eo, function() end)
  end)
  return P
end
