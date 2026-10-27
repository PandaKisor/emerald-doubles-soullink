-- Run through export.py. Loads the built campaign in the stock headless fixture;
-- writes gameplay facts only, never ROM bytes, extracted scripts, or save data.
local outPath, scriptsDir = assert(arg[1]), assert(arg[2])
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))()
local root = '../porting/native/generated/campaign/mods/g3_campaign/'
local cache = require('src.core.game3.dataset').cache()
-- The battle fixture starts with a deliberately sparse SDK dex. Restore the
-- extracted table so weight readers see the same native data as a real game.
F.P._dex=assert(load(assert(cache:read('data/generated/gba/pokemon/dex.lua'))))()
require('src.import.gba.trainer_extract').run(F.rom, cache, {game='emerald'})
require('src.import.gba.encounters_extract').run(F.rom, cache, {version='emerald'})
local Trainers = require('src.core.game3.scripting.trainers')
local State = require('src.core.game3.battle.state')
local Moves = require('src.core.game3.battle.moves')
local C = require('src.core.game3.constants').of('emerald')
local maps = require('src.core.game3.constants.emerald.map_groups').byName
local labels = dofile(scriptsDir .. '/labels.lua')
local scripts = dofile(scriptsDir .. '/scripts.lua')
local events = dofile(scriptsDir .. '/events.lua')
local martPack = dofile(scriptsDir .. '/marts.lua')
local mapRows, labelMaps, labelOf = {}, {}, {}
for symbol, row in pairs(maps) do
  local id = symbol:gsub('^MAP_', 'EM_')
  mapRows[id] = {id=id, name=row.name, group=row.group, num=row.num}
end
local orderedMaps = {}
for _, row in pairs(mapRows) do orderedMaps[#orderedMaps+1] = row end
table.sort(orderedMaps, function(a,b) return #a.name > #b.name end)
for label, key in pairs(labels) do
  if not labelOf[key] or #label < #labelOf[key] then labelOf[key] = label end
  for _, row in ipairs(orderedMaps) do
    if label:sub(1,#row.name+1) == row.name .. '_' then
      labelMaps[key] = row.id
      break
    end
  end
end
-- Shared event scripts (Gabby & Ty, the player's house, etc.) do not have a
-- map prefix. Follow event/script references to recover their calling maps.
local reachMaps, roots = {}, {}
for key,map in pairs(labelMaps) do roots[map]=roots[map] or {};roots[map][key]=true end
local function references(value,out)
  if type(value)=='string' and scripts[value] then out[value]=true
  elseif type(value)=='table' then for _,v in pairs(value) do references(v,out) end end
end
for map,event in pairs(events) do
  roots[map]=roots[map] or {};references(event,roots[map])
end
for map,keys in pairs(roots) do
  local queue,seen={},{}
  for key in pairs(keys) do queue[#queue+1]=key;seen[key]=true end
  local i=1
  while i<=#queue do
    local key=queue[i];i=i+1
    reachMaps[key]=reachMaps[key] or {};reachMaps[key][map]=true
    local refs={};references(scripts[key],refs)
    for nextKey in pairs(refs) do
      if not seen[nextKey] then seen[nextKey]=true;queue[#queue+1]=nextKey end
    end
  end
end
local function scriptMaps(key)
  if labelMaps[key] then return {labelMaps[key]} end
  local rows={};for map in pairs(reachMaps[key] or {}) do rows[#rows+1]=map end
  table.sort(rows);return rows
end

local function clean(v)
  if type(v) ~= 'table' then
    if type(v)=='function' or type(v)=='userdata' or type(v)=='thread' then return nil end
    return v
  end
  local out = {}
  for k, value in pairs(v) do out[k] = clean(value) end
  return out
end
local function pick(v, fields)
  local out = {}
  for _, key in ipairs(fields) do out[key] = clean(v[key]) end
  return out
end
local out = {species={},moves={},items={},abilities=F.data.abilities,typeChart={},
  maps=mapRows,trainers={},wild={},sources={},shops={},
  natures=F.data.manifest.nature, tutorMoves=F.data.manifest.tutorMoves,
  evolutions=dofile(root .. 'full/restoratives/model.lua').rules,
  itemEvolutions=dofile(root .. 'full/evolution-items/model.lua').rules,
  nectarForms=dofile(root .. 'full/evolution-items/model.lua').nectars,
  itemSources=F.campaign.world.sources}
for id, row in pairs(F.data.species) do
  out.species[tostring(id)] = pick(row, {'symbol','name','stats','types','abilities','dex','meta','learnset','eggMoves','machines','tutors'})
  local dex=F.P.dexEntry(id)
  out.species[tostring(id)].weightKg=dex and dex.weight and dex.weight/10 or nil
end
local Types=require('src.core.game3.battle.types')
for a=0,18 do
  local row={}
  for d=0,18 do row[tostring(d)]=Types.effectiveness(a,d,d) end
  out.typeChart[tostring(a)]=row
end
local descriptions = dofile(root .. 'full/inventory-ui/model.lua').moveDescriptions
for id, row in pairs(F.data.moves) do
  if id > 0 and F.campaign.learnsets.supported(id) then
    local rec = pick(row, {'symbol','name','power','accuracy','pp','priority','type','category','sourceEffect','sourceFlags','sourceTarget','secondaryChance','argument'})
    local battle = Moves.get(id)
    rec.runtime = pick(battle, {'id','power','accuracy','pp','priority','type','category','effect','effectId','flags','target','secondaryChance','argument','highCrit','drainPercent','damageRules','hits','tripleKickStep','campaignBulldoze','campaignGrassyGlide','campaignBeakBlast','campaignThaw','alwaysHitMinimized','campaignIgnoreEvasion','campaignBypassProtect'})
    rec.hooks = {}
    for key,value in pairs(battle) do if type(value)=='function' and key:match('^campaign') then rec.hooks[#rec.hooks+1]=key end end
    table.sort(rec.hooks)
    rec.description=descriptions[id] or ''
    out.moves[tostring(id)]=rec
  end
end
-- the price a mart charges: the campaign's mart price wrapper (berries, gifts)
F.campaign.world.wrapPrices()
local ItemsData=require('src.core.game3.items_data')
for id, row in pairs(F.data.items) do
  out.items[tostring(id)] = pick(row, {'symbol','name','description','pocket','price','machine','machineNumber','machineMove','berryNumber','sourceFields'})
  local info=ItemsData.info(id)
  if info and tonumber(info.price) then out.items[tostring(id)].price=info.price end
end

F.campaign.trainers.resolve()
local trainerNames, trainerMaps = {}, {}
for name,id in pairs(C.trainers.byName) do trainerNames[id]=name end
for key,ops in pairs(scripts) do
  for _,op in ipairs(ops) do
    if op.op=='trainerbattle' and tonumber(op.trainer) then
      local id=tonumber(op.trainer)
      trainerMaps[id]=trainerMaps[id] or {}
      for _,map in ipairs(scriptMaps(key)) do trainerMaps[id][map]=true end
    end
  end
end
for id in pairs(F.campaign.trainers.partners) do trainerNames[id]='PHANTOM_'..id end
for id,symbol in pairs(trainerNames) do
  local row = Trainers.get(id)
  if row and row.party and #row.party>0 then
    local foe=Trainers.foeFromId(id)
    local rec={id=id,symbol=symbol,name=row.name,className=row.className,
      authored=F.campaign.trainers.byId[id]~=nil or F.campaign.trainers.partners[id]~=nil,
      phantom=F.campaign.trainers.partners[id]~=nil,maps={},party={},items=row.items,
      nativeDouble=row.doubleBattle and true or false}
    local authored=F.campaign.trainers.byId[id]
    rec.partnerId=authored and authored.partner or nil
    for map in pairs(trainerMaps[id] or {}) do rec.maps[#rec.maps+1]=map end
    table.sort(rec.maps)
    for _,mon in ipairs(foe.party) do
      local b=State.makeBattler(mon,'enemy')
      local m=b.mon
      local p=pick(m,{'species','level','nature','ivs','evs','personality','gender','moves'})
      p.ability,p.item=b.ability,b.item
      p.moves=p.moves or F.P.movesAtLevel(p.species,p.level)
      p.stats={hp=m.maxHp,atk=m.attack,def=m.defense,spa=m.spAtk,spd=m.spDef,spe=m.speed}
      rec.party[#rec.party+1]=p
    end
    out.trainers[#out.trainers+1]=rec
  end
end
table.sort(out.trainers,function(a,b) return a.id<b.id end)

local Encounters=require('src.core.game3.encounters')
Encounters.ensureLoaded()
for map in pairs(mapRows) do
  local row=Encounters._tables[map] or Encounters._tables[map:gsub('^EM_','')]
  if row then out.wild[map]=clean(row) end
end

local W=F.campaign.world
local function handouts(key)
  local result,pending={},nil
  for _,op in ipairs(scripts[key] or {}) do
    if op.op=='setorcopyvar' and tonumber(op[1])==0x8000 and tonumber(op[2]) and tonumber(op[2])<0x4000 then pending=tonumber(op[2])
    elseif op.op=='callstd' and pending and (tonumber(op[1])==0 or tonumber(op[1])==1) then
      result[#result+1]={std=tonumber(op[1]),item=pending};pending=nil
    end
  end
  return result
end
for map,ev in pairs(events) do
  if type(ev)=='table' then
    for _,o in ipairs(ev.objects or {}) do
      local h=handouts(o.scriptKey)
      if #h==1 and h[1].std==1 then
        out.sources[#out.sources+1]={kind='Item ball',map=map,x=o.x,y=o.y,
          label=labelOf[o.scriptKey],localId=o.localId,flag=(tonumber(o.flag) or 0)>0 and tonumber(o.flag) or nil,
          item=W.substitute(map,1,h[1].item,o.localId,o.scriptKey) or h[1].item}
      end
    end
    for _,b in ipairs(ev.bgEvents or {}) do
      if b.type=='hidden_item' then
        out.sources[#out.sources+1]={kind='Hidden item',map=map,x=b.x,y=b.y,item=W.hiddenAt(map,b.x,b.y) or b.item,
          flag=(tonumber(b.flag or b.hiddenFlag) or 0)>0 and tonumber(b.flag or b.hiddenFlag) or nil}
      end
    end
  end
end
local seenShop={}
for key,ops in pairs(scripts) do
  for _,h in ipairs(handouts(key)) do
    if h.std==0 then
      local places=scriptMaps(key)
      out.sources[#out.sources+1]={kind='Gift',map=places[1],maps=places,label=labelOf[key] or key,item=W.substitute(labelMaps[key],0,h.item,nil,key) or h.item}
    end
  end
  for _,op in ipairs(ops) do
    if op.op=='pokemart' then
      local mk=op[1]
      if not seenShop[mk] then
        seenShop[mk]=true
        local mr=martPack.marts and (martPack.marts[mk] or martPack.marts[tonumber(tostring(mk):match('g3:(%x+)') or '',16)])
        if not mr then for _,v in pairs(martPack.marts or {}) do if v.key==mk then mr=v end end end
        if mr and mr.kind~='decorations' then
          local places=scriptMaps(key)
          local berries={}
          for b=0,8 do berries[b+1]=W.berries(b,W.sources.marts[mk]) end
          out.shops[#out.shops+1]={key=mk,label=labelOf[key] or key,map=places[1],maps=places,vanillaItems=mr.items,
            campaign=W.sources.marts[mk],berries=berries}
        end
      end
    end
  end
end

-- Strict JSON (Lua %q is not JSON when strings contain line breaks/control bytes).
local function quote(s)
  return '"'..s:gsub('[%z\1-\31\\"]',function(c)
    local esc={['"']='\\"',['\\']='\\\\',['\n']='\\n',['\r']='\\r',['\t']='\\t'}
    return esc[c] or string.format('\\u%04x',c:byte())
  end)..'"'
end
local function json(v)
  local t=type(v)
  if t=='nil' then return 'null' elseif t=='boolean' or t=='number' then return tostring(v)
  elseif t=='string' then return quote(v)
  elseif t=='table' then
    local count,array=0,true
    for k in pairs(v) do count=count+1;if type(k)~='number' or k<1 or k%1~=0 then array=false end end
    array=array and count==#v
    local parts={}
    if array then for i=1,#v do parts[i]=json(v[i]) end;return '['..table.concat(parts,',')..']' end
    local keys={};for k in pairs(v) do keys[#keys+1]=k end
    table.sort(keys,function(a,b)return tostring(a)<tostring(b)end)
    for _,k in ipairs(keys) do parts[#parts+1]=quote(tostring(k))..':'..json(v[k]) end
    return '{'..table.concat(parts,',')..'}'
  end
  error('Cannot encode '..t)
end
local f=assert(io.open(outPath,'w'));f:write(json(out));f:close()
