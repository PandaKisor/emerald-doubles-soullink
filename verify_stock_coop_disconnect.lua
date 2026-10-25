-- Real link closure, frozen battle, then local continuation through native
-- selectors, faint/replacement, EXP, catch and existing co-op writeback.
local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,H,copy,Json=F.T,F.H,F.copy,F.Json

local function policy(w,st)
  local sel=w.Battle._dblSel
  if not (sel and sel.active) then return end
  local id=sel.active
  local targets={}
  for _,foe in ipairs({1,3}) do if w.State.isAlive(st,foe) then targets[#targets+1]=foe end end
  local target=targets[id==2 and #targets>1 and 2 or 1] or 1
  w.controlled=w.controlled or {};w.controlled[id]=true
  if st.wild and st.coopSolo then
    w.Ui._pendingCommand={kind='ball',battler=id,itemId=1,target=target}
  else
    w.Ui._pendingCommand=w.Commands.playerAction(st,1,1,id,target)
  end
end

local function run(seat,phase,mode)
  local worlds,channels,wire=F.newPair({disconnect='pause',wild=mode=='wild' or mode=='run',foeHp=20})
  local w=worlds[seat]
  if phase=='awarding' then
    H.run(w,function()
      local Coop=require('src.core.game3.battle.coop')
      local prepare=Coop.prepareAwards
      Coop.prepareAwards=function(st,awards)
        local localAwards=prepare(st,awards)
        if #localAwards>0 then w.Battle._headless=false;Coop.prepareAwards=prepare end
        return localAwards
      end
      local seq=require('src.core.game3.battle.exp_seq')
      local begin=seq.begin
      seq.begin=function(awards,push,done,hooks)
        hooks.headless=true
        return begin(awards,push,done,hooks)
      end
    end)
  end
  if phase=='linkswitch' then
    local push=channels[seat].push
    channels[seat].push=function(self,msg)
      if msg.type==w.LB.MSG.SWITCH then return true end
      return push(self,msg)
    end
  end
  local reached=false
  for _=1,500 do
    if w.Battle._phase==phase then reached=true;break end
    H.step(w,policy)
    if w.Battle._phase==phase then reached=true;break end
    H.step(worlds[1-seat],policy)
  end
  T.check(reached,'reaches disconnect phase '..phase)
  if not reached then error('missing test phase '..phase..': '..tostring(w.Battle._phase)) end
  w.Battle._headless=true
  local before,draws,owners,own,partner,originalRng,pauseCount
  H.run(w,function()
    local st=w.Battle.getState()
    own,partner=st.linkOwn,w.State.PARTNER(st.linkOwn)
    if mode=='eliminated' then
      st.eliminated[own]=true
      w.State.battler(st,own).mon.hp=0
      require('src.core.game3.battle.engine').markAbsent(st,own)
    elseif mode=='exhausted' then
      for i,m in ipairs(st.playerParty) do if st.partyOwner.player[i]==own then m.hp=0 end end
    elseif mode=='lastmon' then
      for i,m in ipairs(st.playerParty) do
        if st.partyOwner.player[i]==own and i~=w.State.battler(st,own).partyIndex then m.hp=0 end
      end
    end
    pauseCount=0
    require('src.mods.Runtime').events:on('battle.coop_paused',function(e)
      if e.battle==st then pauseCount=pauseCount+1 end
    end,100,'disconnect-test')
    owners=copy(st.partyOwner.player);originalRng=st.rng
    channels[seat]:fail('test_wifi_lost')
    w.Link.update(1/60)
    T.check(st.coopPaused~=nil,'real channel closure pauses opt-in battle')
    T.eq(w.LB.state,'coop_wait','activity remains alive while waiting')
    T.eq(w.result,nil,'drop has not awarded a result')
    before=require('src.core.game3.battle.coop').hashState(st)
    draws=w.LB._draws.n
    -- Two minutes is well past the normal link timeout, with no policy/UI.
    for _=1,7200 do w.Link.update(1/60);w.Battle.update(1/60,nil) end
    T.eq(require('src.core.game3.battle.coop').hashState(st),before,'pause preserves all shared party data')
    T.eq(w.LB._draws.n,draws,'pause consumes no battle RNG')
    T.eq(w.result,nil,'pause never silently resolves to a draw')
    T.eq(pauseCount,1,'pause notification emitted once')
    -- Native UI is driven independently of Battle.update in a real game.
    local forbidden={wasPressed=function() error('paused UI read input') end}
    T.check(w.Ui.handleInput(forbidden),'battle menu consumes paused input')
    local party=require('src.ui.game3.party_menu')
    local bag=require('src.ui.game3.bag_menu')
    party.handleInput(forbidden);party.update(1);bag.handleInput(forbidden)
    w.departed={}
    for i,m in ipairs(st.playerParty) do if owners[i]==partner then w.departed[i]=copy(m) end end
    w.controlled={}
    T.check(w.Battle.coopContinueSolo(),'player explicitly chooses local continuation')
    T.eq(w.Battle.coopContinueSolo(),false,'repeat continuation cannot start twice')
  end)
  local frames=0
  while not w.result and frames<5000 do
    frames=frames+1
    H.step(w,function(world,st)
      if mode=='run' and st.coopSolo then
        local id=world.Battle._dblSel.active
        world.controlled[id]=true
        world.Ui._pendingCommand={kind='run',battler=id}
      else policy(world,st) end
      if mode=='eliminated' and st.coopSolo then
        -- An older mod may keep setting these marks; solo ignores them.
        st.eliminated[0],st.eliminated[2]=true,true
      end
    end)
  end
  H.run(w,function()
    local st=w.Battle.getState()
    T.check(w.result~=nil,'fallback finishes, phase '..tostring(w.Battle._phase))
    T.eq(w.result,(mode=='exhausted' or mode=='lastmon') and 'lose' or mode=='run' and 'run' or 'win','fallback retains meaningful battle result')
    T.eq(st.coopSolo,true,'battle completed local conversion')
    T.eq(st.link,false,'fallback no longer uses link resolution')
    T.eq(st.linkOwn,own,'writeback owner ID preserved')
    T.same(st.partyOwner.player,owners,'original owner map preserved')
    T.eq(#st.playerParty,12,'original shared party indices preserved')
    T.eq(st.rng,originalRng,'fallback never reseeds the live battle')
    T.eq(w.Guard.tripped,nil,'native fallback AI/effects have no RNG fallback')
    if mode~='exhausted' then
      if mode=='lastmon' then
        T.check(w.controlled[own] and not w.controlled[partner],'one remaining mon never borrows the partner team')
      else T.check(w.controlled[0] and w.controlled[2],'survivor commands both positions') end
      for _,id in ipairs({0,2}) do
        local b=w.State.battler(st,id)
        T.check(not w.State.isPresent(st,id) or owners[b.partyIndex]==own,'active Pokémon belongs to survivor')
      end
    end
    for i,m in pairs(w.departed) do
      T.same(st.playerParty[i],m,'departed party gets no damage/EXP/move mutations')
    end
    if mode=='wild' then
      T.eq(#st.coopCaptures,2,'local fallback catches both foes')
      for _,capture in ipairs(st.coopCaptures) do T.eq(capture.owner,own,'both catch positions credit survivor') end
      T.eq(F.f.Bag.get(w.session.bag,1),8,'survivor spends both balls')
    end
    T.eq(F.Team.writeback(w.E,w.session,st,{1,2,3,4,5,6}),6,'existing writeback still writes local six')
    T.eq(w.LB.state,'done','original link completion callback finishes activity')
    T.eq(#w.reports,0,'fallback does not report a competitive link result')
  end)
  print('COOP_DISCONNECT_COMPLETE',seat,phase,mode or 'trainer',frames,w.result)
end

run(0,'command')
run(1,'linkwait')
run(0,'actions')
run(0,'awarding')
run(1,'linkswitch')
run(0,'command','eliminated')
run(1,'command','exhausted')
run(1,'command','wild')
run(0,'command','lastmon')
run(1,'command','run')

-- Existing callers that did not request a pause keep their draw-on-drop path.
local worlds,channels=F.newPair({})
local w=worlds[0]
H.step(w,policy)
H.run(w,function() channels[0]:fail('legacy_drop') end)
for _=1,100 do if w.result then break end;H.step(w,policy) end
T.eq(w.result,'draw','default disconnect remains a safe draw')
T.eq(w.Battle.getState().coopPaused,nil,'default caller is never left paused')

-- A waiting player can explicitly abandon instead of continuing alone.
worlds,channels=F.newPair({disconnect='pause'})
w=worlds[0]
H.step(w,policy)
H.run(w,function()
  channels[0]:fail('cancel_drop');w.Link.update(1/60)
  T.check(w.Battle.getState().coopPaused~=nil,'abandon case starts paused')
  w.Battle.abort('draw')
end)
for _=1,100 do if w.result then break end;H.step(w,policy) end
T.eq(w.result,'draw','explicit abort resolves the waiting battle')
T.eq(w.Battle.getState().coopPaused,nil,'abort clears pause without deadlock')
T.finish('Campaign co-op disconnect continuation')
