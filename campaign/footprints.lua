-- Pokédex footprints for the new species (ids 413+): the ROM has none, so the
-- dex screen's Kit.rgbaImage read of footprints/<id>.rgba finds nothing.
-- Inclement's prints (campaign/footprint_data.lua, one bit per pixel) are
-- drawn into the same black-on-clear 16x16 image the ROM ones decode to.
return function(Kit, data, active)
  local cache = {}
  local function image(id)
    local hex = data[id]
    if not hex then return nil end
    if cache[id] == nil then
      local ok, img = pcall(function()
        local px = love.image.newImageData(16, 16)
        for i = 0, 63 do
          local nibble = tonumber(hex:sub(i + 1, i + 1), 16)
          for b = 0, 3 do
            local n = i * 4 + b
            local on = math.floor(nibble / 2 ^ (3 - b)) % 2 == 1
            px:setPixel(n % 16, math.floor(n / 16), 0, 0, 0, on and 1 or 0)
          end
        end
        local out = love.graphics.newImage(px)
        out:setFilter("nearest", "nearest")
        return out
      end)
      cache[id] = ok and img or false
    end
    return cache[id] or nil
  end
  local rgbaImage = Kit.rgbaImage
  Kit.rgbaImage = function(path, w, h, ...)
    local img = rgbaImage(path, w, h, ...)
    if img or not active() then return img end
    local id = type(path) == "string" and tonumber(path:match("pokemon/footprints/(%d+)%.rgba$"))
    return id and image(id) or img
  end
  return { image = image, count = function() local n = 0 for _ in pairs(data) do n = n + 1 end return n end }
end
