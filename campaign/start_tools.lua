-- START > TOOLS (user, 2026-10-28): the campaign's field tools under one
-- START entry instead of seven more lines there. The tools still add their
-- own entries (candy.lua, repel.lua, heal.lua, party_tools.lua,
-- guide_sync.lua, anim_viewer.lua); once every mod has added its entries,
-- they move into a list that TOOLS opens in the same window. B goes back.
return function(mod, active)
  local StartMenu = require("src.ui.game3.start_menu")
  local T = {}
  -- the tools, in the order the list shows them
  T.ORDER = { "g3_campaign_candy", "g3_campaign_repel", "g3_campaign_heal", "g3_campaign_ivs",
    "g3_campaign_relearn", "g3_campaign_guide", "g3_campaign_anims" }
  local rank = {}
  for i, id in ipairs(T.ORDER) do rank[id] = i end

  local function se(id)
    pcall(function() require("src.core.game3.audio").playSe(require("src.core.game3.se_ids").resolve(id)) end)
  end

  -- the open START list -> the main list with TOOLS in it, and the tools
  function T.group(entries)
    local main, tools, at = {}, {}, nil
    for _, e in ipairs(entries or {}) do
      if type(e) == "table" and rank[e.id] then
        tools[#tools + 1] = e
        at = at or #main + 1
      else
        main[#main + 1] = e
      end
    end
    if #tools == 0 then return entries, nil end
    table.sort(tools, function(a, b) return rank[a.id] < rank[b.id] end)
    table.insert(main, at, { id = "g3_campaign_tools", label = "TOOLS", onSelect = function() T.open(tools) end })
    return main, tools
  end

  function T.open(tools)
    T.main, T.mainCursor = StartMenu.ENTRIES, StartMenu.cursor
    StartMenu.ENTRIES = tools
    StartMenu.cursor, StartMenu._scrollOffset = 1, 0
    StartMenu.clampScroll()
    StartMenu._g3tools = true
  end

  function T.back()
    StartMenu.ENTRIES = T.main or StartMenu.ENTRIES
    StartMenu.cursor = T.mainCursor or 1
    StartMenu._scrollOffset = 0
    StartMenu.clampScroll()
    StartMenu._g3tools, T.main = nil, nil
  end

  if not StartMenu._g3toolsShow then
    StartMenu._g3toolsShow, StartMenu._g3toolsCancel, StartMenu._g3toolsClose =
      StartMenu.show, StartMenu.cancel, StartMenu.close
    StartMenu.show = function(opts, ...)
      StartMenu._g3tools, T.main = nil, nil
      local r = StartMenu._g3toolsShow(opts, ...)
      if active() and not StartMenu._tutorial then
        local cursorId = StartMenu.ENTRIES[StartMenu.cursor] and StartMenu.ENTRIES[StartMenu.cursor].id
        StartMenu.ENTRIES = T.group(StartMenu.ENTRIES)
        -- the remembered cursor stays on its entry (a tool's goes to TOOLS)
        local want = rank[cursorId] and "g3_campaign_tools" or cursorId
        for i, e in ipairs(StartMenu.ENTRIES) do
          if type(e) == "table" and e.id == want then StartMenu.cursor = i break end
        end
        if StartMenu.cursor > #StartMenu.ENTRIES then StartMenu.cursor = 1 end
        StartMenu.clampScroll()
      end
      return r
    end
    StartMenu.cancel = function(...)
      if StartMenu._g3tools and not StartMenu._confirmExit then
        se("SE_SELECT")
        return T.back()
      end
      return StartMenu._g3toolsCancel(...)
    end
    StartMenu.close = function(...)
      -- a tool that closes START: next time it opens on TOOLS
      if StartMenu._g3tools then
        StartMenu.ENTRIES, StartMenu.cursor = T.main or StartMenu.ENTRIES, T.mainCursor or 1
        StartMenu._g3tools, T.main = nil, nil
      end
      return StartMenu._g3toolsClose(...)
    end
  end
  return T
end
