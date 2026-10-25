-- Every vanilla Emerald trainer from the ROM (through the campaign fixture,
-- with the campaign's authored teams switched off): id, constant, class,
-- name, double flag and party. JSON on stdout. Run from
-- Gen3Mod/gen1recomp-0.3.73: luajit ../porting/native/tools/dump_vanilla_trainers.lua
local F=assert(loadfile('../porting/native/campaign_fixture.lua'))()
require('src.import.gba.trainer_extract').run(F.rom,require('src.core.game3.dataset').cache(),{game='emerald'})
local Trainers=require('src.core.game3.scripting.trainers')
local C=require('src.core.game3.constants').of('emerald')
local SD=require('src.core.SaveData')
SD.setCart('none')  -- the ROM's own teams
local P=F.P
local out={}
for name,id in pairs(C.trainers.byName) do
  local ok,t=pcall(Trainers.get,id)
  if ok and t and t.party and #t.party>0 then
    local party={}
    for _,m in ipairs(t.party) do party[#party+1]=string.format('{"species":%q,"level":%d}',P.name(m.species) or '?',tonumber(m.level) or 0) end
    out[#out+1]=string.format('{"const":%q,"id":%d,"class":%q,"name":%q,"double":%s,"party":[%s]}',
      name,id,tostring(t.className),tostring(t.name),tostring(t.doubleBattle and true or false),table.concat(party,','))
  end
end
io.stderr:write(#out..' trainers\n')
print('['..table.concat(out,',')..']')
