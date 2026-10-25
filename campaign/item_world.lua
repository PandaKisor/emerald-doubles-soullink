-- Inclement's items on the vanilla world (campaign/item_sources.lua, made by
-- tools/gen_item_sources.py):
--   * item balls and hidden items on the same tile as Inclement's give
--     Inclement's item (Mega Stones, Z-Crystals and Bottle Caps excluded)
--   * scripted gifts give Inclement's item where its version of the same
--     script (same label) does (Oldale's mart guide: Focus Sash, Victoria: Life Orb, ...)
--   * town marts sell vanilla's stock plus Inclement's badge-tier stock and
--     the town's own Inclement stock (evolution items, battle items, special
--     balls, and items Inclement gives through NPCs vanilla doesn't have);
--     specialty shops sell Inclement's list for them
return function(mod, data, sources, active)
  local Flags = require("src.core.game3.scripting.flags")
  local Map = require("src.core.game3.map")
  local items = data.identity.namespaces.items
  local W = { sources = sources }
  local function id(sym) return items[sym] end
  local function mapId() return Map.current end

  -- the item a vanilla script hands out on `map` becomes Inclement's: an item
  -- ball (find item, std 1) by the ball's local id, a gift (obtain item,
  -- std 0) by the script giving it and the vanilla item
  function W.substitute(map, std, item, talked, script)
    local sym
    if std == 1 then
      local balls = sources.balls[map]
      sym = balls and balls[tostring(talked)]
    end
    if not sym and script then
      local gifts = sources.gifts[script]
      sym = gifts and gifts[tostring(item)]
    end
    return sym and id(sym) or nil
  end
  function W.hiddenAt(map, x, y)
    local h = sources.hidden[map]
    local sym = h and h[x .. "," .. y]
    return sym and id(sym) or nil
  end
  mod.hooks:wrap("script.command", function(next, ctx, op, row)
    if active() and op == "callstd" and row then
      local std = tonumber(row.std or row[1])
      local vm = ctx and ctx.runner
      if vm and vm.store and (std == 0 or std == 1) then
        local item = Flags.getVar(vm.store, vm.ctx, 0x8000)
        local pc = vm.ctx and vm.ctx.pc
        local new = W.substitute(mapId(), std, item, Flags.getVar(vm.store, vm.ctx, 0x800F), pc and pc.listKey)
        if new and new ~= item then Flags.setVar(vm.store, vm.ctx, 0x8000, new) end
      end
    end
    return next(ctx, op, row)
  end)

  -- hidden items
  local Field = require("src.core.game3.field")
  local pick = Field.pickUpHiddenItem
  Field.pickUpHiddenItem = function(game, hidden, ...)
    if active() and type(hidden) == "table" then
      local new = W.hiddenAt(mapId(), tonumber(hidden.x) or -1, tonumber(hidden.y) or -1)
      if new then
        local copy = {}
        for k, v in pairs(hidden) do copy[k] = v end
        copy.item = new
        hidden = copy
      end
    end
    return pick(game, hidden, ...)
  end

  -- marts
  local function badges()
    local Space = package.loaded["src.core.game3.scripting.space"]
    local store = Space and Space.store
    if not store then return 0 end
    local ok, n = pcall(Flags.countBadges, store)
    return ok and tonumber(n) or 0
  end
  W.badges = badges
  local Marts = require("src.core.game3.marts")
  Marts._campaignWorld = W
  local itemsFor = Marts.itemsFor
  Marts.itemsFor = function(key, ...)
    local list, entry = itemsFor(key, ...)
    if not active() then return list, entry end
    local k = type(key) == "string" and key or (entry and entry.key)
    local m = k and sources.marts[k]
    if not m then return list, entry end
    local out, seen = {}, {}
    local function add(x)
      x = tonumber(x) or id(x)
      if x and x ~= 0 and not seen[x] then seen[x] = true; out[#out + 1] = x end
    end
    if m.kind == "general" then
      for _, x in ipairs(list or {}) do add(x) end
      local tier = sources.tiers[math.min(#sources.tiers, W.badges() + 1)] or {}
      for _, x in ipairs(tier) do add(x) end
      for _, x in ipairs(m.extra or {}) do add(x) end
    else
      for _, x in ipairs(m.items or {}) do add(x) end
      if #out == 0 then return list, entry end
    end
    return out, entry
  end
  return W
end
