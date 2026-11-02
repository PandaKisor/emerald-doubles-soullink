-- Saves store species, moves, abilities and items by number, and full/save.lua
-- refuses a whole save if any number it knows has changed or gone. So a build
-- may add ids but never change or drop one in tools/save_ids.lua. Add new ids to
-- that file when they ship. Run from Gen3Mod/gen1recomp-0.3.73 with luajit.
local frozen=dofile('../porting/native/tools/save_ids.lua')
local built=dofile('../porting/native/generated/campaign/mods/g3_campaign/full/data/identity.lua').namespaces
local checks,bad=0,0
for kind,ids in pairs(frozen) do
  for symbol,id in pairs(ids) do
    checks=checks+1
    if built[kind][symbol]~=id then
      bad=bad+1
      print(('FAIL %s %s was %d, now %s'):format(kind,symbol,id,tostring(built[kind][symbol])))
    end
  end
end
if bad==0 then print(('%d/%d checks passed  (save ids)'):format(checks,checks))
else print(('%d/%d checks passed, %d FAILURES  (save ids)'):format(checks-bad,checks,bad)) os.exit(1) end
