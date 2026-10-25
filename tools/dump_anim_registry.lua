-- Prints the engine's battle-anim sprite callbacks and tasks ("cb X" / "task X")
-- for anim_convert.py. Run from the stock engine tree with luajit.
package.path = "./?.lua;./?/init.lua;" .. package.path
local GV = require("src.core.GameVersion"); GV.set("emerald")
local C = require("src.core.game3.battle.anim_callbacks")
local Tasks = require("src.core.game3.battle.anim_tasks"); Tasks.init()
local out = {}
for k, v in pairs(C) do if type(v) == "function" then out[#out+1] = "cb " .. k end end
for k in pairs(Tasks.REGISTRY) do out[#out+1] = "task " .. k end
table.sort(out); print(table.concat(out, "\n"))
