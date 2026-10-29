-- A New Game never inherits the previous game's flags (user, 2026-10-28: the
-- field guide showed fights won on the new save that were only won on the old
-- one). The flag store (scripting/space.lua, patched in build_probe.PATCHES)
-- writes back only into the session it was loaded from, and the guide sync
-- only reads the live store when it belongs to the current session.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local Runtime = require('src.core.game3.runtime')
local Space = require('src.core.game3.scripting.space')
local Flags = require('src.core.game3.scripting.flags')
local CALVIN = 0x500 + 318
-- saved flags are keyed by string (Flags.serialize)
local function has(flags, id) return flags[id] or flags[tostring(id)] end

local old = F.session()
old.flags = { [CALVIN] = true }
Runtime.session = old
local game = { phase = 'field', session = old, save = {}, mods = F.loader }
Runtime._game = game
T.check(pcall(Space.activate, nil, 'EM_ROUTE102', game, {}), 'the old game\'s field starts')
T.check(Flags.getFlag(Space.store, nil, CALVIN), 'the old game has beaten Calvin')

-- New Game while the old field is still active, on a different map ...
local new = F.session()
new.flags = {}
Runtime.session = new
game.session = new
T.check(pcall(Space.activate, nil, 'EM_LITTLEROOT_TOWN', game, {}), 'the new game\'s field starts')
T.check(not has(new.flags, CALVIN), 'the old store is not saved into the new session')
T.check(not Flags.getFlag(Space.store, nil, CALVIN), 'the new game has not beaten Calvin')
T.check(has(old.flags, CALVIN), 'the old session keeps its own flags')

-- ... and on the same map (continue right where the old game stood)
Space.deactivate()
Runtime.session = old; game.session = old
Space.activate(nil, 'EM_ROUTE102', game, {})
local fresh = F.session()
fresh.flags = {}
Runtime.session = fresh; game.session = fresh
Space.activate(nil, 'EM_ROUTE102', game, {})
T.check(not Flags.getFlag(Space.store, nil, CALVIN), 'same map: the store reloads for the new session')
Space.persistSession(nil, game)
T.check(not has(fresh.flags, CALVIN), 'same map: saving writes nothing old into the new session')

-- the guide sync reads only this session's flags
Space.deactivate()
Runtime.session = old; game.session = old
Space.activate(nil, 'EM_ROUTE102', game, {})
local G = F.campaign.guideSync
local snap = G.snapshot(game, fresh)
local seen = false
for _, f in ipairs(snap.flags) do if f == CALVIN then seen = true end end
T.check(not seen, 'the guide sync of a new game holds no old trainer flags')
snap = G.snapshot(game, old)
seen = false
for _, f in ipairs(snap.flags) do if f == CALVIN then seen = true end end
T.check(seen, 'the old game\'s own sync still lists its flags')

-- A New Game gets its own mod storage (user, 2026-10-29: fights came back on a
-- new save). Stock New Game left the session without a playthrough id, so mod
-- storage fell back to the slot's binding -- the old game's -- where g3_coop's
-- trainer credits live and set their flags again on every connect.
local ModRuntime = require('src.mods.Runtime')
local Storage = require('src.mods.Storage')
local Schema = require('src.core.game3.save_schema_firered')
local SD = require('src.core.SaveData')
local coopStore = Storage.new('g3_coop')
local oldSave = { version = 'emerald', meta = {} }
local oldId = SD.ensurePlaythroughId(oldSave)
T.check(type(oldId) == 'string', 'the old game has a playthrough id')
coopStore:write({ save = oldSave }, 'credits', { 318 })
local bare = Schema.toSaveTable(F.session())
T.check(SD.ensurePlaythroughId(bare) == oldId, 'without the fix a New Game lands in the old storage (the leak)')
local session = F.session()
ModRuntime.emit('save.created', { save = session })
local newSave = Schema.toSaveTable(session)
local newId = newSave.meta and newSave.meta.playthroughId
T.check(type(newId) == 'string' and newId ~= oldId, 'save.created gives the New Game its own playthrough id')
local okR, got = pcall(coopStore.read, coopStore, { save = newSave }, 'credits')
T.check(not (okR and type(got) == 'table' and #got > 0), 'the New Game sees no old co-op credits')
local okO, old = pcall(coopStore.read, coopStore, { save = oldSave }, 'credits')
T.check(okO and type(old) == 'table' and old[1] == 318, 'the old game keeps its own storage')
T.finish('campaign New Game flag isolation')
