-- Authored trainer teams (campaign/trainer_teams.lua) over the ROM's.
--   * A listed vanilla trainer gets its new party: species, fixed level,
--     moves, held item, nature, ability, IVs and EVs. Unlisted trainers keep
--     the ROM's party.
--   * A trainer with a `partner` fights beside a new trainer as a two-trainer
--     battle (2-vs-2 tag): the partner only exists in the battle, borrows a
--     vanilla trainer's class and picture (`like`), and brings its own party.
--   * Levels are fixed. Boss aces sit at the level cap; g3_coop's caps read
--     the bosses' parties through Trainers.get, so they follow these teams.
return function(mod, data, teams, active)
  local Trainers = require("src.core.game3.scripting.trainers")
  local State = require("src.core.game3.battle.state")
  local ids = data.identity.namespaces
  local NATURES = { "HARDY", "LONELY", "BRAVE", "ADAMANT", "NAUGHTY", "BOLD", "DOCILE", "RELAXED", "IMPISH", "LAX",
    "TIMID", "HASTY", "SERIOUS", "JOLLY", "NAIVE", "MODEST", "MILD", "QUIET", "BASHFUL", "RASH", "CALM", "GENTLE",
    "SASSY", "CAREFUL", "QUIRKY" }
  local NATURE = {}
  for i, n in ipairs(NATURES) do NATURE[n] = i - 1 end
  -- EV spreads by role
  local SPREADS = {
    atk = { atk = 1, spe = 1 }, spa = { spa = 1, spe = 1 }, bulk = { hp = 1, def = 1 },
    spdef = { hp = 1, spd = 1 }, tank = { hp = 1, atk = 1 }, stank = { hp = 1, spa = 1 },
  }
  local PARTNER_BASE = 3000
  local T = { byId = {}, partners = {} }

  local function abilityId(name) for id, row in pairs(data.abilities) do if row.symbol == "ABILITY_" .. name then return id end end end
  -- one authored mon -> the ROM party row shape, plus the extra fields
  local function row(spec, tier)
    local species = assert(ids.species["SPECIES_" .. spec[1]], "unknown species " .. tostring(spec[1]))
    local moves = {}
    for i, m in ipairs(spec.moves or {}) do moves[i] = assert(ids.moves["MOVE_" .. m], "unknown move " .. m) end
    local iv = spec.iv or tier.iv or 20
    local ev = spec.ev or tier.ev or 0
    local evs = { hp = 0, atk = 0, def = 0, spa = 0, spd = 0, spe = 0 }
    for stat in pairs(SPREADS[spec.spread or "atk"] or {}) do evs[stat] = ev end
    for stat, v in pairs(spec.evs or {}) do evs[stat] = v end
    return {
      species = species, level = spec[2], moves = moves, iv = iv, rawIv = math.floor(iv * 255 / 31),
      heldItem = spec.item and assert(ids.items["ITEM_" .. spec.item], "unknown item " .. spec.item) or 0,
      campaign = {
        ivs = { hp = iv, atk = iv, def = iv, spa = iv, spd = iv, spe = iv }, evs = evs,
        nature = spec.nature and assert(NATURE[spec.nature], "unknown nature " .. spec.nature) or nil,
        ability = spec.ability and assert(abilityId(spec.ability), "unknown ability " .. spec.ability) or nil,
        gender = spec.gender,
      },
    }
  end
  local function party(list, tier)
    local out = {}
    for i, spec in ipairs(list) do out[i] = row(spec, tier) end
    return out
  end

  -- trainer constants resolve lazily: the ROM's trainer table loads later
  local resolved = false
  local function resolve()
    if resolved then return end
    local C = require("src.core.game3.constants").of("emerald")
    local byName = C and C.trainers and C.trainers.byName
    if not byName then return end
    resolved = true
    local names = {}
    for name in pairs(teams.partners or {}) do names[#names + 1] = name end
    table.sort(names)
    local partnerIds = {}
    for i, name in ipairs(names) do
      local p = teams.partners[name]
      local like = assert(byName["TRAINER_" .. p.like], "unknown trainer " .. tostring(p.like))
      local id = PARTNER_BASE + i
      partnerIds[name] = id
      T.partners[id] = { name = p.name, like = like, defeat = p.defeat, party = party(p.party, teams.tiers[p.tier or "route"]) }
    end
    for name, t in pairs(teams.trainers or {}) do
      local id = assert(byName["TRAINER_" .. name], "unknown trainer " .. name)
      local bag
      if t.items then
        bag = { 0, 0, 0, 0 }
        for i, it in ipairs(t.items) do bag[i] = assert(ids.items["ITEM_" .. it], "unknown item " .. it) end
      end
      T.byId[id] = { party = party(t.party, teams.tiers[t.tier or "route"]), partner = t.partner and assert(partnerIds[t.partner], t.partner),
        double = t.double, bag = bag }
    end
  end
  T.resolve = resolve

  local get = Trainers.get
  Trainers.get = function(trainerId, ...)
    if not active() then return get(trainerId, ...) end
    resolve()
    local id = tonumber(trainerId)
    local p = id and T.partners[id]
    if p then
      local base = get(p.like, ...)
      if not base then return nil end
      base.id, base.name, base.party, base.partySize = id, p.name, p.party, #p.party
      base.dialogs = { defeat = p.defeat }
      base.doubleBattle = false
      return base
    end
    local t = id and T.byId[id]
    local base = get(trainerId, ...)
    if t and base then
      base.party, base.partySize = t.party, #t.party
      base.lastLevel = t.party[#t.party].level
      if t.double ~= nil then base.doubleBattle = t.double end
      -- the trainer's bag (Potions and the like), up to four
      if t.bag then base.items = t.bag end
    end
    return base
  end

  -- the trainer's mons get their authored IVs, EVs, nature, ability, gender
  local foeFromId = Trainers.foeFromId
  Trainers.foeFromId = function(trainerId, ...)
    local foe = foeFromId(trainerId, ...)
    if not foe or not active() then return foe end
    local t = Trainers.get(trainerId)
    for i, mon in ipairs(foe.party or {}) do
      -- the battle reads `item`; the ROM path only fills it under the R/S
      -- trainer policy, so held items were lost
      if mon.item == nil and (tonumber(mon.heldItem) or 0) ~= 0 then mon.item = tonumber(mon.heldItem) end
      local extra = t and t.party[i] and t.party[i].campaign
      if extra then
        mon.ivs, mon.evs = extra.ivs, extra.evs
        if extra.nature then mon.nature = extra.nature end
        if extra.ability then
          mon.ability = extra.ability
          -- the slot travels over the co-op link (the id doesn't)
          local sp = data.species[tonumber(mon.species) or 0]
          for slot, a in ipairs(sp and sp.abilities or {}) do
            if a == extra.ability then mon.abilityNum = slot - 1 break end
          end
        end
        if extra.gender then mon.gender = extra.gender end
      end
    end
    local lead = foe.party and foe.party[1]
    if lead then
      foe.ivs, foe.evs, foe.nature, foe.ability, foe.gender = lead.ivs, lead.evs, lead.nature, lead.ability, lead.gender
      foe.item = lead.item
    end
    return foe
  end

  -- an authored ability picks the species' slot that has it
  local makeBattler = State.makeBattler
  State.makeBattler = function(mon, ...)
    if active() and type(mon) == "table" and mon.abilityNum == nil and tonumber(mon.ability) then
      local sp = data.species[tonumber(mon.species) or 0]
      for slot, a in ipairs(sp and sp.abilities or {}) do
        if a == tonumber(mon.ability) then mon.abilityNum = slot - 1 break end
      end
    end
    return makeBattler(mon, ...)
  end

  -- a partnered trainer's battle becomes a two-trainer battle. g3_coop calls
  -- this before it plans a joint fight, and the bridge calls it for solo play.
  function T.battleOpts(opts)
    if not active() or type(opts) ~= "table" or opts.wild or opts.link or opts.trainerIdB then return opts end
    resolve()
    local t = T.byId[tonumber(opts.trainerId) or -1]
    if t and t.partner then
      opts.twoOpponents, opts.trainerIdB = true, t.partner
      opts.defeatTextB = opts.defeatTextB or T.partners[t.partner].defeat
    end
    return opts
  end
  local Bridge = require("src.core.game3.battle_bridge")
  Bridge.campaignTrainerOpts = T.battleOpts
  local start = Bridge.start
  Bridge.start = function(m, g, foe, opts, ...)
    if type(opts) == "table" and opts.trainerId and not opts.trainerIdB then T.battleOpts(opts) end
    return start(m, g, foe, opts, ...)
  end

  return T
end
