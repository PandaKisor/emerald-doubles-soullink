-- Headless stock-0.3.73 fixture for the built campaign mod (g3_campaign):
-- loads generated/campaign/mods/g3_campaign through the real mod loader under
-- the campaign cart, then runs scripted battles. Run from
-- Gen3Mod/gen1recomp-0.3.73 with luajit.
package.path='./?.lua;./?/init.lua;'..package.path
local extraFiles = ...
local T=require('tests.modkit')
local function read(p) local f=assert(io.open(p,'rb'));local s=f:read('*a');f:close();return s end
-- generated/campaign holds the built mod, the g3_coop release it pairs with
-- and the cart, laid out as the game's data folder
local root='../porting/native/generated/campaign'
local files={}
for rel in io.popen('cd '..root..' && find mods carts -type f'):lines() do files[rel]=read(root..'/'..rel) end
for rel, body in pairs(extraFiles or {}) do files[rel] = body end
local fs=T.sdk.memfs(files);love.filesystem=fs
local Version=require('src.core.GameVersion');Version.set('emerald')
local SD=require('src.core.SaveData');SD.setCart('emerald_doubles_soullink')
local romPath='../1986 - Pokemon Emerald (U)(TrashMan).gba'
local native=assert(loadfile('../porting/battle_lab/emerald_data.lua'))()(romPath)
local P=require('src.core.game3.pokemon')
for k,v in pairs(native.gen3Pokemon) do P[k]=v end
P._battleMoves=native.gen3Moves._rom
local romBytes=read(romPath)
local rom=setmetatable({_raw=romBytes,size=#romBytes,id='emerald'},require('src.import.gba.rom'))
require('src.import.gba.versions').select('emerald')
local Loader=require('src.mods.Loader')
local loader=Loader.new({fs=fs,generation=3})
loader:load(native)
assert(#loader.errors==0,table.concat(loader.errors,'\n'))
local campaign=assert(loader.exports.g3_campaign.campaign,'campaign content did not load')
local nativeText=assert(loadfile('../porting/inputs/playtest-pack/data/generated/gba/scripts/text.lua'))()
require('src.core.game3.scripting.space').ensureBundle=function() return {text=nativeText,textTables={}} end
local cache=require('src.core.game3.dataset').cache()
require('src.import.gba.pokemon_extract').runPart(rom,cache,{part='data'})
require('src.import.gba.rse.misc_extract').run(rom,cache,{game='emerald'})
require('src.import.gba.battle_moves_extract').run(rom,cache)
require('src.import.gba.battle_ai_extract').run(rom,cache,{game='emerald'})
require('src.core.game3.battle.moves').loadRomPack()
local data=campaign.content
local ids=data.identity.namespaces

local seed=0x1234
local function lcg(lo,hi)
  seed=(seed*1103515245+24691)%2147483648
  local v=math.floor(seed/65536)
  if lo==nil then return v/32768 end
  if hi==nil then return 1+v%lo end
  return lo+v%(hi-lo+1)
end

local function move(name) return assert(ids.moves['MOVE_'..name],name) end
local function species(name) return assert(ids.species['SPECIES_'..name],name) end
-- A Pokémon of `name` knowing `moves` (names), full HP and PP.
local function mon(name,level,moves,extra)
  local session={party={},trainerId=111,name='BRENDAN',gender=0,version='emerald'}
  assert(require('src.core.game3.party').giveMon(session,species(name),level))
  local m=session.party[1]
  m.moves,m.pp,m.maxPp={}, {}, {}
  for i,n in ipairs(moves) do m.moves[i]=move(n);m.pp[i]=P.movePp(m.moves[i]);m.maxPp[i]=m.pp[i] end
  for k,v in pairs(extra or {}) do m[k]=v end
  P.applyStats(m);m.hp=m.maxHp
  return m
end
local function session()
  return {version='emerald',engine='game3',name='BRENDAN',trainerId=111,secretId=0,gender=0,
    party={},bag=require('src.core.game3.bag').new(),dex=require('src.core.game3.dex').new(),
    options={},flags={},vars={},money=1000,map='EM_ROUTE102'}
end
-- Headless battle; returns the final state and the battle text log.
local function battle(opts)
  local Battle=require('src.core.game3.battle')
  local s=session()
  require('src.core.game3.runtime').getSession=function() return s end
  s.party=opts.playerParty
  opts.session,opts.headless,opts.autoFight,opts.rng=s,true,true,opts.rng or lcg
  local ok,err=Battle.start(opts)
  T.check(ok,'battle starts '..tostring(err or ''))
  return Battle.getState()
end
return {T=T,P=P,data=data,ids=ids,campaign=campaign,loader=loader,rom=rom,move=move,species=species,
  mon=mon,battle=battle,session=session,reseed=function(n) seed=n end}
