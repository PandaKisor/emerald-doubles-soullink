-- HM moves outside battle (user, 2026-11-01): holding the HM and the badge is
-- enough, no Pokémon has to know the move. The first Pokémon that isn't an egg
-- does it when nobody knows it. Fly and Flash, which start from the party menu,
-- show on every Pokémon. The engine's badge checks still apply.
return function(data, active)
  local FM = require("src.core.game3.field_moves")
  local Flags = require("src.core.game3.scripting.flags")
  local Bag = require("src.core.game3.bag")
  local Runtime = require("src.core.game3.runtime")
  local items = data.identity.namespaces.items
  local HM = { CUT = "HM01_CUT", FLY = "HM02_FLY", SURF = "HM03_SURF", STRENGTH = "HM04_STRENGTH",
    FLASH = "HM05_FLASH", ROCK_SMASH = "HM06_ROCK_SMASH", WATERFALL = "HM07_WATERFALL", DIVE = "HM08_DIVE" }
  local itemFor = {}
  for move, sym in pairs(HM) do
    itemFor[FM.MOVES[move]] = assert(items["ITEM_" .. sym], sym)
  end
  local H = {}
  function H.holds(moveId)
    local item = itemFor[moveId]
    local s = Runtime.getSession and Runtime.getSession()
    return item ~= nil and s ~= nil and s.bag ~= nil and active() and Bag.has(s.bag, item) == true
  end
  local function firstMon(party)
    for slot = 1, #(party or {}) do
      local mon = party[slot]
      if mon and not mon.isEgg and not mon.egg and (tonumber(mon.species) or 0) ~= 0 then return mon, slot - 1 end
    end
  end
  local user = FM.partyMoveUser
  function FM.partyMoveUser(party, move, ...)
    local mon, slot = user(party, move, ...)
    if mon or not H.holds(FM.normalizeMoveId(move)) then return mon, slot end
    local m, s = firstMon(party)
    if m then return m, s end
    return mon, slot
  end
  -- the party menu's list: this Pokémon's moves plus the held menu moves
  function FM.campaignMenuMoves(mon)
    local out = {}
    for i, m in ipairs(mon.moves) do out[i] = m end
    for _, move in ipairs({ FM.MOVES.FLY, FM.MOVES.FLASH }) do
      if H.holds(move) then out[#out + 1] = move end
    end
    return out
  end
  -- scripts: "checkpartymove" for tree, rock, boulder, water, waterfall, dive
  function H.script(ctx, row)
    local vm = ctx and ctx.runner
    local moveId = tonumber(row and row[1])
    if not (vm and vm.store and moveId and H.holds(moveId)) then return end
    if Flags.getVar(vm.store, vm.ctx, 0x800D) ~= 6 then return end
    local s = Runtime.getSession()
    local mon, slot = firstMon(s and s.party)
    if not mon then return end
    Flags.setVar(vm.store, vm.ctx, 0x800D, slot)
    Flags.setVar(vm.store, vm.ctx, 0x8004, tonumber(mon.species))
  end
  return H
end
