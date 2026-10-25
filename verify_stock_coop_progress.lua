local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,copy,Json=F.T,F.copy,F.Json
local base='../porting/full_port/'
local P=require('src.core.game3.coop_progress')
local Vm=require('src.core.game3.scripting.vm')
local Flags=require('src.core.game3.scripting.flags')
local Adapters=require('src.core.game3.scripting.adapters')
local Runtime=require('src.core.game3.runtime')
local Space=require('src.core.game3.scripting.space')
local Field=require('src.core.game3.field')
local current
Runtime.getSession=function() return current and current.s end
local item=F.f.data.identity.namespaces.items.ITEM_TM39_ROCK_TOMB
local gift=F.f.data.identity.namespaces.species.SPECIES_TREECKO
local api=F.f.loader.exports.inclement_battle_test.coopProgress
T.eq(api.API,1,'sealed cartridge exports versioned progression API')
T.eq(api.build,P.BUILD,'engine and cartridge continuation versions match')
local scripts={start={{op='setvar',0x4050,1},{op='trainerbattle',trainer=265,type=1,eventScript='reward'}, {op='end'}},
  reward={{op='setflag',flag=0x867},{op='additem',item,1},{op='setvar',0x4051,2},
    {op='givemon',gift,5,0,0,0,0},{op='releaseall'},{op='end'}}}
local function world(name,id,rows,text)
  local s={version='emerald',engine='game3',name=name,trainerId=id,secretId=id+1,gender=0,
    bag=F.f.Bag.new(),party={},options={},flags={},vars={},custom={},modData={},money=id}
  local w={s=s,battles=0,messages={},map='EM_RUSTBORO_CITY_GYM'}
  local a=Adapters.stub({playerName=name})
  a.modifyItem=function(op,id,n) return op=='additem' and F.f.Bag.add(s.bag,id,n) or F.f.Bag.remove(s.bag,id,n) end
  a.openMessageAsync=function(msg,done) w.messages[#w.messages+1]=msg;if done then done() end end
  a.startTrainerBattle=function(foe,done,opts) w.battles=w.battles+1;w.done=done;w.opts=opts end
  a.playFanfare=function() end;a.fanfarePlaying=function() return false end
  a.onFlagChanged=function() end
  a.listActiveLocalIds=function() return {} end
  a.unfreezeLocal=function() end
  w.vm=Vm.new({store={flags=s.flags,vars=s.vars},scripts=copy(rows or scripts),text=text or {},adapters=a,playerName=name})
  return w
end
local function select(w) current=w;Space.vm=w.vm;Space.store=w.vm.store;Space.mapId=w.map;Field.locked=false end
local function drain(w)
  select(w)
  for _=1,1000 do if not w.vm:isRunning() then return end;w.vm:tick() end
  error('continuation did not finish: '..tostring(w.vm.ctx.pc and w.vm.ctx.pc.listKey))
end
local host,guest=world('BRENDAN',111),world('MAY',222)
select(host);host.vm:start('start',nil,true)
T.eq(host.battles,1,'source VM reaches one real battle')
T.eq(host.opts.coopContinuationError,nil,'continuation captured without error')
local d=assert(host.opts.coopContinuation)
local packet=assert(Json.decode(Json.encode(d)))
T.check(P.prepare(host.s,host.vm,'pair:1:host',d,true),'source binds held VM')
T.check(P.prepare(guest.s,guest.vm,'pair:1:host',packet,false),'guest accepts JSON round trip')
T.eq(P.status(guest.s,'pair:1:host'),'battle','receipt prepared before combat')
T.check(P.canSave(guest.s),'prepared receipt is safely saveable')
local bad=copy(packet);bad.trainerId=266
T.eq(P.prepare(guest.s,guest.vm,'bad',bad,false),false,'mismatched trainer checkpoint rejected')
bad=copy(packet);bad.build='other'
T.eq(P.prepare(guest.s,guest.vm,'bad',bad,false),false,'different build rejected')
T.eq(P.ack(guest.s,'pair:1:host'),false,'receipt cannot be acknowledged before completion')
select(host);host.done('win');drain(host)
T.eq(P.status(host.s,'pair:1:host'),'done','source completion observed at VM halt')
T.eq(F.f.Bag.get(host.s.bag,item),1,'source receives its TM once')
T.eq(host.s.flags[0x867],true,'source receives badge')
T.eq(#host.s.party,1,'source receives gift')
T.check(P.blocked(),'new story fights wait for peer acknowledgement')
select(guest);Flags.setTrainerDefeated(guest.vm.store,nil,265,true)
T.check(P.resolve(guest.s,'pair:1:host','win'),'guest records shared result')
local pending=assert(Json.decode(Json.encode(guest.s.modData)))
guest.s.modData=pending -- simulate save/reload before replay
Space.mapId='ELSEWHERE'
local ok,why=P.replay(guest.s,guest.vm,'pair:1:host')
T.eq(ok,false,'reconnect on another map defers')
T.eq(why,'return_to_map','deferred scene gives explicit reason')
T.eq(F.f.Bag.get(guest.s.bag,item),0,'deferred scene has no partial rewards')
select(guest);T.check(P.replay(guest.s,guest.vm,'pair:1:host'),'guest replays post-battle VM')
drain(guest)
T.eq(guest.battles,0,'guest never repeats battle')
T.eq(P.status(guest.s,'pair:1:host'),'done','guest completion recorded')
T.eq(guest.s.flags[0x867],true,'already-credited guest gets badge')
T.eq(guest.s.vars[0x4050],1,'pre-battle quest var synchronized')
T.eq(guest.s.vars[0x4051],2,'post-battle quest var synchronized')
T.eq(F.f.Bag.get(guest.s.bag,item),1,'guest receives its TM')
T.eq(#guest.s.party,1,'guest receives its own gift')
T.eq(guest.s.party[1].otId,222,'gift uses recipient trainer identity')
T.eq(host.s.party[1].otId,111,'source gift retains its own identity')
T.eq(guest.s.money,222,'personal money never copied')
T.check(P.resolve(guest.s,'pair:1:host','win'),'duplicate result accepted')
T.check(P.replay(guest.s,guest.vm,'pair:1:host'),'duplicate replay is a no-op')
T.eq(F.f.Bag.get(guest.s.bag,item),1,'duplicate packet does not duplicate TM')
T.eq(#guest.s.party,1,'duplicate packet does not duplicate gift')
T.check(P.ack(guest.s,'pair:1:host'),'peer completion acknowledgement accepted')
T.eq(P.blocked(),false,'barrier clears after both finish')
T.eq(P.history(guest.s)[1],'pair:1:host','acknowledged result remains discoverable after peer rolls back save')
T.check(P.canSave(guest.s),'completed effects and receipt can save together')
guest.s.modData=assert(Json.decode(Json.encode(guest.s.modData)))
T.check(P.replay(guest.s,guest.vm,'pair:1:host'),'receipt survives save/load')
T.eq(#guest.s.party,1,'reload plus resend cannot duplicate gift')
T.eq(P.resolve(guest.s,'pair:1:host','lose'),false,'conflicting result refused')

-- Actual native save schema and serializer persist effects and receipts together.
local Schema=require('src.core.game3.save_schema_firered')
local bridge=F.f.SD._inclementFullSave
bridge.stamp(guest.s,bridge.data)
local saved=Schema.toSaveTable(guest.s)
local restored=Schema.fromSaveTable(assert(F.f.SD.decode(F.f.SD.encode(saved))))
T.eq(P.status(restored,'pair:1:host'),'done','native save restores completion receipt')
T.eq(F.f.Bag.get(restored.bag,item),1,'native save restores rewarded TM')
T.eq(restored.party[1].otId,222,'native save restores local gift identity')
T.check(P.replay(restored,guest.vm,'pair:1:host'),'saved completion ignores resend')
T.eq(#restored.party,1,'native save plus resend does not repeat gift')

for _,change in ipairs({function(v) v.scene={{id=1,x='bad',y=2,facing='up',hidden=false,visible=true}} end,
    function(v) v.temps['7']=2 end,function(v) v.vars[1].after=0/0 end,
    function(v) v.specials['32781']={} end,function(v) v.early=not v.early end}) do
  local malformed=copy(packet);change(malformed)
  T.eq(P.prepare(guest.s,guest.vm,'malformed',malformed,false),false,'malformed descriptor rejected before effects')
end
bad=copy(packet);bad.player={x=1,y=2,facing='up'}
T.eq(P.prepare(guest.s,guest.vm,'pair:1:host',bad,false),false,'event ID cannot be reused for another descriptor')
local conflict=world('MAY',300)
conflict.s.vars[0x4050]=9
P.prepare(conflict.s,conflict.vm,'conflict',packet,false);P.resolve(conflict.s,'conflict','win');select(conflict)
local allowed,reason=P.replay(conflict.s,conflict.vm,'conflict')
T.eq(allowed,false,'newer personal quest value is not rolled back')
T.eq(reason,'story_conflict','conflict is actionable')
T.eq(F.f.Bag.get(conflict.s.bag,item),0,'conflict detected before any reward')
T.eq(conflict.s.vars[0x4050],9,'conflict leaves story untouched')
local _,_,detail=P.replay(conflict.s,conflict.vm,'conflict')
T.eq(detail and detail.kind,'var','conflict names the mismatched kind')
T.eq(detail and detail.id,0x4050,'conflict names the mismatched var')
T.eq(detail and detail.actual,9,'conflict reports the local value')
T.eq(detail and detail.after,1,'conflict reports the expected value')
T.eq(P.status(conflict.s,'conflict'),'queued','preflight conflict leaves the receipt queued, not partial')

-- A fault while staging (before the VM's own wrapper) is a failed receipt.
local staging=world('MAY',304)
P.prepare(staging.s,staging.vm,'staging',packet,false);P.resolve(staging.s,'staging','win');select(staging)
local seen
local ModRuntime=require('src.mods.Runtime')
local oldEmit=ModRuntime.emit
ModRuntime.emit=function(name,ev,...) if name=='coop.progress' then seen=ev end;return oldEmit(name,ev,...) end
P._stageFault=function() error('injected staging failure') end
local sok,swhy=P.replay(staging.s,staging.vm,'staging')
P._stageFault=nil;ModRuntime.emit=oldEmit
T.eq(sok,false,'staging fault refuses the replay')
T.eq(swhy,'failed','staging fault reports failure')
T.eq(P.status(staging.s,'staging'),'failed','staging fault records failed receipt')
T.check(P.get(staging.s,'staging').error:find('injected staging failure',1,true),'staging fault cause retained')
T.eq(seen and seen.status,'failed','staging fault is announced to co-op')
T.eq(Field.locked,false,'staging fault releases field controls')
T.eq(staging.vm:isRunning(),false,'staging fault leaves no running VM')
T.eq(P.canSave(staging.s),false,'staging fault cannot reach a save')

-- Later ticks fail safely, and a queued UI prompt cannot be overwritten.
local failing=world('MAY',301)
local releaseMessage
failing.vm.adapters.askYesNo=function(done) releaseMessage=done end
failing.vm.scripts=copy(scripts)
table.insert(failing.vm.scripts.reward,2,{op='yesnobox',0,0})
failing.vm.text.msg={{t='text',s='Claim reward'},{t='eos'}}
select(failing);failing.vm:start('start',nil,true)
local fd=assert(failing.opts.coopContinuation)
P.prepare(failing.s,failing.vm,'failure',fd,true)
failing.done('win');failing.vm:tick()
T.eq(P.status(failing.s,'failure'),'running','waiting continuation has running receipt')
T.eq(P.canSave(failing.s),false,'save prohibited between partial rewards and receipt completion')
bridge.stamp(failing.s,bridge.data)
T.eq(pcall(Schema.toSaveTable,failing.s),false,'real save schema enforces running-event barrier')
T.eq(failing.vm:start('start',nil,true),false,'new VM event cannot replace held continuation')
failing.vm.adapters.modifyItem=function() error('injected later reward failure') end
assert(releaseMessage)(true);failing.vm:tick()
T.eq(P.status(failing.s,'failure'),'failed','later-tick exception records failed receipt')
T.check(P.get(failing.s,'failure').error:find('injected later reward failure',1,true),'failure cause retained')
T.eq(P.canSave(failing.s),false,'partial failed reward cannot reach save')
T.eq(P.replay(failing.s,failing.vm,'failure'),false,'partial failed reward cannot be retried')
T.eq(Field.locked,false,'failure releases field controls for reload')

local unsafe=world('BRENDAN',302,{start={{op='additem',item,1},{op='trainerbattle',trainer=265,type=1,eventScript='reward'}},reward={{op='end'}}})
select(unsafe);unsafe.vm:start('start',nil,true)
T.eq(unsafe.opts.coopContinuation,nil,'pre-battle personal rewards require authored scene handling')
T.eq(unsafe.opts.coopContinuationError,'pre_battle_personal_state','unsafe prelude has explicit reason')
for _,case in ipairs({{'chained_battle',{op='dowildbattle'}},
    {'map_transition',{op='warp',1,2,3},{op='setvar',0x4060,1}}, {'native_battle',{op='special',239}}}) do
  local w=world('MAY',303,{start={{op='trainerbattle',trainer=265,type=1,eventScript='reward'}},reward={case[2],case[3] or {op='end'},{op='end'}}})
  select(w);w.vm:start('start',nil,true)
  T.eq(w.opts.coopContinuationError,case[1],'unsupported continuation refused before team battle')
end

-- A saved prepared origin can receive the survivor's result after restarting.
local recovered=world('MAY',333)
T.check(P.prepare(recovered.s,recovered.vm,'survivor:1',packet,false),'fallback descriptor prepared')
select(recovered);P.resolve(recovered.s,'survivor:1','win');P.replay(recovered.s,recovered.vm,'survivor:1');drain(recovered)
T.eq(recovered.s.flags[0x867],true,'reconnected player recovers progression after fallback win')

-- The initiator left a started shared battle without a win (partner dropped):
-- it detaches, halts its own script, and later takes the partner's fallback win.
local left=world('BRENDAN',446)
select(left);left.vm:start('start',nil,true)
local ld=assert(left.opts.coopContinuation)
T.check(P.prepare(left.s,left.vm,'left:1',ld,true),'dropped initiator binds event')
T.eq(P.detach(left.s,left.vm,'other'),false,'detach refuses an event it does not hold')
T.check(P.detach(left.s,left.vm,'left:1'),'dropped initiator detaches held VM')
T.eq(P.detach(left.s,left.vm,'left:1'),false,'detach is not repeatable')
Field.locked=true;left.done('cancel');drain(left)
T.eq(left.vm:isRunning(),false,'detached script halts without its continuation')
T.eq(P.status(left.s,'left:1'),'battle','detached receipt keeps no local result')
T.eq(left.s.flags[0x867],nil,'detached initiator gets no reward yet')
T.check(P.blocked(),'unresolved receipt holds further story fights')
T.check(P.canSave(left.s),'detached receipt is saveable')
left.s.modData=assert(Json.decode(Json.encode(left.s.modData)))
T.check(P.resolve(left.s,'left:1','win'),'partner fallback win accepted after detach')
select(left);T.check(P.replay(left.s,left.vm,'left:1'),'detached initiator replays partner win');drain(left)
T.eq(P.status(left.s,'left:1'),'done','detached initiator completes')
T.eq(left.s.flags[0x867],true,'detached initiator receives badge from fallback win')
T.eq(F.f.Bag.get(left.s.bag,item),1,'detached initiator receives its TM once')
T.eq(left.battles,1,'detached initiator never re-fights')
local lost=world('BRENDAN',447)
select(lost);lost.vm:start('start',nil,true)
P.prepare(lost.s,lost.vm,'lost:1',lost.opts.coopContinuation,true)
lost.done('lose');drain(lost)
T.eq(P.detach(lost.s,lost.vm,'lost:1'),false,'resolved receipt cannot detach')
T.check(api.detach~=nil,'cartridge exports detach')

-- A cancelled type-3 rival must not fall through into the post-battle vars.
local cancel=world('BRENDAN',444,{start={{op='trainerbattle',trainer=532,type=3},
  {op='setvar',0x4055,9},{op='end'}}})
select(cancel);cancel.vm:start('start',nil,true)
T.check(P.prepare(cancel.s,cancel.vm,'cancel',cancel.opts.coopContinuation,true),'cancel test binds event')
Field.locked=true;cancel.done('cancel');drain(cancel)
T.eq(cancel.s.vars[0x4055],nil,'called-off rival does not advance story')
T.eq(Flags.isTrainerDefeated(cancel.vm.store,nil,532),false,'called-off rival stays unbeaten')
T.eq(cancel.vm:isRunning(),false,'cancelled VM shuts down')
T.eq(P.status(cancel.s,'cancel'),'cancelled','cancel result is distinct from defeat')

local defeated=world('BRENDAN',445)
select(defeated);defeated.vm:start('start',nil,true)
P.prepare(defeated.s,defeated.vm,'defeat',defeated.opts.coopContinuation,true)
defeated.done('lose');drain(defeated)
T.eq(P.status(defeated.s,'defeat'),'cancelled','ordinary defeat has no reward continuation')
T.eq(defeated.s.flags[0x867],nil,'ordinary defeat gives no badge')
T.eq(F.f.Bag.get(defeated.s.bag,item),0,'ordinary defeat gives no TM')
local Bridge=require('src.core.game3.battle_bridge')
local oldStart=Bridge.start
local bridgeOpts
Bridge.start=function(_,_,_,opts) bridgeOpts=opts end
Adapters.host(nil,{session=defeated.s},nil).startTrainerBattle({trainerId=265},function() end,
  {coopContinuation=packet,coopContinuationError='example'})
T.eq(bridgeOpts.coopContinuation,packet,'native adapter forwards descriptor to co-op interception')
T.eq(bridgeOpts.coopContinuationError,'example','native adapter forwards unsupported reason')
Bridge.start=oldStart

local Objects=require('src.core.game3.objects')
local oldPerm,oldMap=Objects._perm,Objects._mapId
Objects._perm={};Objects._mapId='EM_RUSTBORO_CITY_GYM'
local sceneRows={start={{op='setobjectxyperm',2,5,6},{op='trainerbattle',trainer=265,type=1,eventScript='reward'}},
  reward={{op='setobjectxyperm',3,7,8},{op='end'}}}
local sceneSource=world('BRENDAN',448,sceneRows)
sceneSource.vm.adapters.setObjectState=Adapters.host(nil,{session=sceneSource.s},nil).setObjectState
select(sceneSource);sceneSource.vm:start('start',nil,true)
local sd=assert(sceneSource.opts.coopContinuation)
T.eq(#sd.objects,2,'checkpoint records only changed pre-battle object coordinates')
Objects._perm={OTHER_MAP={[9]={x=90,y=91}}}
local scenePeer=world('MAY',449,sceneRows)
scenePeer.vm.adapters.setObjectState=Adapters.host(nil,{session=scenePeer.s},nil).setObjectState
select(scenePeer);api.prepare('scene',sd,false);api.resolve('scene','win');api.replay('scene');drain(scenePeer)
T.eq(Objects._perm[scenePeer.map][2].x,5,'pre-battle object template update reaches partner')
T.eq(Objects._perm[scenePeer.map][3].y,8,'native continuation performs post-battle object update')
T.eq(Objects._perm.OTHER_MAP[9].x,90,'unrelated personal object state preserved')
Objects._perm,Objects._mapId=oldPerm,oldMap

-- Real native gym continuation: inspect/capture and execute the extracted VM.
local dir=base..'generated/playtest/userdata/love/inclement-playtest/emerald/data/generated/gba/scripts/'
local native=assert(loadfile(dir..'scripts.lua'))()
local labels=assert(loadfile(dir..'labels.lua'))()
local text=assert(loadfile(dir..'text.lua'))()
Space.ensureBundle=function() return {text=text,textTables=assert(loadfile(dir..'text_tables.lua'))()} end
local n=world('BRENDAN',555,native,text)
select(n);n.vm:start(labels.RustboroCity_Gym_EventScript_Roxanne,nil,true)
T.eq(n.battles,1,'actual Roxanne script reaches battle')
T.eq(n.opts.coopContinuationError,nil,'actual Roxanne continuation is supported')
local descriptor=assert(n.opts.coopContinuation)
local peer=world('MAY',666,native,text)
select(peer);P.prepare(peer.s,peer.vm,'roxanne',descriptor,false);P.resolve(peer.s,'roxanne','win')
local worked,reason=P.replay(peer.s,peer.vm,'roxanne')
T.check(worked,'actual Roxanne replay starts: '..tostring(reason));drain(peer)
T.eq(peer.s.flags[0x867],true,'native Roxanne awards Stone Badge to partner')
T.check(F.f.Bag.get(peer.s.bag,item)>0,'native Roxanne gives Rock Tomb TM to partner')
T.eq(peer.battles,0,'native continuation never re-fights leader')

-- Emerald's early rival (Route 103, trainerbattle_no_intro = mode 3) has no
-- FireRed EARLY_RIVAL heal-on-loss: a loss is an ordinary defeat/whiteout.
local Opcodes=require('src.core.game3.scripting.opcodes')
T.check(Opcodes.active():trainerBattleType(3)~='EARLY_RIVAL','Emerald mode 3 is not the FireRed early rival')
T.check(Opcodes.active():trainerBattleType(9)~='EARLY_RIVAL','Emerald mode 9 is not the FireRed early rival')

-- Chained fights (Museum, Space Center): each fight is a phase with its own
-- receipt; reaching the next fight completes the phase before it.
local chainRows={start={{op='trainerbattle',trainer=265,type=3},{op='setvar',0x4070,1},
  {op='trainerbattle',trainer=266,type=3},{op='setvar',0x4071,1},{op='additem',item,1},{op='end'}}}
local function chainWorld(name,id) local w=world(name,id,chainRows);return w end
local CA,CB=chainWorld('BRENDAN',801),chainWorld('MAY',802)
select(CA);CA.vm:start('start',nil,true)
local c1=assert(CA.opts.coopContinuation,'first fight captured')
T.eq(CA.opts.coopContinuationError,nil,'chained scene is no longer refused')
T.eq(c1.chain,nil,'first phase follows nothing')
T.check(P.prepare(CA.s,CA.vm,'chain:1',c1,true),'leader binds phase 1')
select(CB);T.check(P.prepare(CB.s,CB.vm,'chain:1',assert(Json.decode(Json.encode(c1))),false),'follower prepares phase 1')
P.resolve(CB.s,'chain:1','win')
select(CA);P.resolve(CA.s,'chain:1','win');CA.done('win')
for _=1,50 do CA.vm:tick();if CA.battles==2 then break end end
T.eq(CA.battles,2,'leader script reaches the second fight')
T.eq(P.status(CA.s,'chain:1'),'done','reaching the next fight completes phase 1 (leader)')
T.eq(CA.opts.coopChain,'chain:1','second fight names its phase')
local c2=assert(CA.opts.coopContinuation,'second fight captured after a won phase')
T.eq(c2.chain,'chain:1','checkpoint links to phase 1')
T.eq(#c2.vars,0,'phase 2 prelude starts at the boundary')
T.eq(CA.s.vars[0x4070],1,'between-fight story ran on the leader')
select(CB);T.check(P.replay(CB.s,CB.vm,'chain:1'),'follower replays phase 1')
for _=1,50 do CB.vm:tick();if CB.battles==1 then break end end
T.eq(CB.battles,1,'follower replay stops at the second fight')
T.eq(P.status(CB.s,'chain:1'),'done','phase 1 done on the follower')
T.eq(CB.opts.coopChain,'chain:1','follower fight names the same phase')
T.eq(CB.opts.coopBound,nil,'nothing prepared yet for phase 2')
T.eq(CB.s.vars[0x4070],1,'between-fight story replayed on the follower')
-- both games fight phase 2 together, each continuing its own script
select(CA);T.check(P.prepare(CA.s,CA.vm,'chain:2',c2,true),'leader binds phase 2')
select(CB);T.check(P.prepare(CB.s,CB.vm,'chain:2',assert(Json.decode(Json.encode(c2))),true),'follower binds its own waiting script to phase 2')
P.resolve(CB.s,'chain:2','win');CB.done('win');drain(CB)
select(CA);P.resolve(CA.s,'chain:2','win');CA.done('win');drain(CA)
for _,w in ipairs({CA,CB}) do
  select(w)
  T.eq(P.status(w.s,'chain:2'),'done','phase 2 done in each game')
  T.eq(w.s.vars[0x4071],1,'post-scene story in each game')
  T.eq(F.f.Bag.get(w.s.bag,item),1,'scene reward once in each game')
end
-- a partner who missed it all gets both phases later, in order, no battles
local CL=chainWorld('MAY',803)
select(CL)
for _,id in ipairs({'chain:1','chain:2'}) do
  local d=assert(Json.decode(Json.encode(id=='chain:1' and c1 or c2)))
  T.check(P.prepare(CL.s,CL.vm,id,d,false),'late partner prepares '..id);P.resolve(CL.s,id,'win')
end
local okW,whyW=P.replay(CL.s,CL.vm,'chain:2')
T.eq(okW,false,'a later phase waits for the one before');T.eq(whyW,'chain_wait','chain wait is explicit')
T.check(P.replay(CL.s,CL.vm,'chain:1'),'late partner replays phase 1');drain(CL)
T.eq(CL.battles,0,'late partner never fights either phase')
T.eq(P.status(CL.s,'chain:1'),'done','late phase 1 done')
T.eq(P.status(CL.s,'chain:2'),'done','late phase 2 taken at its fight')
T.eq(CL.s.vars[0x4071],1,'late partner finishes the scene')
T.eq(F.f.Bag.get(CL.s.bag,item),1,'late partner reward once')
-- the leader's phase 2 prep can arrive before the follower reaches the fight
local CF=chainWorld('MAY',804)
select(CF)
P.prepare(CF.s,CF.vm,'chain:1',assert(Json.decode(Json.encode(c1))),false);P.resolve(CF.s,'chain:1','win')
T.check(P.prepare(CF.s,CF.vm,'chain:2',assert(Json.decode(Json.encode(c2))),false),'early phase 2 prep accepted')
P.replay(CF.s,CF.vm,'chain:1')
for _=1,50 do CF.vm:tick();if CF.battles==1 then break end end
T.eq(CF.opts.coopBound,'chain:2','reaching the fight binds the prepared phase')
T.eq(P.get(CF.s,'chain:2').origin,true,'follower script now holds phase 2')
P.resolve(CF.s,'chain:2','win');CF.done('win');drain(CF)
T.eq(P.status(CF.s,'chain:2'),'done','bound phase completes')
T.eq(F.f.Bag.get(CF.s.bag,item),1,'bound phase reward once')
-- a follower that left at the fight later replays phase 2 on its own
local CH=chainWorld('MAY',805)
select(CH)
P.prepare(CH.s,CH.vm,'chain:1',assert(Json.decode(Json.encode(c1))),false);P.resolve(CH.s,'chain:1','win')
P.replay(CH.s,CH.vm,'chain:1')
for _=1,50 do CH.vm:tick();if CH.battles==1 then break end end
Field.locked=true;CH.done('cancel');drain(CH)
T.eq(CH.vm:isRunning(),false,'follower left the scene at the fight')
P.prepare(CH.s,CH.vm,'chain:2',assert(Json.decode(Json.encode(c2))),false);P.resolve(CH.s,'chain:2','win')
T.check(P.replay(CH.s,CH.vm,'chain:2'),'phase 2 replays on its own afterwards');drain(CH)
T.eq(CH.s.vars[0x4071],1,'left follower finishes the scene later')
T.eq(F.f.Bag.get(CH.s.bag,item),1,'left follower reward once')

-- the native Museum scene: two grunts, now two linked phases
do
  local M=world('BRENDAN',806,native,text);M.map='EM_SLATEPORT_CITY_OCEANIC_MUSEUM_2F'
  select(M);M.vm:start(labels.SlateportCity_OceanicMuseum_2F_EventScript_CaptStern,nil,true)
  for _=1,400 do if M.battles>0 or not M.vm:isRunning() then break end;M.vm:tick() end
  T.eq(M.battles,1,'Museum reaches the first grunt')
  T.eq(M.opts.coopContinuationError,nil,'Museum first grunt is supported')
  local m1=M.opts.coopContinuation
  if m1 then
    P.prepare(M.s,M.vm,'museum:1',m1,true);P.resolve(M.s,'museum:1','win');M.done('win')
    for _=1,2000 do if M.battles>1 or not M.vm:isRunning() then break end;M.vm:tick() end
    T.eq(M.battles,2,'Museum reaches the second grunt')
    T.eq(M.opts.coopChain,'museum:1','second grunt follows the first')
    T.eq(M.opts.coopContinuationError,nil,'Museum second grunt is supported')
  end
end

-- Scenes that end by moving the player on (a warp then waitstate/release/end):
-- each game plays the whole ending and makes the same move. Native scripts.
local facade=F.f.data.identity.namespaces.items.ITEM_TM42_FACADE
for _,scene in ipairs({
    {label='PetalburgCity_Gym_EventScript_NormanBattle',trainer=269,map='EM_PETALBURG_CITY_GYM',badge=0x86B,tm=facade,facing=2},
    {label='EverGrandeCity_ChampionsRoom_EventScript_Wallace',trainer=335,map='EM_EVER_GRANDE_CITY_CHAMPIONS_ROOM'},
    {label='SeafloorCavern_Room9_EventScript_ArchieAwakenKyogre',trainer=34,map='EM_SEAFLOOR_CAVERN_ROOM9'}}) do
  local name=scene.label:match('EventScript_(.*)$')
  local src=world('BRENDAN',560,native,text);src.map=scene.map
  local function mover(w)
    w.vm.adapters.warp=function(g,n,id,x,y,done) w.warped={g,n,x,y};if done then done() end end
  end
  mover(src)
  select(src);src.vm:start(assert(labels[scene.label],scene.label),nil,true)
  for _=1,400 do if src.battles>0 or not src.vm:isRunning() then break end;src.vm:tick() end
  T.eq(src.battles,1,name..' script reaches its battle')
  T.eq(src.opts and src.opts.coopContinuationError,nil,name..' continuation is supported')
  local sd=src.opts and src.opts.coopContinuation
  if sd then
    local dst=world('MAY',561,native,text);dst.map=scene.map;mover(dst)
    local packet=assert(Json.decode(Json.encode(sd)))
    -- the stub player has no facing at the talk; Norman's ending switches on it
    if scene.facing then packet.specials[tostring(0x800C)]=scene.facing end
    select(dst);T.check(P.prepare(dst.s,dst.vm,'scene:'..name,packet,false),name..' partner prepares')
    P.resolve(dst.s,'scene:'..name,'win')
    local started,why=P.replay(dst.s,dst.vm,'scene:'..name)
    T.check(started,name..' replay starts: '..tostring(why))
    -- The stub adapters never finish field-effect/camera specials (Archie's
    -- Kyogre awakening): a wait that stalls 300 ticks is completed here.
    local stalled,last=0,nil
    for _=1,20000 do
      if not dst.vm:isRunning() then break end
      dst.vm:tick()
      local pc=dst.vm.ctx.pc;local at=pc and (pc.listKey..':'..pc.index)
      stalled=at==last and stalled+1 or 0;last=at
      if stalled>300 and dst.vm.ctx.status=='waiting' then
        dst.vm.ctx.nativePoll=function() return true end;dst.vm.ctx.stateWait=nil;stalled=0
      end
    end
    T.eq(dst.vm:isRunning(),false,name..' replay finishes')
    T.eq(P.status(dst.s,'scene:'..name),'done',name..' partner completes the scene')
    T.check(dst.warped~=nil,name..' partner moves on like the initiator')
    T.eq(Flags.isTrainerDefeated(dst.vm.store,nil,scene.trainer),true,name..' beaten in the partner game')
    T.eq(dst.battles,0,name..' never re-fought')
    if scene.badge then T.eq(dst.s.flags[scene.badge],true,name..' badge reaches the partner') end
    if scene.tm then T.eq(F.f.Bag.get(dst.s.bag,scene.tm),1,name..' TM reaches the partner') end
  end
end

-- Steven's Space Center multi (a native special battle, not the trainer
-- opcode): a shared checkpoint resumes at its win branch, after the party
-- specials; a called-off fight stops with the launcher's party change undone.
do
  -- Steven's party data comes from the ROM's battle tables
  require('src.import.gba.battle_rse_data_extract').run(F.f.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
  local Bridge=require('src.core.game3.battle_bridge')
  local oldStart=Bridge.start
  local launched
  Bridge.start=function(_,_,_,opts) launched=opts;return true end
  local function stevenWorld(name,id)
    local w=world(name,id,native,text);w.map='EM_MOSSDEEP_CITY_SPACE_CENTER_2F'
    for i=1,3 do w.s.party[i]=F.mon(0,30) end
    w.s.savedPlayerParty={F.mon(0,30),F.mon(0,30),F.mon(0,30),F.mon(0,30)}
    return w
  end
  local S1=stevenWorld('BRENDAN',820)
  select(S1);launched=nil
  S1.vm:start(labels.MossdeepCity_SpaceCenter_2F_EventScript_DoStevenMultiBattle,nil,true)
  for _=1,200 do if launched or not S1.vm:isRunning() then break end;S1.vm:tick() end
  T.check(launched~=nil,'Steven multi launches its battle')
  T.eq(launched and launched.coopContinuationError,nil,'Steven multi checkpoint is supported')
  local sd=launched and launched.coopContinuation
  T.eq(sd and sd.kind,'special','Steven checkpoint is a special battle')
  T.check(sd and sd.resume~=nil,'Steven checkpoint resumes at the win branch')
  if sd then
    T.check(P.prepare(S1.s,S1.vm,'steven:1',sd,true),'Steven event binds the launcher')
    local S2=stevenWorld('MAY',821)
    local before=#S2.s.party
    select(S2);T.check(P.prepare(S2.s,S2.vm,'steven:1',assert(Json.decode(Json.encode(sd))),false),'partner prepares Steven event')
    P.resolve(S2.s,'steven:1','win')
    select(S1);P.resolve(S1.s,'steven:1','win');launched.done('win');drain(S1)
    T.eq(P.status(S1.s,'steven:1'),'done','launcher scene completes after a shared win')
    select(S2);local ok,why=P.replay(S2.s,S2.vm,'steven:1')
    T.check(ok,'partner replays the Steven win cutscene: '..tostring(why))
    for _=1,6000 do if not S2.vm:isRunning() then break end;S2.vm:tick()
      if S2.vm.ctx.status=='waiting' and S2.vm.ctx.stateWait then S2.vm.ctx.stateWait=nil end end
    T.eq(P.status(S2.s,'steven:1'),'done','partner completes the Steven scene')
    T.eq(#S2.s.party,before,'partner party untouched by the launcher specials')
    T.eq(Flags.isTrainerDefeated(S2.vm.store,nil,sd.trainerId),true,'Maxie beaten in the partner game')
    T.eq(Flags.isTrainerDefeated(S2.vm.store,nil,sd.trainerB),true,'Courtney beaten in the partner game')
  end
  -- called off: no win, the scene stops, the party is the saved one again
  local S3=stevenWorld('BRENDAN',822)
  select(S3);launched=nil
  S3.vm:start(labels.MossdeepCity_SpaceCenter_2F_EventScript_DoStevenMultiBattle,nil,true)
  for _=1,200 do if launched or not S3.vm:isRunning() then break end;S3.vm:tick() end
  T.check(launched~=nil,'second Steven launch')
  if launched then
    launched.done('cancel')
    for _=1,50 do if not S3.vm:isRunning() then break end;S3.vm:tick() end
    T.eq(S3.vm:isRunning(),false,'called-off Steven fight stops the scene')
    T.eq(#S3.s.party,4,'called-off Steven fight restores the saved party')
    local stevenLeft=false
    for _,m in ipairs(S3.s.party) do if m.stevenPartner then stevenLeft=true end end
    T.eq(stevenLeft,false,'no Steven POKeMON left in the party')
    T.eq(Flags.isTrainerDefeated(S3.vm.store,nil,sd and sd.trainerId or 0),false,'called-off fight is not a win')
  end
  Bridge.start=oldStart
end

-- Paired: the sealed co-op's own lib/progress.lua over its real protocol, a
-- JSON wire and this real API, on two native Roxanne worlds. Covers C10's
-- policy cases that a model API could miss.
local function bundled(name)
  local path=base..'generated/development/mods/g3_coop/lib/'..name..'.lua'
  return assert(loadfile(path))()
end
local Protocol,Progress=bundled('protocol'),bundled('progress')
local ModRuntime=require('src.mods.Runtime')
local link={up=true}
local clock=0
local function coopWorld(name,id,rows)
  local w=world(name,id,rows or native,rows and {} or text)
  w.inbox,w.events,w.toasts,w.seq={}, {}, {}, 0
  w.p=Progress.new({
    api=function() return api end,
    send=function(fields)
      local msg=assert(Protocol.validate(assert(Json.decode(Json.encode(Protocol.prog(fields))))))
      w.peer.inbox[#w.peer.inbox+1]=msg
    end,
    connected=function() return link.up end,
    now=function() return clock end,
    toast=function(t) w.toasts[#w.toasts+1]=t end,
    newId=function() w.seq=w.seq+1;return ('g3c:%d.0:%d:1'):format(id,w.seq) end,
    canJoin=function() return true end,
    idle=function() return not w.vm:isRunning() end,
    held=function() return w.held end,
    mapName=function(m) return m end,
    map=function() return Space.mapId end,
    ownPrefix=function() return ('g3c:%d.0:'):format(id) end,
    onResult=function(eid,r)
      if w.follow and w.follow==eid then w.follow=nil;w.held=nil;w.done(r) end
    end,
    log=function() end,
  })
  return w
end
local oldEmit=ModRuntime.emit
ModRuntime.emit=function(name,ev,...)
  if name=='coop.progress' and current and current.events then current.events[#current.events+1]=copy(ev) end
  return oldEmit(name,ev,...)
end
local function step(w)
  select(w)
  local box=w.inbox;w.inbox={}
  for _,m in ipairs(box) do w.p:onMessage(m) end
  for _=1,200 do if not w.vm:isRunning() then break end;w.vm:tick() end
  local evs=w.events;w.events={}
  for _,ev in ipairs(evs) do w.p:onStatus(ev) end
  clock=clock+0.6;w.p:tick()
  for _=1,200 do if not w.vm:isRunning() then break end;w.vm:tick() end
  evs=w.events;w.events={}
  for _,ev in ipairs(evs) do w.p:onStatus(ev) end
end
local function pump(a,b,n) for _=1,n or 10 do step(a);step(b) end end
local function acked(id) local _,a=api.status(id);return a end
local function said(w,word) for _,t in ipairs(w.toasts) do if t:find(word,1,true) then return true end end return false end
local function shared(a,b)
  select(a);a.vm:start(labels.RustboroCity_Gym_EventScript_Roxanne,nil,true)
  local ready
  local id=assert(a.p:begin(assert(a.opts.coopContinuation),function(i) ready=i end,function() end))
  a.held=id
  pump(a,b,2)
  T.eq(ready,id,'paired: partner prepared the native event')
  select(b);T.eq(b.p:expected(),id,'paired: partner links its joint battle')
  return id
end
local function reconnect(a,b)
  link.up=true
  select(a);a.p:connected();select(b);b.p:connected()
  pump(a,b,12)
end

-- 1. The initiator ended the battle after its partner dropped; the partner
-- continued alone and won. The fallback win reaches the initiator.
local A1,B1=coopWorld('BRENDAN',901),coopWorld('MAY',902)
A1.peer,B1.peer=B1,A1
local id1=shared(A1,B1)
link.up=false
select(A1);T.check(A1.p:leave(id1,true),'paired: dropped initiator leaves the event open')
A1.held=nil;A1.done('cancel');drain(A1)
T.eq(api.status(id1),'battle','paired: no local result while the partner may have won')
T.eq(A1.s.flags[0x867],nil,'paired: no badge yet for the initiator')
T.check(P.blocked(),'paired: story fights wait for the result')
select(B1);B1.p:finish(id1,'win')
pump(A1,B1,4)
select(B1);T.eq(api.status(id1),'done','paired: the survivor plays its own ending')
T.eq(B1.s.flags[0x867],true,'paired: survivor badge')
select(A1);A1.s.modData=assert(Json.decode(Json.encode(A1.s.modData))) -- saved and reloaded meanwhile
reconnect(A1,B1)
select(A1)
T.eq(api.status(id1),'done','paired: fallback win replays for the initiator')
T.eq(A1.s.flags[0x867],true,'paired: initiator badge from the fallback win')
T.eq(F.f.Bag.get(A1.s.bag,item),1,'paired: initiator TM once')
T.eq(A1.battles,1,'paired: initiator never re-fights')
T.eq(acked((id1)),true,'paired: initiator acknowledged')
T.eq(P.blocked(),false,'paired: barrier clears for the initiator')
select(B1);T.eq(acked((id1)),true,'paired: survivor acknowledged')
T.eq(B1.battles,0,'paired: survivor never ran the battle script')

-- 2. The partner dropped and lost alone; the initiator won.
local A2,B2=coopWorld('BRENDAN',903),coopWorld('MAY',904)
A2.peer,B2.peer=B2,A2
local id2=shared(A2,B2)
link.up=false
select(B2);T.check(B2.p:leave(id2,false),'paired: dropped partner leaves its receipt open')
select(A2);A2.p:finish(id2,'win');A2.p:started(id2);A2.held=nil;A2.done('win');drain(A2)
pump(A2,B2,2)
reconnect(A2,B2)
select(B2);T.eq(api.status(id2),'done','paired: initiator win reaches the dropped partner')
T.eq(B2.s.flags[0x867],true,'paired: dropped partner badge')
T.eq(acked((id2)),true,'paired: both acknowledged')
select(A2);T.eq(P.blocked(),false,'paired: no barrier left')

-- 3. Nobody won it: reconnect calls it off in both games.
local A3,B3=coopWorld('BRENDAN',905),coopWorld('MAY',906)
A3.peer,B3.peer=B3,A3
local id3=shared(A3,B3)
link.up=false
select(A3);A3.p:leave(id3,true);A3.held=nil;A3.done('cancel');drain(A3)
select(B3);B3.p:leave(id3,false)
reconnect(A3,B3)
select(A3);T.eq(api.status(id3),'cancelled','paired: unwon fight called off (initiator)')
T.eq(P.blocked(),false,'paired: called-off fight frees story fights')
T.eq(Flags.isTrainerDefeated(A3.vm.store,nil,265),false,'paired: Roxanne still unbeaten')
select(B3);T.eq(api.status(id3),'cancelled','paired: unwon fight called off (partner)')

-- 4. Different results (an older co-op's lone loss): reported, never cleared.
local A4,B4=coopWorld('BRENDAN',907),coopWorld('MAY',908)
A4.peer,B4.peer=B4,A4
local id4=shared(A4,B4)
link.up=false
select(B4);B4.p:finish(id4,'lose')
select(A4);A4.p:finish(id4,'win');A4.p:started(id4);A4.held=nil;A4.done('win');drain(A4)
pump(A4,B4,2)
reconnect(A4,B4)
select(A4);T.eq(api.status(id4),'done','paired: winner keeps its ending')
T.eq(acked((id4)),false,'paired: out-of-sync win is not acknowledged')
T.check(P.blocked(),'paired: out-of-sync story stays on hold')
T.check(said(A4,'out of sync'),'paired: winner told the story is out of sync')
select(B4);T.check(said(B4,'out of sync'),'paired: loser told too')

-- 5. A replay that can't play (here: the partner's script data differs, as
-- with a mismatched build): tried once per visit, explained, no effects.
local A5,B5=coopWorld('BRENDAN',909),coopWorld('MAY',910)
A5.peer,B5.peer=B5,A5
local id5=shared(A5,B5)
local origin5=A5.opts.coopContinuation.origin.listKey
B5.vm.scripts[origin5][#B5.vm.scripts[origin5]+1]={op='end'}
select(B5);B5.p:finish(id5,'win')
select(A5);A5.p:finish(id5,'win');A5.p:started(id5);A5.held=nil;A5.done('win');drain(A5)
pump(A5,B5,6)
select(B5)
T.eq(api.status(id5),'queued','paired: conflicted replay stays queued')
T.check(said(B5,'script_mismatch'),'paired: refusal explained')
T.eq(B5.s.flags[0x867],nil,'paired: no partial reward on conflict')
T.eq(B5.p:busy(),false,'paired: conflict does not hold the field')
-- 6. A two-fight scene, played live: the leader prepares the second fight,
-- the follower's replay waits there, both fight it and finish their scripts.
local function chainStart(a,b)
  select(a);a.vm:start('start',nil,true)
  local ready
  local id=assert(a.p:begin(assert(a.opts.coopContinuation),function(i) ready=i end,function() end))
  a.held=id;pump(a,b,2)
  T.eq(ready,id,'chain: partner prepared fight 1')
  select(b);b.p:expected()
  b.p:finish(id,'win')
  select(a);a.p:finish(id,'win');a.p:started(id);a.held=nil;a.done('win')
  for _=1,50 do if a.battles==2 then break end;a.vm:tick() end
  T.eq(a.battles,2,'chain: leader reaches fight 2')
  return id
end
-- what main.lua's hook does when a script reaches a scene's later fight
local function hook(w,tid)
  select(w)
  if not w.p:own(w.opts.coopChain) then
    w.held=w.opts.coopBound;w.follow=w.opts.coopBound
    w.p:follow(w.opts.coopChain,tid,w.opts.coopBound,function(i) w.held=i;w.follow=i end)
    return 'follow'
  end
  local id=assert(w.p:begin(w.opts.coopContinuation,function(i) w.ready2=i end,function(why) w.failed2=why end))
  w.held=id
  return 'lead',id
end
local A6,B6=coopWorld('BRENDAN',911,chainRows),coopWorld('MAY',912,chainRows)
A6.peer,B6.peer=B6,A6
local k1=chainStart(A6,B6)
local role6,k2=hook(A6,266)
T.eq(role6,'lead','chain: the scene starter leads fight 2')
pump(A6,B6,6)
T.eq(B6.battles,1,'chain: follower replay waits at fight 2')
T.eq(hook(B6,266),'follow','chain: the partner follows')
pump(A6,B6,4)
T.eq(A6.ready2,k2,'chain: follower answered once at the fight')
select(B6);T.eq(B6.held,k2,'chain: follower script holds the leader fight')
-- the joint battle: both resolve, each game's own script carries on
select(B6);B6.p:finish(k2,'win');B6.held=nil;B6.follow=nil;B6.done('win');drain(B6)
select(A6);A6.p:finish(k2,'win');A6.p:started(k2);A6.held=nil;A6.done('win');drain(A6)
pump(A6,B6,8)
for _,w in ipairs({A6,B6}) do
  select(w)
  T.eq(api.status(k1),'done','chain: fight 1 done in each game')
  T.eq(api.status(k2),'done','chain: fight 2 done in each game')
  T.eq(acked(k2),true,'chain: fight 2 acknowledged in each game')
  T.eq(F.f.Bag.get(w.s.bag,item),1,'chain: scene reward once in each game')
  T.eq(P.blocked(),false,'chain: no barrier left')
end
T.eq(B6.battles,1,'chain: follower ran only the fight it shared')

-- 7. The follower is away for fight 2: the leader fights it alone and the
-- follower plays the rest of the scene on reconnect.
local A7,B7=coopWorld('BRENDAN',913,chainRows),coopWorld('MAY',914,chainRows)
A7.peer,B7.peer=B7,A7
local j1=chainStart(A7,B7)
pump(A7,B7,4)
select(B7);T.eq(B7.battles,1,'chain/away: follower reached fight 2')
hook(B7,266)
link.up=false
-- main.lua: a follower with no link leaves the scene at the fight
select(B7);B7.p:unfollow();B7.held=nil;B7.follow=nil;Field.locked=true;B7.done('cancel');drain(B7)
select(A7);local j2=assert(A7.p:solo(A7.opts.coopContinuation),'chain/away: leader keeps an event')
A7.done('win');drain(A7)
pump(A7,B7,2)
select(A7);T.eq(api.status(j2),'done','chain/away: leader finished alone')
reconnect(A7,B7)
select(B7)
T.eq(api.status(j2),'done','chain/away: follower plays the rest of the scene')
T.eq(F.f.Bag.get(B7.s.bag,item),1,'chain/away: follower reward once')
T.eq(B7.s.vars[0x4071],1,'chain/away: follower story finished')
T.eq(acked(j2),true,'chain/away: acknowledged')
select(A7);T.eq(P.blocked(),false,'chain/away: leader barrier clears')

ModRuntime.emit=oldEmit
link.up=true

-- Static native coverage audit; this is graph coverage, not a playthrough.
local audit={accepted={},refused={}}
local inspector=world('AUDIT',777,{})
inspector.vm.scripts=native
select(inspector)
for key,rows in pairs(native) do for index,row in ipairs(rows) do
  if row.op=='trainerbattle' and F.f.loader.exports.inclement_battle_test.coopStoryTrainer(row.trainer) then
    inspector.vm._scriptKey=key
    inspector.vm.ctx.pc={listKey=key,index=index+1}
    P.beginScript(inspector.vm)
    local earlyFlag=require('src.core.game3.scripting.opcodes').active():trainerBattleType(tonumber(row.type) or 0)=='EARLY_RIVAL'
    local desc,why=P.capture(inspector.vm,row,row.trainer,earlyFlag)
    local bucket=desc and audit.accepted or audit.refused
    bucket[#bucket+1]={key=key,index=index,trainer=row.trainer,reason=why}
    if desc then T.check(P.validate(inspector.vm,desc),'accepted native graph validates locally') end
  end
end end
for _,bucket in pairs(audit) do table.sort(bucket,function(a,b) return a.key==b.key and a.index<b.index or a.key<b.key end) end
local out=assert(io.open(base..'generated/coop-progress-audit.json','wb'));out:write(Json.encode(audit));out:close()
print(('Native story graphs: %d accepted, %d refused (not a scene playthrough)'):format(#audit.accepted,#audit.refused))
T.finish('Shared story continuation replay')
