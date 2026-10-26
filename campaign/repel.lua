-- Unlimited normal Repel, stored with this save. Keep any paid Repel's
-- remaining steps intact so switching the toggle off resumes that item.
return function(mod, active)
  local Sem = require("src.core.game3.field_semantics")
  local Steps = require("src.core.game3.step_events")
  local Runtime = require("src.core.game3.runtime")
  local R = {}
  function R.enabled(session)
    local md = session and session.modData
    return active() and md and md.g3_campaign and md.g3_campaign.repel == true or false
  end
  function R.toggle(session)
    if not active() or not session then return false end
    session.modData = session.modData or {}
    session.modData.g3_campaign = session.modData.g3_campaign or {}
    session.modData.g3_campaign.repel = not R.enabled(session)
    return R.enabled(session)
  end

  Sem._campaignRepel = R
  if not Sem._campaignRepelGet then
    Sem._campaignRepelGet = Sem.getVar
    Sem.getVar = function(session, name)
      local value = Sem._campaignRepelGet(session, name)
      if name == "repelSteps" and Sem._campaignRepel.enabled(session) then
        return math.max(2, tonumber(value) or 0)
      end
      return value
    end
    local step = Steps.onRepelStep
    Steps.onRepelStep = function(session, game)
      if Sem._campaignRepel.enabled(session) then return false end
      return step(session, game)
    end
  end

  mod.hooks:wrap("ui.start_menu.items", function(next, game, items)
    local out = next(game, items)
    if not active() or type(out) ~= "table" then return out end
    local copy, at = {}, nil
    for i, entry in ipairs(out) do
      copy[i] = entry
      if entry.id == "bag" or entry.id == "g3_campaign_candy" then at = i + 1 end
    end
    if not at then return out end
    local function label(session) return "REPEL: " .. (R.enabled(session) and "ON" or "OFF") end
    local entry = { id = "g3_campaign_repel", label = label(Runtime.getSession()) }
    entry.onSelect = function(_, session)
      session = session or Runtime.getSession()
      R.toggle(session)
      entry.label = label(session)
    end
    table.insert(copy, at, entry)
    return copy
  end)
  return R
end
