-- Inclement's items on the vanilla world (campaign/item_sources.lua, made by
-- tools/gen_item_sources.py):
--   * item balls and hidden items on the same tile as Inclement's give
--     Inclement's item (Mega Stones, Z-Crystals and Bottle Caps excluded)
--   * scripted gifts give Inclement's item where its version of the same
--     script (same label) does (Oldale's mart guide: Focus Sash, Victoria: Life Orb, ...)
--   * town marts sell vanilla's stock plus Inclement's badge-tier stock and
--     the town's own Inclement stock (evolution items, battle items, special
--     balls, and items Inclement gives through NPCs vanilla doesn't have);
--     specialty shops sell Inclement's list for them; an item Inclement
--     gives for free (price 0) costs what sources.prices says
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
  -- Vanilla scripts number the pockets as vanilla's bag does (1 ITEMS,
  -- 2 POKé BALLS, 3 TMs & HMs, 4 BERRIES, 5 KEY ITEMS), but the campaign bag
  -- has Inclement's seven, so checkitemtype answers in vanilla's numbers:
  -- a Friend Ball (Inclement's pocket 6) had no case, and the find-item
  -- script stopped with the ball still on the ground. MEDICINE and BATTLE
  -- ITEMS have no vanilla pocket: they take the ITEMS case, and the pocket
  -- name the script buffers next is rewritten.
  local ItemsData = require("src.core.game3.items_data")
  local VANILLA_POCKET = { ITEMS = 1, POKE_BALLS = 2, TM_CASE = 3, BERRY_POUCH = 4, KEY_ITEMS = 5 }
  local POCKET_NAME = { MEDICINE = "MEDICINE", BATTLE = "BATTLE ITEMS" }
  W.VANILLA_POCKET, W.POCKET_NAME = VANILLA_POCKET, POCKET_NAME
  local pocketName = setmetatable({}, { __mode = "k" })
  mod.hooks:wrap("script.command", function(next, ctx, op, row)
    local runner = ctx and ctx.runner
    if active() and runner and runner.store and row and (op == "checkitemtype" or op == "bufferstdstring") then
      local done = next(ctx, op, row)
      local sctx = runner.ctx
      if op == "checkitemtype" then
        local item = tonumber(row[1] or row.item)
        if item and item >= 0x4000 then item = Flags.getVar(runner.store, sctx, item) end
        local pocket = item and ItemsData.pocketOf(item)
        Flags.setVar(runner.store, sctx, 0x800D, VANILLA_POCKET[pocket] or 1)
        pocketName[sctx] = POCKET_NAME[pocket]
      elseif pocketName[sctx] then
        local dest = (tonumber(row.dest or row[1]) or 0) + 1
        local vars = sctx and sctx.stringVars
        -- the ITEMS case's name ("put away the X in the ITEMS POCKET.")
        if vars and tostring(vars[dest]):find("ITEMS", 1, true) then vars[dest] = pocketName[sctx] end
        pocketName[sctx] = nil
      end
      return done
    end
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
  -- a mart item Inclement prices at 0 (a gift there) costs sources.prices
  -- (full/inventory.lua replaces ItemsData.info after this runs, so the
  -- wrapper goes on whatever is there when a mart opens)
  local priceOf = {}
  for sym, price in pairs(sources.prices or {}) do
    if id(sym) then priceOf[id(sym)] = price end
  end
  local priced
  local function wrapPrices()
    if ItemsData.info == priced then return end
    local info0 = ItemsData.info
    priced = function(item, ...)
      local info = info0(item, ...)
      if active() and info and (tonumber(info.price) or 0) == 0 and priceOf[info.id] then info.price = priceOf[info.id] end
      return info
    end
    ItemsData.info = priced
  end
  W.wrapPrices = wrapPrices
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
    wrapPrices()
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
