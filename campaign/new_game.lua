-- A New Game gets its own playthrough identity (user, 2026-10-29: beaten
-- trainers came back on a new save). Stock Gen 3 New Game leaves the session
-- without meta.playthroughId, so mod storage (SaveData.ensurePlaythroughId)
-- fell back to the save slot's existing binding: the old game's storage.
-- g3_coop keeps its trainer credits there and sets their flags again on every
-- connect. A fresh id gives the new game empty mod storage; its first SAVE
-- rebinds the slot to it (SaveData.save -> rememberPlaythroughId). Until then
-- Continue still loads the old game with its own storage.
return function(mod, active)
  local SaveData = require("src.core.SaveData")
  local N = {}

  function N.fresh(session)
    if not (active() and type(session) == "table") then return nil end
    session.meta = type(session.meta) == "table" and session.meta or {}
    session.meta.playthroughId = SaveData.newPlaythroughId()
    return session.meta.playthroughId
  end

  mod.events:on("save.created", function(ev) N.fresh(ev and ev.save) end)
  return N
end
