-- Inclement's items on the vanilla world (campaign/item_world.lua +
-- item_sources.lua), headless on stock 0.3.73 through the built mod: gift,
-- item ball and hidden item substitutions, the script hook that applies
-- them, and badge-tier mart stock. Run from Gen3Mod/gen1recomp-0.3.73.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local W=assert(F.campaign.world,'item world installed')
local S=W.sources
local items=F.ids.items
local Map=require('src.core.game3.map')
local Flags=require('src.core.game3.scripting.flags')
local ModRuntime=require('src.mods.Runtime')

-- the Victoria (Winstrate) and Oldale gifts, found by their scripts
local function giftKey(item)
  for key,row in pairs(S.gifts) do for v,sym in pairs(row) do if sym==item then return key,tonumber(v) end end end
end
for _,sym in ipairs({'ITEM_LIFE_ORB','ITEM_FOCUS_SASH','ITEM_CHOICE_SCARF','ITEM_ROCKY_HELMET'}) do
  local key,v=giftKey(sym)
  T.check(key~=nil,sym..' replaces a vanilla gift')
  if key then T.eq(W.substitute('ANY',0,v,0,key),items[sym],sym..' through its script') end
end
T.eq(W.substitute('EM_OLDALE_TOWN',0,13,0,'g3:00000000'),nil,'other scripts keep their gifts')
-- item balls by local id
local route104=S.balls.EM_ROUTE104
T.check(route104~=nil,'Route 104 has changed item balls')
for lid,sym in pairs(route104 or {}) do
  T.eq(W.substitute('EM_ROUTE104',1,0,tonumber(lid)),items[sym],'Route 104 ball '..lid..' gives '..sym)
end
-- hidden items by tile
for tile,sym in pairs(S.hidden.EM_ROUTE111 or {}) do
  local x,y=tile:match('(%d+),(%d+)')
  T.eq(W.hiddenAt('EM_ROUTE111',tonumber(x),tonumber(y)),items[sym],'Route 111 hidden '..tile..' is '..sym)
end
-- the script hook rewrites VAR_0x8000 before the obtain/find script runs
do
  local key,v=giftKey('ITEM_LIFE_ORB')
  local store=Flags.newStore()
  local vm={store=store,ctx={specialVars={},pc={listKey=key,index=3}}}
  Flags.setVar(store,vm.ctx,0x8000,v)
  local Ctx=require('src.core.game3.scripting.ctx')
  ModRuntime.call('script.command',function() return false end,{runner=vm},'callstd',{op='callstd',std=0})
  T.eq(Flags.getVar(store,vm.ctx,0x8000),items.ITEM_LIFE_ORB,'the hook swaps the item the script gives')
  Flags.setVar(store,vm.ctx,0x8000,v)
  ModRuntime.call('script.command',function() return false end,{runner=vm},'callstd',{op='callstd',std=2})
  T.eq(Flags.getVar(store,vm.ctx,0x8000),v,'other std scripts are left alone')
end
-- marts: vanilla stock + Inclement's badge tier + the town's own stock
local Marts=require('src.core.game3.marts')
local fortreeKey
for k,m in pairs(S.marts) do if m.label=='FortreeCity_Mart_EventScript_Clerk' then fortreeKey=k end end
T.check(fortreeKey~=nil,'Fortree mart is mapped')
Marts._byKey=Marts._byKey or {}
Marts._byKey[fortreeKey]={key=fortreeKey,items={4,13}}
local list=Marts.itemsFor(fortreeKey)
local has={}
for _,x in ipairs(list or {}) do has[x]=true end
T.check(has[4] and has[13],'vanilla stock stays (Poké Ball, Potion)')
T.check(has[items.ITEM_RAZOR_CLAW] and has[items.ITEM_DRAGON_SCALE],'Fortree sells its evolution items')
T.check(has[items.ITEM_CHOICE_SCARF],'items given by NPCs vanilla lacks are sold in their town')
local n0=#list
local badges=W.badges
W.badges=function() return 5 end
T.check(#Marts.itemsFor(fortreeKey)>n0,'more badges, more stock')
W.badges=badges
-- every evolution item has a source (generator audit, rerun here)
local Pokemon=require('src.core.game3.pokemon')
local sources={}
for _,t in ipairs({S.balls,S.hidden}) do for _,row in pairs(t) do for _,sym in pairs(row) do sources[sym]=true end end end
for _,row in pairs(S.gifts) do for _,sym in pairs(row) do sources[sym]=true end end
for _,tier in ipairs(S.tiers) do for _,sym in ipairs(tier) do sources[sym]=true end end
for _,m in pairs(S.marts) do for _,sym in ipairs(m.extra or m.items or {}) do sources[sym]=true end end
for _,sym in ipairs({'ITEM_DUSK_STONE','ITEM_SHINY_STONE','ITEM_DAWN_STONE','ITEM_ICE_STONE','ITEM_RAZOR_CLAW','ITEM_RAZOR_FANG',
    'ITEM_ELECTIRIZER','ITEM_MAGMARIZER','ITEM_PROTECTOR','ITEM_REAPER_CLOTH','ITEM_DUBIOUS_DISC','ITEM_PRISM_SCALE','ITEM_OVAL_STONE',
    'ITEM_WHIPPED_DREAM','ITEM_SACHET'}) do
  T.check(sources[sym],sym..' can be obtained')
end
T.finish('campaign item world')
