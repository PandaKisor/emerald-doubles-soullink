-- Inclement Emerald's additions on vanilla Emerald: expanded species, art,
-- abilities, natures, items, learning, evolutions, wild encounters and the
-- expanded-content save identity. Inclement's rebuilt maps, scripts, shops
-- and centers are deliberately left out; the world is the player's ROM.
return function(mod, active)
  local function source(path)
    return assert(load(assert(mod:read(path)), "@" .. mod.path .. "/" .. path))()
  end
  local Pokemon = require("src.core.game3.pokemon")
  local Content = source("full/pokemon_data.lua")
  local data = Content.load(function(path) return mod:read("full/data/" .. path) end)

  -- Expanded moves with battle support, then the learnsets that teach them.
  local routeMoves = source("full/route_moves.lua").install(data, active)
  local U = source("campaign/battle/util.lua")(data)
  U.naturalGift = source("campaign/natural_gift.lua")
  local field = source("campaign/battle/field.lua")(mod, U, active)
  field.items = source("campaign/battle/items.lua")(mod, U, field)
  field.abilities = source("campaign/battle/abilities.lua")(mod, U, field)
  field.ai = source("campaign/battle/ai.lua")(mod, U, field)
  local specs = { U = U, bySymbol = {} }
  for symbol, spec in pairs(source("campaign/battle/hits.lua")(U, field)) do
    if symbol ~= "STATUS_ARG" then specs.bySymbol[symbol] = spec end
  end
  for symbol, spec in pairs(source("campaign/battle/statuses.lua")(U, field)) do specs.bySymbol[symbol] = spec end
  local anims = source("campaign/move_anims.lua")
  anims.install = source("campaign/anim_templates.lua")
  anims.read = function(path) return mod:read(path) end
  source("campaign/anim_code.lua")()
  local moves = source("campaign/moves.lua")(data, source("campaign/move_list.lua"), specs, active, anims)
  mod.exports.campaignAnimViewer = source("campaign/anim_viewer.lua")(mod, data, moves, active)
  local battleMoves = {}
  for id in pairs(routeMoves.supported) do battleMoves[id] = true end
  for id in pairs(moves.supported) do battleMoves[id] = true end
  local gate = source("campaign/moves_gate.lua")(data, battleMoves)
  -- hand-authored teams, then rematches made from them (tools/gen_rematch_teams.py),
  -- then the generated draft (tools/gen_trainer_teams.lua) for anything left
  local teams = source("campaign/trainer_teams.lua")
  for _, layer in ipairs({ source("campaign/trainer_teams_rematch.lua"), source("campaign/trainer_teams_gen.lua") }) do
    for _, key in ipairs({ "trainers", "partners" }) do
      for name, t in pairs(layer[key]) do if teams[key][name] == nil then teams[key][name] = t end end
    end
  end
  local trainers = source("campaign/trainers.lua")(mod, data, teams, active)
  local world = source("campaign/item_world.lua")(mod, data, source("campaign/item_sources.lua"), active)

  Content.install(Pokemon, data, active)
  local Art = source("full/species_art.lua")
  Art.install({ Pokemon = Pokemon, MonAnim = require("src.core.game3.mon_anim"),
    MonAnimData = require("src.core.game3.mon_anim_data"), PicCoords = require("src.core.game3.battle.pic_coords") },
    Art.load(function(path) return mod:read("full/species-art/" .. path) end), active)
  source("campaign/cries.lua")(mod, source)
  source("full/abilities.lua").install({ Pokemon = Pokemon,
    Party = require("src.core.game3.party"), SaveMon = require("src.core.game3.save_mon"),
    State = require("src.core.game3.battle.state"), Evolution = require("src.core.game3.evolution"),
    BenchStatus = require("src.core.game3.battle.party_status_rs"), SummaryData = require("src.core.game3.summary_data"),
  }, data, active)
  source("full/natures.lua").install({ Pokemon = Pokemon,
    SummaryData = require("src.core.game3.summary_data"), SaveMon = require("src.core.game3.save_mon"),
    Party = require("src.core.game3.party"), State = require("src.core.game3.battle.state"),
    Natives = require("src.core.game3.scripting.natives"),
    Pokeblock = require("src.core.game3.rse.pokeblock"),
    RomText = require("src.core.game3.rom_text") }, data, active)
  source("full/inventory.lua").install(require("src.core.game3.items_data"), require("src.core.game3.bag"),
    data, source("full/data/bag.lua"), active)
  source("full/learning.lua").install({ Pokemon = Pokemon,
    ItemsData = require("src.core.game3.items_data") }, data, active)
  source("full/ability_items.lua").install({ Pokemon = Pokemon,
    ItemsData = require("src.core.game3.items_data"), ItemUse = require("src.core.game3.item_use"),
    Bag = require("src.core.game3.bag") }, data, active)
  local fieldItems = source("full/field_items.lua").install(source("full/field-items/model.lua"), active)
  mod.events:on("world.blacked_out", fieldItems.blackout)
  source("full/evolution_items.lua").install(data, source("full/evolution-items/model.lua"), active)
  source("full/medicine.lua").install(data, source("full/medicine/model.lua"), active)
  source("full/level_evolution.lua").install(data, source("full/restoratives/model.lua"), active)
  local restoratives = source("full/restoratives.lua").install(data, source("full/restoratives/model.lua"), active)
  local candy = source("campaign/candy.lua")(mod, data, restoratives, active)
  local repel = source("campaign/repel.lua")(mod, active)
  local heal = source("campaign/heal.lua")(mod, active)
  local partyTools = source("campaign/party_tools.lua")(mod, active)
  local starterKit = source("campaign/starter_kit.lua")(mod, data, active)
  source("full/tutors.lua").install({ Pokemon = Pokemon,
    MoveLearn = require("src.core.game3.move_learn") }, data, active)
  source("full/inventory_ui.lua").install({ ItemsData = require("src.core.game3.items_data"),
    SummaryData = require("src.core.game3.summary_data"),
    Pokemon = Pokemon, BagChrome = require("src.ui.game3.rse.bag_chrome") },
    data, source("full/inventory-ui/model.lua"), source("full/inventory-ui/manifest.lua"),
    mod.path .. "/full/inventory-ui", active)
  source("campaign/wild.lua")(require("src.core.game3.encounters"), data, source("campaign/wild_maps.lua"), active)
  source("campaign/dex.lua")(require("src.ui.game3.rse.mapsec"), Pokemon, source("campaign/dex_entries.lua"), active)

  local SD = require("src.core.SaveData")
  local Save = source("full/save.lua")
  Save.install({ SaveData = SD, Schema = require("src.core.game3.save_schema_firered"),
    Version = require("src.core.GameVersion"), SaveFileIO = require("src.import.SaveFileIO"),
    SaveConvert = require("src.save_convert.SaveConvert") }, data, active)
  return { content = data, save = Save, active = active, learnsets = gate, moves = moves, trainers = trainers, world = world,
    battleMoves = battleMoves, candy = candy, repel = repel, heal = heal, partyTools = partyTools, starterKit = starterKit }
end
