-- START > TOOLS > PC (user, 2026-11-01): the boxes from anywhere, since a Soul
-- Link run swaps teams all the time. Not during a tutorial or before the first
-- Pokémon, because the start menu only lists it once there is a party.
return function(mod, active)
  local R = {}
  function R.open(game, session)
    if not active() then return end
    -- START stays open under it, so B comes back to TOOLS
    require("src.ui.game3.pc_menu").show({
      session = session or require("src.core.game3.runtime").getSession(),
      startMode = "storage", closeOnExit = true, silentClose = true,
    })
  end
  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local s = require("src.core.game3.runtime").getSession()
    if not (s and s.party and #s.party > 0) then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_pc", label = "PC", onSelect = R.open })
    return copy
  end)
  return R
end
