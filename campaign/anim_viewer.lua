-- START > MOVE ANIMS: a practice battle for looking at every new move's
-- animation (campaign/move_anims.lua) in a real battle scene.
--   * the battle: a wild double against level-1 copies of the lead two party
--     species (already seen, so the Pokédex doesn't change)
--   * the list replaces the command menu (it shows only while the battle
--     waits for a command, over the text box): Up/Down pick a move,
--     Left/Right (or L/R) a page, A plays it from your lead onto the foe,
--     SELECT from the foe onto your lead, B hides it (then RUN to leave);
--     SELECT at the command menu brings it back
--   * nothing in it counts: running always works, balls are refused, no EXP,
--     no whiteout, and BattleBridge._campaignPractice tells g3_coop it's no
--     encounter (Soul Link) and no shared battle
return function(mod, data, moves, active)
  local Bridge = require("src.core.game3.battle_bridge")
  local Anim = require("src.core.game3.battle.anim")
  local Runtime = require("src.core.game3.runtime")
  -- the moves with their own converted animation, in name order
  local list = {}
  for id in pairs(moves.scripts or {}) do
    local symbol = moves.records[id] and moves.records[id].id
    if symbol then
      local name = symbol:lower():gsub("_", " "):gsub("(%a)(%w*)", function(a, b) return a:upper() .. b end)
      list[#list + 1] = { id = id, name = name }
    end
  end
  table.sort(list, function(a, b) return a.name < b.name end)

  local V = { open = false, want = false, sel = 1, battle = nil, pending = false, status = nil }
  local Battle = require("src.core.game3.battle")
  local function atCommand()
    return Battle._active == true and Battle._phase == "command" and not Anim.busy()
  end
  local PAGE = 10

  local function practice() return Bridge._campaignPractice == true end

  -- START > MOVE ANIMS
  mod.hooks:wrap("ui.start_menu.items", function(next, g, items)
    local out = next(g, items)
    if type(out) ~= "table" or not active() or #list == 0 then return out end
    local copy, at = {}, nil
    for i, e in ipairs(out) do
      copy[i] = e
      if type(e) == "table" and e.id == "save" and not at then at = i end
    end
    table.insert(copy, at or math.max(1, #copy), {
      id = "g3_campaign_anims", label = "MOVE ANIMS",
      onSelect = function()
        local ok, StartMenu = pcall(require, "src.ui.game3.start_menu")
        if ok and StartMenu and StartMenu.close then StartMenu.close(true) end
        V.pending = true  -- started from the field on the next free tick
      end,
    })
    return copy
  end)

  local function startPractice(g)
    local session = Runtime.getSession()
    local party = session and session.party or {}
    local a, b = party[1], party[2] or party[1]
    if not (a and a.species) then return end
    Bridge._campaignPractice = true
    V.sel, V.status = math.max(1, math.min(V.sel, #list)), nil
    local start = Bridge._g3coopStartWild or Bridge.startWild
    start(Runtime._mod or mod, g, { species = a.species, level = 1 },
      { wildPartner = { species = b.species, level = 1 }, noWhiteout = true, campaignPractice = true })
  end

  mod.events:on("battle.started", function(ev)
    if practice() then
      V.battle = ev and ev.battle
      V.want = true
    end
  end)
  mod.events:on("battle.ended", function()
    if practice() then
      Bridge._campaignPractice = nil
      V.open, V.want, V.battle = false, false, nil
    end
  end)

  -- nothing counts in a practice battle
  mod.hooks:wrap("battle.run", function(next, c)
    if practice() then return true end
    return next(c)
  end)
  mod.hooks:wrap("exp.gain", function(next, info)
    if practice() then return 0 end
    return next(info)
  end)
  local BattleItems = require("src.core.game3.battle.items")
  local use = BattleItems.use
  BattleItems.use = function(st, adapter, bag, session, itemId, ...)
    if practice() and BattleItems.isBall(itemId) then
      local text = "This is a practice battle.\nPOKéMON can't be caught here."
      if adapter and adapter.say then adapter:say(text) end
      return "error", { text }, false, false
    end
    return use(st, adapter, bag, session, itemId, ...)
  end

  local function speciesOf(battler)
    return battler and battler.mon and battler.mon.species or nil
  end
  local function play(reverse)
    local m = list[V.sel]
    if not m or Anim.busy() then return end
    local st = V.battle or {}
    local atk, tgt = 0, 1
    local atkSide, tgtSide = "player", "enemy"
    local atkSp, tgtSp = speciesOf(st.player), speciesOf(st.enemy)
    if reverse then atk, tgt, atkSide, tgtSide, atkSp, tgtSp = 1, 0, "enemy", "player", tgtSp, atkSp end
    local ok, err = pcall(Anim.launchMove, m.id, {
      attackerId = atk, targetId = tgt, attackerSide = atkSide, targetSide = tgtSide,
      isReversed = reverse, attackerSpecies = atkSp, targetSpecies = tgtSp,
      ctx = { moveId = m.id, moveDmg = 1 },
    })
    V.status = ok and (m.name .. (reverse and "  (foe -> you)" or "")) or ("error: " .. tostring(err))
    V.playing = ok
    if not ok then mod.log:warn("move anims: %s: %s", m.name, tostring(err)) end
  end

  -- the list reads this frame's presses (keyboard and pad alike) before the
  -- battle does, and keeps them from it while open
  mod.hooks:wrap("input.step", function(next, g, dt)
    if V.pending and g and g.phase == "field" then
      V.pending = false
      local ok, err = pcall(startPractice, g)
      if not ok then mod.log:warn("move anims: %s", tostring(err)) end
    end
    local input = g and g.input
    local queue = input and input.pressQueue
    if practice() and queue then
      -- shown only while the battle waits for a command (or an animation it
      -- started plays), so the intro and the battle's text run as usual
      if V.open and not V.playing and not atCommand() then V.open = false end
      if V.want and not V.open and atCommand() then V.open = true end
      if V.playing and not Anim.busy() then V.playing = false end
      if V.open then
        for _, b in ipairs(queue) do
          if b == "up" then V.sel = V.sel > 1 and V.sel - 1 or #list
          elseif b == "down" then V.sel = V.sel < #list and V.sel + 1 or 1
          elseif b == "left" or b == "l" then V.sel = math.max(1, V.sel - PAGE)
          elseif b == "right" or b == "r" then V.sel = math.min(#list, V.sel + PAGE)
          elseif b == "a" then play(false)
          elseif b == "select" then play(true)
          elseif b == "b" then V.open, V.want = false, false
          end
        end
        for i = #queue, 1, -1 do queue[i] = nil end
      else
        for i, b in ipairs(queue) do
          if b == "select" and atCommand() then
            V.open, V.want = true, true
            table.remove(queue, i)
            break
          end
        end
      end
    end
    return next(g, dt)
  end)

  -- the list, over the battle's text box (the game area is centred in the
  -- window at 240x160 times the scale)
  local font, fontScale
  mod.hooks:wrap("render.hud", function(next, g, viewport)
    next(g, viewport)
    if not (practice() and love and love.graphics) then return end
    local gfx = love.graphics
    local vp = viewport or {}
    local scale = math.max(1, tonumber(vp.scale) or 3)
    local W, H = vp.width or (240 * scale), vp.height or (160 * scale)
    local gx, gy = math.floor((W - 240 * scale) / 2), math.floor((H - 160 * scale) / 2)
    if fontScale ~= scale then
      local ok, f = pcall(gfx.newFont, "assets/fonts/plainpixel/PlainPixel-Regular.ttf", math.max(8, math.floor(scale * 7)))
      font, fontScale = ok and f or false, scale
    end
    local prev = gfx.getFont()
    if font then gfx.setFont(font) end
    local f = gfx.getFont()
    local lh = f:getHeight()
    local pad = math.floor(scale * 3)
    -- the text box: GBA rows 112-160
    local bx, by, bw, bh = gx, gy + 112 * scale, 240 * scale, 48 * scale
    if not V.open then
      if atCommand() then
        local text = "SELECT: move anim list"
        local tw = f:getWidth(text) + pad * 2
        gfx.setColor(0, 0, 0, 0.75)
        gfx.rectangle("fill", gx + 240 * scale - tw - pad, gy + pad, tw, lh + pad)
        gfx.setColor(1, 1, 1, 1)
        gfx.print(text, gx + 240 * scale - tw, gy + pad + math.floor(pad / 2))
      end
      gfx.setFont(prev)
      return
    end
    gfx.setColor(0.05, 0.07, 0.12, 1)
    gfx.rectangle("fill", bx, by, bw, bh)
    local rows = math.max(1, math.floor((bh - pad * 2) / lh) - 1)
    local half = math.floor(rows / 2)
    local first = math.max(1, math.min(V.sel - half, #list - rows + 1))
    local listW = math.floor(bw * 0.55)
    for i = 0, rows - 1 do
      local m = list[first + i]
      if not m then break end
      local y = by + pad + lh * i
      if first + i == V.sel then
        gfx.setColor(0.25, 0.55, 0.95, 0.95)
        gfx.rectangle("fill", bx + pad / 2, y, listW, lh)
      end
      gfx.setColor(1, 1, 1, 1)
      gfx.print(m.name, bx + pad, y)
    end
    local ix = bx + listW + pad * 2
    gfx.setColor(1, 1, 1, 1)
    gfx.print(("%d / %d"):format(V.sel, #list), ix, by + pad)
    gfx.setColor(0.75, 0.8, 0.9, 1)
    gfx.print("A: play   SELECT: reverse", ix, by + pad + lh)
    gfx.print("L/R: page   B: hide", ix, by + pad + lh * 2)
    if V.status then
      gfx.setColor(0.6, 0.9, 0.6, 1)
      gfx.print(V.status, bx + pad, by + bh - lh - pad / 2)
    end
    gfx.setColor(1, 1, 1, 1)
    gfx.setFont(prev)
  end)

  V.list, V.play = list, play
  return V
end
