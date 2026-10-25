-- Stock-0.3.73 copy of full_port/coop_link_fixture.lua: the same two engine
-- worlds, but with NO engine overlay on package.path.  The patched battle and
-- link modules come from the native probe build of the campaign mod, which
-- installs them from inside the real mod sandbox (native/swap.lua).
package.path='./?.lua;./?/init.lua;'..package.path
local T=require('tests.modkit')
local H=require('tests.link3_harness')
package.loaded['src.link.Wire']=nil
local Json=require('src.link.Json')
local base='../porting/full_port/'
local function read(p) local f=assert(io.open(p,'rb'));local s=f:read('*a');f:close();return s end
local files={}
for path in pairs(assert(Json.decode(read(base..'generated/development-hashes.json')))) do files[path]=read(base..'generated/development/'..path) end
-- the native probe of the campaign mod replaces the development one
local probeRoot='../porting/native/generated/probe/'
for path in pairs(files) do if path:match('^mods/inclement_battle_test/') then files[path]=nil end end
for path in read(probeRoot..'files.txt'):gmatch('[^\n]+') do files[path]=read(probeRoot..path) end
local fs=T.sdk.memfs(files);love.filesystem=fs
local fixture=assert(loadfile(base..'inventory_fixture.lua'))()
local f=fixture('..',read,fs)
-- test plumbing only (as in newPair below): this file's own require() sees
-- the probe's co-op-only modules
for name,m in pairs(assert(f.loader.exports.inclement_battle_test.nativeModules,'native probe did not install')) do package.loaded[name]=m end
local nativeText=assert(loadfile(base..'generated/playtest/userdata/love/inclement-playtest/emerald/data/generated/gba/scripts/text.lua'))()
H.bundle={text=nativeText,textTables={}}
local cache=require('src.core.game3.dataset').cache()
require('src.import.gba.pokemon_extract').runPart(f.rom,cache,{part='data'})
require('src.import.gba.rse.misc_extract').run(f.rom,cache,{game='emerald'})
require('src.import.gba.battle_moves_extract').run(f.rom,cache)
require('src.import.gba.battle_ai_extract').run(f.rom,cache,{game='emerald'})
require('src.core.game3.battle.moves').loadRomPack()
local P=f.P
-- Read the packaged snapshot, not a concurrently changing co-op source tree.
local Team=assert(load(files['mods/g3_coop/lib/teambattle.lua'],'@bundled/teambattle.lua'))()
local Channel=assert(load(files['mods/g3_coop/lib/channel.lua'],'@bundled/channel.lua'))()
local function copy(v) if type(v)~='table' then return v end local r={} for k,x in pairs(v) do r[k]=copy(x) end return r end
local function mon(owner,level,moves)
  local m={species=1,personality=123,level=level,moves=moves or {33},pp={35,35,35,35},item=0,
    ivs={hp=20,atk=20,def=20,spe=20,spa=20,spd=20},evs={hp=0,atk=0,def=0,spe=0,spa=0,spd=0},
    otName=owner==0 and 'BRENDAN' or 'MAY',otId=owner==0 and 111 or 222,otSecretId=0,friendship=70}
  P.applyStats(m);m.hp=m.maxHp
  local Exp=require('src.core.game3.battle.experience')
  Exp.syncExpToLevel(m)
  m.exp=Exp.expForLevel(m,level+1)-1
  return m
end
local function newPair(opts)
  opts=opts or {}
  local wild,eliminate,legacy,disconnect=opts.wild,opts.eliminate,opts.legacy,opts.disconnect
  local sharedCount,sharedSplit=opts.sharedCount,opts.sharedSplit or 1
  local setups={}
  for seat=0,1 do
    local party={}
    for i=1,6 do
      party[i]=mon(seat,opts.playerLevel or 8,i==1 and {33,45,73,74} or {33})
      if i>1 then party[i].item=f.data.identity.namespaces.items.ITEM_EXP_SHARE end
    end
    setups[seat]={name=seat==0 and 'BRENDAN' or 'MAY',trainerId=seat==0 and 111 or 222,gender=seat,party=party}
  end
  local foes={}
  for i=1,2 do
    local party={}
    for j=1,wild and 1 or 3 do
      party[j]=mon(i,opts.foeLevel or 5,opts.foeMoves or {f.data.identity.namespaces.moves.MOVE_ECHOED_VOICE,45})
      if not wild then party[j].hp=opts.foeHp or 4 end
    end
    foes[i]={name='FOE '..i,party=party,trainerId=100+i,class=1,pic=1,aiFlags=1}
  end
  setups[0].foes,setups[0].seed=foes,0x12345
  local worlds,channels,wire={},{},{}
  for seat=0,1 do
    local s={name=setups[seat].name,trainerId=setups[seat].trainerId,gender=seat,secretId=0,
      version='emerald',engine='game3',party=copy(setups[seat].party),bag=f.Bag.new(),
      dex=require('src.core.game3.dex').new(),options={},flags={},vars={},money=1000,map='EM_ROUTE102'}
    f.Bag.add(s.bag,1,10)
    worlds[seat]=H.newWorld('coop-'..seat,s)
    H.run(worlds[seat],function()
      worlds[seat].fixture=fixture('..',read,fs)
      -- test plumbing only: lets this file's own require() see the probe's
      -- co-op-only modules (the engine never asks for them by name)
      local probe=worlds[seat].fixture.loader.exports.inclement_battle_test
      assert(probe and probe.nativeModules,'native probe did not install')
      for name,m in pairs(probe.nativeModules) do package.loaded[name]=m end
      require('src.core.GameVersion').set('emerald')
      require('src.core.game3.scripting.space').ensureBundle=function() return H.bundle end
    end)
  end
  for seat=0,1 do
    channels[seat]=Channel.new(1,function(_,msg)
      wire[#wire+1]={seat=seat,msg=copy(msg)}
      channels[1-seat]:push(assert(Json.decode(Json.encode(msg))))
    end)
    channels[seat].peerSeat=1-seat
  end
  for seat=0,1 do
    local w=worlds[seat]
    H.run(w,function()
      local lk=w.Game3Link.attach(channels[seat],{seat=seat,seats=2,game=w.game,linkType=w.Game3Link.LINKTYPE.BATTLE})
      w.Link.attach(lk)
      w.LB.headless,w.LB.autoFight,w.LB.fade=true,false,false
      local originalHash=w.LB.hashParts
      w.snapshots={}
      w.LB.hashParts=function(st)
        w.snapshots[st.turn]=require('src.core.game3.battle.coop').hashState(st)
        return originalHash(st)
      end
    end)
  end
  for _=1,5 do for seat=0,1 do H.run(worlds[seat],function() worlds[seat].Link.update(1/60) end) end end
  for seat=0,1 do
    local w=worlds[seat]
    H.run(w,function()
      local original=w.LB.beginMulti
      w.LB.beginMulti=function(setup,done,opts)
        opts.battle.coopTeam=not legacy
        opts.battle.coopDisconnect=disconnect
        opts.battle.wild=wild
        if sharedCount then
          local pool={}
          for _,seat in ipairs({3,1}) do for _,m in ipairs(setup[seat].party) do pool[#pool+1]=m end end
          setup[3].party,setup[1].party={},{}
          for i=1,sharedCount do
            local dest=i<=sharedSplit and setup[3].party or setup[1].party
            dest[#dest+1]=pool[i]
          end
          opts.battle.coopSharedFoe=true
          opts.battle.frontierTrainerB=nil
        end
        if wild then
          opts.battle.frontierTrainer=nil;opts.battle.frontierTrainerB=nil;opts.battle.towerLinkMulti=nil
        end
        return original(setup,done,opts)
      end
      local E={LB=w.LB,TowerLink=require('src.core.game3.link.tower_link'),
        Party=require('src.core.game3.party'),Trainers=require('src.core.game3.scripting.trainers')}
      w.E=E
      local Coop=require('src.core.game3.battle.coop')
      local validBall=Coop.validBall
      Coop.validBall=function(st,id,act)
        local valid=validBall(st,id,act)
        if not valid then print('INVALID_BALL',id,st.link,st.multi,st.coopTeam,st.wild,Json.encode(act)) end
        return valid
      end
      local ok,why=Team.begin(E,copy(setups[seat]),copy(setups[1-seat]),seat,function(word) w.result=word end)
      assert(ok,why)
      w.LB.beginMulti=original
      local st=w.Battle.getState()
      if eliminate then st.eliminated[0]=true;st.player.mon.hp=0 end
    end)
  end
  return worlds,channels,wire,setups
end
return { newPair=newPair,T=T,H=H,f=f,Json=Json,Team=Team,Channel=Channel,copy=copy,mon=mon }
