local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,H=F.T,F.H
local base='../porting/full_port/'
local exports=F.f.loader.exports.inclement_battle_test
T.eq(exports.coopStoryTrainer(265),true,'native Roxanne is mandatory')
T.eq(exports.coopStoryTrainer(520),true,'native rival is mandatory')
T.eq(exports.coopStoryTrainer(10),true,'Petalburg Woods story grunt is mandatory')
T.eq(exports.coopStoryTrainer(157),false,'Matthew is not Matt')
T.eq(exports.coopStoryTrainer(60000),false,'optional center Lucy is not mandatory')
T.eq(exports.coopStoryTrainer(60319),false,'expanded Calvin is not mandatory')
T.eq(exports.coopStoryTrainer(99999),false,'unknown IDs are not guessed')
T.eq(exports.coopTrainerPlan(60319).format,'single','route trainer has explicit single-pool default')
T.eq(exports.coopTrainerPlan(99999),nil,'unknown plan rejected')
T.eq(exports.coopTrainerPlan(734,514).format,'pair','explicit native story pair retains separate trainers')
T.eq(exports.coopTrainerPlan(734,734),nil,'duplicate trainer is not a two-trainer encounter')

for _,count in ipairs({1,2,3,6}) do
  local worlds=F.newPair({sharedCount=count})
  for seat=0,1 do H.run(worlds[seat],function()
    local w=worlds[seat]; local st=w.Battle.getState()
    T.eq(st.coopSharedFoe,true,'flag reaches state initialization')
    T.eq(#st.foeParty,count,'no duplicate enemy monsters')
    T.eq(st.enemy.partyIndex,1,'first shared enemy')
    T.eq(w.State.isAbsent(st,3),count==1,'one enemy permits 2v1')
    if count>1 then T.eq(st.battlers[3].partyIndex,2,'second shared enemy') end
    for slot=1,count do for _,id in ipairs({1,3}) do
      T.eq(w.State.ownsSlot(st,id,slot),true,'both enemy seats own every shared reserve')
    end end
    T.eq(w.State.ownsSlot(st,0,7),false,'player cannot take partner party')
    T.eq(w.State.ownsSlot(st,2,1),false,'partner cannot take player party')
    local E=require('src.core.game3.battle.engine')
    if count>=3 then
      T.eq(E.replacementCandidates(st,1)[1],3,'left enemy crosses transport partition')
      st.monToSwitchInto[1]=3
      local candidates=E.replacementCandidates(st,3)
      T.eq(candidates[1],count>3 and 4 or nil,'shared reservation excludes duplicate replacement')
      local chosen=require('src.core.game3.link.tower_link').aiSwitch(st.linkSeatOf[3])
      T.check(chosen~=3,'virtual AI honors other seat reservation')
      st.monToSwitchInto[1]=nil
    end
    if count==6 then
      local TL=require('src.core.game3.link.tower_link')
      local Ai=require('src.core.game3.battle.ai'); local choose=Ai.chooseAction
      Ai.chooseAction=function() return {kind='switch',slot=3} end
      T.eq(TL.aiAction(st.linkSeatOf[1]).kind,'switch','first virtual enemy reserves bench slot')
      T.eq(TL.aiAction(st.linkSeatOf[3]).kind,'move','second virtual enemy cannot choose same bench slot')
      T.eq(st.monToSwitchInto[1],nil,'host-only AI reservation does not leak to battle state')
      Ai.chooseAction=choose;TL.battle.sharedTurn=nil
    end
    local pics=require('src.core.game3.battle.intro_seq').multiTrainerPics(st,0)
    T.eq(pics.enemyPic2,nil,'single trainer has no invented second portrait')
  end) end
  local sharedSwitches={}
  if count==6 then H.run(worlds[0],function()
    local Ai=require('src.core.game3.battle.ai'); local choose=Ai.chooseAction
    Ai.chooseAction=function(st,id,opts)
      if st.turn==1 then
        local slot=require('src.core.game3.battle.engine').switchCandidates(st,id)[1]
        sharedSwitches[id]=slot
        return {kind='switch',slot=slot}
      end
      return choose(st,id,opts)
    end
  end) end
  for seat=0,1 do H.run(worlds[seat],function()
    local w=worlds[seat];local push=w.Ui.push;w.pushed={}
    w.Ui.push=function(text,...) w.pushed[#w.pushed+1]=tostring(text);return push(text,...) end
  end) end
  local frames=0
  while frames<1000 and not (worlds[0].result and worlds[1].result) do
    frames=frames+1
    for seat=0,1 do H.run(worlds[seat],function()
      local w=worlds[seat]; local st=w.Battle.getState()
      local sel=w.Battle._dblSel
      if st and sel and sel.active then
        local target=w.State.isAlive(st,1) and 1 or 3
        w.Ui._pendingCommand=w.Commands.playerAction(st,1,1,sel.active,target)
      end
      w.Link.update(0.2);w.LB.update(0.2);w.Battle.update(0.2,w.game)
    end) end
  end
  T.eq(worlds[0].result,'win','host finishes single-trainer battle')
  T.eq(worlds[1].result,'win','guest finishes single-trainer battle')
  for seat=0,1 do
    local generic=false
    for _,text in ipairs(worlds[seat].pushed) do if text:find('Player defeated',1,true) then generic=true end end
    T.eq(generic,false,'shared-foe win has no literal "Player defeated" line')
  end
  if count==1 then H.run(worlds[1],function()
    local lost=require('src.core.game3.battle.battle_text').get(5,{coopSharedFoe=true,outcome='lost',playerName='MAY'})
    T.check(lost:find('MAY',1,true) and not lost:find('Player',1,true),'shared-foe loss names this player: '..lost)
  end) end
  if count==6 then
    T.eq(sharedSwitches[1],3,'first virtual enemy switches to first reserve over link')
    T.eq(sharedSwitches[3],4,'second virtual enemy switches to next reserve over link')
  end
  for turn,hash in pairs(worlds[0].snapshots) do
    T.eq(worlds[1].snapshots[turn],hash,'shared pool paired turn hash')
  end
end

local Runtime=require('src.mods.Runtime')
local Gate=require('src.core.game3.trainer_joint_gate')
local Vm=require('src.core.game3.scripting.vm')
local Flags=require('src.core.game3.scripting.flags')
local Field=require('src.core.game3.field')
local savedHooks=Runtime.hooks
local messages,done,calls=0,nil,{}
local wait=true
Runtime.hooks={chains={['trainer.joint_gate']=true},call=function(_,name,default,id,kind,ctx)
  calls[#calls+1]={id=id,kind=kind,ctx=ctx}
  return wait and {action='wait',text='Wait for your partner.'} or default()
end}
local vm=Vm.new({scripts={event={{op='setvar',var=0x4001,value=99},
  {op='lockall'},{op='applymovement',1,123},{op='trainerbattle',trainer=265},{op='end'}}},
  adapters={log=function() end,openMessageAsync=function(text,cb) messages=messages+1;done=cb end}})
Field.locked=false
local before=F.Json.encode(vm.ctx)
T.eq(vm:startTalk('event',42,3),true,'waiting event handled')
T.eq(F.Json.encode(vm.ctx),before,'wait does not stamp talk variables or enter VM')
T.eq(Flags.getVar(vm.store,vm.ctx,0x4001),0,'pre-battle side effects never execute')
T.eq(Flags.isTrainerDefeated(vm.store,nil,265),false,'trainer remains unbeaten')
T.eq(messages,1,'one dismissible message')
T.eq(Field.locked,true,'message locks movement')
done();T.eq(Field.locked,false,'dismiss restores movement')
vm.scripts.allowed={{op='setvar',var=0x4001,value=7},{op='end'}}
wait=false
T.eq(vm:start('allowed'),true,'allowed ordinary script starts')
T.eq(Flags.getVar(vm.store,vm.ctx,0x4001),7,'allowed event retains original behavior')
wait=true
vm.scripts.branch={{op='checkflag',flag=100},{op='goto_if',cond=1,target='fight'},{op='end'}}
vm.scripts.fight={{op='trainerbattle',trainer=265},{op='end'}}
T.eq(#Gate.trainers(vm,'branch'),0,'false flag branch cannot spuriously gate dialogue')
Flags.setFlag(vm.store,vm.ctx,100,true)
T.eq(Gate.trainers(vm,'branch')[1],265,'true flag branch finds fight before event')
Flags.setTrainerDefeated(vm.store,nil,265,true)
T.eq(#Gate.trainers(vm,'branch'),0,'defeated story trainer dialogue remains accessible')
vm.scripts.resetFight={{op='cleartrainerflag',265},{op='goto',target='fight'}}
T.eq(Gate.trainers(vm,'resetFight')[1],265,'shadow trainer-flag reset cannot bypass gate')
T.eq(Flags.isTrainerDefeated(vm.store,nil,265),true,'preflight does not clear real trainer flag')
vm.scripts.loopStart={{op='cleartrainerflag',265},{op='setvar',0x4005,0},{op='goto',target='loop'}}
vm.scripts.loop={{op='addvar',0x4005,1},{op='compare_var_to_value',0x4005,4},
  {op='goto_if',cond=0,target='loop'},{op='goto',target='fight'}}
T.eq(Gate.trainers(vm,'loopStart')[1],265,'bounded loop fallback retains a reset story fight')
Flags.setTrainerDefeated(vm.store,nil,265,false)
vm.scripts.unknown={{op='specialvar',0x800d,1},{op='compare_var_to_value',0x800d,1},
  {op='goto_if',cond=1,target='fight'},{op='end'}}
T.eq(Gate.trainers(vm,'unknown')[1],265,'unknown native branch is inspected without executing it')

-- Inspect actual extracted Emerald event roots, not only synthetic bytecode.
local dir=base..'generated/playtest/userdata/love/inclement-playtest/emerald/data/generated/gba/scripts/'
local scripts=assert(loadfile(dir..'scripts.lua'))()
local labels=assert(loadfile(dir..'labels.lua'))()
local native=Vm.new({scripts=scripts})
local function includes(t,id) for _,n in ipairs(t or {}) do if n==id then return true end end return false end
T.check(includes(Gate.trainers(native,labels.RustboroCity_Gym_EventScript_Roxanne),265),'actual Roxanne root preflights')
T.check(includes(Gate.trainers(native,labels.Route103_EventScript_RivalMay),532),'actual rival approach root preflights')
for starter,id in pairs({[0]=532,[1]=535,[2]=529}) do
  Flags.setVar(native.store,native.ctx,16419,starter)
  local ids=Gate.trainers(native,labels.Route103_EventScript_RivalMay)
  T.eq(#ids,1,'real rival branch selects one starter team')
  T.eq(ids[1],id,'real starter variable picks correct trainer ID')
end
vm.scripts.steven={{op='setvar',0x8004,8},{op='special',239},{op='end'}}
T.check(includes(Gate.trainers(vm,'steven'),734),'native Steven event preflights Maxie')
T.check(includes(Gate.trainers(vm,'steven'),514),'native Steven event preflights Tabitha')
-- On-frame scripts used to lock before reaching the VM. Reject before both
-- the field lock and context mutation, then suppress repeated same-tile prompts.
local spaceName='src.core.game3.scripting.space'
local savedSpace=package.loaded[spaceName]
local Space=assert(loadfile(base..'generated/engine-overlay/src/core/game3/scripting/space.lua'))()
package.loaded[spaceName]=Space
local old={vm=Space.vm,store=Space.store,bundle=Space.bundle,mapId=Space.mapId,active=Space.active}
Space.vm,Space.store,Space.mapId,Space.active=vm,vm.store,'gate-test',true
Space.bundle={events={['gate-test']={mapScripts={onFrame={{var=0,value=0,script='event'}}}}}}
local m=messages
Space.runOnFrame();T.eq(messages,m+1,'frame event shows one wait message')
T.eq(vm.ctx.fieldControlsLocked,nil,'frame event does not mark controls locked')
done();T.eq(Field.locked,false,'frame message dismissal restores walking')
Space.runOnFrame();T.eq(messages,m+1,'same-tile frame event does not reopen message')
Space.vm,Space.store,Space.bundle,Space.mapId,Space.active=old.vm,old.store,old.bundle,old.mapId,old.active
package.loaded[spaceName]=savedSpace

local TS=require('src.core.game3.trainer_sight')
local Hud=require('src.ui.game3.hud');local show=Hud.openMessage
Hud.openMessage=function(_,text,opts) messages=messages+1;done=opts.done end
local eo={trainerId=265,localId=1,cellX=0,cellY=0,facing='down',sight=3}
local player={cellX=0,cellY=1}
local collision='src.core.game3.scripting.collision'
-- TrainerSight resolves collision_rse indirectly through its collision module.
local C=require('src.core.game3.collision')
local priorLedge,priorCell,priorElevation=C.isLedge,C.cell,C.elevationMismatchOn
C.isLedge=function() return false end; C.cell=nil; C.elevationMismatchOn=nil
TS.engage(nil,eo,1)
T.eq(eo.frozen,nil,'wait precedes freezing sight trainer')
T.eq(eo.scriptBusy,nil,'wait precedes approach state')
T.eq(eo.facing,'down','wait preserves facing')
done()
T.eq(TS.checkLineOfSight(eo,player,nil),false,'sight stays suppressed after dismiss')
player.cellX=1
T.eq(TS.checkLineOfSight(eo,player,nil),false,'walking outside LOS clears suppression')
player.cellX=0
T.eq(TS.checkLineOfSight(eo,player,nil),true,'returning into LOS re-enables encounter')
C.isLedge,C.cell,C.elevationMismatchOn=priorLedge,priorCell,priorElevation
Hud.openMessage=show;Runtime.hooks=savedHooks
T.finish('Campaign trainer pool and pre-event gate')
