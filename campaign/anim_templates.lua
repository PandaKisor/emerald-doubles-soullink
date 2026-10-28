-- The donor sprite templates the donor's animations use (campaign/move_anims.lua
-- "templates", g1 format) added beside vanilla's. The engine's callbacks come
-- from four ports, each with its own template table and format, and the
-- callback decides which one a sprite reads, so each template goes into all
-- four (never over a vanilla entry):
--   g1 / g4  anim_port/g1_templates.lua, g4_templates.lua: 0-based tables of
--            {f,d,h,v} / {xs,ys,r,d}, {jump}, {loop}, {e=true}
--   g2       anim_port/g2_templates.lua (+ g2_pret's merged TEMPLATES):
--            1-based, {img,dur,h,v} / {xs,ys,rot,dur}, {stop=true}
--   g3       anim_port/g3_data.lua templates: 1-based, {f,d,h=1,v=1} /
--            {x,y,r,d}, {j}, {l}, {e=1}, aff/blend numbers
return function(templates)
  local function list(tbl, each)
    local out = {}
    for i = 0, 63 do
      if tbl[i] == nil then break end
      local seq = {}
      for j, c in ipairs(tbl[i]) do seq[j] = each(c) end
      out[i + 1] = seq
    end
    return out
  end
  local function g2frame(c)
    if c.e then return { stop = true } end
    if c.jump then return { jump = c.jump } end
    if c.loop then return { loop = c.loop } end
    return { img = c.f, dur = c.d or 0, h = c.h and true or false, v = c.v and true or false }
  end
  local function g2affine(c)
    if c.e then return { stop = true } end
    if c.jump then return { jump = c.jump } end
    if c.loop then return { loop = c.loop } end
    return { xs = c.xs, ys = c.ys, rot = c.r, dur = c.d }
  end
  local function g3frame(c)
    if c.e then return { e = 1 } end
    if c.jump then return { j = c.jump } end
    if c.loop then return { l = c.loop } end
    return { f = c.f, d = c.d, h = c.h and 1 or nil, v = c.v and 1 or nil }
  end
  local function g3affine(c)
    if c.e then return { e = 1 } end
    if c.jump then return { j = c.jump } end
    if c.loop then return { l = c.loop } end
    return { x = c.xs, y = c.ys, r = c.r, d = c.d }
  end

  local function port(name)
    local ok, m = pcall(require, "src.core.game3.battle.anim_port." .. name)
    return ok and type(m) == "table" and m or nil
  end
  local g1, g4, g2, g3 = port("g1_templates"), port("g4_templates"), port("g2_templates"), port("g3_data")
  local g2pret = port("g2_pret")
  local added = 0
  for name, t in pairs(templates or {}) do
    if g1 and g1[name] == nil then g1[name] = t end
    if g4 and g4[name] == nil then g4[name] = t end
    local two = { tag = t.tag, w = t.w, h = t.h, affineMode = t.affineMode, blend = t.objBlend, priority = t.priority,
                  anims = list(t.anims, g2frame), affine = list(t.affine, g2affine) }
    if g2 and g2[name] == nil then g2[name] = two end
    -- g2_pret merges g2_templates once, on first use
    if g2pret and g2pret.TEMPLATES and g2pret.TEMPLATES[name] == nil and g2pret._tmplLoaded then
      g2pret.TEMPLATES[name] = two
    end
    local three = g3 and g3.templates
    if three and three[name] == nil then
      three[name] = { tag = t.tag, w = t.w, h = t.h, aff = t.affineMode, blend = t.objBlend and 1 or 0,
                      anims = list(t.anims, g3frame), affine = list(t.affine, g3affine) }
    end
    added = added + 1
  end
  return added
end
