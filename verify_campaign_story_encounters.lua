-- Exercise the packaged co-op wiring and real native tutorial constructors.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local Runtime = require('src.core.game3.runtime')
local MR = require('src.mods.Runtime')
local Story = require('src.core.game3.scripting.natives_frontier_story')
local FieldRse = require('src.core.game3.scripting.natives_field_rse')
local s = F.session()
Runtime.session = s
local game = {phase='field',session=s,save={},mods=F.loader}
Runtime._game = game
MR.emit('game.ready', {game=game})
local tr = F.loader.exports.g3_coop.tracker()
-- Keep storage/rules isolated; all event handlers and native constructors are real.
tr.d.read = function() return nil,'not_found' end
tr.d.write = function() return true end
tr.d.options = function() return {on=true,gift=true,static=true,hard=true,dupes=true} end
local area = 16
tr.d.areaOf = function() return area end
tr:ensure()
local function log() return tr.run.logs[tr.tid] end
local function started(species, kinds)
  local st = {kinds=kinds or {},enemy={mon={species=species,personality=0x12345678,otId=111}}}
  MR.emit('battle.started', {kind='wild',speciesId=species,battle=st})
  return st
end
local starter = F.mon('TREECKO', 5, {'POUND'})
s.party = {starter}
tr:_scanParty(s, true)
T.check(tr:view().mine.areas[0], 'starter still counts in Littleroot')
local before = #log()
started(F.species('ZIGZAGOON'), {firstBattle='birch'})
T.eq(tr:blockText(), nil, 'Birch rescue has no encounter restriction')
MR.emit('battle.ended', {result='win'})
T.eq(#log(), before, 'Birch rescue creates no encounter or miss')
T.eq(tr:view().mine.areas[16], nil, 'Route 101 remains available after rescue')

area = 1 -- Norman lends Zigzagoon in Petalburg Gym before walking to Route 102.
Story.savePlayerParty(s)
for _, create in ipairs({Story.wallyZigzagoon, FieldRse.loadWallyZigzagoon}) do
  local zig = create(s)
  T.check(zig._g3coopBorrowed, 'native constructor marks the borrowed Zigzagoon')
  tr:_scanParty(s, true)
  T.eq(#log(), before, 'Norman loan is not a gift encounter')
  zig.hp = 0
  tr:_scanFaints(s)
  T.eq(#log(), before, 'borrowed Zigzagoon never records a faint')
  T.check(not tr:isBanned(zig), 'hard rules leave the borrowed party alone')
end
area = 17
tr:_scanParty(s, true)
T.eq(#log(), before, 'walking to Route 102 cannot turn the loan into a gift')
local st = started(F.species('RALTS'), {tutorial='wally'})
T.eq(tr:blockText(), nil, 'tutorial ball is never restricted')
MR.emit('pokemon.caught', {mon=F.mon('RALTS', 5, {'GROWL'})})
MR.emit('battle.fainted', {battle=st,sideName='player',battler={mon=s.party[1]}})
MR.emit('battle.ended', {result='catch'})
T.eq(#log(), before, 'Wally demonstration records no encounter, catch, miss or faint')
Story.loadPlayerParty(s)
tr:_scanParty(s, true)
T.eq(#log(), before, 'restored real party is not mistaken for gifts')
T.eq(tr:view().mine.areas[1], nil, 'Petalburg encounter stays available')
T.eq(tr:view().mine.areas[17], nil, 'Route 102 encounter stays available')

area = 16
started(F.species('ZIGZAGOON'))
T.eq(tr:view().mine.areas[16].state, 'pending', 'ordinary wild Zigzagoon still counts')
MR.emit('battle.ended', {result='win'})
T.eq(tr:view().mine.areas[16].state, 'failed', 'ordinary Zigzagoon defeat consumes the encounter')
area = 17
local zig = F.mon('ZIGZAGOON', 7, {'TACKLE'})
s.party[#s.party+1] = zig
tr:_scanParty(s, true)
T.eq(tr:view().mine.areas[17].s, F.species('ZIGZAGOON'), 'real Zigzagoon gift still counts')

-- Existing append-only logs normalize on either side without losing real catches.
local SL = dofile('../coop/g3_coop/lib/soullink.lua')
local run = SL.newRun({tid='A',nm='A'}, SL.DEFAULT_RULES, 'legacy')
run.partner = {tid='B',nm='B'}
run.logs.A = {
  {k='enc',a=16,s=277,h='gift'}, {k='catch',a=16,s=277,u='1:1'},
  {k='enc',a=16,s=288,h='static'}, {k='miss',a=16},
  {k='enc',a=1,s=288,h='gift'}, {k='catch',a=1,s=288,u='2:1'},
  {k='enc',a=17,s=392,h='static'}, {k='miss',a=17},
  {k='faint',u='1:1'},
}
run.logs.B = {
  {k='enc',a=16,s=288,h='static'}, {k='miss',a=16},
  {k='enc',a=17,s=288,h='gift'}, {k='catch',a=17,s=288,u='2:2'},
}
local function view() return SL.derive(run, nil, tr.d.giftArea, tr.d.ignoreEncounter) end
local v = view()
T.eq(v.mine.areas[16], nil, 'old Birch miss no longer spends Route 101')
T.eq(v.theirs.areas[16], nil, 'partner old Birch miss also excluded')
T.eq(v.mine.areas[1], nil, 'old Norman loan no longer spends Petalburg')
T.eq(v.mine.areas[17], nil, 'old Wally tutorial no longer spends Route 102')
T.eq(v.theirs.areas[17], nil, 'loan first scanned on Route 102 is excluded')
T.eq(v.lines[288], nil, 'loan does not block Zigzagoon through dupes clause')
T.check(v.dead['1:1'], 'real starter faint history survives normalization')
T.eq(#run.logs.A, 9, 'normalization does not rewrite wire history')
run.logs.A[10] = {k='enc',a=16,s=288,h='wild'}
run.logs.A[11] = {k='catch',a=16,s=288,u='3:1'}
run.logs.A[12] = {k='faint',u='3:1'}
v = view()
T.eq(v.mine.areas[16].u, '3:1', 'later real Zigzagoon remains the Route 101 encounter')
T.check(v.dead['3:1'], 'real Zigzagoon death survives normalization')
T.check(not SL.emeraldStoryEncounter('firered', {a=16,s=288,h='static'}), 'other games are unchanged')
T.finish('campaign scripted encounter exclusions')
