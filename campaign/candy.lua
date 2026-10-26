-- START > RARE CANDY grants one reusable candy and opens its normal party
-- controller, including move learning and evolution. The campaign uses
-- g3_coop's current cap, not the donor game's separate badge-cap setting.
return function(mod, data, restoratives, active)
  local Bag = require("src.core.game3.bag")
  local Runtime = require("src.core.game3.runtime")
  local C = { id = assert(data.identity.namespaces.items.ITEM_RARE_CANDY), active = active }

  function C.cap()
    local game = Runtime._game
    local coop = game and game.mods and game.mods.exports and game.mods.exports.g3_coop
    return coop and coop.levelCap and coop.levelCap() or 100
  end

  restoratives.reusableCandy = active
  restoratives._campaignCandy = C
  if not restoratives._campaignOriginalCap then
    restoratives._campaignOriginalCap = restoratives.cap
    restoratives.cap = function(session)
      local current = restoratives._campaignCandy
      if current.active() then return current.cap() end
      return restoratives._campaignOriginalCap(session)
    end
  end

  function C.grant(session)
    if not active() or not (session and session.bag) then return false end
    return Bag.has(session.bag, C.id, 1) or Bag.add(session.bag, C.id, 1)
  end

  function C.open(_, session)
    if not active() then return end
    session = session or Runtime.getSession()
    if not (session and session.party and #session.party > 0) then return end
    require("src.ui.game3.start_menu").close(true)
    if not C.grant(session) then
      require("src.ui.game3.message").show("Make room in your MEDICINE pocket\nfor a reusable RARE CANDY.")
      return
    end
    require("src.ui.game3.party_menu").show(session.party, session.moveOverlay, {
      session = session, bag = session.bag, item = C.id, mode = "use",
    })
  end

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" then at = i + 1 end
    end
    -- Only the ordinary field menu offers the bag (not Safari/Frontier).
    if not at then return out end
    table.insert(copy, at, { id = "g3_campaign_candy", label = "RARE CANDY", onSelect = C.open })
    return copy
  end)
  return C
end
