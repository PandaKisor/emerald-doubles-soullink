-- A first encounter's wild double holds no duplicate lines (user, 2026-10-28):
-- the cart's patched BattleBridge.startWild (build_probe.PATCHES) asks
-- g3_coop's wildPick (lib/tracker.lua pickFirstEncounters) before the battle.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local Runtime = require('src.core.game3.runtime')
local MR = require('src.mods.Runtime')
local Bridge = require('src.core.game3.battle_bridge')
local Encounters = require('src.core.game3.encounters')
local s = F.session()
s.map = 'EM_ROUTE102'
Runtime.session = s
Runtime.getSession = function() return s end
local game = { phase = 'field', session = s, save = {}, mods = F.loader }
Runtime._game = game
MR.emit('game.ready', { game = game })
local tr = F.loader.exports.g3_coop.tracker()
tr.d.read = function() return nil, 'not_found' end
tr.d.write = function() return true end
tr.d.options = function() return { on = true, gift = true, static = true, dupes = true } end
tr.d.areaOf = function() return 17 end
T.check(tr:ensure() ~= nil, 'Soul Link is on')
T.check(type(Bridge.wildPick) == 'function', 'g3_coop installs wildPick on the cart')

local ZIGZAGOON, POOCHYENA, WURMPLE = F.species('ZIGZAGOON'), F.species('POOCHYENA'), F.species('WURMPLE')
-- rolls come from a list; the battle itself is captured, not played
local queue
Encounters.rollSweetScent = function() local sp = table.remove(queue, 1) return sp and { species = sp, level = 3 } or nil end
local started
Bridge.start = function(_, _, foe, opts) started = { foe = foe, opts = opts } return true end
local function step(lead, list)
  queue, started = list, nil
  Bridge._g3coopStep = true       -- as Encounters.onStep marks a step encounter
  Bridge.startWild(nil, game, { species = lead, level = 3 }, {})
  local a = started and started.foe and started.foe.species
  local b = started and started.opts and started.opts.wildPartner and started.opts.wildPartner.species
  return a, b
end

local a, b = step(ZIGZAGOON, { ZIGZAGOON, POOCHYENA })
T.check(a == ZIGZAGOON and b == POOCHYENA, 'two Zigzagoon on a first encounter: the partner is rerolled')
-- Zigzagoon's line is now owned (caught elsewhere)
local view = tr:view()
view.lines[view.baseOf and view.baseOf(ZIGZAGOON) or ZIGZAGOON] = true
a, b = step(ZIGZAGOON, { WURMPLE, POOCHYENA })
T.check(a ~= ZIGZAGOON and b ~= ZIGZAGOON and a ~= b, 'an owned line is rerolled out of a step encounter')
tr.d.options = function() return { on = false } end
tr.viewCache = nil
a, b = step(ZIGZAGOON, { ZIGZAGOON })
T.check(a == ZIGZAGOON and b == ZIGZAGOON, 'with Soul Link off the rolls are left alone')
T.finish('campaign first encounters without duplicates')
