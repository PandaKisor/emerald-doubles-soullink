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
-- vanilla scripts get vanilla's pocket numbers (the find-item script had no
-- case for Inclement's POKé BALLS pocket 6, so a Friend Ball stayed put)
do
  local store=Flags.newStore()
  local sctx={specialVars={},stringVars={}}
  local vm={store=store,ctx=sctx}
  local function pocketCase(sym)
    Flags.setVar(store,sctx,0x8000,items[sym])
    ModRuntime.call('script.command',function() Flags.setVar(store,sctx,0x800D,99) return false end,
      {runner=vm},'checkitemtype',{op='checkitemtype',0x8000})
    return Flags.getVar(store,sctx,0x800D)
  end
  local function bufferedName()
    ModRuntime.call('script.command',function() sctx.stringVars[3]='ITEMS' return false end,
      {runner=vm},'bufferstdstring',{op='bufferstdstring',2,0})
    return sctx.stringVars[3]
  end
  T.eq(pocketCase('ITEM_FRIEND_BALL'),2,'a Friend Ball is in the POKé BALLS case')
  T.eq(pocketCase('ITEM_POTION'),1,'a Potion is in the ITEMS case')
  T.eq(bufferedName(),'MEDICINE','and is put away in the MEDICINE POCKET')
  T.eq(pocketCase('ITEM_X_ACCURACY'),1,'an X Accuracy takes the ITEMS case')
  T.eq(bufferedName(),'BATTLE ITEMS','in the BATTLE ITEMS POCKET')
  T.eq(pocketCase('ITEM_SOOTHE_BELL'),1,'a Soothe Bell is in ITEMS')
  T.eq(bufferedName(),'ITEMS','and keeps the ITEMS POCKET name')
  T.eq(pocketCase('ITEM_TM40_AERIAL_ACE'),3,'a TM is in the TMs & HMs case')
  T.eq(pocketCase('ITEM_ORAN_BERRY'),4,'a berry is in the BERRIES case')
  T.eq(pocketCase('ITEM_MACH_BIKE'),5,'a key item is in the KEY ITEMS case')
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
