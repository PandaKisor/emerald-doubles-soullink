-- Each player's bag gets 2 Oran Berries and a Potion once Birch's rescue
-- battle (the starter's first fight) ends, so the Route 103 rival isn't a
-- coin flip at level 5 (user, 2026-10-27). Once per save (modData flag).
return function(mod, data, active)
  local Bag = require("src.core.game3.bag")
  local Runtime = require("src.core.game3.runtime")
  local items = data.identity.namespaces.items
  local KIT = { { "ITEM_ORAN_BERRY", 2 }, { "ITEM_POTION", 1 } }
  local K = { kit = KIT }
  local birch = false

  function K.given(session)
    local md = session and session.modData
    return md and md.g3_campaign and md.g3_campaign.starterKit == true or false
  end

  function K.grant(session)
    if not active() or not (session and session.bag) or K.given(session) then return false end
    for _, entry in ipairs(KIT) do
      local id = assert(items[entry[1]], entry[1])
      Bag.add(session.bag, id, entry[2])
    end
    session.modData = session.modData or {}
    session.modData.g3_campaign = session.modData.g3_campaign or {}
    session.modData.g3_campaign.starterKit = true
    return true
  end

  mod.events:on("battle.started", function(ev)
    local kinds = ev and ev.battle and ev.battle.kinds or {}
    birch = kinds.firstBattle == "birch"
  end)
  mod.events:on("battle.ended", function()
    if not birch then return end
    birch = false
    K.grant(Runtime.getSession())
  end)
  return K
end
