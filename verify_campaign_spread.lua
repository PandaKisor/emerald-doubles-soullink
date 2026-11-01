-- Spread moves (campaign/spread_moves.json) and key gifts (campaign/key_gifts.lua),
-- headless on stock 0.3.73 through the built mod: each listed move hits both
-- foes in a double from either side, the moves kept single-target stay so, and
-- the gifts, their lines and the shops line up.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
local T=F.T
local State=require('src.core.game3.battle.state')
local Battle=require('src.core.game3.battle')
local Engine=require('src.core.game3.battle.engine')
local Moves=require('src.core.game3.battle.moves')
local SPREAD={'LOW_SWEEP','MIRROR_SHOT','EXTRASENSORY','BUG_BUZZ','SILVER_WIND','MAGICAL_LEAF','LEAF_TORNADO','GUST',
  'HURRICANE','SHOCK_WAVE','FLAME_BURST','NIGHT_DAZE','ECHOED_VOICE','ROUND','CHATTER'}
for _,s in ipairs(SPREAD) do T.eq(tonumber(Moves.get(F.move(s)).target),8,s..' targets both foes') end
for _,s in ipairs({'WATER_PULSE','BUBBLE_BEAM','PSYCHIC','AIR_SLASH'}) do
  T.eq(tonumber(Moves.get(F.move(s)).target),0,s..' stays single-target')
end

local current
local resolve=Engine.resolveMove
Engine.resolveMove=function(user,target,moveId,...)
  local st=select(3,...)
  local n=tonumber(moveId) or Moves.numForName(moveId)
  if not current or n~=current.id then return resolve(user,target,moveId,...) end
  local u=st and State.occupant(st,user) or user
  local a,b=current.foes(u)
  local foeA,foeB=State.battler(st,a),State.battler(st,b)
  local ha,hb=foeA and foeA.mon and foeA.mon.hp or 0,foeB and foeB.mon and foeB.mon.hp or 0
  local ally=State.battler(st,State.PARTNER(State.idOf(u)))
  local hAlly=ally and ally.mon and ally.mon.hp or 0
  local r={resolve(user,target,moveId,...)}
  if ha>0 and hb>0 then
    current.uses=current.uses+1
    local na,nb=foeA.mon.hp,foeB.mon.hp
    -- a Ground type shrugs off Shock Wave, which still has to reach it
    local function took(b,was,now)
      return now<was or (current.id==F.move('SHOCK_WAVE') and (b.type1==4 or b.type2==4))
    end
    if took(foeA,ha,na) and took(foeB,hb,nb) then current.both=current.both+1 end
    if ally and ally.mon and ally.mon.hp<hAlly then current.ally=true end
  end
  return unpack(r)
end
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local TRAINER=assert(C.trainers.byName.TRAINER_ROXANNE_1)
local function run(symbol,foeUses)
  local id=F.move(symbol)
  current={id=id,uses=0,both=0}
  current.foes=function(u) local me=State.idOf(u) return (me+1)%4,(me+3)%4 end
  F.reseed(0x4321)
  local function team(moves) local p={} for i=1,3 do p[i]=F.mon('MEW',40,moves) end return p end
  local foe=Trainers.foeFromId(TRAINER)
  foe.party=team(foeUses and {symbol} or {'TACKLE'})
  foe.doubleBattle=true
  local ok,err=pcall(F.battle,{playerParty=team(foeUses and {'TACKLE'} or {symbol}),foe=foe,double=true,trainerId=TRAINER})
  Battle.reset()
  T.check(ok,symbol..' battle runs: '..tostring(err))
  local who=foeUses and 'foe' or 'player'
  T.check(current.uses>0 and current.both>0,symbol..' ('..who..') damages both foes in one use')
  T.check(not current.ally,symbol..' ('..who..') leaves the ally alone')
  print(('%-14s %-6s both-hit uses %d of %d'):format(symbol,who,current.both,current.uses))
end
for _,s in ipairs(SPREAD) do run(s,false); run(s,true) end

-- Wide Gems: only the matching type, only single-target, permanent
local function wide(symbol,moves,item)
  current={id=F.move(symbol),uses=0,both=0}
  current.foes=function(u) local me=State.idOf(u) return (me+1)%4,(me+3)%4 end
  F.reseed(0x4321)
  local p={}
  for i=1,3 do p[i]=F.mon('MEW',40,moves,{item=F.ids.items[item]}) end
  local foe=Trainers.foeFromId(TRAINER)
  local q={} for i=1,3 do q[i]=F.mon('MEW',40,{'TACKLE'}) end
  foe.party=q; foe.doubleBattle=true
  local ok,err=pcall(F.battle,{playerParty=p,foe=foe,double=true,trainerId=TRAINER})
  Battle.reset()
  T.check(ok,symbol..' with '..item..' runs: '..tostring(err))
  local out={uses=current.uses,both=current.both,left=p[1].item or p[1].heldItem}
  current=nil
  return out
end
local r=wide('CRUNCH',{'CRUNCH'},'ITEM_WIDE_DARK_GEM')
T.check(r.uses>0 and r.both>0,'Wide Dark Gem: Crunch hits both foes ('..r.both..'/'..r.uses..')')
T.eq(r.left,F.ids.items.ITEM_WIDE_DARK_GEM,'the gem is kept')
r=wide('CRUNCH',{'CRUNCH'},'ITEM_WIDE_STEEL_GEM')
T.eq(r.both,0,'Wide Steel Gem leaves Crunch alone')
r=wide('DOUBLE_KICK',{'DOUBLE_KICK'},'ITEM_WIDE_FIGHTING_GEM')
T.eq(r.both,0,'a multi-hit move stays single-target')
r=wide('SHADOW_BALL',{'SHADOW_BALL'},'ITEM_WIDE_GHOST_GEM')
T.check(r.both>0,'Wide Ghost Gem: Shadow Ball hits both foes')

-- key gifts
local W=F.campaign.world
local S=W.sources
local ids=F.ids.items
for key,row in pairs(S.gifts) do for v,sym in pairs(row) do T.check(ids[sym]~=nil,sym..' exists') end end
T.eq(W.substitute('ANY',0,296,0,'g3:081fc855'),ids.ITEM_TM88_LOW_SWEEP,'Brawly gives Low Sweep')
T.eq(W.substitute('ANY',0,296,0,'g3:081fc878'),ids.ITEM_TM88_LOW_SWEEP,'Brawly, second script')
T.eq(W.substitute('ANY',0,322,0,'g3:0820df8d'),ids.ITEM_TM73_THUNDER_WAVE,'Wattson gives Thunder Wave')
-- every old gift and formerly unobtainable TM reaches a shop
local sold={}
for _,m in pairs(S.marts) do for _,x in ipairs(m.extra or {}) do sold[x]=true end for _,x in ipairs(m.items or {}) do sold[x]=true end end
for _,sym in ipairs({'ITEM_TM72_VOLT_SWITCH','ITEM_TM31_BRICK_BREAK','ITEM_TM08_BULK_UP','ITEM_TM05_ROAR','ITEM_TM41_TORMENT','ITEM_TM45_ATTRACT',
    'ITEM_TM34_SLUDGE_WAVE','ITEM_TM82_DRAGON_TAIL','ITEM_TM67_RECYCLE','ITEM_HEAT_ROCK','ITEM_DAMP_ROCK','ITEM_SMOOTH_ROCK','ITEM_ICY_ROCK'}) do
  T.check(sold[sym],sym..' is sold')
end
-- lines: known ROM keys, fit the box, parse
local RomText=require('src.core.game3.rom_text')
local TextIR=require('src.core.game3.scripting.text_ir')
for key,line in pairs(S.giftText) do
  T.check(RomText.has(key),key..' is a ROM text')
  for row in (line.."\n"):gmatch('([^\n\f]*)[\n\f]') do T.check(#row:gsub('é','e')<=38,'fits: '..row) end
  local ir=TextIR.fromAscii(line)
  local nl,para=0,0
  for _,s in ipairs(ir) do if s.t=='nl' then nl=nl+1 elseif s.t=='para' then para=para+1 end end
  T.check((line:find('\n',1,true)==nil or nl>0) and (line:find('\f',1,true)==nil or para>0),'breaks parse: '..key)
end
-- the line goes through the script hook into the VM's text, which message boxes read
local ModRuntime=require('src.mods.Runtime')
local Vm=require('src.core.game3.scripting.vm')
local key='g3:081fd181'
local vm=setmetatable({text={[key]=RomText.ir(key)},adapters={}},{__index=Vm})
T.check(vm:getText(key)~=nil,'test VM has the ROM line')
ModRuntime.call('script.command',function() return false end,{runner=vm},'loadword',{op='loadword',0,key,value=key,dest=0})
local shown={}
for _,seg in ipairs(vm:getText(key)) do if seg.s then shown[#shown+1]=seg.s end end
T.check(table.concat(shown,' '):find('LOW SWEEP',1,true)~=nil,'Brawly names Low Sweep in the message box')
T.check(table.concat(shown,' '):find('BULK UP',1,true)==nil,'Bulk Up is gone from his line')
-- HM moves without knowing them
local FM=require('src.core.game3.field_moves')
local Runtime=require('src.core.game3.runtime')
local Bag=require('src.core.game3.bag')
local Flags=require('src.core.game3.scripting.flags')
local party={F.mon('MEW',20,{'TACKLE'}),F.mon('MEW',20,{'TACKLE'})}
party[1].isEgg=true
local bag=Bag.new()
local getSession=Runtime.getSession
Runtime.getSession=function() return {bag=bag,party=party} end
T.eq(FM.partyMoveUser(party,'SURF'),nil,'no HM, nobody surfs')
Bag.add(bag,ids.ITEM_HM03_SURF,1)
local who,slot=FM.partyMoveUser(party,'SURF')
T.eq(who,party[2],'holding the HM, the first non-egg surfs')
T.eq(slot,1,'its party slot')
local store=Flags.newStore()
local sctx={specialVars={},stringVars={}}
local vmH={store=store,ctx=sctx}
local function check(move)
  ModRuntime.call('script.command',function() Flags.setVar(store,sctx,0x800D,6) return false end,{runner=vmH},'checkpartymove',{op='checkpartymove',move})
  return Flags.getVar(store,sctx,0x800D)
end
T.eq(check(FM.MOVES.SURF),1,'scripts accept a held HM')
T.eq(check(FM.MOVES.CUT),6,'scripts still refuse an HM not held')
T.eq(#FM.campaignMenuMoves(party[2]),#party[2].moves,'no Fly or Flash in the menu without the HM')
Bag.add(bag,ids.ITEM_HM02_FLY,1)
T.eq(FM.campaignMenuMoves(party[2])[#party[2].moves+1],FM.MOVES.FLY,'Fly shows once the HM is held')
Runtime.getSession=getSession
T.finish('campaign spread moves and key gifts')
