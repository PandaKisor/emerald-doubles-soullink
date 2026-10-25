-- Inclement learnsets, egg moves, machines and tutors teach only moves the
-- battle engine can run: the shared Gen 3 moves plus the expanded moves that
-- already have battle support. Everything else stays out until its effect is
-- ported, so no Pokémon can bring an unusable move into a battle.
--
-- Runs on the loaded content before the learning and tutor layers build
-- their compatibility sets from it.
return function(data, extraSupported)
  local ids = data.identity.namespaces.moves
  local nativeMax = assert(ids.MOVE_PSYCHO_BOOST, "Missing the last Gen 3 move")
  local tackle = assert(ids.MOVE_TACKLE)
  local function supported(move)
    move = tonumber(move)
    return move ~= nil and move > 0 and (move <= nativeMax or extraSupported[move] == true)
  end
  local dropped, filled = 0, 0
  for _, row in pairs(data.species) do
    local kept = {}
    for _, entry in ipairs(row.learnset) do
      if supported(entry[2]) then kept[#kept + 1] = entry else dropped = dropped + 1 end
    end
    -- A Pokémon caught or met at its lowest level must know something.
    local first = row.learnset[1] and row.learnset[1][1]
    if first and not (kept[1] and kept[1][1] <= math.max(first, 1)) then
      table.insert(kept, 1, { math.max(first, 1), tackle })
      filled = filled + 1
    end
    row.learnset = kept
    local eggs = {}
    for _, move in ipairs(row.eggMoves) do if supported(move) then eggs[#eggs + 1] = move end end
    row.eggMoves = eggs
    local machines = {}
    for _, item in ipairs(row.machines) do
      local info = data.items[item]
      if info and supported(info.machineMove) then machines[#machines + 1] = item end
    end
    row.machines = machines
    local tutors = {}
    for _, tutor in ipairs(row.tutors) do
      if supported(data.manifest.tutorMoves[tutor]) then tutors[#tutors + 1] = tutor end
    end
    row.tutors = tutors
  end
  return { supported = supported, dropped = dropped, filled = filled }
end
