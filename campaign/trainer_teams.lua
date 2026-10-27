-- Trainer teams, Route 103 rival to Roxanne and the Rustboro rival (draft 1,
-- 2026-10-23), read by
-- campaign/trainers.lua. Built for doubles from Inclement Emerald's teams for
-- the same trainers (pokeemerald-1.13 trainer_parties.h) and the species on
-- these routes, with fixed levels: route trainers climb toward the cap, boss
-- aces sit on it (Roxanne: Nosepass 15).
--   trainers  vanilla trainer constant (no TRAINER_) -> { party, partner, tier,
--             items } (items: the trainer's bag, up to four, e.g. { "SUPER_POTION" })
--   partners  new tag partners: borrow `like`'s class and picture
--   party     { SPECIES, level, moves, item, nature, ability, spread, iv, ev }
--   spread    which stats get `ev` EVs: atk (Atk/Spe), spa (SpA/Spe), bulk
--             (HP/Def), spdef (HP/SpD), tank (HP/Atk), stank (HP/SpA)
return {
  tiers = {
    route = { iv = 20, ev = 84 },
    grunt = { iv = 24, ev = 128 },
    gym = { iv = 25, ev = 128 },
    leader = { iv = 31, ev = 252 },
  },

  trainers = {
    -- Rival, Route 103: just the starter (the player has only theirs) -------------
    BRENDAN_ROUTE_103_MUDKIP = { party = {
      { "TREECKO", 5, nature = "JOLLY", item = "ORAN_BERRY", moves = { "POUND", "LEER" } },
    } },
    BRENDAN_ROUTE_103_TREECKO = { party = {
      { "TORCHIC", 5, nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SCRATCH", "GROWL" } },
    } },
    BRENDAN_ROUTE_103_TORCHIC = { party = {
      { "MUDKIP", 5, nature = "ADAMANT", item = "ORAN_BERRY", moves = { "TACKLE", "GROWL" } },
    } },
    MAY_ROUTE_103_MUDKIP = { party = {
      { "TREECKO", 5, nature = "JOLLY", item = "ORAN_BERRY", moves = { "POUND", "LEER" } },
    } },
    MAY_ROUTE_103_TREECKO = { party = {
      { "TORCHIC", 5, nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SCRATCH", "GROWL" } },
    } },
    MAY_ROUTE_103_TORCHIC = { party = {
      { "MUDKIP", 5, nature = "ADAMANT", item = "ORAN_BERRY", moves = { "TACKLE", "GROWL" } },
    } },

    -- Rival, Rustboro (after the Devon Goods): four, alone (a story fight); the
    -- starter is the ace at 17 (the cap after Roxanne) -----------------------------
    BRENDAN_RUSTBORO_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "DEWPIDER", 16, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "BUBBLE", "INFESTATION", "WATER_SPORT" } },
      { "GROWLITHE", 16, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "REVERSAL", "ROAR" } },
      { "GROVYLE", 17, ability = "OVERGROW", nature = "JOLLY", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "DRAGON_BREATH", "FURY_CUTTER", "ROCK_TOMB" } },
    } },
    BRENDAN_RUSTBORO_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "GROWLITHE", 16, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "REVERSAL", "ROAR" } },
      { "SHROOMISH", 16, ability = "POISON_HEAL", nature = "IMPISH", spread = "bulk", item = "TOXIC_ORB", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "HEADBUTT" } },
      { "MARSHTOMP", 17, ability = "TORRENT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_SHOT", "WATER_GUN", "ROCK_TOMB", "GROWL" } },
    } },
    BRENDAN_RUSTBORO_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "DEWPIDER", 16, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "BUBBLE", "INFESTATION", "WATER_SPORT" } },
      { "SHROOMISH", 16, ability = "POISON_HEAL", nature = "IMPISH", spread = "bulk", item = "TOXIC_ORB", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "HEADBUTT" } },
      { "COMBUSKEN", 17, ability = "BLAZE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DOUBLE_KICK", "ROCK_TOMB", "FLAME_CHARGE", "PECK" } },
    } },
    MAY_RUSTBORO_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "RECOVER", "PSYWAVE", "SWIFT" } },
      { "PONYTA", 16, ability = "FLAME_BODY", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "DOUBLE_KICK", "TACKLE", "TAIL_WHIP" } },
      { "GROVYLE", 17, ability = "OVERGROW", nature = "JOLLY", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "DRAGON_BREATH", "FURY_CUTTER", "ROCK_TOMB" } },
    } },
    MAY_RUSTBORO_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "STEENEE", 16, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "CHARM", "ACUPRESSURE", "SYNTHESIS" } },
      { "PONYTA", 16, ability = "FLAME_BODY", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "DOUBLE_KICK", "TACKLE", "TAIL_WHIP" } },
      { "MARSHTOMP", 17, ability = "TORRENT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_SHOT", "WATER_GUN", "ROCK_TOMB", "GROWL" } },
    } },
    MAY_RUSTBORO_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "DOUBLE_TEAM" } },
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "RECOVER", "PSYWAVE", "SWIFT" } },
      { "STEENEE", 16, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "CHARM", "ACUPRESSURE", "SYNTHESIS" } },
      { "COMBUSKEN", 17, ability = "BLAZE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DOUBLE_KICK", "ROCK_TOMB", "FLAME_CHARGE", "PECK" } },
    } },

    -- Route 102 ---------------------------------------------------------------
    CALVIN_1 = { partner = "R102_DALE", party = {
      { "POOCHYENA", 8, ability = "QUICK_FEET", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BITE", "HOWL", "TACKLE", "SAND_ATTACK" } },
      { "LILLIPUP", 8, ability = "VITAL_SPIRIT", nature = "ADAMANT", item = "SILK_SCARF", moves = { "TACKLE", "BITE", "HELPING_HAND", "BABY_DOLL_EYES" } },
    } },
    RICK = { partner = "R102_OWEN", party = {
      { "WURMPLE", 7, ability = "SHIELD_DUST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "POISON_STING", "BUG_BITE", "STRING_SHOT", "TACKLE" } },
      { "GRUBBIN", 8, ability = "SWARM", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "BUG_BITE", "BITE", "MUD_SLAP", "STRING_SHOT" } },
    } },
    ALLEN = { partner = "R102_BEN", party = {
      { "ZIGZAGOON", 7, ability = "GLUTTONY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "SAND_ATTACK", "TAIL_WHIP", "GROWL" } },
      { "TAILLOW", 8, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PECK", "QUICK_ATTACK", "FOCUS_ENERGY", "GROWL" } },
    } },
    TIANA = { partner = "R102_DANA", party = {
      { "BUIZEL", 8, ability = "SWIFT_SWIM", nature = "HASTY", item = "MYSTIC_WATER", moves = { "WATER_GUN", "QUICK_ATTACK", "SONIC_BOOM", "GROWL" } },
      { "SHROOMISH", 8, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "ABSORB", "LEECH_SEED", "TACKLE" } },
    } },

    -- Route 104 (south) ------------------------------------------------------------
    BILLY = { partner = "R104_SAM", party = {
      { "LITLEO", 10, ability = "UNNERVE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "EMBER", "WORK_UP", "HEADBUTT", "LEER" } },
      { "SEEDOT", 9, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "ASTONISH", "GROWTH", "HARDEN" } },
    } },
    DARIAN = { partner = "R104_NEIL", party = {
      { "GOLDEEN", 10, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "PECK", "SUPERSONIC", "WATER_SPORT" } },
      { "WINGULL", 9, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "SHARP_BEAK", moves = { "WATER_GUN", "AERIAL_ACE", "SUPERSONIC", "GROWL" } },
    } },
    CINDY_1 = { partner = "R104_PERCY", party = {
      { "BUNEARY", 10, ability = "LIMBER", nature = "JOLLY", item = "SILK_SCARF", moves = { "POUND", "DEFENSE_CURL", "ENDURE", "BABY_DOLL_EYES" } },
      { "AZURILL", 9, ability = "THICK_FAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE", "WATER_GUN", "CHARM", "TAIL_WHIP" } },
    } },

    -- Petalburg Woods ----------------------------------------------------------------
    LYLE = { partner = "PW_WADE", party = {
      { "VENIPEDE", 10, ability = "SPEED_BOOST", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_STING", "ROLLOUT", "DEFENSE_CURL", "SCREECH" } },
      { "SURSKIT", 10, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE", "QUICK_ATTACK", "SWEET_SCENT", "WATER_SPORT" } },
      { "SEWADDLE", 10, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BUG_BITE", "STRING_SHOT", "TACKLE", "RAZOR_LEAF" } },
    } },
    JAMES_1 = { partner = "PW_COLE", party = {
      { "PARAS", 11, ability = "EFFECT_SPORE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "STUN_SPORE", "FURY_CUTTER", "ABSORB", "SCRATCH" } },
      { "SHROOMISH", 11, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "MEGA_DRAIN", "TACKLE" } },
    } },
    -- the story grunt fights alone (co-op shares this scene)
    GRUNT_PETALBURG_WOODS = { tier = "grunt", party = {
      { "CARVANHA", 12, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "RAGE", "LEER" } },
      { "SKRELP", 11, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "POOCHYENA", 11, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "HOWL", "SAND_ATTACK", "TACKLE" } },
    } },

    -- Route 104 (north) --------------------------------------------------------------
    WINSTON_1 = { partner = "R104_ROSA", party = {
      { "PIDOVE", 11, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "LEER", "GROWL" } },
      { "BIDOOF", 12, ability = "SIMPLE", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "HEADBUTT", "TACKLE" } },
    } },
    HALEY_1 = { partner = "R104_TARA", party = {
      { "GOTHITA", 11, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "FAKE_TEARS", "PLAY_NICE", "TICKLE" } },
      { "SKIDDO", 11, ability = "SAP_SIPPER", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "VINE_WHIP", "LEECH_SEED", "GROWTH", "TACKLE" } },
      { "STARLY", 11, ability = "RECKLESS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AERIAL_ACE", "GROWL", "DOUBLE_TEAM" } },
    } },
    -- the twins are a double on their own
    GINA_AND_MIA_1 = { party = {
      { "COTTONEE", 11, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND", "MEGA_DRAIN" } },
      { "PETILIL", 11, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "SLEEP_POWDER", "MEGA_DRAIN", "FAIRY_WIND", "LEECH_SEED" } },
      { "LOTAD", 11, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "MIST", "ASTONISH" } },
      { "SEEDOT", 11, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROLLOUT", "GROWTH", "ABSORB", "HARDEN" } },
    } },
    IVAN = { partner = "R104_HUGO", party = {
      { "TENTACOOL", 11, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ACID", "BUBBLE", "SUPERSONIC", "WRAP" } },
      { "LUVDISC", 11, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },

    -- Rustboro Gym: trainers fight alone with three --------------------------------------
    JOSH = { tier = "gym", party = {
      { "GEODUDE", 12, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_THROW", "MAGNITUDE", "ROCK_POLISH", "DEFENSE_CURL" } },
      { "DWEBBLE", 12, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_BLAST", "FURY_CUTTER", "WITHDRAW", "SAND_ATTACK" } },
      { "BONSLY", 12, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "LOW_KICK", "FAKE_TEARS", "FLAIL" } },
    } },
    TOMMY = { tier = "gym", party = {
      { "ROCKRUFF", 13, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_THROW", "BITE", "HOWL", "SAND_ATTACK" } },
      { "KABUTO", 13, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ABSORB", "SCRATCH", "SAND_ATTACK" } },
      { "ROGGENROLA", 12, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_BLAST", "MUD_SLAP", "HARDEN", "TACKLE" } },
    } },
    MARC = { tier = "gym", party = {
      { "CRANIDOS", 13, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HEADBUTT", "PURSUIT", "FOCUS_ENERGY", "LEER" } },
      { "ARCHEN", 13, ability = "DEFEATIST", nature = "JOLLY", item = "SHARP_BEAK", moves = { "ROCK_THROW", "AERIAL_ACE", "QUICK_ATTACK", "DOUBLE_TEAM" } },
      { "SHIELDON", 13, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "PROTECT", "TAUNT", "METAL_SOUND", "TACKLE" } },
    } },

    -- Roxanne: six, alone (2-vs-1), Sand Force Nosepass is the ace at the cap ---------------
    ROXANNE_1 = { tier = "leader", party = {
      { "NOSEPASS", 15, ability = "SAND_FORCE", nature = "IMPISH", spread = "bulk", item = "BERRY_JUICE", moves = { "SANDSTORM", "ROCK_TOMB", "BULLDOZE", "THUNDER_WAVE" } },
      { "AMAURA", 13, ability = "REFRIGERATE", nature = "MODEST", spread = "spa", item = "CHOPLE_BERRY", moves = { "ECHOED_VOICE", "ROCK_TOMB", "THUNDER_WAVE", "ICY_WIND" } },
      { "ARON", 13, ability = "STURDY", nature = "ADAMANT", item = "CHESTO_BERRY", moves = { "ROCK_TOMB", "METAL_CLAW", "PROTECT", "REST" } },
      { "TYRUNT", 14, ability = "STRONG_JAW", nature = "ADAMANT", item = "RED_CARD", moves = { "BITE", "ROCK_TOMB", "STOMP", "STEALTH_ROCK" } },
      { "ANORITH", 14, ability = "BATTLE_ARMOR", nature = "JOLLY", item = "WATER_GEM", moves = { "ROCK_TOMB", "WATER_GUN", "METAL_CLAW", "FURY_CUTTER" } },
      { "LILEEP", 14, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    -- Chapter 2: Rustboro to Brawly (draft 1, 2026-10-27; cap 17 then 19) ------------
    -- Route 116, west: tag battles at 13-14 ------------------------------------------
    JOEY = { partner = "R116_TIM", party = {
      { "HOUNDOUR", 13, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "EMBER", "BITE", "SMOG", "HOWL" } },
      { "SKITTY", 13, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    JOSE = { partner = "R116_GUS", party = {
      { "JOLTIK", 13, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "ABSORB" } },
      { "SPINARAK", 13, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_STING", "SHADOW_SNEAK", "INFESTATION", "STRING_SHOT" } },
    } },
    KAREN_1 = { partner = "R116_EMMA", party = {
      { "SKIDDO", 13, ability = "SAP_SIPPER", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "VINE_WHIP", "LEECH_SEED", "GROWTH" } },
      { "EEVEE", 13, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
    } },
    CLARK = { partner = "R116_HANK", party = {
      { "GEODUDE", 14, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_THROW", "ROLLOUT", "DEFENSE_CURL", "ROCK_POLISH" } },
      { "ARON", 14, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    DEVAN = { partner = "R116_OLAF", party = {
      { "DUNSPARCE", 14, ability = "SERENE_GRACE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BITE", "YAWN", "PROTECT" } },
      { "TEDDIURSA", 14, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    JOHNSON = { partner = "R116_RAY", party = {
      { "TAILLOW", 14, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
      { "BLITZLE", 14, ability = "MOTOR_DRIVE", nature = "JOLLY", item = "MAGNET", moves = { "SHOCK_WAVE", "FLAME_CHARGE", "QUICK_ATTACK", "THUNDER_WAVE" } },
    } },

    -- Route 116, east (Cut): tag battles at 14-15 ------------------------------------
    SARAH = { partner = "R116_ELLA", party = {
      { "BOUNSWEET", 14, ability = "SWEET_VEIL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "PLAY_NICE", "RAPID_SPIN", "HELPING_HAND" } },
      { "RALTS", 15, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DISARMING_VOICE", "CONFUSION", "MAGICAL_LEAF", "HYPNOSIS" } },
    } },
    DAWSON = { partner = "R116_REX", party = {
      { "AXEW", 15, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_RAGE", "BITE", "ASSURANCE", "LEER" } },
      { "SKITTY", 14, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    JERRY_1 = { partner = "R116_LIAM", party = {
      { "SHUPPET", 15, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "PANCHAM", 14, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ARM_THRUST", "KARATE_CHOP", "COMET_PUNCH", "WORK_UP" } },
    } },
    JANICE = { partner = "R116_JUNE", party = {
      { "MARILL", 15, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SEEDOT", 14, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ROLLOUT", "GROWTH", "HARDEN" } },
    } },

    -- Rusturf Tunnel: the grunt with the Devon Goods fights alone -------------------
    GRUNT_RUSTURF_TUNNEL = { tier = "grunt", party = {
      { "CARVANHA", 16, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ASSURANCE", "PROTECT" } },
      { "SKRELP", 15, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "ZUBAT", 15, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },

    -- Route 106 beach: tag battles at 16 ---------------------------------------------
    NED = { partner = "R106_KAI", party = {
      { "TENTACOOL", 16, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "FINNEON", 16, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "GUST", "ICY_WIND", "PROTECT" } },
    } },
    ELLIOT_1 = { partner = "R106_ROY", party = {
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "BINACLE", 16, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "FURY_SWIPES", "WATER_GUN", "SHADOW_CLAW" } },
    } },

    -- Dewford Gym: trainers fight alone with three -----------------------------------
    JOCELYN = { tier = "gym", party = {
      { "MEDITITE", 16, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "MANKEY", 16, ability = "DEFIANT", nature = "JOLLY", item = "BLACK_BELT", moves = { "KARATE_CHOP", "PURSUIT", "ROCK_TOMB", "FOCUS_ENERGY" } },
      { "CRABRAWLER", 16, ability = "HYPER_CUTTER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "BUBBLE_BEAM", "PURSUIT", "LEER" } },
    } },
    LAURA = { tier = "gym", party = {
      { "MIENFOO", 16, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LOW_SWEEP", "U_TURN", "DETECT" } },
      { "MAKUHITA", 16, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FORCE_PALM", "KNOCK_OFF", "SAND_ATTACK", "BULK_UP" } },
      { "CROAGUNK", 16, ability = "DRY_SKIN", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "FEINT_ATTACK", "TAUNT" } },
    } },
    BRENDEN = { tier = "gym", party = {
      { "TYROGUE", 17, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "MACH_PUNCH", "HELPING_HAND", "RAPID_SPIN" } },
      { "SCRAGGY", 17, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "LOW_SWEEP", "HEADBUTT", "PROTECT" } },
      { "TIMBURR", 17, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "ROCK_THROW", "FORCE_PALM", "BULK_UP" } },
    } },
    LILITH = { tier = "gym", party = {
      { "MONFERNO", 17, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "MACH_PUNCH", "FLAME_WHEEL", "U_TURN", "TAUNT" } },
      { "HAWLUCHA", 17, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "KARATE_CHOP", "FEATHER_DANCE", "DETECT" } },
      { "PANCHAM", 16, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ARM_THRUST", "KARATE_CHOP", "COMET_PUNCH", "WORK_UP" } },
    } },
    CRISTIAN = { tier = "gym", party = {
      { "MACHOP", 16, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "FOCUS_ENERGY" } },
      { "PIGNITE", 17, ability = "THICK_FAT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
      { "STUFFUL", 16, ability = "FLUFFY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BRUTAL_SWING", "FORCE_PALM", "BABY_DOLL_EYES", "PROTECT" } },
    } },
    TAKAO = { tier = "gym", party = {
      { "JANGMO_O", 17, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
      { "RIOLU", 17, ability = "STEADFAST", nature = "JOLLY", item = "BLACK_BELT", moves = { "FORCE_PALM", "QUICK_ATTACK", "METAL_CLAW", "FEINT" } },
      { "SCRAGGY", 16, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "LOW_SWEEP", "PROTECT" } },
    } },

    -- Brawly: six, alone (2-vs-1), Guts Makuhita is the ace at the cap ---------------
    BRAWLY_1 = { tier = "leader", party = {
      { "MEDITITE", 17, ability = "PURE_POWER", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "BULLET_PUNCH", "DETECT" } },
      { "SCRAGGY", 17, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "LOW_SWEEP", "HEADBUTT", "PROTECT" } },
      { "MIENFOO", 18, ability = "REGENERATOR", nature = "JOLLY", item = "FOCUS_SASH", moves = { "LOW_SWEEP", "KNOCK_OFF", "U_TURN", "DETECT" } },
      { "RIOLU", 17, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "FORCE_PALM", "BULLET_PUNCH", "ROCK_TOMB", "FEINT" } },
      { "HAWLUCHA", 18, ability = "UNBURDEN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
      { "MAKUHITA", 19, ability = "GUTS", nature = "ADAMANT", spread = "tank", item = "FLAME_ORB", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ROCK_SLIDE" } },
    } },
    -- Chapter 3: Dewford to Wattson (draft 1, 2026-10-27; caps 20, 21, 24) -----------
    -- Route 109 beach: tag battles at 16-17 ------------------------------------------
    HUEY = { partner = "R109_WES", party = {
      { "WINGULL", 17, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "TIMBURR", 16, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
    } },
    EDMOND = { partner = "R109_PIP", party = {
      { "SLOWPOKE", 17, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "CONFUSION", "WATER_GUN", "YAWN", "DISABLE" } },
      { "STARAVIA", 17, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    HAILEY = { partner = "R109_DOT", party = {
      { "SPHEAL", 16, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "BIBAREL", 16, ability = "SIMPLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HEADBUTT", "AQUA_JET", "DEFENSE_CURL", "ROLLOUT" } },
    } },
    RICKY_1 = { partner = "R109_BO", party = {
      { "ZIGZAGOON", 17, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "MAREANIE", 16, ability = "MERCILESS", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "BITE", "POISON_STING", "TOXIC_SPIKES", "WIDE_GUARD" } },
    } },
    LOLA_1 = { partner = "R109_KIM", party = {
      { "WAILMER", 17, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "CHINCHOU", 16, ability = "VOLT_ABSORB", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTRO_BALL", "BUBBLE", "THUNDER_WAVE", "CONFUSE_RAY" } },
    } },
    CHANDLER = { partner = "R109_ZED", party = {
      { "PANPOUR", 17, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "BITE", "TAUNT", "PLAY_NICE" } },
      { "CORPHISH", 16, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },

    -- the Seashore House: three in a row, each alone with three ---------------------------
    SIMON = { party = {
      { "SEEL", 17, ability = "HYDRATION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ICY_WIND", "HEADBUTT", "ENCORE" } },
      { "CROCONAW", 18, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "ICE_FANG", "WATER_GUN", "SCARY_FACE" } },
      { "HERDIER", 17, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
    } },
    JOHANNA = { party = {
      { "GOLDEEN", 17, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
      { "BRUXISH", 17, ability = "DAZZLING", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "CONFUSION", "DISABLE" } },
      { "ALOMOMOLA", 17, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    DWAYNE = { party = {
      { "MAKUHITA", 18, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "TENTACOOL", 17, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "CORPHISH", 17, ability = "HYPER_CUTTER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "DOUBLE_HIT", "PROTECT" } },
    } },

    -- Oceanic Museum: two grunts in a row, each alone ------------------------------------
    GRUNT_MUSEUM_1 = { tier = "grunt", party = {
      { "CARVANHA", 18, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ASSURANCE", "PROTECT" } },
      { "BASCULIN", 17, ability = "ADAPTABILITY", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "BITE", "CHIP_AWAY", "TAIL_WHIP" } },
      { "ZUBAT", 17, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    GRUNT_MUSEUM_2 = { tier = "grunt", party = {
      { "GRIMER_ALOLAN", 18, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "POISON_FANG", "BITE", "DISABLE", "HARDEN" } },
      { "SKRELP", 17, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "POOCHYENA", 17, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "HOWL", "SAND_ATTACK", "TACKLE" } },
    } },

    -- Route 110: tag battles at 17-18 ------------------------------------------------------
    ISABEL_1 = { partner = "R110_ANN", party = {
      { "PLUSLE", 17, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "PACHIRISU", 17, ability = "VOLT_ABSORB", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "NUZZLE", "SPARK", "SUPER_FANG", "ENDURE" } },
    } },
    KALEB = { partner = "R110_GIL", party = {
      { "MINUN", 17, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "EMOLGA", 17, ability = "MOTOR_DRIVE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPARK", "AIR_CUTTER", "NUZZLE", "QUICK_ATTACK" } },
    } },
    TIMMY = { partner = "R110_OTTO", party = {
      { "FERROSEED", 17, ability = "IRON_BARBS", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "MIRROR_SHOT", "PIN_MISSILE", "LEECH_SEED", "PROTECT" } },
      { "ELECTRIKE", 17, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    EDWIN_1 = { partner = "R110_MOE", party = {
      { "LOMBRE", 18, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "MEGA_DRAIN", "BUBBLE", "KNOCK_OFF" } },
      { "NUZLEAF", 18, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "AIR_CUTTER", "GROWTH", "TORMENT" } },
    } },
    JOSEPH = { partner = "R110_BRAD", party = {
      { "LUXIO", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "BITE", "DOUBLE_KICK", "LEER" } },
      { "VOLTORB", 18, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
    } },
    EDWARD = { partner = "R110_VIC", party = {
      { "KADABRA", 18, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "SOLOSIS", 17, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "RECOVER", "CHARM", "PROTECT" } },
    } },
    ALYSSA = { partner = "R110_LIZ", party = {
      { "MAGNEMITE", 18, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "SUPERSONIC" } },
      { "TRANQUILL", 18, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "GUST", "ROOST" } },
    } },
    DALE = { partner = "R110_HAL", party = {
      { "WAILMER", 18, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "ALOMOMOLA", 17, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },

    -- Rival, Route 110: five, alone; the starter is the ace at 20 ---------------------------
    BRENDAN_ROUTE_110_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "DEWPIDER", 18, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "BUG_BITE", "BITE", "SPIDER_WEB" } },
      { "GROWLITHE", 19, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "REVERSAL" } },
      { "MAGNEMITE", 18, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "GROVYLE", 20, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "MEGA_DRAIN", "DRAGON_BREATH", "FURY_CUTTER", "QUICK_ATTACK" } },
    } },
    BRENDAN_ROUTE_110_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "GROWLITHE", 19, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "REVERSAL" } },
      { "SHROOMISH", 18, ability = "POISON_HEAL", nature = "IMPISH", spread = "bulk", item = "TOXIC_ORB", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "HEADBUTT" } },
      { "MAGNEMITE", 18, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "MARSHTOMP", 20, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "WATER_GUN", "ROCK_TOMB", "PROTECT" } },
    } },
    BRENDAN_ROUTE_110_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "DEWPIDER", 18, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "BUG_BITE", "BITE", "SPIDER_WEB" } },
      { "SHROOMISH", 18, ability = "POISON_HEAL", nature = "IMPISH", spread = "bulk", item = "TOXIC_ORB", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "HEADBUTT" } },
      { "MAGNEMITE", 18, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "COMBUSKEN", 20, ability = "BLAZE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_TOMB", "PECK" } },
    } },
    MAY_ROUTE_110_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "STARYU", 18, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "PONYTA", 18, ability = "FLAME_BODY", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "DOUBLE_KICK", "FLAME_CHARGE" } },
      { "AZUMARILL", 18, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "HELPING_HAND", "DEFENSE_CURL" } },
      { "GROVYLE", 20, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "MEGA_DRAIN", "DRAGON_BREATH", "FURY_CUTTER", "QUICK_ATTACK" } },
    } },
    MAY_ROUTE_110_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "STEENEE", 18, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
      { "PONYTA", 18, ability = "FLAME_BODY", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "DOUBLE_KICK", "FLAME_CHARGE" } },
      { "AZUMARILL", 18, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "HELPING_HAND", "DEFENSE_CURL" } },
      { "MARSHTOMP", 20, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "WATER_GUN", "ROCK_TOMB", "PROTECT" } },
    } },
    MAY_ROUTE_110_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "STARYU", 18, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "STEENEE", 18, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
      { "AZUMARILL", 18, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "HELPING_HAND", "DEFENSE_CURL" } },
      { "COMBUSKEN", 20, ability = "BLAZE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_TOMB", "PECK" } },
    } },

    -- Trick House 1: tag battles at 18 ---------------------------------------------------
    SALLY = { partner = "TH1_MIA", party = {
      { "ODDISH", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "TORRACAT", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "DOUBLE_KICK", "LICK", "ROAR" } },
    } },
    ROBIN = { partner = "TH1_ZOE", party = {
      { "FLETCHINDER", 18, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "FLAME_CHARGE", "PECK", "QUICK_ATTACK", "TAILWIND" } },
      { "BRIONNE", 18, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "DISARMING_VOICE", "ICY_WIND", "AQUA_JET", "ENCORE" } },
    } },
    EDDIE = { partner = "TH1_KIP", party = {
      { "DUCKLETT", 18, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "FEATHER_DANCE", "DEFOG" } },
      { "DARTRIX", 18, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PECK", "FORESIGHT" } },
    } },

    -- Route 103 east: tag battles at 18-19 --------------------------------------------------
    DAISY = { partner = "R103_FAY", party = {
      { "CHERUBI", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
      { "ROSELIA", 19, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "MEGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    -- the twins are a double on their own
    AMY_AND_LIV_1 = { party = {
      { "JIGGLYPUFF", 18, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
      { "CLEFAIRY", 18, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
      { "PLUSLE", 18, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "MINUN", 18, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
    } },
    MIGUEL_1 = { partner = "R103_GUY", party = {
      { "SKITTY", 19, ability = "WONDER_SKIN", nature = "JOLLY", item = "SILK_SCARF", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "MEOWTH", 19, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_SWIPES", "BITE", "FEINT_ATTACK", "TAUNT" } },
    } },
    ANDREW = { partner = "R103_FINN", party = {
      { "BARBOACH", 19, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_GUN", "AMNESIA", "PROTECT" } },
      { "HORSEA", 18, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "LEER" } },
      { "QWILFISH", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATER_GUN", "TOXIC_SPIKES", "HARDEN" } },
    } },
    MARCOS = { partner = "R103_JAX", party = {
      { "ELEKID", 19, ability = "STATIC", nature = "JOLLY", item = "MAGNET", moves = { "SHOCK_WAVE", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "KRICKETUNE", 19, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    RHETT = { partner = "R103_DUKE", party = {
      { "SAWK", 19, ability = "STURDY", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "KARATE_CHOP", "ROCK_TOMB", "COUNTER" } },
      { "MAKUHITA", 19, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "VITAL_THROW" } },
    } },

    -- Wally at Mauville's gym door: four, alone; Kirlia is the ace at 21 -----------------------
    WALLY_MAUVILLE = { tier = "gym", party = {
      { "ROSELIA", 20, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
      { "FLETCHINDER", 20, ability = "FLAME_BODY", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_CHARGE", "ACROBATICS", "QUICK_ATTACK", "TAILWIND" } },
      { "AZUMARILL", 20, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "KIRLIA", 21, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },

    -- Cycling Road: tag battles at 20-21 -------------------------------------------------------
    JACLYN = { partner = "CR_NOVA", party = {
      { "SOLOSIS", 20, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "RECOVER", "CHARM", "PROTECT" } },
      { "KADABRA", 21, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    JACOB = { partner = "CR_TOD", party = {
      { "GROWLITHE", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "ROAR" } },
      { "ROCKRUFF", 21, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
    } },
    ANTHONY = { partner = "CR_WIN", party = {
      { "MAGNEMITE", 20, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "CHARJABUG", 20, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
    } },
    BENJAMIN_1 = { partner = "CR_ACE", party = {
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "GEODUDE_ALOLAN", 20, ability = "GALVANIZE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "SPARK", "SMACK_DOWN", "ROCK_POLISH" } },
    } },
    ABIGAIL_1 = { partner = "CR_ADA", party = {
      { "EMOLGA", 20, ability = "MOTOR_DRIVE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "AIR_CUTTER", "NUZZLE", "QUICK_ATTACK" } },
      { "TOGEDEMARU", 20, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    JASMINE = { partner = "CR_SKY", party = {
      { "STARAVIA", 20, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
      { "KLINK", 20, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "VISE_GRIP", "CHARGE_BEAM", "METAL_SOUND", "AUTOTOMIZE" } },
    } },

    -- Route 117: tag battles at 20-21; the breeders and the twins fight alone ------------------
    DEREK = { partner = "R117_KAI", party = {
      { "MOTHIM", 21, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "CONFUSION", "QUIVER_DANCE", "PROTECT" } },
      { "JOLTIK", 20, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },
    ANNA_AND_MEG_1 = { party = {
      { "MINCCINO", 21, ability = "SKILL_LINK", nature = "JOLLY", item = "SILK_SCARF", moves = { "DOUBLE_SLAP", "SWIFT", "HELPING_HAND", "ENCORE" } },
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "SKITTY", 20, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "MACHOP", 20, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    DYLAN_1 = { partner = "R117_LEE", party = {
      { "YANMA", 21, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "SILVER_WIND", "DETECT", "SUPERSONIC" } },
      { "DODUO", 20, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
    } },
    MARIA_1 = { partner = "R117_MAE", party = {
      { "TRANQUILL", 20, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "DETECT", "TAILWIND" } },
      { "HAWLUCHA", 21, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
    } },
    ISAAC_1 = { party = {
      { "EEVEE", 19, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
      { "BONSLY", 19, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_THROW", "LOW_KICK", "FAKE_TEARS", "FLAIL" } },
      { "DEINO", 19, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "BITE", "HEADBUTT", "FOCUS_ENERGY" } },
      { "LITWICK", 19, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EMBER", "ASTONISH", "MINIMIZE", "CONFUSE_RAY" } },
    } },
    LYDIA_1 = { party = {
      { "ELEKID", 19, ability = "STATIC", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "MAGBY", 19, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EMBER", "SMOG", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "SMOOCHUM", 19, ability = "OBLIVIOUS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "POWDER_SNOW", "HEART_STAMP", "SWEET_KISS", "SING" } },
      { "DRATINI", 19, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "TWISTER", "THUNDER_WAVE", "AGILITY" } },
    } },
    MELINA = { partner = "R117_ROX", party = {
      { "PONYTA", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
      { "SNEASEL", 21, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "ICY_WIND", "QUICK_ATTACK", "TAUNT" } },
    } },
    BRANDI = { partner = "R117_IVY", party = {
      { "ESPURR", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MUNNA", 21, ability = "TELEPATHY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "MOONLIGHT", "DEFENSE_CURL" } },
    } },
    AISHA = { partner = "R117_JO", party = {
      { "LUCARIO", 21, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "BULLET_PUNCH", "METAL_CLAW", "DETECT" } },
      { "MEDITITE", 20, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },

    -- Route 111 south: tag battles at 21 ----------------------------------------------------------
    TYRON = { partner = "R111_ABE", party = {
      { "SANDSHREW", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "SCYTHER", 21, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "WING_ATTACK", "FALSE_SWIPE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
    } },
    CELINA = { partner = "R111_NIA", party = {
      { "BELLSPROUT", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "VINE_WHIP", "ACID", "SLEEP_POWDER", "WRAP" } },
      { "SKIPLOOM", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
    } },
    BIANCA = { partner = "R111_PIA", party = {
      { "PUMPKABOO", 21, ability = "INSOMNIA", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "ASTONISH", "LEECH_SEED", "CONFUSE_RAY" } },
      { "RATICATE", 21, ability = "GUTS", nature = "JOLLY", item = "SILK_SCARF", moves = { "HYPER_FANG", "QUICK_ATTACK", "BITE", "FOCUS_ENERGY" } },
    } },
    HAYDEN = { partner = "R111_CY", party = {
      { "NUMEL", 21, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "PONYTA", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
    } },

    -- the Winstrates: four in a row, each alone with three -------------------------------------
    VICTOR = { tier = "gym", party = {
      { "STARAVIA", 21, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
      { "GUMSHOOS", 21, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "FIRE_FANG", "ICE_FANG", "SAND_ATTACK" } },
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    VICTORIA = { tier = "gym", party = {
      { "WHIMSICOTT", 21, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "MEGA_DRAIN", "FAIRY_WIND", "STUN_SPORE" } },
      { "ROSELIA", 21, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
      { "CLEFAIRY", 21, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
    } },
    VIVI = { tier = "gym", party = {
      { "BUIZEL", 21, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "QUICK_ATTACK", "SWIFT", "PURSUIT" } },
      { "SALANDIT", 21, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "SMOG", "DRAGON_RAGE", "SWEET_SCENT" } },
      { "SKIDDO", 21, ability = "SAP_SIPPER", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "BULLDOZE", "LEECH_SEED", "GROWTH" } },
    } },
    VICKY = { tier = "gym", party = {
      { "HERACROSS", 22, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "HORN_ATTACK", "ARM_THRUST", "NIGHT_SLASH", "COUNTER" } },
      { "MEOWTH", 21, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
      { "WHIMSICOTT", 21, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "MEGA_DRAIN", "FAIRY_WIND", "COTTON_SPORE" } },
    } },

    -- Mauville Gym: trainers fight alone with three ----------------------------------------------
    KIRK = { tier = "gym", party = {
      { "VOLTORB", 22, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
      { "BLITZLE", 21, ability = "MOTOR_DRIVE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "FLAME_CHARGE", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "ELECTRIKE", 22, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    SHAWN = { tier = "gym", party = {
      { "HELIOPTILE", 22, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDER_SHOCK", "QUICK_ATTACK", "MUD_SLAP", "CHARGE" } },
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "LUXIO", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "BITE", "DOUBLE_KICK", "LEER" } },
    } },
    BEN = { tier = "gym", party = {
      { "STUNFISK", 22, ability = "STATIC", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "THUNDER_SHOCK", "MUD_SHOT", "SUCKER_PUNCH" } },
      { "TOGEDEMARU", 22, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "ROLLOUT", "DEFENSE_CURL" } },
      { "CHARJABUG", 21, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
    } },
    VIVIAN = { tier = "gym", party = {
      { "ELEKID", 22, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "MAGNET", moves = { "SHOCK_WAVE", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "MACHOP", 21, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "PACHIRISU", 21, ability = "VOLT_ABSORB", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "NUZZLE", "SPARK", "SUPER_FANG", "ENDURE" } },
    } },
    ANGELO = { tier = "gym", party = {
      { "ILLUMISE", 22, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
      { "VOLBEAT", 22, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
      { "JOLTIK", 21, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },

    -- Wattson: six, alone (2-vs-1); Raichu is the ace at the cap ---------------------------------
    WATTSON_1 = { tier = "leader", party = {
      { "MAGNEMITE", 22, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "JOLTIK", 22, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "FOCUS_SASH", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "ABSORB" } },
      { "CHINCHOU", 22, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "SPARK", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "ROTOM", 23, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "TOGEDEMARU", 23, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "SPARK", "NUZZLE", "U_TURN", "DEFENSE_CURL" } },
      { "RAICHU", 24, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
    } },
    -- Chapter 4: Mauville to Flannery (draft 1, 2026-10-27; caps 25, 26, 29) ----------
    -- Route 111 north: Gabby and Ty interview you with a double of their own -------------
    GABBY_AND_TY_1 = { party = {
      { "MAGNEMITE", 22, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "LOUDRED", 22, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "BITE", "HOWL", "SUPERSONIC" } },
    } },

    -- Route 112: tag battles at 21-22 -----------------------------------------------------
    LARRY = { partner = "R112_BUD", party = {
      { "WEEPINBELL", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "GROWLITHE", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "ROAR" } },
    } },
    CAROL = { partner = "R112_SUE", party = {
      { "NOCTOWL", 21, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "CONFUSION", "HYPNOSIS", "REFLECT" } },
      { "ODDISH", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BRICE = { partner = "R112_GUS", party = {
      { "DRILBUR", 22, ability = "MOLD_BREAKER", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "BULLDOZE", "RAPID_SPIN", "HONE_CLAWS" } },
      { "DWEBBLE", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BUG_BITE", "SMACK_DOWN", "PROTECT" } },
    } },
    TRENT_1 = { partner = "R112_ROB", party = {
      { "GEODUDE_ALOLAN", 22, ability = "GALVANIZE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "SPARK", "SMACK_DOWN", "ROCK_POLISH" } },
      { "GEODUDE", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    BRYANT = { partner = "R112_ASH", party = {
      { "SLUGMA", 22, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "ROCK_THROW", "CLEAR_SMOG", "HARDEN" } },
      { "QUILAVA", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "SWIFT", "QUICK_ATTACK", "SMOKESCREEN" } },
    } },
    SHAYLA = { partner = "R112_LIL", party = {
      { "BAYLEEF", 22, ability = "TRIAGE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "CHERUBI", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
    } },

    -- Route 113: tag battles at 21-22 in the ash ------------------------------------------------
    JAYLEN = { partner = "R113_PIP", party = {
      { "TRAPINCH", 22, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "DARUMAKA", 21, ability = "HUSTLE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "HEADBUTT", "BITE", "WORK_UP" } },
    } },
    DILLON = { partner = "R113_TAD", party = {
      { "ARON", 22, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
      { "HERDIER", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
    } },
    LAO_1 = { partner = "R113_ZEN", party = {
      { "FROGADIER", 22, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "ROUND" } },
      { "KOFFING", 21, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SMOG", "SLUDGE", "SMOKESCREEN", "HAZE" } },
    } },
    LUNG = { partner = "R113_KO", party = {
      { "NINJASK", 22, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "KOFFING", 21, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SMOG", "SLUDGE", "SMOKESCREEN", "HAZE" } },
    } },
    MADELINE_1 = { partner = "R113_UMA", party = {
      { "TROPIUS", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
      { "NUMEL", 22, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "SPHEAL", 21, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    -- the twins are a double on their own
    TORI_AND_TIA = { party = {
      { "SPINDA", 22, ability = "CONTRARY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "PSYBEAM", "DIZZY_PUNCH", "FAKE_OUT" } },
      { "SPINDA", 22, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    SOPHIE = { partner = "R113_BEA", party = {
      { "SUDOWOODO", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "LOW_KICK", "BLOCK", "FAKE_TEARS" } },
      { "SWIRLIX", 21, ability = "SWEET_VEIL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "COTTON_SPORE", "PLAY_NICE" } },
    } },
    COBY = { partner = "R113_TAO", party = {
      { "SKARMORY", 22, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SAND_ATTACK", "SPIKES" } },
      { "TRUMBEAK", 21, ability = "SKILL_LINK", nature = "JOLLY", item = "SHARP_BEAK", moves = { "ROCK_BLAST", "PLUCK", "ROCK_SMASH", "SUPERSONIC" } },
    } },
    LAWRENCE = { partner = "R113_RIO", party = {
      { "BALTOY", 22, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
      { "HIPPOPOTAS", 21, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "YAWN", "SAND_TOMB" } },
    } },
    WYATT = { partner = "R113_MAX", party = {
      { "CHARMELEON", 22, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "DRAGON_BREATH", "SMOKESCREEN", "FIRE_FANG" } },
      { "NIDORINO", 22, ability = "POISON_POINT", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_TAIL", "DOUBLE_KICK", "HORN_ATTACK", "FOCUS_ENERGY" } },
    } },

    -- Route 114: tag battles at 22-23; Tyra and Ivy fight as a double ---------------------------------
    STEVE_1 = { partner = "R114_HAL", party = {
      { "RHYHORN", 23, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_BLAST", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "DRUDDIGON", 22, ability = "ROUGH_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "BITE", "SCARY_FACE", "REVENGE" } },
    } },
    BERNIE_1 = { partner = "R114_ED", party = {
      { "LARVESTA", 22, ability = "FLAME_BODY", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_CHARGE", "BUG_BITE", "STRING_SHOT", "ABSORB" } },
      { "SIMIPOUR", 22, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "BITE", "TAUNT", "PLAY_NICE" } },
    } },
    SHANE = { partner = "R114_IKE", party = {
      { "ZANGOOSE", 23, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "SLASH", "QUICK_ATTACK", "FURY_CUTTER", "HONE_CLAWS" } },
      { "EKANS", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_FANG", "BITE", "GLARE", "SCREECH" } },
    } },
    CLAUDE = { partner = "R114_JEB", party = {
      { "GYARADOS", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "QWILFISH", 22, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATER_GUN", "TOXIC_SPIKES", "HARDEN" } },
    } },
    NOLAN = { partner = "R114_GUY", party = {
      { "WISHIWASHI", 22, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "GOLDEEN", 22, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    NANCY = { partner = "R114_FLO", party = {
      { "SPRITZEE", 22, ability = "AROMA_VEIL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "SWEET_KISS", "AROMATHERAPY" } },
      { "GROTLE", 22, ability = "OVERGROW", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "BITE", "CURSE", "MEGA_DRAIN" } },
    } },
    LENNY = { partner = "R114_OZ", party = {
      { "ONIX", 23, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "HARD_STONE", moves = { "ROCK_TOMB", "DRAGON_BREATH", "SCREECH", "STEALTH_ROCK" } },
      { "SWINUB", 22, ability = "THICK_FAT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICE_SHARD", "MUD_SLAP", "ICY_WIND", "MIST" } },
    } },
    LUCAS_1 = { partner = "R114_BOB", party = {
      { "MINIOR", 23, ability = "SHIELDS_DOWN", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SWIFT", "ROCK_TOMB", "CONFUSE_RAY", "SELF_DESTRUCT" } },
      { "FERROSEED", 22, ability = "IRON_BARBS", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "MIRROR_SHOT", "PIN_MISSILE", "LEECH_SEED", "PROTECT" } },
    } },
    TYRA_AND_IVY = { party = {
      { "EELEKTRIK", 23, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "ACID", "HEADBUTT", "THUNDER_WAVE" } },
      { "PHANPY", 23, ability = "PICKUP", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "ROLLOUT", "DEFENSE_CURL", "SLAM" } },
    } },
    ANGELINA = { partner = "R114_MEL", party = {
      { "PRINPLUP", 22, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "METAL_CLAW", "PECK", "GROWL" } },
      { "CUTIEFLY", 22, ability = "SHIELD_DUST", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "STRUGGLE_BUG", "STUN_SPORE", "SWEET_SCENT" } },
    } },
    KAI = { partner = "R114_NED", party = {
      { "WHISCASH", 23, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
      { "BARBOACH", 22, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_GUN", "AMNESIA", "PROTECT" } },
    } },
    CHARLOTTE = { partner = "R114_ROE", party = {
      { "TANGELA", 23, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "VINE_WHIP", "SLEEP_POWDER", "INGRAIN" } },
      { "VULPIX", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "CONFUSE_RAY", "QUICK_ATTACK", "WILL_O_WISP" } },
    } },

    -- Route 115 south: tag battles at 22-23 --------------------------------------------------------------
    NOB_1 = { partner = "R115_KEN", party = {
      { "MACHOKE", 23, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "MEDITITE", 22, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    HECTOR = { partner = "R115_DON", party = {
      { "ZANGOOSE", 22, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SLASH", "QUICK_ATTACK", "FURY_CUTTER", "HONE_CLAWS" } },
      { "SEVIPER", 22, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
    } },
    MARLENE = { partner = "R115_EVE", party = {
      { "SPOINK", 22, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "MEDITITE", 22, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    CYNDY_1 = { partner = "R115_JAN", party = {
      { "DEWOTT", 23, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "FURY_CUTTER", "REVENGE", "FOCUS_ENERGY" } },
      { "STUFFUL", 22, ability = "FLUFFY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BRUTAL_SWING", "FORCE_PALM", "BABY_DOLL_EYES", "PROTECT" } },
    } },

    -- Mt. Chimney: tag battles at 23-24; Team Magma fights alone ------------------------------------------------
    SAWYER_1 = { partner = "MC_BRAM", party = {
      { "ROCKRUFF", 23, ability = "STEADFAST", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
      { "CARBINK", 23, ability = "STURDY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "REFLECT", "SMACK_DOWN", "STEALTH_ROCK" } },
    } },
    MELISSA = { partner = "MC_LIV", party = {
      { "TOGETIC", 24, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "SNUBBULL", 23, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "HEADBUTT", "ROAR", "CHARM" } },
    } },
    SHEILA = { partner = "MC_FAE", party = {
      { "CINCCINO", 24, ability = "SKILL_LINK", nature = "JOLLY", item = "SILK_SCARF", moves = { "TAIL_SLAP", "DOUBLE_SLAP", "HELPING_HAND", "ENCORE" } },
      { "STEENEE", 23, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
    } },
    SHIRLEY = { partner = "MC_DEE", party = {
      { "ORICORIO", 24, ability = "DANCER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "FEATHER_DANCE", "TEETER_DANCE", "PECK" } },
      { "MEOWTH", 23, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
    } },
    SHELBY_1 = { partner = "MC_RUE", party = {
      { "MIENFOO", 24, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LOW_SWEEP", "U_TURN", "DETECT" } },
      { "WOBBUFFET", 24, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
    } },
    GRUNT_MT_CHIMNEY_1 = { tier = "grunt", party = {
      { "NUMEL", 24, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "DIGLETT", 23, ability = "ARENA_TRAP", nature = "JOLLY", item = "SOFT_SAND", moves = { "BULLDOZE", "SUCKER_PUNCH", "ASTONISH", "SAND_ATTACK" } },
      { "POOCHYENA", 23, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "HOWL", "SAND_ATTACK", "TACKLE" } },
    } },
    GRUNT_MT_CHIMNEY_2 = { tier = "grunt", party = {
      { "GOLBAT", 24, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "RHYHORN", 23, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_BLAST", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "SLUGMA", 23, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "ROCK_THROW", "CLEAR_SMOG", "HARDEN" } },
    } },
    -- Tabitha: five, alone; a ground-and-rock team, Gligar is the ace at 25
    TABITHA_MT_CHIMNEY = { tier = "gym", party = {
      { "NUMEL", 23, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "ROGGENROLA", 23, ability = "STURDY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MUD_SHOT", "ROCK_BLAST", "SMACK_DOWN", "STEALTH_ROCK" } },
      { "DARUMAKA", 24, ability = "HUSTLE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "HEADBUTT", "BITE", "WORK_UP" } },
      { "ONIX", 24, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "ROCK_TOMB", "DRAGON_BREATH", "SCREECH", "STEALTH_ROCK" } },
      { "GLIGAR", 25, ability = "IMMUNITY", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "BULLDOZE", "QUICK_ATTACK", "KNOCK_OFF" } },
    } },
    -- Maxie: six, alone; Numel is the ace at 26
    MAXIE_MT_CHIMNEY = { tier = "leader", party = {
      { "GOLBAT", 25, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "KOFFING", 24, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "DEINO", 24, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "BITE", "HEADBUTT", "FOCUS_ENERGY" } },
      { "WEEPINBELL", 24, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "ACID", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "HOUNDOUR", 25, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "FEINT_ATTACK", "SNARL", "WILL_O_WISP" } },
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "EARTH_POWER", "AMNESIA", "MAGNITUDE" } },
    } },

    -- Jagged Pass: tag battles at 25-26 -----------------------------------------------------------------------
    ERIC = { partner = "JP_COL", party = {
      { "LARVITAR", 26, ability = "GUTS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BITE", "STOMPING_TANTRUM", "SCARY_FACE" } },
      { "METANG", 25, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "METAL_CLAW", "CONFUSION", "PURSUIT", "TAKE_DOWN" } },
    } },
    AUTUMN = { partner = "JP_IDA", party = {
      { "LITLEO", 25, ability = "UNNERVE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FIRE_FANG", "INCINERATE", "HEADBUTT", "WORK_UP" } },
      { "SERVINE", 25, ability = "CONTRARY", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "LEAF_TORNADO", "MEGA_DRAIN", "GLARE", "LEECH_SEED" } },
    } },
    JULIO = { partner = "JP_ROD", party = {
      { "MAGNEMITE", 25, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "MIRROR_SHOT" } },
      { "LUXIO", 26, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SPARK", "CRUNCH", "DOUBLE_KICK", "SWAGGER" } },
    } },
    DIANA_1 = { partner = "JP_BEL", party = {
      { "QUILLADIN", 25, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "PIN_MISSILE", "BITE", "ROLLOUT", "LEECH_SEED" } },
      { "PIDGEOTTO", 25, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    ETHAN_1 = { partner = "JP_GUS", party = {
      { "RUFFLET", 25, ability = "HUSTLE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "FURY_ATTACK", "HONE_CLAWS", "TAILWIND" } },
      { "SANDSLASH", 26, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
    } },

    -- Lavaridge Gym: trainers fight alone with three -------------------------------------------------------------
    COLE = { tier = "gym", party = {
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "FLAME_BURST", "AMNESIA", "MAGNITUDE" } },
      { "MAROWAK_ALOLAN", 27, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "FLAME_WHEEL", "BONE_CLUB", "HEX", "FALSE_SWIPE" } },
      { "SIMISEAR", 26, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_BURST", "INCINERATE", "BITE", "TAUNT" } },
    } },
    JEFF = { tier = "gym", party = {
      { "SLUGMA", 26, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
      { "BRAIXEN", 27, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "PSYBEAM", "LUCKY_CHANT", "HOWL" } },
      { "PUMPKABOO", 26, ability = "INSOMNIA", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "ASTONISH", "LEECH_SEED", "TRICK_OR_TREAT" } },
    } },
    AXLE = { tier = "gym", party = {
      { "MAGBY", 26, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_BURST", "FEINT_ATTACK", "CLEAR_SMOG", "SMOKESCREEN" } },
      { "PONYTA", 27, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
      { "ROTOM", 26, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "WILL_O_WISP" } },
    } },
    JACE = { tier = "gym", party = {
      { "PIGNITE", 27, ability = "THICK_FAT", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
      { "FLAREON", 26, ability = "FLASH_FIRE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FIRE_FANG", "BITE", "QUICK_ATTACK", "HELPING_HAND" } },
      { "GROWLITHE", 26, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "ROAR" } },
    } },
    KEEGAN = { tier = "gym", party = {
      { "LITWICK", 26, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "HEX", "WILL_O_WISP", "MINIMIZE" } },
      { "SUNFLORA", 27, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "GIGA_DRAIN", "GROWTH", "LEECH_SEED" } },
      { "VULPIX", 26, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "HEAT_ROCK", moves = { "INCINERATE", "CONFUSE_RAY", "QUICK_ATTACK", "WILL_O_WISP" } },
    } },
    ELI = { tier = "gym", party = {
      { "HEATMOR", 27, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "CHARCOAL", moves = { "INCINERATE", "BUG_BITE", "FURY_SWIPES", "HONE_CLAWS" } },
      { "TORKOAL", 26, ability = "WHITE_SMOKE", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "SMOKESCREEN", "CURSE", "PROTECT" } },
      { "LITWICK", 26, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_BURST", "HEX", "WILL_O_WISP", "MINIMIZE" } },
    } },
    GERALD = { tier = "gym", party = {
      { "TORRACAT", 27, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "DOUBLE_KICK", "BITE", "FAKE_OUT" } },
      { "KECLEON", 26, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
      { "OCTILLERY", 26, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "OCTAZOOKA", "PSYBEAM", "AURORA_BEAM", "FOCUS_ENERGY" } },
    } },
    DANIELLE = { tier = "gym", party = {
      { "MONFERNO", 27, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "MACH_PUNCH", "FLAME_WHEEL", "FAKE_OUT", "TAUNT" } },
      { "LOPUNNY", 26, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CIRCLE_THROW", "QUICK_ATTACK", "BABY_DOLL_EYES", "AGILITY" } },
      { "PONYTA", 26, ability = "FLAME_BODY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
    } },

    -- Flannery: six, alone (2-vs-1); Drought Torkoal sets the sun, it's the ace at the cap ----
    FLANNERY_1 = { tier = "leader", party = {
      { "VULPIX", 27, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "HEAT_ROCK", moves = { "FLAME_BURST", "CONFUSE_RAY", "WILL_O_WISP", "QUICK_ATTACK" } },
      { "FLETCHINDER", 28, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "FLAME_CHARGE", "ACROBATICS", "TAILWIND", "QUICK_ATTACK" } },
      { "HOUNDOUR", 27, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "FEINT_ATTACK", "SNARL", "WILL_O_WISP" } },
      { "SUNFLORA", 28, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "RAZOR_LEAF", "GROWTH", "HELPING_HAND" } },
      { "LARVESTA", 28, ability = "FLAME_BODY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLAME_CHARGE", "BUG_BITE", "STRING_SHOT", "FLAME_WHEEL" } },
      { "TORKOAL", 29, ability = "DROUGHT", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "CLEAR_SMOG", "PROTECT", "YAWN" } },
    } },
  },

  partners = {
    R102_DALE = { like = "CALVIN_1", name = "DALE", defeat = "Aw, we were a good team, too!", party = {
      { "TYMPOLE", 7, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE", "ECHOED_VOICE", "ACID", "GROWL" } },
      { "GOTHITA", 7, ability = "FRISK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "POUND", "TICKLE", "PLAY_NICE" } },
    } },
    R102_OWEN = { like = "RICK", name = "OWEN", defeat = "My bugs got squished...", party = {
      { "SURSKIT", 8, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE", "QUICK_ATTACK", "SWEET_SCENT", "WATER_SPORT" } },
      { "SEWADDLE", 7, ability = "OVERCOAT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "STRING_SHOT", "TACKLE" } },
    } },
    R102_BEN = { like = "ALLEN", name = "BEN", defeat = "Rolling didn't work out...", party = {
      { "BIDOOF", 7, ability = "SIMPLE", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "TACKLE", "GROWL" } },
      { "SEEDOT", 7, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "ASTONISH", "HARDEN", "TACKLE" } },
    } },
    R102_DANA = { like = "TIANA", name = "DANA", defeat = "You two are too strong!", party = {
      { "RALTS", 8, ability = "TELEPATHY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "DISARMING_VOICE", "DOUBLE_TEAM", "GROWL" } },
      { "LOTAD", 8, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ABSORB", "BUBBLE", "ASTONISH", "GROWL" } },
    } },
    R104_SAM = { like = "BILLY", name = "SAM", defeat = "Next time we'll win!", party = {
      { "BUNNELBY", 9, ability = "CHEEK_POUCH", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "DOUBLE_SLAP", "MUD_SLAP", "LEER" } },
      { "PIDOVE", 9, ability = "SUPER_LUCK", nature = "JOLLY", item = "SHARP_BEAK", moves = { "GUST", "QUICK_ATTACK", "LEER", "GROWL" } },
    } },
    R104_NEIL = { like = "DARIAN", name = "NEIL", defeat = "The big one got away...", party = {
      { "LUVDISC", 9, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_GUN", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "MAGIKARP", 12, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
    } },
    R104_PERCY = { like = "WINSTON_1", name = "PERCY", defeat = "Hmph. Money can't buy everything.", party = {
      { "LEDYBA", 9, ability = "AERILATE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "SWIFT", "SUPERSONIC", "REFLECT" } },
      { "PIDGEY", 9, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "GUST", "QUICK_ATTACK", "SAND_ATTACK", "TACKLE" } },
    } },
    PW_WADE = { like = "LYLE", name = "WADE", defeat = "The woods are full of tough bugs... and you.", party = {
      { "NINCADA", 10, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "FURY_SWIPES", "FALSE_SWIPE", "ABSORB", "SAND_ATTACK" } },
      { "GRUBBIN", 11, ability = "SWARM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "BITE", "VISE_GRIP", "STRING_SHOT" } },
    } },
    PW_COLE = { like = "JAMES_1", name = "COLE", defeat = "Our spores weren't enough!", party = {
      { "CUTIEFLY", 11, ability = "SHIELD_DUST", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "STUN_SPORE", "STRUGGLE_BUG", "ABSORB" } },
      { "LEDYBA", 11, ability = "AERILATE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SWIFT", "TACKLE", "LIGHT_SCREEN", "REFLECT" } },
    } },
    R104_ROSA = { like = "CINDY_1", name = "ROSA", defeat = "My, how unladylike of me to lose.", party = {
      { "PETILIL", 11, ability = "OWN_TEMPO", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SLEEP_POWDER", "MEGA_DRAIN", "FAIRY_WIND", "LEECH_SEED" } },
      { "CHERUBI", 11, ability = "CHLOROPHYLL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HELPING_HAND", "LEECH_SEED", "MORNING_SUN", "TACKLE" } },
    } },
    R104_TARA = { like = "HALEY_1", name = "TARA", defeat = "Haley, they're too good!", party = {
      { "BUDEW", 11, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "STUN_SPORE", "GROWTH", "WATER_SPORT" } },
      { "RALTS", 11, ability = "TELEPATHY", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "DISARMING_VOICE", "HYPNOSIS", "DOUBLE_TEAM" } },
    } },
    R104_HUGO = { like = "IVAN", name = "HUGO", defeat = "Reeled in by you two...", party = {
      { "TYMPOLE", 12, ability = "WATER_ABSORB", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MUD_SHOT", "BUBBLE", "ECHOED_VOICE", "SUPERSONIC" } },
      { "GOLDEEN", 12, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "FLAIL", "SUPERSONIC", "PECK" } },
    } },
    -- Chapter 2 partners -----------------------------------------------------------------
    R116_TIM = { like = "JOEY", name = "TIM", defeat = "Joey, they're way better than us!", party = {
      { "STARLY", 13, ability = "RECKLESS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "GROWL" } },
      { "SHINX", 13, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SPARK", "BITE", "QUICK_ATTACK", "LEER" } },
    } },
    R116_GUS = { like = "JOSE", name = "GUS", defeat = "My bugs need more training...", party = {
      { "FOMANTIS", 13, ability = "LEAF_GUARD", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "FURY_CUTTER", "LEAFAGE", "GROWTH" } },
      { "NINCADA", 13, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "ABSORB", "SAND_ATTACK" } },
    } },
    R116_EMMA = { like = "KAREN_1", name = "EMMA", defeat = "We studied so hard for this!", party = {
      { "MAREEP", 13, ability = "STATIC", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDER_SHOCK", "THUNDER_WAVE", "COTTON_SPORE", "CHARGE" } },
      { "CHINGLING", 13, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "HELPING_HAND", "YAWN", "ASTONISH" } },
    } },
    R116_HANK = { like = "CLARK", name = "HANK", defeat = "Hard as rock, and still we lost!", party = {
      { "DRILBUR", 14, ability = "MOLD_BREAKER", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "MUD_SLAP", "RAPID_SPIN", "HONE_CLAWS" } },
      { "LARVITAR", 14, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "BITE", "PAYBACK", "SCARY_FACE" } },
    } },
    R116_OLAF = { like = "DEVAN", name = "OLAF", defeat = "Back to the tunnel for us...", party = {
      { "WHISMUR", 14, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "ASTONISH", "HOWL" } },
      { "NOIBAT", 14, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "GUST", "BITE", "SUPERSONIC", "TAILWIND" } },
    } },
    R116_RAY = { like = "JOHNSON", name = "RAY", defeat = "Aw, I wanted to win that one.", party = {
      { "RIOLU", 14, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "METAL_CLAW", "FEINT", "COUNTER" } },
      { "POOCHYENA", 14, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "THIEF", "HOWL", "SAND_ATTACK" } },
    } },
    R116_ELLA = { like = "SARAH", name = "ELLA", defeat = "How terribly rude of you to win.", party = {
      { "PANSEAR", 15, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "INCINERATE", "FLAME_BURST", "YAWN", "PLAY_NICE" } },
      { "LOTAD", 14, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R116_REX = { like = "DAWSON", name = "REX", defeat = "Daddy will hear about this!", party = {
      { "STARYU", 15, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "MAREEP", 14, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDER_SHOCK", "THUNDER_WAVE", "COTTON_SPORE", "CHARGE" } },
    } },
    R116_LIAM = { like = "JERRY_1", name = "LIAM", defeat = "That wasn't in the textbook!", party = {
      { "ZUBAT", 14, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "ASTONISH" } },
      { "EXEGGCUTE", 15, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "LEECH_SEED", "HYPNOSIS", "REFLECT" } },
    } },
    R116_JUNE = { like = "JANICE", name = "JUNE", defeat = "Janice, they beat us both!", party = {
      { "WINGULL", 15, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_GUN", "AERIAL_ACE", "SUPERSONIC", "MIST" } },
      { "TEDDIURSA", 14, ability = "PICKUP", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "BABY_DOLL_EYES" } },
    } },
    R106_KAI = { like = "NED", name = "KAI", defeat = "Even the sea's on your side.", party = {
      { "BUIZEL", 16, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "QUICK_ATTACK", "SWIFT", "PURSUIT" } },
      { "SHELLDER", 16, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ICE_SHARD", "WITHDRAW", "WATER_GUN" } },
    } },
    R106_ROY = { like = "ELLIOT_1", name = "ROY", defeat = "Nothing's biting today, huh.", party = {
      { "CHATOT", 16, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "TAUNT", "TAILWIND", "SING" } },
      { "INKAY", 16, ability = "CONTRARY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FOUL_PLAY", "PECK", "TOPSY_TURVY", "HYPNOSIS" } },
    } },
    -- Chapter 3 partners -------------------------------------------------------------------
    R109_WES = { like = "HUEY", name = "WES", defeat = "Shiver me timbers!", party = {
      { "SEEL", 16, ability = "HYDRATION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ICY_WIND", "HEADBUTT", "ENCORE" } },
      { "CORPHISH", 17, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },
    R109_PIP = { like = "EDMOND", name = "PIP", defeat = "Swabbed the deck with us, you did.", party = {
      { "CUBCHOO", 17, ability = "SLUSH_RUSH", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "FROST_BREATH", "FURY_SWIPES", "PLAY_NICE" } },
      { "PANPOUR", 16, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "BITE", "TAUNT", "WATER_SPORT" } },
    } },
    R109_DOT = { like = "HAILEY", name = "DOT", defeat = "My floatie popped...", party = {
      { "MARILL", 16, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "BUIZEL", 16, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "QUICK_ATTACK", "SWIFT", "PURSUIT" } },
    } },
    R109_BO = { like = "RICKY_1", name = "BO", defeat = "Aww, sand in my shoes AND I lost.", party = {
      { "TYMPOLE", 16, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE", "MUD_SHOT", "ECHOED_VOICE", "SUPERSONIC" } },
      { "GOLDEEN", 16, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R109_KIM = { like = "LOLA_1", name = "KIM", defeat = "Let's go build sandcastles instead.", party = {
      { "HORSEA", 16, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_GUN", "TWISTER", "SMOKESCREEN", "BUBBLE" } },
      { "JIGGLYPUFF", 16, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R109_ZED = { like = "CHANDLER", name = "ZED", defeat = "The tide went out on us.", party = {
      { "TENTACOOL", 16, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "MAREANIE", 17, ability = "REGENERATOR", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "BITE", "POISON_STING", "WIDE_GUARD", "TOXIC_SPIKES" } },
    } },
    R110_ANN = { like = "ISABEL_1", name = "ANN", defeat = "Our babies did their best!", party = {
      { "CLEFAIRY", 17, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
      { "MEOWTH", 17, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
    } },
    R110_GIL = { like = "KALEB", name = "GIL", defeat = "Zapped right back at us!", party = {
      { "PIKACHU", 17, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "HERDIER", 17, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
    } },
    R110_OTTO = { like = "TIMMY", name = "OTTO", defeat = "I'll bike faster next time!", party = {
      { "DODUO", 17, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "PURSUIT", "QUICK_ATTACK", "AGILITY" } },
      { "ZUBAT", 17, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R110_MOE = { like = "EDWIN_1", name = "MOE", defeat = "A rare loss for my collection.", party = {
      { "KLINK", 17, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "VISE_GRIP", "CHARGE_BEAM", "METAL_SOUND", "AUTOTOMIZE" } },
      { "ODDISH", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R110_BRAD = { like = "JOSEPH", name = "BRAD", defeat = "Feedback! Total feedback!", party = {
      { "WHISMUR", 18, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
      { "JIGGLYPUFF", 17, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R110_VIC = { like = "EDWARD", name = "VIC", defeat = "I foresaw this. Sort of.", party = {
      { "ESPURR", 17, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "PSYBEAM", "CONFUSION", "LIGHT_SCREEN" } },
      { "MUNNA", 17, ability = "TELEPATHY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "MOONLIGHT", "DEFENSE_CURL" } },
    } },
    R110_LIZ = { like = "ALYSSA", name = "LIZ", defeat = "You out-paced us both!", party = {
      { "PONYTA", 18, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "TAIL_WHIP" } },
      { "ELEKID", 17, ability = "STATIC", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
    } },
    R110_HAL = { like = "DALE", name = "HAL", defeat = "Reeled in by kids again.", party = {
      { "TENTACOOL", 17, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "BINACLE", 18, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "FURY_SWIPES", "WATER_GUN", "SHADOW_CLAW" } },
    } },
    TH1_MIA = { like = "SALLY", name = "MIA", defeat = "This house is too tricky!", party = {
      { "CHERUBI", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
      { "SKITTY", 18, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    TH1_ZOE = { like = "ROBIN", name = "ZOE", defeat = "Tricked us right back!", party = {
      { "MEOWTH", 18, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
      { "WINGULL", 18, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    TH1_KIP = { like = "EDDIE", name = "KIP", defeat = "Which way is the exit?", party = {
      { "ZIGZAGOON", 18, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "LUXIO", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SPARK", "BITE", "DOUBLE_KICK", "LEER" } },
    } },
    R103_FAY = { like = "DAISY", name = "FAY", defeat = "What a lovely, lovely loss.", party = {
      { "ODDISH", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "STEENEE", 18, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
    } },
    R103_GUY = { like = "MIGUEL_1", name = "GUY", defeat = "My precious Pokémon!", party = {
      { "HERDIER", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
      { "PIKACHU", 18, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    R103_FINN = { like = "ANDREW", name = "FINN", defeat = "That one got away from me.", party = {
      { "TENTACOOL", 18, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "GOLDEEN", 18, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R103_JAX = { like = "MARCOS", name = "JAX", defeat = "Our set got cut short!", party = {
      { "WHISMUR", 19, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
      { "VOLTORB", 19, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
    } },
    R103_DUKE = { like = "RHETT", name = "DUKE", defeat = "Hrrah! I yield!", party = {
      { "MACHOP", 19, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "TIMBURR", 18, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
    } },
    CR_NOVA = { like = "JACLYN", name = "NOVA", defeat = "I didn't see that coming...", party = {
      { "ESPURR", 20, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MUNNA", 20, ability = "TELEPATHY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "MOONLIGHT", "DEFENSE_CURL" } },
    } },
    CR_TOD = { like = "JACOB", name = "TOD", defeat = "Out-pedaled AND out-battled.", party = {
      { "DODUO", 20, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
      { "PONYTA", 20, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
    } },
    CR_WIN = { like = "ANTHONY", name = "WIN", defeat = "We blew a fuse!", party = {
      { "HELIOPTILE", 20, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDER_SHOCK", "QUICK_ATTACK", "MUD_SLAP", "CHARGE" } },
      { "PACHIRISU", 20, ability = "VOLT_ABSORB", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "NUZZLE", "SPARK", "SUPER_FANG", "ENDURE" } },
    } },
    CR_ACE = { like = "BENJAMIN_1", name = "ACE", defeat = "Can't win 'em all on the road.", party = {
      { "FLAAFFY", 20, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDER_SHOCK", "COTTON_SPORE", "THUNDER_WAVE", "TAKE_DOWN" } },
      { "TRANQUILL", 20, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "DETECT", "ROOST" } },
    } },
    CR_ADA = { like = "ABIGAIL_1", name = "ADA", defeat = "That was electrifying. For you.", party = {
      { "MINUN", 20, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "PLUSLE", 20, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
    } },
    CR_SKY = { like = "JASMINE", name = "SKY", defeat = "Wind's against us today.", party = {
      { "HELIOPTILE", 20, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDER_SHOCK", "QUICK_ATTACK", "MUD_SLAP", "CHARGE" } },
      { "DUCKLETT", 20, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "FEATHER_DANCE", "DEFOG" } },
    } },
    R117_KAI = { like = "DEREK", name = "TOBY", defeat = "My bugs... squashed.", party = {
      { "SCYTHER", 20, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "WING_ATTACK", "FALSE_SWIPE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "KRICKETUNE", 20, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    R117_LEE = { like = "DYLAN_1", name = "LEE", defeat = "Lap time: too slow.", party = {
      { "TRANQUILL", 20, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "DETECT", "TAILWIND" } },
      { "PONYTA", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
    } },
    R117_MAE = { like = "MARIA_1", name = "MAE", defeat = "We'll train harder for the next race.", party = {
      { "YANMA", 20, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "SILVER_WIND", "DETECT", "SUPERSONIC" } },
      { "MEDITITE", 20, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    R117_ROX = { like = "MELINA", name = "ROX", defeat = "Hit the wall at the last mile.", party = {
      { "LUXIO", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "BITE", "DOUBLE_KICK", "LEER" } },
      { "STARAVIA", 20, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    R117_IVY = { like = "BRANDI", name = "IVY", defeat = "The future was cloudy today.", party = {
      { "KADABRA", 20, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "SOLOSIS", 20, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "RECOVER", "CHARM", "PROTECT" } },
    } },
    R117_JO = { like = "AISHA", name = "JO", defeat = "You hit harder than we do!", party = {
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "MAKUHITA", 20, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "VITAL_THROW" } },
    } },
    R111_ABE = { like = "TYRON", name = "ABE", defeat = "Our campfire's out.", party = {
      { "GROWLITHE", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "ROAR" } },
      { "NINCADA", 21, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R111_NIA = { like = "CELINA", name = "NIA", defeat = "Such a sweet scent of defeat.", party = {
      { "CHERUBI", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
      { "STEENEE", 21, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
    } },
    R111_PIA = { like = "BIANCA", name = "PIA", defeat = "Picnic's ruined!", party = {
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "TEDDIURSA", 21, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    R111_CY = { like = "HAYDEN", name = "CY", defeat = "Burnt out, just like that.", party = {
      { "SALANDIT", 21, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "SMOG", "DRAGON_RAGE", "SWEET_SCENT" } },
      { "HOUNDOUR", 21, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "EMBER", "BITE", "SMOG", "HOWL" } },
    } },
    -- Chapter 4 partners -----------------------------------------------------------------------
    R112_BUD = { like = "LARRY", name = "BUD", defeat = "Back to camp for us.", party = {
      { "SWABLU", 21, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "NUMEL", 22, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    R112_SUE = { like = "CAROL", name = "SUE", defeat = "Our picnic basket's empty...", party = {
      { "MARILL", 21, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    R112_GUS = { like = "BRICE", name = "GUS", defeat = "Rock solid, and still cracked.", party = {
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "NOSEPASS", 21, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "HARDEN" } },
    } },
    R112_ROB = { like = "TRENT_1", name = "ROB", defeat = "Rockslide... on us.", party = {
      { "GEODUDE", 21, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "ROGGENROLA", 22, ability = "STURDY", nature = "MODEST", spread = "spa", item = "HARD_STONE", moves = { "MUD_SHOT", "ROCK_BLAST", "SMACK_DOWN", "STEALTH_ROCK" } },
    } },
    R112_ASH = { like = "BRYANT", name = "ASH", defeat = "Snuffed out!", party = {
      { "HOUNDOUR", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "EMBER", "BITE", "SMOG", "HOWL" } },
      { "DARUMAKA", 21, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FIRE_FANG", "HEADBUTT", "BITE", "WORK_UP" } },
    } },
    R112_LIL = { like = "SHAYLA", name = "LIL", defeat = "The flowers wilted on us.", party = {
      { "ROSELIA", 22, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
      { "SPOINK", 21, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R113_PIP = { like = "JAYLEN", name = "PIP", defeat = "Ash in my eyes!", party = {
      { "SANDSHREW", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "SPINDA", 21, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    R113_TAD = { like = "DILLON", name = "TAD", defeat = "We're covered in soot and loss.", party = {
      { "SKARMORY", 21, ability = "KEEN_EYE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SAND_ATTACK", "SPIKES" } },
      { "NINCADA", 22, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R113_ZEN = { like = "LAO_1", name = "ZEN", defeat = "Our stealth was not enough.", party = {
      { "SHUPPET", 22, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "NINJASK", 21, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
    } },
    R113_KO = { like = "LUNG", name = "KO", defeat = "Smoked out ourselves.", party = {
      { "ACCELGOR", 22, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID", "QUICK_ATTACK", "DOUBLE_TEAM" } },
      { "GRIMER", 21, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R113_UMA = { like = "MADELINE_1", name = "UMA", defeat = "My parasol's full of ash.", party = {
      { "SWABLU", 21, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R113_BEA = { like = "SOPHIE", name = "BEA", defeat = "Dessert is cancelled!", party = {
      { "SANDSLASH_ALOLAN", 22, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
      { "SPINDA", 21, ability = "CONTRARY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "PSYBEAM", "DIZZY_PUNCH", "FAKE_OUT" } },
    } },
    R113_TAO = { like = "COBY", name = "TAO", defeat = "Grounded, both of us.", party = {
      { "SWABLU", 22, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "NOCTOWL", 21, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "CONFUSION", "HYPNOSIS", "REFLECT" } },
    } },
    R113_RIO = { like = "LAWRENCE", name = "RIO", defeat = "The desert wind beat us.", party = {
      { "TRAPINCH", 21, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "CACNEA", 22, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    R113_MAX = { like = "WYATT", name = "MAX", defeat = "My rare ones weren't rare enough.", party = {
      { "NIDORINA", 22, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "SLUGMA", 21, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "ROCK_THROW", "CLEAR_SMOG", "HARDEN" } },
    } },
    R114_HAL = { like = "STEVE_1", name = "HAL", defeat = "Fossil-fueled and still lost.", party = {
      { "ANORITH", 22, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "HARD_STONE", moves = { "ANCIENT_POWER", "FURY_CUTTER", "METAL_CLAW", "PROTECT" } },
      { "LILEEP", 22, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    R114_ED = { like = "BERNIE_1", name = "ED", defeat = "Burned out by the river.", party = {
      { "SLUGMA", 22, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "ROCK_THROW", "CLEAR_SMOG", "HARDEN" } },
      { "LOTAD", 22, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_IKE = { like = "SHANE", name = "IKE", defeat = "Sore losers, the pair of us.", party = {
      { "SEVIPER", 22, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
      { "ESCAVALIER", 23, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "HEADBUTT", "PURSUIT", "LEER" } },
    } },
    R114_JEB = { like = "CLAUDE", name = "JEB", defeat = "The big one bit back.", party = {
      { "DRATINI", 22, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "TWISTER", "THUNDER_WAVE", "AGILITY" } },
      { "LOTAD", 22, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_GUY = { like = "NOLAN", name = "GUY", defeat = "Only minnows today.", party = {
      { "WAILMER", 22, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "MAGIKARP", 23, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
    } },
    R114_FLO = { like = "NANCY", name = "FLO", defeat = "Oh dear, oh dear.", party = {
      { "SWABLU", 22, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "SEEDOT", 22, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ROLLOUT", "GROWTH", "HARDEN" } },
    } },
    R114_OZ = { like = "LENNY", name = "OZ", defeat = "Avalanche of defeat.", party = {
      { "GEODUDE", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    R114_BOB = { like = "LUCAS_1", name = "BOB", defeat = "Meteor shower of losses.", party = {
      { "NOSEPASS", 23, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "HARDEN" } },
      { "SOLROCK", 22, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "MORNING_SUN" } },
    } },
    R114_MEL = { like = "ANGELINA", name = "MEL", defeat = "No fair, you two!", party = {
      { "SURSKIT", 22, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "QUICK_ATTACK", "SWEET_SCENT", "AGILITY" } },
      { "SKIPLOOM", 22, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
    } },
    R114_NED = { like = "KAI", name = "NED", defeat = "Let's call it a day.", party = {
      { "CORPHISH", 22, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
      { "TENTACOOL", 23, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R114_ROE = { like = "CHARLOTTE", name = "ROE", defeat = "My garden's been trampled.", party = {
      { "BELLOSSOM", 22, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "SPOINK", 22, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115_KEN = { like = "NOB_1", name = "KEN", defeat = "Osu! A fine defeat.", party = {
      { "TIMBURR", 22, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "TAILLOW", 22, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R115_DON = { like = "HECTOR", name = "DON", defeat = "A gap in my collection.", party = {
      { "SWELLOW", 23, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "JIGGLYPUFF", 22, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R115_EVE = { like = "MARLENE", name = "EVE", defeat = "I sensed this would happen.", party = {
      { "RALTS", 22, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DISARMING_VOICE", "CONFUSION", "MAGICAL_LEAF", "HYPNOSIS" } },
      { "CHIMECHO", 23, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R115_JAN = { like = "CYNDY_1", name = "JAN", defeat = "Hyah! We'll train harder!", party = {
      { "RIOLU", 22, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FORCE_PALM", "QUICK_ATTACK", "METAL_CLAW", "FEINT" } },
      { "JANGMO_O", 22, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
    } },
    MC_BRAM = { like = "SAWYER_1", name = "BRAM", defeat = "Like a boulder down the mountain.", party = {
      { "GRAVELER", 24, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "TORKOAL", 23, ability = "WHITE_SMOKE", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "SMOKESCREEN", "CURSE", "PROTECT" } },
    } },
    MC_LIV = { like = "MELISSA", name = "LIV", defeat = "Not a hair out of place, and still lost.", party = {
      { "FURFROU", 23, ability = "FUR_COAT", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "BITE", "BABY_DOLL_EYES", "SAND_ATTACK" } },
      { "CLEFAIRY", 23, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
    } },
    MC_FAE = { like = "SHEILA", name = "FAE", defeat = "How very unglamorous.", party = {
      { "SKITTY", 23, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "TOGETIC", 23, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    MC_DEE = { like = "SHIRLEY", name = "DEE", defeat = "Our dance fell flat.", party = {
      { "ORICORIO", 23, ability = "DANCER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "FEATHER_DANCE", "TEETER_DANCE", "PECK" } },
      { "GLAMEOW", 23, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "FEINT_ATTACK", "CHARM" } },
    } },
    MC_RUE = { like = "SHELBY_1", name = "RUE", defeat = "Well fought. Truly.", party = {
      { "MEDICHAM", 24, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FORCE_PALM", "CONFUSION", "FAKE_OUT", "DETECT" } },
      { "CHIMECHO", 23, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    JP_COL = { like = "ERIC", name = "COL", defeat = "Down the pass we go.", party = {
      { "NOSEPASS", 25, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
      { "MACHOKE", 25, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
    } },
    JP_IDA = { like = "AUTUMN", name = "IDA", defeat = "The leaves are falling. So are we.", party = {
      { "SWABLU", 25, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "NUMEL", 25, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    JP_ROD = { like = "JULIO", name = "ROD", defeat = "Out of breath and out of Pokémon.", party = {
      { "SPOINK", 25, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "STARAVIA", 25, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    JP_BEL = { like = "DIANA_1", name = "BEL", defeat = "The view was nice, at least.", party = {
      { "SKIPLOOM", 25, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
      { "MACHOP", 25, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    JP_GUS = { like = "ETHAN_1", name = "WALT", defeat = "Cold camp tonight.", party = {
      { "TORKOAL", 25, ability = "WHITE_SMOKE", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "SMOKESCREEN", "CURSE", "PROTECT" } },
      { "SPINDA", 25, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
  },
}
