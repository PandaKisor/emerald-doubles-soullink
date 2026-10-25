-- Paired integration checks using the packaged co-op transport and entry point.
local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,H,f,Json,Team,copy=F.T,F.H,F.f,F.Json,F.Team,F.copy
local base='../porting/full_port/'
local function run(wild,eliminate,mixed,legacy)
  local worlds,channels,wire,setups=F.newPair({wild=wild,eliminate=eliminate,legacy=legacy})
  for seat=0,1 do H.run(worlds[seat],function()
    local st=worlds[seat].Battle.getState()
    T.eq(st.coopTeam,not legacy,'beginMulti passes co-op flag to battle state')
    T.eq(st.double,true,'linked wild/trainer battle retains doubles')
    T.eq(#st.playerParty,12,'real TeamBattle brings six plus six')
    T.eq(st.linkOwn,seat==0 and 0 or 2,'local owner remains stable')
  end) end
  local function policy(w,st)
    local sel=w.Battle._dblSel
    if not (sel and sel.active) then return end
    local id=sel.active
    local targets={}
    for _,foe in ipairs({1,3}) do if w.State.isAlive(st,foe) then targets[#targets+1]=foe end end
    local target=targets[(id==2 and #targets>1) and 2 or 1] or 1
    if wild and (not mixed or (id==0 and st.turn==1)) then
      w.Ui._pendingCommand={kind='ball',battler=id,itemId=1,target=target}
    else
      w.Ui._pendingCommand=w.Commands.playerAction(st,1,1,id,target)
    end
  end
  local frames=0
  while frames<12000 and not (worlds[0].result and worlds[1].result) do
    frames=frames+1
    for seat=0,1 do
      -- Different presentation/update speeds must not affect shared state.
      for _=1,seat==0 and 1 or 3 do H.step(worlds[seat],policy) end
    end
  end
  local hashes={}
  for seat=0,1 do
    local w=worlds[seat]
    H.run(w,function()
      T.check(w.result~=nil,'both peers finish within budget, phase '..tostring(w.Battle._phase))
      T.eq(w.LB.endReason,nil,'no protocol/desync failure')
      T.eq(w.Guard.tripped,nil,'no battle RNG fallback')
      local st=w.Battle.getState()
      T.eq(st.coopPostDone==true,not legacy,'local post-battle processing is opt-in')
      hashes[seat]=copy(w.LB._myHashes)
      if wild then
        T.eq(#(st.coopCaptures or {}),mixed and 1 or 2,'expected wild targets caught')
        T.eq(f.Bag.get(w.session.bag,1),mixed and seat==1 and 10 or 9,'each player consumes only their own ball')
        if mixed then T.check(st.playerParty[12].exp>setups[1].party[6].exp,'remaining wild foe gives shared EXP') end
      elseif legacy then
        T.eq(st.playerParty[12].exp,setups[1].party[6].exp,'ordinary link battles still award no EXP')
      else
        T.check(st.playerParty[12].exp>setups[1].party[6].exp,'partner sixth slot gets real battle EXP')
      end
      local slots={1,2,3,4,5,6}
      T.eq(Team.writeback(w.E,w.session,st,slots),6,'existing owner writeback still applies six mons')
    end)
  end
  local common=0
  for turn,digest in pairs(hashes[0]) do
    if hashes[1][turn] then common=common+1;T.eq(digest,hashes[1][turn],'matching complete shared turn hash') end
  end
  T.check(common>0,'real link exchanged checked turn hashes')
  T.eq(worlds[0].result,worlds[1].result,'partner outcomes agree')
  if worlds[0].LB.endReason or worlds[1].LB.endReason then
    local path=base..'generated/coop-link-failure-'..(wild and 'wild' or (eliminate and 'eliminated' or 'trainer'))..'.json'
    local out=assert(io.open(path,'w'))
    out:write(Json.encode({host=worlds[0].snapshots,guest=worlds[1].snapshots,wire=wire}));out:close()
  end
  local count=0
  for _,row in ipairs(wire) do
    if row.msg.kind=='ball' then count=count+1;T.eq(type(row.msg.repeatCaught),'boolean','ball carries thrower dex context') end
  end
  if wild then T.eq(count,mixed and 1 or 2,'balls travel through link actions') end
  print('COOP_LINK_COMPLETE',legacy and 'legacy-team' or (mixed and 'wild-catch-and-fight' or (wild and 'wild' or (eliminate and 'eliminated' or 'trainer'))),frames,common,worlds[0].result)
end
run(false,false)
run(false,true)
run(true,false)
run(true,false,true)
run(false,false,false,true)
T.finish('Campaign co-op paired link')
