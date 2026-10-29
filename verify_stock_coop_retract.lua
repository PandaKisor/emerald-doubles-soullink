-- B takes back a co-op battle choice while the partner hasn't chosen (user,
-- 2026-10-28; build_probe.PATCHES link/battle.lua + battle/init.lua). Two real
-- linked games: the guest picks, asks to take it back, and picks again; the
-- host's answer decides, and both games must play the same turns.
-- Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local F=assert(loadfile('../porting/native/stock_coop_link_fixture.lua'))()
local T,H,copy=F.T,F.H,F.copy

-- hold: per seat, whether the policy may pick yet; pick: per seat, the move slot to use
local function run(label, script)
  local worlds=F.newPair({})
  local hold,slot={[0]=false,[1]=false},{[0]=1,[1]=1}
  local function policy(w,st)
    local sel=w.Battle._dblSel
    if not (sel and sel.active) then return end
    local seat=w.Battle._st.linkOwn==0 and 0 or 1
    if hold[seat] then return end
    local target=w.State.isAlive(st,1) and 1 or 3
    w.Ui._pendingCommand=w.Commands.playerAction(st,1,slot[seat],sel.active,target)
  end
  local frames=0
  local function steps(n) for _=1,n do frames=frames+1; for seat=0,1 do H.step(worlds[seat],policy) end end end
  script(worlds,hold,slot,steps)
  while frames<12000 and not (worlds[0].result and worlds[1].result) do steps(1) end
  local hashes={}
  for seat=0,1 do
    local w=worlds[seat]
    H.run(w,function()
      T.check(w.result~=nil,label..': both games finish')
      T.eq(w.LB.endReason,nil,label..': no protocol/desync failure')
      hashes[seat]=copy(w.LB._myHashes)
    end)
  end
  local common=0
  for turn,digest in pairs(hashes[0]) do
    if hashes[1][turn] then common=common+1;T.eq(digest,hashes[1][turn],label..': matching turn hash') end
  end
  T.check(common>0,label..': the games compared turn hashes')
end

local function phase(w) local p; H.run(w,function() p=w.Battle._phase end) return p end
local function until_(steps,cond,n) for _=1,n or 600 do if cond() then return true end steps(1) end return cond() end

-- the partner (host) hasn't chosen: the take-back is granted
run('granted',function(worlds,hold,slot,steps)
  hold[0]=true
  T.check(until_(steps,function() return phase(worlds[1])=='linkwait' end),'granted: the guest picked and waits')
  local asked
  H.run(worlds[1],function() asked=worlds[1].LB.requestRetract(worlds[1].Battle._st.turn) end)
  T.check(asked,'granted: the guest asks to take it back')
  T.check(until_(steps,function() return phase(worlds[1])=='command' end),'granted: the guest chooses again')
  local turn; H.run(worlds[1],function() turn=worlds[1].Battle._st.turn end)
  slot[1]=2
  hold[0]=false
  T.check(until_(steps,function() local t; H.run(worlds[0],function() t=worlds[0].Battle._st.turn end) return t>turn end),
    'granted: the host plays the turn with the new pick')
end)

-- the host already chose: too late, the turn plays with the first pick
run('refused',function(worlds,hold,slot,steps)
  hold[0]=true
  T.check(until_(steps,function() return phase(worlds[1])=='linkwait' end),'refused: the guest picked and waits')
  -- the host chooses and plays the turn before the guest's request arrives
  hold[0]=false
  T.check(until_(steps,function() return phase(worlds[0])~='command' and phase(worlds[0])~='linkwait' end),'refused: the host played the turn')
  local asked
  H.run(worlds[1],function() asked=worlds[1].LB.requestRetract(worlds[1].Battle._st.turn) end)
  T.check(asked ~= nil,'refused: the guest asks anyway')
  steps(30)
  T.check(phase(worlds[1])~='command' or worlds[1].LB._retract==nil,'refused: the guest does not choose again')
end)
T.finish('Campaign co-op take-back (B)')
