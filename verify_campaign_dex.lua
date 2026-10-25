-- The campaign's Pokédex (campaign/dex.lua + the patched dex screen) and its
-- hand-off to g3_coop's level caps, headless on stock 0.3.73 through the
-- built mod: Inclement's species join the HOENN dex past 202 and the
-- NATIONAL dex past 386, the sort orders take them in, the screen's list
-- builds past 386 rows, and g3_coop is told the story is vanilla (its own
-- cap list applies). Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T = F.T
local cache = require('src.core.game3.dataset').cache()
require('src.import.gba.rse.pokedex_chrome_extract').run(F.rom, cache, { cacheRoot = 'data/generated/gba', game = 'emerald' })
require('src.import.gba.pokedex_entries_extract').run(F.rom, cache, { cacheRoot = 'data/generated/gba', game = 'emerald' })
local P = F.P
local Mapsec = require('src.ui.game3.rse.mapsec')
local Gfx = require('src.ui.game3.rse.pokedex_gfx')
local List = require('src.ui.game3.rse.pokedex_list')
Gfx.reset()
-- the screen loads its packs through love.filesystem; here they're in the
-- dataset cache
local Kit = require('src.ui.game3.rse.scene_kit')
local loadLua = Kit.loadLua
Kit.loadLua = function(path)
  local src = cache:read(path)
  if src then return assert(load(src, '@' .. path, 't', {}))() end
  return loadLua(path)
end

local turtwig = P.national(F.ids.species.SPECIES_TURTWIG)
T.eq(turtwig, 387, 'Turtwig is national 387')

-- the HOENN dex goes on past 202
local regional = assert(Mapsec.readLua('pokemon/pokedex/regional.lua'), 'regional pack')
T.eq(regional.nationalToRegional[252], 1, 'Treecko is still HOENN 001')
T.eq(regional.nationalToRegional[387], 203, 'Turtwig is HOENN 203')
T.check(regional.count > 600, 'the HOENN dex holds the new species (' .. regional.count .. ')')
T.eq(regional.numerical[203], 387, 'in national order')

local orders = Gfx.orders()
T.eq(#orders.numerical_hoenn, regional.count, 'the screen lists the same HOENN dex')
T.check(#orders.numerical_national > 386, 'the NATIONAL dex runs past 386 (' .. #orders.numerical_national .. ')')
local inAtoz, inLight = false, false
for _, nat in ipairs(orders.atoz) do if nat == 387 then inAtoz = true end end
for _, nat in ipairs(orders.lightest) do if nat == 387 then inLight = true end end
T.check(inAtoz and inLight, 'A to Z and weight orders include Turtwig')
T.check(#orders.atoz == #orders.lightest and #orders.atoz == #orders.smallest, 'the three sort orders agree')

-- the screen's list, with the last new species seen
local last = orders.numerical_hoenn[#orders.numerical_hoenn]
local seen = { [252] = true, [387] = true, [last] = true }
local ctx = { orders = orders, nationalEnabled = true, nationalCount = #orders.numerical_national,
  seen = function(nat) return seen[nat] == true end, owned = function(nat) return nat == 387 end,
  hoennNumber = function(nat) return regional.nationalToRegional[nat] end }
local list = List.create(ctx, List.DEX_MODE_HOENN, List.ORDER_NUMERICAL)
T.eq(list.count, #orders.numerical_hoenn, 'the HOENN list runs to the last species seen')
T.eq(list.items[202].dexNum, 387, 'row 203 is Turtwig')
T.check(list.items[202].owned, 'owned')
local nat = List.create(ctx, List.DEX_MODE_NATIONAL, List.ORDER_NUMERICAL)
T.check(nat.count > 386, 'the NATIONAL list too')
local abc = List.create(ctx, List.DEX_MODE_HOENN, List.ORDER_ALPHABETICAL)
T.eq(abc.count, 3, 'A to Z lists the three seen')
local counts = List.counts(ctx)
T.eq(counts.hoennSeen, 3, 'and HOENN seen counts them')

-- the patched screen lifts its 386-row limit
local files = assert(loadfile('../porting/native/generated/campaign/mods/g3_campaign/native/files.lua'))()
local shipped
for _, row in ipairs(files) do if row.name == 'src.ui.game3.rse.pokedex' then shipped = row end end
T.check(shipped and shipped.replaces, 'the dex screen ships patched')
local f = assert(io.open('../porting/native/generated/campaign/mods/g3_campaign/native/engine/src/ui/game3/rse/pokedex.lua'))
local src = f:read('*a')
f:close()
T.check(not src:find('>= 386', 1, true) and src:find('MAX_ROWS = 1024', 1, true), 'with no 386-row bound')
local Pokedex = require('src.ui.game3.rse.pokedex')
T.check(type(Pokedex.context) == 'function', 'and installs over the stock module')

-- g3_coop uses its own (vanilla) level-cap list on this cart
T.eq(F.loader.exports.g3_campaign.coopVanillaStory, true, 'the campaign tells g3_coop the story is vanilla')
T.finish('campaign Pokédex')
