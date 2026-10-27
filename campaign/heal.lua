-- Field-menu healing uses the same HP/status/PP restoration as a nurse.
return function(mod, active)
  local Runtime = require("src.core.game3.runtime")
  local Party = require("src.core.game3.party")
  local H = {}

  function H.heal(game, session)
    if not active() then return 0, 0 end
    session = session or Runtime.getSession()
    if not (session and session.party) then return 0, 0 end
    game = game or Runtime._game
    local coop = game and game.mods and game.mods.exports and game.mods.exports.g3_coop
    local tracker = coop and coop.tracker and coop.tracker()
    -- Record any field-poison faint before healing can hide it from the scan.
    if tracker and tracker:ensure() then tracker:_scanFaints(session) end
    local party, skipped = {}, 0
    for _, mon in ipairs(session.party) do
      if tracker and tracker:isBanned(mon) then
        skipped = skipped + 1
      else
        party[#party + 1] = mon
      end
    end
    Party.healAll(party)
    return #party, skipped
  end

  function H.open(game, session)
    if not active() then return end
    local count, skipped = H.heal(game, session)
    require("src.ui.game3.start_menu").close(true)
    local text = count > 0 and "Your team was fully healed!" or "No POKeMON could be healed."
    if skipped > 0 then text = text .. "\nSoul Link bans still apply." end
    require("src.ui.game3.message").show(text)
  end

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_heal", label = "HEAL TEAM", onSelect = H.open })
    return copy
  end)
  return H
end
