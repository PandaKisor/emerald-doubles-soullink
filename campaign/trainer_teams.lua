-- Trainer teams, Route 103 rival to Roxanne and the Rustboro rival (draft 1,
-- 2026-10-23), read by
-- campaign/trainers.lua. Built for doubles from the donor's teams for
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
    -- Chapter 5: Lavaridge to Norman (draft 1, 2026-10-27; cap 31) --------------------
    -- Route 111 north of the desert (met on the way to Fallarbor): tag battles at 22-23
    TRAVIS = { partner = "R111N_ROY", party = {
      { "GOLETT", 22, ability = "IRON_FIST", nature = "ADAMANT", item = "HARD_STONE", moves = { "SHADOW_PUNCH", "MUD_SLAP", "DEFENSE_CURL", "ROLLOUT" } },
      { "PIDGEOTTO", 22, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "GUST" } },
    } },
    IRENE = { partner = "R111N_ADA", party = {
      { "PHANTUMP", 22, ability = "NATURAL_CURE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ASTONISH", "LEECH_SEED", "CONFUSE_RAY", "FEINT_ATTACK" } },
      { "AZUMARILL", 22, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "ROLLOUT", "HELPING_HAND", "DEFENSE_CURL" } },
    } },
    WILTON_1 = { partner = "R111N_ZED", party = {
      { "HONEDGE", 23, ability = "NO_GUARD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FURY_CUTTER", "METAL_SOUND", "AERIAL_ACE" } },
      { "GIBLE", 22, ability = "ROUGH_SKIN", nature = "JOLLY", item = "SOFT_SAND", moves = { "DRAGON_RAGE", "SAND_TOMB", "SLASH", "SAND_ATTACK" } },
      { "SOLOSIS", 22, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "RECOVER", "CHARM", "PROTECT" } },
    } },
    BROOKE_1 = { partner = "R111N_MAY", party = {
      { "MONFERNO", 23, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "MACH_PUNCH", "FLAME_WHEEL", "FAKE_OUT", "TAUNT" } },
      { "SHELLOS", 22, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "HIDDEN_POWER" } },
      { "ROSELIA", 22, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    DAISUKE = { partner = "R111N_KEN", party = {
      { "TIMBURR", 23, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "MAKUHITA", 22, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
    } },
    -- Trick House 2 (after the Dynamo Badge): tag battles at 24-25
    PAUL = { partner = "TH2_OLI", party = {
      { "SALANDIT", 24, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "SMOG", "DRAGON_RAGE", "SWEET_SCENT" } },
      { "FOONGUS", 25, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "FEINT_ATTACK", "STUN_SPORE", "ASTONISH" } },
    } },
    TED = { partner = "TH2_ABI", party = {
      { "KIRLIA", 25, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "MEOWTH", 24, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
    } },
    GEORGIA = { partner = "TH2_ZAC", party = {
      { "CLEFAIRY", 24, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
      { "BEAUTIFLY", 25, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "MEGA_DRAIN", "ATTRACT", "STUN_SPORE" } },
    } },
    -- Route 111 desert: tag battles at 27-28 in the sandstorm
    DUSTY_1 = { partner = "DES_RAE", party = {
      { "GOLETT", 27, ability = "IRON_FIST", nature = "ADAMANT", item = "HARD_STONE", moves = { "SHADOW_PUNCH", "BULLDOZE", "DEFENSE_CURL", "ROLLOUT" } },
      { "SIGILYPH", 28, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "AIR_CUTTER", "TAILWIND", "REFLECT" } },
      { "SHIELDON", 27, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "IRON_DEFENSE", "ANCIENT_POWER", "PROTECT", "TAUNT" } },
    } },
    DREW = { partner = "DES_HAL", party = {
      { "SANDSLASH", 28, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
      { "CACNEA", 27, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    BEAU = { partner = "DES_IKE", party = {
      { "AMBIPOM", 28, ability = "TECHNICIAN", nature = "JOLLY", item = "SILK_SCARF", moves = { "FAKE_OUT", "FURY_SWIPES", "SWIFT", "BATON_PASS" } },
      { "VULLABY", 27, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "PLUCK", "KNOCK_OFF", "TAILWIND" } },
    } },
    HEIDI = { partner = "DES_FLO", party = {
      { "MUDBRAY", 28, ability = "STAMINA", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "ROCK_SMASH", "DOUBLE_KICK", "IRON_DEFENSE" } },
      { "GLOOM", 27, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BECKY = { partner = "DES_LEA", party = {
      { "SNOVER", 28, ability = "SNOW_WARNING", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "RAZOR_LEAF", "MIST", "ICE_SHARD" } },
      { "PSYDUCK", 27, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    CELIA = { partner = "DES_NIA", party = {
      { "IVYSAUR", 28, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
      { "LOMBRE", 27, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "MEGA_DRAIN", "BUBBLE", "KNOCK_OFF" } },
    } },
    BRYAN = { partner = "DES_OTT", party = {
      { "YAMASK", 27, ability = "MUMMY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HEX", "WILL_O_WISP", "DISABLE", "PROTECT" } },
      { "TYRUNT", 28, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "ROCK_TOMB", "STOMP", "DRAGON_TAIL" } },
    } },
    BRANDEN = { partner = "DES_GIL", party = {
      { "FARFETCHD", 28, ability = "SUPER_LUCK", nature = "JOLLY", item = "LEEK", moves = { "AERIAL_ACE", "SLASH", "FURY_CUTTER", "KNOCK_OFF" } },
      { "LEAFEON", 27, ability = "LEAF_GUARD", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "QUICK_ATTACK", "BITE", "SYNTHESIS" } },
    } },
    -- Trick House 3 (after the Heat Badge): tag battles at 27-28
    JUSTIN = { partner = "TH3_MO", party = {
      { "KECLEON", 28, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
      { "SLOWPOKE", 27, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "CONFUSION", "WATER_PULSE", "YAWN", "DISABLE" } },
      { "SANDSLASH_ALOLAN", 27, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
    } },
    MARTHA = { partner = "TH3_BO", party = {
      { "MEOWSTIC_FEMALE", 28, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "SKIDDO", 27, ability = "SAP_SIPPER", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "BULLDOZE", "LEECH_SEED", "GROWTH" } },
      { "CLEFAIRY", 27, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
    } },
    ALAN = { partner = "TH3_AL", party = {
      { "CUBONE", 28, ability = "ROCK_HEAD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "BONE_CLUB", "HEADBUTT", "FALSE_SWIPE", "FOCUS_ENERGY" } },
      { "PROBOPASS", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
      { "ARON", 27, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    -- Petalburg Gym: trainers fight alone with three
    RANDALL = { tier = "gym", party = {
      { "SWELLOW", 29, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "LOPUNNY", 28, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CIRCLE_THROW", "QUICK_ATTACK", "BABY_DOLL_EYES", "BOUNCE" } },
      { "DEERLING", 28, ability = "SAP_SIPPER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TAKE_DOWN", "DOUBLE_KICK", "LEECH_SEED", "CAMOUFLAGE" } },
    } },
    PARKER = { tier = "gym", party = {
      { "SPINDA", 28, ability = "CONTRARY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "PSYBEAM", "DIZZY_PUNCH", "HYPNOSIS" } },
      { "STANTLER", 29, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "STOMP", "TAKE_DOWN", "HYPNOSIS", "CONFUSE_RAY" } },
      { "GIRAFARIG", 28, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "STOMP", "AGILITY", "BATON_PASS" } },
    } },
    GEORGE = { tier = "gym", party = {
      { "CHANSEY", 29, ability = "NATURAL_CURE", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "SOFT_BOILED", "HELPING_HAND", "CHARM", "SING" } },
      { "DUNSPARCE", 28, ability = "SERENE_GRACE", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BODY_SLAM", "ROLLOUT", "YAWN" } },
      { "PORYGON", 28, ability = "TRACE", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "SIGNAL_BEAM", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
    } },
    BERKE = { tier = "gym", party = {
      { "LICKITUNG", 28, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROLLOUT", "KNOCK_OFF", "STOMP", "DEFENSE_CURL" } },
      { "MUNCHLAX", 29, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BODY_SLAM", "BITE", "CHIP_AWAY", "RECYCLE" } },
      { "TEDDIURSA", 28, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    MARY = { tier = "gym", party = {
      { "RUFFLET", 28, ability = "HUSTLE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "FURY_ATTACK", "HONE_CLAWS", "TAILWIND" } },
      { "RATICATE_ALOLAN", 28, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HYPER_FANG", "BITE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "DRAMPA", 29, ability = "BERSERK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "ECHOED_VOICE", "GLARE", "TWISTER" } },
    } },
    ALEXIA = { tier = "gym", party = {
      { "MUNCHLAX", 28, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BODY_SLAM", "BITE", "CHIP_AWAY", "RECYCLE" } },
      { "FURFROU", 28, ability = "FUR_COAT", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "BITE", "BABY_DOLL_EYES", "SAND_ATTACK" } },
      { "MILTANK", 29, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STOMP", "ROLLOUT", "MILK_DRINK", "DEFENSE_CURL" } },
    } },
    JODY = { tier = "gym", party = {
      { "ZANGOOSE", 29, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "SLASH", "QUICK_ATTACK", "FURY_CUTTER", "HONE_CLAWS" } },
      { "BOUFFALANT", 28, ability = "SAP_SIPPER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HEADBUTT", "REVENGE", "PURSUIT", "FOCUS_ENERGY" } },
      { "PORYGON", 28, ability = "TRACE", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "SIGNAL_BEAM", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
    } },
    -- Norman: six, alone (2-vs-1); Vigoroth is the ace at the cap
    NORMAN_1 = { tier = "leader", party = {
      { "KANGASKHAN", 30, ability = "SCRAPPY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DOUBLE_HIT", "SUCKER_PUNCH", "PROTECT" } },
      { "LINOONE", 29, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "HEADBUTT", "COVET", "PROTECT" } },
      { "LOUDRED", 29, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "BITE", "STOMP", "SUPERSONIC" } },
      { "SWELLOW", 30, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "TAUROS", 30, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "HORN_ATTACK", "SCARY_FACE" } },
      { "VIGOROTH", 31, ability = "VITAL_SPIRIT", nature = "ADAMANT", item = "EVIOLITE", moves = { "SLASH", "FEINT_ATTACK", "SLACK_OFF", "BULK_UP" } },
    } },
    -- Chapter 6a: sea routes, ship, Route 115 north, Route 118, Trick House 4 (draft 1, 2026-10-27) ----
    -- Route 118 west (from Mauville, no Surf): tag battles at 21-22
    WADE = { partner = "R118_IKE", party = {
      { "GYARADOS", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "CHINCHOU", 21, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ELECTRO_BALL", "BUBBLE", "THUNDER_WAVE", "CONFUSE_RAY" } },
    } },
    DEANDRE = { partner = "R118_POE", party = {
      { "DIGGERSBY", 22, ability = "HUGE_POWER", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "DOUBLE_KICK", "QUICK_ATTACK", "MUD_SHOT" } },
      { "ARON", 21, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    ROSE_1 = { partner = "R118_IVY", party = {
      { "FLOETTE", 22, ability = "FLOWER_VEIL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "MAGICAL_LEAF", "WISH", "HELPING_HAND" } },
      { "IVYSAUR", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
    } },
    DALTON_1 = { partner = "R118_REX", party = {
      { "NOIBAT", 22, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "SUPERSONIC", "TAILWIND" } },
      { "LOUDRED", 22, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "BITE", "HOWL", "SUPERSONIC" } },
    } },
    -- Routes 105-108 (Surf): tag battles at 28-29
    LUIS = { partner = "SEA_ORR", party = {
      { "CARVANHA", 28, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "SWIRLIX", 28, ability = "SWEET_VEIL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "COTTON_SPORE", "PLAY_NICE" } },
    } },
    DOMINIK = { partner = "SEA_GIL", party = {
      { "GYARADOS", 29, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "ICE_FANG", "DRAGON_RAGE" } },
      { "BRUXISH", 28, ability = "DAZZLING", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "AQUA_JET", "CONFUSION", "ICE_FANG" } },
    } },
    DOUGLAS = { partner = "SEA_JON", party = {
      { "LAPRAS", 29, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICY_WIND", "WATER_PULSE", "CONFUSE_RAY", "SING" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    BEVERLY = { partner = "SEA_AMY", party = {
      { "PELIPPER", 29, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "MAREANIE", 28, ability = "REGENERATOR", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "BITE", "VENOSHOCK", "WIDE_GUARD", "TOXIC_SPIKES" } },
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
    } },
    IMANI = { partner = "SEA_ZOE", party = {
      { "AZUMARILL", 29, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "SEEL", 28, ability = "HYDRATION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ICY_WIND", "HEADBUTT", "ENCORE" } },
    } },
    KYLA = { partner = "SEA_FAY", party = {
      { "NIDORINA", 28, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "FRILLISH", 28, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "BUBBLE_BEAM", "RECOVER", "NIGHT_SHADE" } },
    } },
    FOSTER = { partner = "SEA_RAE", party = {
      { "OMANYTE", 29, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "WATER_PULSE", "BITE", "PROTECT" } },
      { "BRONZOR", 28, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "CONFUSION", "GYRO_BALL", "HYPNOSIS", "IMPRISON" } },
      { "UNOWN", 28, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HIDDEN_POWER" } },
    } },
    ANDRES_1 = { partner = "SEA_OTT", party = {
      { "ARCHEN", 29, ability = "DEFEATIST", nature = "JOLLY", item = "SHARP_BEAK", moves = { "ANCIENT_POWER", "PLUCK", "QUICK_ATTACK", "ROCK_THROW" } },
      { "AMAURA", 28, ability = "REFRIGERATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AURORA_BEAM", "ROCK_THROW", "THUNDER_WAVE", "ICY_WIND" } },
      { "PROBOPASS", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
    } },
    JOSUE = { partner = "SEA_SKY", party = {
      { "TRANQUILL", 29, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "DELIBIRD", 28, ability = "HUSTLE", nature = "JOLLY", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "ICY_WIND", "DRILL_PECK", "PRESENT" } },
    } },
    TARA = { partner = "SEA_KIM", party = {
      { "CROCONAW", 29, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "ICE_FANG", "AQUA_TAIL", "SCARY_FACE" } },
      { "AUDINO", 28, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "HELPING_HAND", "DOUBLE_SLAP", "DISARMING_VOICE" } },
      { "HORSEA", 28, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    LISA_AND_RAY = { party = {
      { "CLAUNCHER", 28, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BUBBLE_BEAM", "HELPING_HAND", "SWORDS_DANCE" } },
      { "SKRELP", 28, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "BASCULIN", 28, ability = "ADAPTABILITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AQUA_JET", "BITE", "CHIP_AWAY", "TAIL_WHIP" } },
      { "ALOMOMOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    DARRIN = { partner = "SEA_LEO", party = {
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "PELIPPER", 29, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    TONY_1 = { partner = "SEA_MAC", party = {
      { "CARVANHA", 29, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "WIMPOD", 28, ability = "WIMP_OUT", nature = "JOLLY", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "AQUA_JET", "SAND_ATTACK", "PROTECT" } },
    } },
    JEROME = { partner = "SEA_HAL", party = {
      { "BINACLE", 29, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "FURY_SWIPES", "WATER_GUN", "SHADOW_CLAW" } },
      { "CUBCHOO", 28, ability = "SLUSH_RUSH", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "FROST_BREATH", "FURY_SWIPES", "PLAY_NICE" } },
    } },
    MATTHEW = { partner = "SEA_DUN", party = {
      { "MANTINE", 29, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WING_ATTACK", "WIDE_GUARD", "TAILWIND" } },
      { "PIKACHU", 28, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    DENISE = { partner = "SEA_ELA", party = {
      { "DUCKLETT", 28, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "FEATHER_DANCE", "DEFOG" } },
      { "GOLDEEN", 28, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
    } },
    CORY_1 = { partner = "SEA_BEN", party = {
      { "STUNFISK", 29, ability = "STATIC", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "THUNDER_SHOCK", "MUD_SHOT", "SUCKER_PUNCH" } },
      { "POLIWHIRL", 28, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    MISSY = { partner = "SEA_LIA", party = {
      { "CLAMPERL", 28, ability = "SHELL_ARMOR", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WHIRLPOOL", "CLAMP", "IRON_DEFENSE", "WATER_GUN" } },
      { "PYUKUMUKU", 29, ability = "INNARDS_OUT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "HELPING_HAND", "BIDE", "PURIFY", "MUD_SPORT" } },
    } },
    CAROLINA = { partner = "SEA_PIA", party = {
      { "MANECTRIC", 29, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "HAWLUCHA", 29, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
      { "DEERLING", 28, ability = "SAP_SIPPER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TAKE_DOWN", "DOUBLE_KICK", "LEECH_SEED", "CAMOUFLAGE" } },
    } },
    BETH = { partner = "SEA_UMA", party = {
      { "POLIWHIRL", 29, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
      { "LUVDISC", 29, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    CAMRON = { partner = "SEA_TOD", party = {
      { "STARMIE", 30, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "DUCKLETT", 29, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "FEATHER_DANCE", "TAILWIND" } },
    } },
    -- Abandoned Ship: tag battles at 28-29; the young couple is a double
    JANI = { partner = "SHIP_BO", party = {
      { "DRATINI", 28, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "TWISTER", "THUNDER_WAVE", "AGILITY" } },
      { "SIMIPOUR", 28, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "BITE", "TAUNT", "PLAY_NICE" } },
      { "FURRET", 28, ability = "FRISK", nature = "JOLLY", item = "SILK_SCARF", moves = { "SLAM", "QUICK_ATTACK", "HELPING_HAND", "FOLLOW_ME" } },
    } },
    DUNCAN = { partner = "SHIP_WES", party = {
      { "MACHOKE", 29, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "DHELMISE", 28, ability = "STEELWORKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "METAL_SOUND", "WHIRLPOOL", "ASTONISH" } },
    } },
    GARRISON = { partner = "SHIP_RIO", party = {
      { "TIRTOUGA", 29, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BITE", "AQUA_JET", "PROTECT" } },
      { "ONIX", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "HARD_STONE", moves = { "ROCK_TOMB", "DRAGON_BREATH", "SCREECH", "STEALTH_ROCK" } },
      { "GRAVELER_ALOLAN", 28, ability = "GALVANIZE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "SPARK", "SMACK_DOWN", "ROCK_POLISH" } },
    } },
    CHARLIE = { partner = "SHIP_DOT", party = {
      { "FINNEON", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "GUST", "ICY_WIND", "PROTECT" } },
      { "OCTILLERY", 29, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "OCTAZOOKA", "PSYBEAM", "AURORA_BEAM", "FOCUS_ENERGY" } },
    } },
    THALIA_1 = { partner = "SHIP_LIV", party = {
      { "FLOETTE", 29, ability = "FLOWER_VEIL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "MAGICAL_LEAF", "WISH", "HELPING_HAND" } },
      { "KIRLIA", 29, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    DEMETRIUS = { partner = "SHIP_KIP", party = {
      { "LUXIO", 29, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "CRUNCH", "DOUBLE_KICK", "LEER" } },
      { "HERDIER", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
    } },
    KIRA_AND_DAN_1 = { party = {
      { "VOLBEAT", 29, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
      { "ILLUMISE", 29, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    -- Route 109 and 103 (Surf): tag battles at 28-29
    GWEN = { partner = "R109S_ANN", party = {
      { "FLOATZEL", 29, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "SWIFT", "PURSUIT" } },
      { "QUAGSIRE", 28, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "MUD_SHOT", "AQUA_TAIL", "YAWN", "PROTECT" } },
      { "LUVDISC", 28, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    ALICE = { partner = "R109S_EVE", party = {
      { "CORSOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
      { "CLOYSTER", 29, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
      { "KANGASKHAN", 28, ability = "SCRAPPY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DOUBLE_HIT", "BITE", "PROTECT" } },
    } },
    AUSTINA = { partner = "R109S_KIT", party = {
      { "SHELLOS_EAST_SEA", 28, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "HIDDEN_POWER" } },
      { "BIBAREL", 28, ability = "SIMPLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HYPER_FANG", "AQUA_JET", "DEFENSE_CURL", "ROLLOUT" } },
    } },
    DAVID = { partner = "R109S_GUS", party = {
      { "CORPHISH", 28, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
      { "SANDYGAST", 28, ability = "WATER_COMPACTION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "SAND_TOMB", "ASTONISH", "HYPNOSIS" } },
    } },
    CARTER = { partner = "R109S_NED", party = {
      { "LANTURN", 29, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "SPARK", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    MEL_AND_PAUL = { party = {
      { "DUSTOX", 29, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SILVER_WIND", "CONFUSION", "MOONLIGHT", "PROTECT" } },
      { "BEAUTIFLY", 29, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "MEGA_DRAIN", "STUN_SPORE", "ATTRACT" } },
    } },
    ELIJAH = { partner = "R109S_ACE", party = {
      { "SKARMORY", 29, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
      { "HONCHKROW", 28, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "WING_ATTACK", "SUCKER_PUNCH", "HAZE" } },
    } },
    ISABELLE = { partner = "R103S_MEG", party = {
      { "MAREANIE", 28, ability = "REGENERATOR", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "BITE", "VENOSHOCK", "WIDE_GUARD", "TOXIC_SPIKES" } },
      { "LAPRAS", 29, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICY_WIND", "WATER_PULSE", "CONFUSE_RAY", "SING" } },
      { "ALOMOMOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    PETE = { partner = "R103S_SAM", party = {
      { "WARTORTLE", 29, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BITE", "PROTECT", "RAPID_SPIN" } },
      { "WISHIWASHI", 28, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    -- Route 115 north (Surf): tag battles at 28-29
    KOICHI = { partner = "R115N_DAN", party = {
      { "LUCARIO", 29, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "BULLET_PUNCH", "METAL_CLAW", "DETECT" } },
      { "PASSIMIAN", 28, ability = "RECEIVER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "FEINT", "QUICK_GUARD", "BRICK_BREAK" } },
      { "PANCHAM", 28, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ARM_THRUST", "KARATE_CHOP", "COMET_PUNCH", "WORK_UP" } },
    } },
    KYRA = { partner = "R115N_JO", party = {
      { "FLAREON", 29, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "BITE", "QUICK_ATTACK", "HELPING_HAND" } },
      { "WHIRLIPEDE", 28, ability = "SPEED_BOOST", nature = "IMPISH", spread = "bulk", item = "POISON_BARB", moves = { "POISON_TAIL", "BUG_BITE", "PROTECT", "TOXIC_SPIKES" } },
      { "DODUO", 28, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "PURSUIT", "QUICK_ATTACK", "AGILITY" } },
    } },
    JAIDEN = { partner = "R115N_KO", party = {
      { "NINJASK", 28, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "SWALOT", 29, ability = "STICKY_HOLD", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "SLUDGE", "YAWN", "STOCKPILE", "ACID_SPRAY" } },
      { "STUNKY", 28, ability = "AFTERMATH", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BITE", "VENOSHOCK", "SCREECH", "SMOKESCREEN" } },
    } },
    ALIX = { partner = "R115N_VIC", party = {
      { "MUSHARNA", 29, ability = "SYNCHRONIZE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "MOONLIGHT", "YAWN" } },
      { "SMOOCHUM", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "POWDER_SNOW", "HEART_STAMP", "SWEET_KISS", "SING" } },
    } },
    HELENE = { partner = "R115N_ROX", party = {
      { "MEDITITE", 28, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "STEENEE", 29, ability = "SWEET_VEIL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "DOUBLE_SLAP", "PLAY_NICE", "RAPID_SPIN" } },
    } },
    TIMOTHY_1 = { partner = "R115N_KEN", party = {
      { "HARIYAMA", 29, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "DUSKULL", 29, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "KADABRA", 29, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    -- Route 118 east (Surf) and Trick House 4: tag battles at 29-30
    BARNY = { partner = "R118E_HAL", party = {
      { "TENTACOOL", 29, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "CARVANHA", 29, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "BINACLE", 29, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "FURY_SWIPES", "WATER_GUN", "SHADOW_CLAW" } },
    } },
    PERRY = { partner = "R118E_JAY", party = {
      { "TRUMBEAK", 30, ability = "SKILL_LINK", nature = "JOLLY", item = "SHARP_BEAK", moves = { "ROCK_BLAST", "PLUCK", "BULLET_SEED", "SUPERSONIC" } },
      { "TRANQUILL", 29, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "DARTRIX", 29, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PLUCK", "FORESIGHT" } },
    } },
    CHESTER = { partner = "R118E_KAY", party = {
      { "FLETCHINDER", 30, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "FLAME_CHARGE", "ACROBATICS", "TAILWIND", "QUICK_ATTACK" } },
      { "VULLABY", 29, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "PLUCK", "TAILWIND", "IRON_DEFENSE" } },
    } },
    CORA = { partner = "TH4_ZIA", party = {
      { "MEDITITE", 29, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "HAWLUCHA", 29, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
      { "CROAGUNK", 29, ability = "DRY_SKIN", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "SUCKER_PUNCH", "TAUNT" } },
    } },
    PAULA = { partner = "TH4_MAE", party = {
      { "BRELOOM", 30, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "FORCE_PALM" } },
      { "PANCHAM", 29, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ARM_THRUST", "KARATE_CHOP", "COMET_PUNCH", "WORK_UP" } },
      { "POLIWHIRL", 29, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    YUJI = { partner = "TH4_GOR", party = {
      { "HARIYAMA", 30, ability = "GUTS", nature = "ADAMANT", spread = "tank", item = "FLAME_ORB", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "SCRAGGY", 29, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "LOW_SWEEP", "HEADBUTT", "PROTECT" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34) ----------
    -- Route 119: tag battles at 30-31 in the rain and long grass
    CHRIS = { partner = "R119_BO", party = {
      { "GYARADOS", 31, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "BITE", "ICE_FANG", "DRAGON_DANCE" } },
      { "BASCULIN", 30, ability = "ADAPTABILITY", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "CRUNCH", "AQUA_TAIL", "TAIL_WHIP" } },
      { "BARBOACH", 30, ability = "HYDRATION", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_PULSE", "AMNESIA", "PROTECT" } },
    } },
    DONALD = { partner = "R119_GUS", party = {
      { "SWADLOON", 30, ability = "LEAF_GUARD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BUG_BITE", "RAZOR_LEAF", "PROTECT", "STRING_SHOT" } },
      { "BUTTERFREE", 31, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", moves = { "SLEEP_POWDER", "BUG_BUZZ", "PSYBEAM", "TAILWIND" } },
      { "JOLTIK", 30, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },
    TAYLOR = { partner = "R119_TED", party = {
      { "RIBOMBEE", 31, ability = "SHIELD_DUST", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "STRUGGLE_BUG", "STUN_SPORE", "POLLEN_PUFF" } },
      { "ARAQUANID", 30, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "BITE" } },
      { "VIVILLON", 30, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", moves = { "SLEEP_POWDER", "BUG_BUZZ", "GUST", "STRUGGLE_BUG" } },
    } },
    HUGH = { partner = "R119_CY", party = {
      { "NOCTOWL", 30, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "FEAROW", 31, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "DRILL_RUN", "PURSUIT", "AERIAL_ACE", "FOCUS_ENERGY" } },
      { "TROPIUS", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
    } },
    YASU = { partner = "R119_KO", party = {
      { "FROGADIER", 31, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "GOLBAT", 30, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "SKORUPI", 30, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_FANG", "KNOCK_OFF", "PIN_MISSILE", "SCARY_FACE" } },
    } },
    DOUG = { partner = "R119_LIL", party = {
      { "MASQUERAIN", 31, ability = "INTIMIDATE", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "AIR_SLASH", "BUG_BUZZ", "STUN_SPORE", "TAILWIND" } },
      { "ARIADOS", 30, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_JAB", "SUCKER_PUNCH", "SPIDER_WEB", "SHADOW_SNEAK" } },
    } },
    GREG = { partner = "R119_PIP", party = {
      { "LEDIAN", 30, ability = "EARLY_BIRD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
      { "BEEDRILL", 31, ability = "SWARM", nature = "JOLLY", item = "POISON_BARB", moves = { "TWINEEDLE", "DRILL_PECK", "AGILITY", "PROTECT" } },
      { "ESCAVALIER", 30, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "X_SCISSOR", "FURY_CUTTER", "PROTECT" } },
    } },
    PHIL = { partner = "R119_SKY", party = {
      { "STARAVIA", 31, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
      { "FARFETCHD", 30, ability = "SUPER_LUCK", nature = "JOLLY", item = "LEEK", moves = { "AERIAL_ACE", "SLASH", "FURY_CUTTER", "KNOCK_OFF" } },
    } },
    TAKASHI = { partner = "R119_ZEN", party = {
      { "ACCELGOR", 31, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "QUICK_ATTACK", "DOUBLE_TEAM" } },
      { "KOFFING", 30, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
    } },
    JACKSON_1 = { partner = "R119_RAN", party = {
      { "MANTINE", 31, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
      { "ROTOM", 30, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "PARASECT", 30, ability = "DRY_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SPORE", "X_SCISSOR", "LEECH_LIFE", "PROTECT" } },
    } },
    CATHERINE_1 = { partner = "R119_WEN", party = {
      { "GLOOM", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "PALPITOAD", 31, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "MUD_SHOT", "ECHOED_VOICE", "SUPERSONIC" } },
      { "CUBCHOO", 30, ability = "SLUSH_RUSH", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "FROST_BREATH", "FURY_SWIPES", "PLAY_NICE" } },
    } },
    KENT = { partner = "R119_ABE", party = {
      { "NINJASK", 31, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "SHEDINJA", 30, ability = "WONDER_GUARD", nature = "ADAMANT", item = "FOCUS_SASH", moves = { "SHADOW_SNEAK", "FURY_CUTTER", "CONFUSE_RAY", "MIND_READER" } },
    } },
    HIDEO = { partner = "R119_JIN", party = {
      { "PAWNIARD", 31, ability = "DEFIANT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
      { "GRIMER", 30, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    FABIAN = { partner = "R119_JAX", party = {
      { "MANECTRIC", 31, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "CHATOT", 30, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "AIR_CUTTER", "TAUNT", "TAILWIND" } },
    } },
    DAYTON = { partner = "R119_ASH", party = {
      { "SLUGMA", 30, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
      { "DARUMAKA", 31, ability = "HUSTLE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_PUNCH", "HEADBUTT", "BITE", "WORK_UP" } },
    } },
    RACHEL = { partner = "R119_UMA", party = {
      { "LOMBRE", 30, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "KNOCK_OFF" } },
      { "HELIOLISK", 31, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "QUICK_ATTACK", "GRASS_KNOT", "VOLT_SWITCH" } },
    } },
    BRENT = { partner = "R119_DON", party = {
      { "LARVESTA", 31, ability = "FLAME_BODY", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BUG_BITE", "FLAME_CHARGE", "STRING_SHOT" } },
      { "VOLBEAT", 30, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
    } },
    -- Weather Institute: Aqua grunts fight alone with three
    GRUNT_WEATHER_INST_1 = { tier = "grunt", party = {
      { "GOLBAT", 30, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "SKRELP", 30, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "LIEPARD", 30, ability = "PRANKSTER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "TORMENT", "ASSIST" } },
    } },
    GRUNT_WEATHER_INST_2 = { tier = "grunt", party = {
      { "PELIPPER", 31, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "FERROSEED", 30, ability = "IRON_BARBS", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "MIRROR_SHOT", "PIN_MISSILE", "LEECH_SEED", "PROTECT" } },
      { "CARVANHA", 30, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
    } },
    GRUNT_WEATHER_INST_3 = { tier = "grunt", party = {
      { "MIGHTYENA", 30, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "WIMPOD", 30, ability = "WIMP_OUT", nature = "JOLLY", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "AQUA_JET", "SAND_ATTACK", "PROTECT" } },
      { "GRIMER_ALOLAN", 30, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "POISON_FANG", "BITE", "DISABLE", "HARDEN" } },
    } },
    GRUNT_WEATHER_INST_4 = { tier = "grunt", party = {
      { "SPHEAL", 30, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "BRINE", "ENCORE" } },
      { "FLOATZEL", 31, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "SWIFT", "PURSUIT" } },
      { "INKAY", 30, ability = "CONTRARY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FOUL_PLAY", "PSYCHO_CUT", "TOPSY_TURVY", "HYPNOSIS" } },
    } },
    GRUNT_WEATHER_INST_5 = { tier = "grunt", party = {
      { "CROAGUNK", 31, ability = "DRY_SKIN", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "SUCKER_PUNCH", "TAUNT" } },
      { "EELEKTRIK", 31, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "ACID", "HEADBUTT", "THUNDER_WAVE" } },
      { "QWILFISH", 30, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATERFALL", "TOXIC_SPIKES", "HARDEN" } },
    } },
    -- Shelly: six, alone, a rain team under Drizzle; Crawdaunt is the ace at 32
    SHELLY_WEATHER_INSTITUTE = { tier = "leader", party = {
      { "PELIPPER", 31, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 31, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "RAIN_DANCE" } },
      { "SHARPEDO", 31, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "GOLDUCK", 31, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "ICY_WIND" } },
      { "LANTURN", 31, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "DISCHARGE", "WATER_PULSE", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "CRAWDAUNT", 32, ability = "ADAPTABILITY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    -- Rival, Route 119: five, alone; the starter is the ace at 33
    BRENDAN_ROUTE_119_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARAQUANID", 31, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "BITE" } },
      { "ARCANINE", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "CRUNCH", "EXTREME_SPEED", "ROAR" } },
      { "MAGNETON", 31, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "GROVYLE", 33, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "LEAF_BLADE", "DRAGON_BREATH", "QUICK_ATTACK", "DETECT" } },
    } },
    BRENDAN_ROUTE_119_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARCANINE", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "CRUNCH", "EXTREME_SPEED", "ROAR" } },
      { "BRELOOM", 31, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "MAGNETON", 31, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
    } },
    BRENDAN_ROUTE_119_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARAQUANID", 31, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "BITE" } },
      { "BRELOOM", 31, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "MAGNETON", 31, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "LIGHT_SCREEN" } },
      { "COMBUSKEN", 33, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_SLIDE", "DETECT" } },
    } },
    MAY_ROUTE_119_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "STARMIE", 31, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
      { "PONYTA", 32, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "BOUNCE" } },
      { "AZUMARILL", 31, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "GROVYLE", 33, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "LEAF_BLADE", "DRAGON_BREATH", "QUICK_ATTACK", "DETECT" } },
    } },
    MAY_ROUTE_119_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "TSAREENA", 31, ability = "QUEENLY_MAJESTY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "TROP_KICK", "STOMP", "PLAY_NICE", "RAPID_SPIN" } },
      { "PONYTA", 32, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "BOUNCE" } },
      { "AZUMARILL", 31, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_ROUTE_119_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "STARMIE", 31, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
      { "TSAREENA", 31, ability = "QUEENLY_MAJESTY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "TROP_KICK", "STOMP", "PLAY_NICE", "RAPID_SPIN" } },
      { "AZUMARILL", 31, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "COMBUSKEN", 33, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_SLIDE", "DETECT" } },
    } },
    -- Route 120: tag battles at 31-32
    CHIP = { partner = "R120_RAE", party = {
      { "DWEBBLE", 31, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "X_SCISSOR", "SMACK_DOWN", "PROTECT" } },
      { "BALTOY", 31, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "ANCIENT_POWER", "ROCK_TOMB", "REFLECT" } },
      { "AERODACTYL", 32, ability = "PRESSURE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BITE", "WING_ATTACK", "TAILWIND" } },
    } },
    JEFFREY_1 = { partner = "R120_GUS", party = {
      { "DURANT", 31, ability = "HUSTLE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "IRON_HEAD", "BITE", "AGILITY" } },
      { "VESPIQUEN", 32, ability = "PRESSURE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "POWER_GEM", "FELL_STINGER", "BUG_BUZZ", "AIR_SLASH" } },
      { "MASQUERAIN", 31, ability = "INTIMIDATE", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "AIR_SLASH", "BUG_BUZZ", "STUN_SPORE", "TAILWIND" } },
    } },
    COLIN = { partner = "R120_SKY", party = {
      { "DODUO", 31, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "PURSUIT", "QUICK_ATTACK", "AGILITY" } },
      { "XATU", 32, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "ORICORIO", 31, ability = "DANCER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "FEATHER_DANCE", "TEETER_DANCE", "HELPING_HAND" } },
    } },
    KEIGO = { partner = "R120_KO", party = {
      { "FROGADIER", 32, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "KOFFING", 31, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "PAWNIARD", 31, ability = "DEFIANT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
    } },
    ROBERT_1 = { partner = "R120_ACE", party = {
      { "FEAROW", 32, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "DRILL_RUN", "PURSUIT", "AERIAL_ACE", "FOCUS_ENERGY" } },
      { "STARAVIA", 32, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    CLARISSA = { partner = "R120_NIA", party = {
      { "TANGROWTH", 32, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "KNOCK_OFF", "SLEEP_POWDER", "INGRAIN" } },
      { "WAILMER", 31, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "LITLEO", 31, ability = "UNNERVE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "HYPER_VOICE", "WORK_UP", "HEADBUTT" } },
    } },
    ANGELICA = { partner = "R120_PIA", party = {
      { "MEOWSTIC_FEMALE", 32, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "CASTFORM", 31, ability = "FORECAST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WEATHER_BALL", "RAIN_DANCE", "SUNNY_DAY", "ICE_BEAM" } },
      { "EMOLGA", 31, ability = "MOTOR_DRIVE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "AIR_SLASH", "NUZZLE", "ENCORE" } },
    } },
    LORENZO = { partner = "R120_RAN", party = {
      { "LUDICOLO", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "RAIN_DANCE" } },
      { "ZANGOOSE", 31, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "FACADE", "CRUSH_CLAW", "QUICK_ATTACK", "HONE_CLAWS" } },
      { "NIDOQUEEN", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    JENNA = { partner = "R120_WEN", party = {
      { "SHIFTRY", 32, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "EXPLOSION" } },
      { "SEVIPER", 31, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
      { "NIDOKING", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
    } },
    RILEY = { partner = "R120_JIN", party = {
      { "SKUNTANK", 32, ability = "AFTERMATH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "VENOSHOCK", "BITE", "SMOKESCREEN" } },
      { "MOTHIM", 31, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "AIR_SLASH", "QUIVER_DANCE", "PROTECT" } },
    } },
    CALLIE = { partner = "R120_ROX", party = {
      { "MEDITITE", 31, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "DETECT" } },
      { "LOPUNNY", 32, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CIRCLE_THROW", "QUICK_ATTACK", "BOUNCE", "FAKE_OUT" } },
      { "MIENFOO", 31, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DRAIN_PUNCH", "U_TURN", "DETECT" } },
    } },
    JENNIFER = { partner = "R120_MAX", party = {
      { "SABLEYE", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "JANGMO_O", 31, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
      { "WHIMSICOTT", 32, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "GIGA_DRAIN", "ENERGY_BALL", "ENCORE" } },
    } },
    LEONEL = { partner = "R120_LEO", party = {
      { "VIKAVOLT", 32, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "BUG_BUZZ", "AIR_SLASH", "STRING_SHOT" } },
      { "IVYSAUR", 31, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLEEP_POWDER", "LEECH_SEED", "SLUDGE_BOMB" } },
      { "PSYDUCK", 31, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    -- Fortree Gym: trainers fight alone with three
    JARED = { tier = "gym", party = {
      { "SWOOBAT", 32, ability = "SIMPLE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "PSYCHIC", "CALM_MIND", "ROOST" } },
      { "NOCTOWL", 32, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "NOIBAT", 33, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "DRAGON_PULSE", "TAILWIND", "BITE" } },
    } },
    HUMBERTO = { tier = "gym", party = {
      { "GLIGAR", 33, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ACROBATICS", "EARTHQUAKE", "KNOCK_OFF", "PROTECT" } },
      { "VULLABY", 32, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "PLUCK", "TAILWIND", "IRON_DEFENSE" } },
      { "HAWLUCHA", 32, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
    } },
    EDWARDO = { tier = "gym", party = {
      { "STARAVIA", 32, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
      { "HONCHKROW", 33, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "WING_ATTACK", "SUCKER_PUNCH", "HAZE" } },
      { "DRIFBLIM", 32, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "HEX", "TAILWIND", "WILL_O_WISP" } },
    } },
    FLINT = { tier = "gym", party = {
      { "SWELLOW", 33, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "YANMEGA", 32, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "BUG_BUZZ", "DETECT", "ANCIENT_POWER" } },
      { "MANTINE", 32, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    ASHLEY = { tier = "gym", party = {
      { "RUFFLET", 32, ability = "HUSTLE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "WING_ATTACK", "HONE_CLAWS", "TAILWIND" } },
      { "PIDGEOTTO", 32, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "DUCKLETT", 33, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "FEATHER_DANCE", "TAILWIND" } },
    } },
    DARIUS = { tier = "gym", party = {
      { "TROPIUS", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_SLASH", "GROWTH", "SWEET_SCENT" } },
      { "DODRIO", 33, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "ARCHEN", 32, ability = "DEFEATIST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ACROBATICS", "QUICK_ATTACK", "AGILITY" } },
    } },
    -- Winona: six, alone (2-vs-1), a Tailwind team; Altaria is the ace at the cap
    WINONA_1 = { tier = "leader", party = {
      { "WHIMSICOTT", 32, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "FOCUS_SASH", moves = { "TAILWIND", "ENERGY_BALL", "GIGA_DRAIN", "ENCORE" } },
      { "SKARMORY", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "STEEL_WING", "AIR_SLASH", "SPIKES", "TAILWIND" } },
      { "HAWLUCHA", 33, ability = "UNBURDEN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "DRAIN_PUNCH", "FEATHER_DANCE", "DETECT" } },
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "WIDE_GUARD", "PROTECT" } },
      { "TROPIUS", 33, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "MAGICAL_LEAF", "SYNTHESIS", "PROTECT" } },
      { "ALTARIA", 34, ability = "NATURAL_CURE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DRAGON_DANCE", "DRAGON_BREATH", "AERIAL_ACE", "ROOST" } },
    } },
    -- Chapter 7a: Routes 121-123, Mt. Pyre, Lilycove rival (draft 1, 2026-10-27; cap 35) ----
    -- Route 121: tag battles at 32-33; the breeders fight alone with four
    MYLES = { party = {
      { "LUCARIO", 33, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "BULLET_PUNCH", "METAL_CLAW", "DETECT" } },
      { "TOGETIC", 32, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "MAGBY", 32, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "FEINT_ATTACK", "CLEAR_SMOG", "SMOKESCREEN" } },
      { "MILTANK", 33, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STOMP", "ROLLOUT", "MILK_DRINK", "DEFENSE_CURL" } },
    } },
    PAT = { party = {
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
      { "BOUFFALANT", 32, ability = "SAP_SIPPER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HEADBUTT", "REVENGE", "PURSUIT", "FOCUS_ENERGY" } },
      { "ELEKID", 32, ability = "STATIC", nature = "JOLLY", item = "MAGNET", moves = { "SHOCK_WAVE", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "LYCANROC", 33, ability = "SAND_RUSH", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BITE", "ACCELEROCK", "ROCK_TOMB" } },
    } },
    JESSICA_1 = { partner = "R121_ANN", party = {
      { "KROKOROK", 33, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "SAND_TOMB", "TORMENT" } },
      { "ARBOK", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_FANG", "CRUNCH", "GLARE", "SCREECH" } },
      { "KECLEON", 32, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    CALE = { partner = "R121_GUS", party = {
      { "WORMADAM", 33, ability = "ANTICIPATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ENERGY_BALL", "CONFUSION", "PROTECT" } },
      { "WORMADAM_SANDY_CLOAK", 32, ability = "ANTICIPATION", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_BLAST", "BUG_BITE", "PROTECT", "SUCKER_PUNCH" } },
    } },
    TAMMY = { partner = "R121_WEN", party = {
      { "MISMAGIUS", 33, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "TAUNT" } },
      { "SHUPPET", 32, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    WALTER_1 = { partner = "R121_MAX", party = {
      { "LUXRAY", 33, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "CRUNCH", "ICE_FANG", "SWAGGER" } },
      { "SLOWKING", 32, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "YAWN", "TRICK_ROOM" } },
      { "LINOONE", 32, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "HEADBUTT", "COVET", "PROTECT" } },
    } },
    VANESSA = { partner = "R121_PIA", party = {
      { "RAICHU", 33, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
      { "TOGEDEMARU", 32, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "U_TURN", "DEFENSE_CURL" } },
      { "GRANBULL", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PLAY_ROUGH", "BITE", "ROAR", "HEADBUTT" } },
    } },
    MARCEL = { partner = "R121_TOD", party = {
      { "SHIFTRY", 33, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "FEINT_ATTACK" } },
      { "ZEBSTRIKA", 33, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "MAGNET", moves = { "SPARK", "FLAME_CHARGE", "STOMP", "THUNDER_WAVE" } },
      { "STOUTLAND", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "CRUNCH", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
    } },
    KATE_AND_JOY = { party = {
      { "SWOOBAT", 33, ability = "SIMPLE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "PSYCHIC", "CALM_MIND", "ROOST" } },
      { "VIGOROTH", 33, ability = "VITAL_SPIRIT", nature = "ADAMANT", item = "EVIOLITE", moves = { "SLASH", "FEINT_ATTACK", "SLACK_OFF", "BULK_UP" } },
    } },
    CRISTIN_1 = { partner = "R121_ROX", party = {
      { "NINETALES", 33, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "TRAPINCH", 32, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
      { "PIDGEOTTO", 32, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AIR_SLASH", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    -- Route 122 and Mt. Pyre: tag battles at 32-34; the Aqua grunts at the summit fight alone
    GABRIELLE_1 = { party = {
      { "BERGMITE", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "NEVER_MELT_ICE", moves = { "AVALANCHE", "BITE", "ICE_FANG", "RAPID_SPIN" } },
      { "BAYLEEF", 33, ability = "TRIAGE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "RAICHU_ALOLAN", 33, ability = "SURGE_SURFER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "SPARK", "NUZZLE", "THUNDER_WAVE" } },
      { "DONPHAN", 33, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "ROLLOUT", "KNOCK_OFF", "RAPID_SPIN" } },
    } },
    ZANDER = { partner = "PYRE_DAN", party = {
      { "HARIYAMA", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "HITMONLEE", 33, ability = "RECKLESS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "HIGH_JUMP_KICK", "BLAZE_KICK", "FAKE_OUT", "BRICK_BREAK" } },
      { "PIGNITE", 32, ability = "THICK_FAT", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
    } },
    LEAH = { partner = "PYRE_ELI", party = {
      { "GENGAR", 33, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "SLUDGE_BOMB", "HYPNOSIS", "CONFUSE_RAY" } },
      { "SPOINK", 32, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "JYNX", 32, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ICE_PUNCH", "HEART_STAMP", "FAKE_OUT", "LOVELY_KISS" } },
    } },
    VALERIE_1 = { partner = "PYRE_NIA", party = {
      { "SABLEYE", 33, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "DUSKULL", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "SPIRITOMB", 33, ability = "INFILTRATOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "SUCKER_PUNCH", "CONFUSE_RAY", "NASTY_PLOT" } },
    } },
    TASHA = { partner = "PYRE_ZIA", party = {
      { "LAMPENT", 33, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "SPELL_TAG", moves = { "HEX", "FLAME_BURST", "WILL_O_WISP", "MINIMIZE" } },
      { "SHUPPET", 32, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "TREVENANT", 33, ability = "NATURAL_CURE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_LEECH", "SHADOW_CLAW", "WILL_O_WISP", "FEINT_ATTACK" } },
    } },
    MARK = { partner = "PYRE_OTT", party = {
      { "RHYHORN", 33, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "AXEW", 32, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_CLAW", "CRUNCH", "ASSURANCE", "TAUNT" } },
      { "LICKILICKY", 33, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROLLOUT", "KNOCK_OFF", "STOMP", "DEFENSE_CURL" } },
    } },
    ATSUSHI = { partner = "PYRE_GOR", party = {
      { "DEWOTT", 33, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "FURY_CUTTER", "REVENGE", "FOCUS_ENERGY" } },
      { "MACHOKE", 33, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_SLIDE", "BULK_UP" } },
      { "ARON", 32, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "IRON_HEAD", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    WILLIAM = { partner = "PYRE_VIC", party = {
      { "ELGYEM", 32, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "GUARD_SPLIT", "MIRACLE_EYE", "ZEN_HEADBUTT" } },
      { "GARDEVOIR", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "HYPNOSIS" } },
      { "GALLADE", 33, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
    } },
    KAYLA = { partner = "PYRE_IVY", party = {
      { "WOBBUFFET", 33, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "ALAKAZAM", 33, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "HYPNO", 32, ability = "INSOMNIA", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "HEADBUTT", "SWAGGER" } },
    } },
    CEDRIC = { partner = "PYRE_LEO", party = {
      { "BRONZOR", 32, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "CONFUSION", "GYRO_BALL", "HYPNOSIS", "TRICK_ROOM" } },
      { "SOLOSIS", 32, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYSHOCK", "RECOVER", "CHARM", "PROTECT" } },
      { "MEOWSTIC_FEMALE", 33, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
    } },
    DEZ_AND_LUKE = { party = {
      { "CLOYSTER", 34, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
      { "STEELIX", 34, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "IRON_TAIL", "ROCK_SLIDE", "BULLDOZE", "STEALTH_ROCK" } },
    } },
    GRUNT_MT_PYRE_1 = { tier = "grunt", party = {
      { "GRIMER", 33, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
      { "RATICATE_ALOLAN", 33, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HYPER_FANG", "BITE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "TENTACRUEL", 34, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SLUDGE_BOMB", "TOXIC_SPIKES", "WRAP" } },
    } },
    GRUNT_MT_PYRE_2 = { tier = "grunt", party = {
      { "BRUXISH", 33, ability = "DAZZLING", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "AQUA_JET", "PSYCHIC_FANGS", "ICE_FANG" } },
      { "SNEASEL", 34, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "ICY_WIND", "FAKE_OUT", "TAUNT" } },
      { "WAILMER", 33, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
    } },
    GRUNT_MT_PYRE_3 = { tier = "grunt", party = {
      { "FRILLISH", 33, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "WATER_PULSE", "RECOVER", "NIGHT_SHADE" } },
      { "FOONGUS", 33, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "FEINT_ATTACK", "STUN_SPORE", "ASTONISH" } },
      { "LANTURN", 34, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "WATER_PULSE", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    GRUNT_MT_PYRE_4 = { tier = "grunt", party = {
      { "TIRTOUGA", 34, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BITE", "AQUA_JET", "PROTECT" } },
      { "LIEPARD", 33, ability = "PRANKSTER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "TORMENT", "ASSIST" } },
      { "QWILFISH", 33, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATERFALL", "TOXIC_SPIKES", "HARDEN" } },
    } },
    -- Route 123: tag battles at 32-34; Miu and Yuki are a double
    MIU_AND_YUKI = { party = {
      { "NINETALES", 33, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "NINETALES_ALOLAN", 33, ability = "SNOW_CLOAK", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "EXTRASENSORY", "CONFUSE_RAY", "AURORA_VEIL" } },
    } },
    VIOLET = { partner = "R123_FAY", party = {
      { "ROSELIA", 32, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
      { "TROPIUS", 33, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_SLASH", "GROWTH", "SWEET_SCENT" } },
    } },
    DAVIS = { partner = "R123_GUS", party = {
      { "PINSIR", 33, ability = "MOXIE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "X_SCISSOR", "STORM_THROW", "BULLDOZE", "SWORDS_DANCE" } },
      { "WHIRLIPEDE", 32, ability = "SPEED_BOOST", nature = "IMPISH", spread = "bulk", item = "POISON_BARB", moves = { "POISON_TAIL", "BUG_BITE", "PROTECT", "TOXIC_SPIKES" } },
    } },
    JAZMYN = { partner = "R123_MAX", party = {
      { "ABSOL", 33, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "GOOMY", 32, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "WATER_PULSE", "PROTECT", "RAIN_DANCE" } },
      { "JOLTEON", 33, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "DOUBLE_KICK", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ALBERTO = { partner = "R123_SKY", party = {
      { "PELIPPER", 33, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "XATU", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "SWABLU", 32, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    ED = { partner = "R123_DON", party = {
      { "SEVIPER", 33, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "CRUNCH", "SCREECH" } },
      { "ZANGOOSE", 33, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "FACADE", "CRUSH_CLAW", "QUICK_ATTACK", "HONE_CLAWS" } },
      { "GLACEON", 33, ability = "SNOW_CLOAK", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_FANG", "ICY_WIND", "BITE", "QUICK_ATTACK" } },
    } },
    KINDRA = { partner = "R123_ZEN", party = {
      { "YAMASK", 32, ability = "MUMMY", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HEX", "WILL_O_WISP", "DISABLE", "PROTECT" } },
      { "MAROWAK_ALOLAN", 33, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "FLAME_WHEEL", "SHADOW_BONE", "BONE_CLUB", "FALSE_SWIPE" } },
      { "ROTOM", 33, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    FERNANDO_1 = { partner = "R123_JAX", party = {
      { "ZEBSTRIKA", 33, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "MAGNET", moves = { "SPARK", "FLAME_CHARGE", "STOMP", "THUNDER_WAVE" } },
      { "CHATOT", 33, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "AIR_CUTTER", "TAUNT", "TAILWIND" } },
      { "KRICKETUNE", 32, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "X_SCISSOR", "SING", "TAUNT" } },
    } },
    CAMERON_1 = { partner = "R123_VIC", party = {
      { "SOLROCK", 33, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "ROCK_POLISH", "MORNING_SUN" } },
      { "EXEGGUTOR_ALOLAN", 33, ability = "FRISK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAGON_HAMMER", "SEED_BOMB", "HYPNOSIS", "TRICK_ROOM" } },
      { "BRAIXEN", 32, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "PSYBEAM", "LUCKY_CHANT", "HOWL" } },
    } },
    JACKI_1 = { partner = "R123_IVY", party = {
      { "MUSHARNA", 33, ability = "SYNCHRONIZE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "MOONLIGHT", "YAWN" } },
      { "GIRAFARIG", 33, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "STOMP", "AGILITY", "BATON_PASS" } },
      { "ESPEON", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SWIFT", "QUICK_ATTACK", "MORNING_SUN" } },
    } },
    FREDRICK = { partner = "R123_KEN", party = {
      { "DOUBLADE", 34, ability = "NO_GUARD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SHADOW_SNEAK", "SWORDS_DANCE", "AERIAL_ACE" } },
      { "COMFEY", 33, ability = "TRIAGE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "MAGICAL_LEAF", "SWEET_KISS", "WRAP" } },
      { "PUPITAR", 33, ability = "SHED_SKIN", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "CRUNCH", "STOMPING_TANTRUM", "SCARY_FACE" } },
    } },
    BRAXTON = { partner = "R123_ACE", party = {
      { "RUFFLET", 33, ability = "HUSTLE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "WING_ATTACK", "SLASH", "HONE_CLAWS", "TAILWIND" } },
      { "GABITE", 34, ability = "ROUGH_SKIN", nature = "JOLLY", item = "SOFT_SAND", moves = { "DRAGON_CLAW", "BULLDOZE", "SLASH", "SAND_TOMB" } },
      { "WHIRLIPEDE", 33, ability = "SPEED_BOOST", nature = "IMPISH", spread = "bulk", item = "POISON_BARB", moves = { "POISON_TAIL", "BUG_BITE", "PROTECT", "TOXIC_SPIKES" } },
    } },
    WENDY = { partner = "R123_ELA", party = {
      { "MAWILE", 33, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "PLAY_ROUGH", "SUCKER_PUNCH", "PROTECT" } },
      { "ROSERADE", 34, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "MIENFOO", 33, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DRAIN_PUNCH", "U_TURN", "DETECT" } },
    } },
    JONAS = { partner = "R123_KO", party = {
      { "KOFFING", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "SALANDIT", 33, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "VENOSHOCK", "DRAGON_RAGE", "SWEET_SCENT" } },
    } },
    KAYLEY = { partner = "R123_UMA", party = {
      { "CASTFORM", 33, ability = "FORECAST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WEATHER_BALL", "SUNNY_DAY", "ICE_BEAM", "SOLAR_BEAM" } },
      { "DEERLING", 33, ability = "SAP_SIPPER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TAKE_DOWN", "DOUBLE_KICK", "LEECH_SEED", "CAMOUFLAGE" } },
    } },
    -- Rival in Lilycove: five, alone; the starter is the ace at 35
    BRENDAN_LILYCOVE_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARAQUANID", 33, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "BITE" } },
      { "ARCANINE", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "CRUNCH", "EXTREME_SPEED", "ROAR" } },
      { "MAGNETON", 33, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "TRI_ATTACK" } },
      { "GROVYLE", 35, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "LEAF_BLADE", "DRAGON_BREATH", "QUICK_ATTACK", "DETECT" } },
    } },
    BRENDAN_LILYCOVE_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARCANINE", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_WHEEL", "CRUNCH", "EXTREME_SPEED", "ROAR" } },
      { "BRELOOM", 33, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "MAGNETON", 33, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "TRI_ATTACK" } },
      { "MARSHTOMP", 35, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
    } },
    BRENDAN_LILYCOVE_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "ARAQUANID", 33, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "BITE" } },
      { "BRELOOM", 33, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "MAGNETON", 33, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLASH_CANNON", "THUNDER_WAVE", "TRI_ATTACK" } },
      { "COMBUSKEN", 35, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_SLIDE", "DETECT" } },
    } },
    MAY_LILYCOVE_MUDKIP = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "STARMIE", 33, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
      { "PONYTA", 34, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "BOUNCE" } },
      { "AZUMARILL", 33, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "GROVYLE", 35, ability = "OVERGROW", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "LEAF_BLADE", "DRAGON_BREATH", "QUICK_ATTACK", "DETECT" } },
    } },
    MAY_LILYCOVE_TORCHIC = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "TSAREENA", 33, ability = "QUEENLY_MAJESTY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "TROP_KICK", "STOMP", "PLAY_NICE", "RAPID_SPIN" } },
      { "PONYTA", 34, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "BOUNCE" } },
      { "AZUMARILL", 33, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "MARSHTOMP", 35, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_LILYCOVE_TREECKO = { tier = "gym", party = {
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "STARMIE", 33, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
      { "TSAREENA", 33, ability = "QUEENLY_MAJESTY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "TROP_KICK", "STOMP", "PLAY_NICE", "RAPID_SPIN" } },
      { "AZUMARILL", 33, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "COMBUSKEN", 35, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DOUBLE_KICK", "FLAME_CHARGE", "ROCK_SLIDE", "DETECT" } },
    } },
    -- Chapter 7b: Magma and Aqua Hideouts (draft 1, 2026-10-27; caps 36, 37, 38) ------
    -- Magma Hideout: grunts fight alone with three (34-35)
    GRUNT_MAGMA_HIDEOUT_1 = { tier = "grunt", party = {
      { "SWALOT", 34, ability = "STICKY_HOLD", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "SLUDGE_BOMB", "YAWN", "STOCKPILE", "ACID_SPRAY" } },
      { "CAMERUPT", 35, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "YAWN" } },
      { "PERSIAN_ALOLAN", 34, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "FURY_SWIPES", "TAUNT" } },
    } },
    GRUNT_MAGMA_HIDEOUT_2 = { tier = "grunt", party = {
      { "HIPPOWDON", 35, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "CRUNCH", "YAWN", "SLACK_OFF" } },
      { "SANDSLASH", 34, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "CRUSH_CLAW", "ROCK_SLIDE", "RAPID_SPIN" } },
      { "GASTRODON", 34, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "ICY_WIND" } },
    } },
    GRUNT_MAGMA_HIDEOUT_3 = { tier = "grunt", party = {
      { "CLAYDOL", 34, ability = "LEVITATE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "EARTH_POWER", "PSYBEAM", "TRICK_ROOM", "REFLECT" } },
      { "TRUBBISH", 35, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "TAKE_DOWN", "TOXIC_SPIKES", "CLEAR_SMOG" } },
      { "UMBREON", 34, ability = "SYNCHRONIZE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "FOUL_PLAY", "MOONLIGHT", "CONFUSE_RAY", "SNARL" } },
    } },
    GRUNT_MAGMA_HIDEOUT_4 = { tier = "grunt", party = {
      { "SCRAGGY", 35, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "LOW_SWEEP", "PROTECT" } },
      { "NIDOKING", 34, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "SLUGMA", 34, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
    } },
    GRUNT_MAGMA_HIDEOUT_5 = { tier = "grunt", party = {
      { "FLETCHINDER", 34, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "FLAME_CHARGE", "ACROBATICS", "TAILWIND", "QUICK_ATTACK" } },
      { "PAWNIARD", 35, ability = "DEFIANT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
      { "VENOMOTH", 34, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "PSYBEAM", "SLEEP_POWDER", "QUIVER_DANCE" } },
    } },
    GRUNT_MAGMA_HIDEOUT_6 = { tier = "grunt", party = {
      { "ARIADOS", 35, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_JAB", "SUCKER_PUNCH", "SPIDER_WEB", "SHADOW_SNEAK" } },
      { "TURTONATOR", 34, ability = "SHELL_ARMOR", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAMETHROWER", "DRAGON_PULSE", "PROTECT", "INCINERATE" } },
      { "GOLETT", 34, ability = "IRON_FIST", nature = "ADAMANT", item = "HARD_STONE", moves = { "SHADOW_PUNCH", "BULLDOZE", "DEFENSE_CURL", "ROLLOUT" } },
    } },
    GRUNT_MAGMA_HIDEOUT_7 = { tier = "grunt", party = {
      { "GRAVELER", 34, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "SKUNTANK", 35, ability = "AFTERMATH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "VENOSHOCK", "CRUNCH", "SMOKESCREEN" } },
      { "KOFFING", 34, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
    } },
    GRUNT_MAGMA_HIDEOUT_8 = { tier = "grunt", party = {
      { "MIGHTYENA", 35, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "TRAPINCH", 34, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
      { "SKORUPI", 34, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_FANG", "KNOCK_OFF", "PIN_MISSILE", "SCARY_FACE" } },
    } },
    GRUNT_MAGMA_HIDEOUT_9 = { tier = "grunt", party = {
      { "CAMERUPT", 34, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "YAWN" } },
      { "CROBAT", 35, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "CONFUSE_RAY", "TAILWIND" } },
      { "SHIFTRY", 34, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    GRUNT_MAGMA_HIDEOUT_10 = { tier = "grunt", party = {
      { "CACTURNE", 35, ability = "SAND_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "NEEDLE_ARM", "SUCKER_PUNCH", "SPIKY_SHIELD", "FEINT_ATTACK" } },
      { "LITLEO", 34, ability = "UNNERVE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "HYPER_VOICE", "WORK_UP", "HEADBUTT" } },
      { "SANDYGAST", 34, ability = "WATER_COMPACTION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "SAND_TOMB", "ASTONISH", "HYPNOSIS" } },
    } },
    GRUNT_MAGMA_HIDEOUT_11 = { tier = "grunt", party = {
      { "PILOSWINE", 34, ability = "THICK_FAT", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "EARTHQUAKE", "ICE_FANG", "AMNESIA" } },
      { "MANDIBUZZ", 35, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "AIR_SLASH", "TAILWIND", "ROOST" } },
      { "SCOLIPEDE", 34, ability = "SPEED_BOOST", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_TAIL", "BUG_BITE", "PROTECT", "TOXIC_SPIKES" } },
    } },
    GRUNT_MAGMA_HIDEOUT_12 = { tier = "grunt", party = {
      { "SABLEYE", 35, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "TORKOAL", 34, ability = "DROUGHT", nature = "MODEST", spread = "stank", item = "CHARCOAL", moves = { "LAVA_PLUME", "CLEAR_SMOG", "PROTECT", "YAWN" } },
      { "DRILBUR", 34, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "BULLDOZE", "RAPID_SPIN", "HONE_CLAWS" } },
    } },
    GRUNT_MAGMA_HIDEOUT_13 = { tier = "grunt", party = {
      { "RHYHORN", 34, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "FOONGUS", 35, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "FEINT_ATTACK", "STUN_SPORE", "ASTONISH" } },
      { "PANCHAM", 34, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ARM_THRUST", "KARATE_CHOP", "COMET_PUNCH", "WORK_UP" } },
    } },
    GRUNT_MAGMA_HIDEOUT_14 = { tier = "grunt", party = {
      { "LIEPARD", 35, ability = "PRANKSTER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "TORMENT", "ASSIST" } },
      { "SALANDIT", 34, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "VENOSHOCK", "DRAGON_RAGE", "SWEET_SCENT" } },
      { "NIDOQUEEN", 34, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    GRUNT_MAGMA_HIDEOUT_15 = { tier = "grunt", party = {
      { "KROKOROK", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "SAND_TOMB", "TORMENT" } },
      { "WEEPINBELL", 35, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "TORRACAT", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "DOUBLE_KICK", "BITE", "FAKE_OUT" } },
    } },
    GRUNT_MAGMA_HIDEOUT_16 = { tier = "grunt", party = {
      { "GLIGAR", 35, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ACROBATICS", "EARTHQUAKE", "KNOCK_OFF", "PROTECT" } },
      { "DUSTOX", 34, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SILVER_WIND", "CONFUSION", "MOONLIGHT", "PROTECT" } },
      { "MAGMAR", 34, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "FEINT_ATTACK", "CLEAR_SMOG", "SMOKESCREEN" } },
    } },
    -- Tabitha: five, alone; Camerupt is the ace at 36
    TABITHA_MAGMA_HIDEOUT = { tier = "gym", party = {
      { "GIGALITH", 35, ability = "SAND_STREAM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "BULLDOZE", "EXPLOSION", "PROTECT" } },
      { "DARMANITAN", 35, ability = "SHEER_FORCE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "ROCK_SLIDE", "U_TURN", "SUPERPOWER" } },
      { "STEELIX", 35, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "IRON_TAIL", "EARTHQUAKE", "ROCK_SLIDE", "STEALTH_ROCK" } },
      { "MIGHTYENA", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "CAMERUPT", 36, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "PROTECT" } },
    } },
    -- Maxie: six, alone, a sun team; Torkoal sets Drought, Camerupt is the ace at 37
    MAXIE_MAGMA_HIDEOUT = { tier = "leader", party = {
      { "TORKOAL", 36, ability = "DROUGHT", nature = "MODEST", spread = "stank", item = "HEAT_ROCK", moves = { "LAVA_PLUME", "CLEAR_SMOG", "PROTECT", "YAWN" } },
      { "CROBAT", 36, ability = "INNER_FOCUS", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "VICTREEBEL", 36, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "SOLAR_BEAM", "SLUDGE_BOMB", "SLEEP_POWDER", "WEATHER_BALL" } },
      { "LYCANROC", 36, ability = "SAND_RUSH", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_SLIDE", "CRUNCH", "ACCELEROCK", "PROTECT" } },
      { "ZWEILOUS", 36, ability = "HUSTLE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DRAGON_TAIL", "CRUNCH", "HEADBUTT", "ROAR" } },
      { "CAMERUPT", 37, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "PROTECT" } },
    } },
    -- Aqua Hideout: grunts fight alone with three (36-37)
    GRUNT_AQUA_HIDEOUT_1 = { tier = "grunt", party = {
      { "GOLBAT", 36, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_SLASH", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "CLAUNCHER", 37, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BUBBLE_BEAM", "HELPING_HAND", "SWORDS_DANCE" } },
      { "GRIMER_ALOLAN", 36, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "POISON_FANG", "CRUNCH", "DISABLE", "HARDEN" } },
    } },
    GRUNT_AQUA_HIDEOUT_2 = { tier = "grunt", party = {
      { "TENTACRUEL", 37, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "WRAP" } },
      { "DHELMISE", 36, ability = "STEELWORKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCHOR_SHOT", "GIGA_DRAIN", "WHIRLPOOL", "ASTONISH" } },
      { "MIGHTYENA", 36, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
    } },
    GRUNT_AQUA_HIDEOUT_3 = { tier = "grunt", party = {
      { "SHARPEDO", 36, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "SKRELP", 37, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "SLUDGE_BOMB", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "GRIMER", 36, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    GRUNT_AQUA_HIDEOUT_4 = { tier = "grunt", party = {
      { "SEISMITOAD", 37, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "SLUDGE_WAVE", "HYPER_VOICE", "ROUND" } },
      { "BASCULIN", 36, ability = "ADAPTABILITY", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "CRUNCH", "AQUA_TAIL", "TAIL_WHIP" } },
      { "SCRAGGY", 36, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "LOW_SWEEP", "PROTECT" } },
    } },
    GRUNT_AQUA_HIDEOUT_5 = { tier = "grunt", party = {
      { "SEALEO", 36, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "BRINE", "DEFENSE_CURL", "ENCORE" } },
      { "FLOATZEL", 37, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "CRUNCH", "PURSUIT" } },
      { "MALAMAR", 36, ability = "CONTRARY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUPERPOWER", "FOUL_PLAY", "PSYCHO_CUT", "TOPSY_TURVY" } },
    } },
    GRUNT_AQUA_HIDEOUT_6 = { tier = "grunt", party = {
      { "CROAGUNK", 37, ability = "DRY_SKIN", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "SUCKER_PUNCH", "TAUNT" } },
      { "MAREANIE", 36, ability = "REGENERATOR", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "BITE", "VENOSHOCK", "WIDE_GUARD", "TOXIC_SPIKES" } },
      { "GYARADOS", 36, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "BITE", "ICE_FANG", "DRAGON_DANCE" } },
    } },
    GRUNT_AQUA_HIDEOUT_7 = { tier = "grunt", party = {
      { "CLOYSTER", 36, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
      { "KINGLER", 37, ability = "HYPER_CUTTER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "STOMP", "KNOCK_OFF", "PROTECT" } },
      { "SKUNTANK", 36, ability = "AFTERMATH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "VENOSHOCK", "CRUNCH", "SMOKESCREEN" } },
    } },
    GRUNT_AQUA_HIDEOUT_8 = { tier = "grunt", party = {
      { "RELICANTH", 37, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "PANGORO", 36, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HAMMER_ARM", "CRUNCH", "BULLET_PUNCH", "CIRCLE_THROW" } },
      { "VILEPLUME", 36, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "STUN_SPORE", "MOONLIGHT" } },
    } },
    -- Matt: five, alone, at the submarine dock; Gyarados is the ace at 38
    MATT = { tier = "gym", party = {
      { "SEISMITOAD", 37, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "SLUDGE_WAVE", "HYPER_VOICE", "PROTECT" } },
      { "PELIPPER", 36, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "WATER_PULSE", "TAILWIND", "PROTECT" } },
      { "TOXICROAK", 37, ability = "DRY_SKIN", nature = "ADAMANT", item = "BLACK_SLUDGE", moves = { "FAKE_OUT", "POISON_JAB", "DRAIN_PUNCH", "SUCKER_PUNCH" } },
      { "DHELMISE", 37, ability = "STEELWORKER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ANCHOR_SHOT", "GIGA_DRAIN", "WHIRLPOOL", "PROTECT" } },
      { "GYARADOS", 38, ability = "MOXIE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    -- Chapter 7c: Routes 124-125, Mossdeep, Space Center (draft 1, 2026-10-27; cap 42) ----
    -- Route 124: tag battles at 38-39 on the open sea
    CHAD = { partner = "R124_LEO", party = {
      { "STOUTLAND", 38, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "CRUNCH", "TAKE_DOWN", "HELPING_HAND", "WORK_UP" } },
      { "FRILLISH", 38, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "WATER_PULSE", "RECOVER", "NIGHT_SHADE" } },
      { "LUMINEON", 38, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
    } },
    JENNY_1 = { partner = "R124_MIA", party = {
      { "WAILORD", 39, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "STARMIE", 38, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "BRIONNE", 38, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "ENCORE" } },
    } },
    DECLAN = { partner = "R124_GIL", party = {
      { "GYARADOS", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "DEWGONG", 38, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
    } },
    SPENCER = { partner = "R124_HAL", party = {
      { "TENTACRUEL", 39, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "PELIPPER", 38, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "WATER_PULSE", "TAILWIND", "PROTECT" } },
    } },
    ROLAND = { partner = "R124_DUN", party = {
      { "OCTILLERY", 38, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "OCTAZOOKA", "ICE_BEAM", "PSYBEAM", "FOCUS_ENERGY" } },
      { "CLAWITZER", 39, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "DARK_PULSE", "DRAGON_PULSE", "PROTECT" } },
    } },
    GRACE = { partner = "R124_LIA", party = {
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "GOREBYSS", 38, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
    } },
    ISABELLA = { partner = "R124_TOD", party = {
      { "MANTINE", 38, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
      { "AZUMARILL", 39, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    LILA_AND_ROY_1 = { party = {
      { "GASTRODON", 39, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    -- Route 125 and Shoal Cave: tag battles at 38-40
    NOLEN = { partner = "R125_JON", party = {
      { "POLIWRATH", 39, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "WISHIWASHI", 38, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "RAICHU", 38, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
    } },
    TANYA = { partner = "R125_AMY", party = {
      { "LUVDISC", 38, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "ALOMOMOLA", 38, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
      { "VAPOREON", 39, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    ERNEST_1 = { partner = "R125_BEN", party = {
      { "CONKELDURR", 39, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "GOLISOPOD", 39, ability = "EMERGENCY_EXIT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FIRST_IMPRESSION", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
      { "KANGASKHAN", 38, ability = "SCRAPPY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DOUBLE_HIT", "SUCKER_PUNCH", "PROTECT" } },
    } },
    STAN = { partner = "R125_MAC", party = {
      { "KINGDRA", 39, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "SURF", "DRAGON_PULSE", "FOCUS_ENERGY", "PROTECT" } },
      { "BIBAREL", 38, ability = "SIMPLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HYPER_FANG", "WATERFALL", "CURSE", "ROLLOUT" } },
    } },
    PRESLEY = { partner = "R125_SKY", party = {
      { "STARAPTOR", 39, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "CLOSE_COMBAT", "QUICK_ATTACK", "TAILWIND" } },
      { "GLIGAR", 39, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ACROBATICS", "EARTHQUAKE", "KNOCK_OFF", "PROTECT" } },
    } },
    SHARON = { partner = "R125_ELA", party = {
      { "SEAKING", 38, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "SLOWBRO", 39, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
    } },
    KIM_AND_IRIS = { party = {
      { "ALTARIA", 39, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "RHYDON", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "DRILL_RUN", "MEGAHORN", "PROTECT" } },
      { "CRYOGONAL", 38, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "FREEZE_DRY", "REFLECT", "LIGHT_SCREEN" } },
      { "ROTOM", 38, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDERBOLT", "HEX", "WILL_O_WISP", "THUNDER_WAVE" } },
    } },
    AURON = { partner = "R125_KEN", party = {
      { "MANECTRIC", 40, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "FLAMETHROWER", "THUNDER_WAVE", "SNARL" } },
      { "LUCARIO", 40, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "CLOSE_COMBAT", "BULLET_PUNCH", "CRUNCH", "DETECT" } },
    } },
    -- Trick Houses 5 and 6: tag battles at 39-40
    BENNY = { partner = "TH6_SKY", party = {
      { "SWELLOW", 40, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "FARFETCHD", 39, ability = "SUPER_LUCK", nature = "JOLLY", item = "LEEK", moves = { "LEAF_BLADE", "BRAVE_BIRD", "KNOCK_OFF", "SWORDS_DANCE" } },
    } },
    SEBASTIAN = { partner = "TH6_RAN", party = {
      { "SCIZOR", 40, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLET_PUNCH", "X_SCISSOR", "U_TURN", "PROTECT" } },
      { "DONPHAN", 39, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "ICE_SHARD", "KNOCK_OFF", "RAPID_SPIN" } },
      { "DUNSPARCE", 39, ability = "SERENE_GRACE", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BODY_SLAM", "ROCK_SLIDE", "GLARE", "ROOST" } },
    } },
    SOPHIA = { partner = "TH6_WEN", party = {
      { "LURANTIS", 40, ability = "CONTRARY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "LEAF_BLADE", "X_SCISSOR", "SUPERPOWER", "DEFOG" } },
      { "ORICORIO_POM_POM", 39, ability = "DANCER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "REVELATION_DANCE", "AIR_SLASH", "FEATHER_DANCE", "TEETER_DANCE" } },
      { "MUDSDALE", 39, ability = "STAMINA", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HIGH_HORSEPOWER", "HEAVY_SLAM", "ROCK_SLIDE", "PROTECT" } },
    } },
    -- Mossdeep Gym: psychic trainers fight alone with three
    PRESTON = { tier = "gym", party = {
      { "SLOWKING", 40, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "ALAKAZAM", 40, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "PROTECT" } },
      { "HYPNO", 39, ability = "INSOMNIA", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PSYCHIC", "HYPNOSIS", "FOCUS_PUNCH", "TRICK_ROOM" } },
    } },
    VIRGIL = { tier = "gym", party = {
      { "MEDICHAM", 40, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "BRONZONG", 40, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "GYRO_BALL", "PSYCHIC", "TRICK_ROOM", "HYPNOSIS" } },
      { "CLAYDOL", 39, ability = "LEVITATE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "EARTH_POWER", "PSYCHIC", "REFLECT", "TRICK_ROOM" } },
    } },
    BLAKE = { tier = "gym", party = {
      { "GIRAFARIG", 39, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "HYPER_VOICE", "AGILITY", "BATON_PASS" } },
      { "MEOWSTIC_FEMALE", 40, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "FAKE_OUT", "DARK_PULSE", "LIGHT_SCREEN" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "POWER_GEM", "CONFUSE_RAY", "MAGIC_COAT" } },
    } },
    HANNAH = { tier = "gym", party = {
      { "BRUXISH", 40, ability = "DAZZLING", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "PSYCHIC_FANGS", "AQUA_JET", "CRUNCH", "ICE_FANG" } },
      { "MALAMAR", 40, ability = "CONTRARY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUPERPOWER", "FOUL_PLAY", "PSYCHO_CUT", "TOPSY_TURVY" } },
      { "STARMIE", 39, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    SAMANTHA = { tier = "gym", party = {
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "GARDEVOIR", 40, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "HYPNOSIS" } },
      { "GALLADE", 39, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
    } },
    SYLVIA = { tier = "gym", party = {
      { "ORANGURU", 40, ability = "INNER_FOCUS", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "INSTRUCT", "TRICK_ROOM", "FOUL_PLAY" } },
      { "GOTHORITA", 39, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "FAKE_TEARS", "TICKLE", "FLATTER" } },
      { "CHIMECHO", 39, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    NATE = { tier = "gym", party = {
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "POWER_GEM", "CONFUSE_RAY", "MAGIC_COAT" } },
      { "STARMIE", 40, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "MR_MIME", 39, ability = "FILTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "DAZZLING_GLEAM", "FAKE_OUT", "WIDE_GUARD" } },
    } },
    KATHLEEN = { tier = "gym", party = {
      { "HYPNO", 39, ability = "INSOMNIA", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PSYCHIC", "HYPNOSIS", "FOCUS_PUNCH", "TRICK_ROOM" } },
      { "SWOOBAT", 40, ability = "SIMPLE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "PSYCHIC", "CALM_MIND", "ROOST" } },
      { "MISMAGIUS", 39, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "TAUNT" } },
    } },
    CLIFFORD = { tier = "gym", party = {
      { "RAICHU_ALOLAN", 40, ability = "SURGE_SURFER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "THUNDERBOLT", "NUZZLE", "FOCUS_BLAST" } },
      { "MR_MIME", 39, ability = "FILTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "DAZZLING_GLEAM", "FAKE_OUT", "WIDE_GUARD" } },
      { "SLOWBRO", 39, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
    } },
    NICHOLAS = { tier = "gym", party = {
      { "MUSHARNA", 40, ability = "SYNCHRONIZE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "PSYCHIC", "HYPNOSIS", "MOONLIGHT", "YAWN" } },
      { "WOBBUFFET", 39, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "ESPEON", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "SHADOW_BALL", "MORNING_SUN" } },
    } },
    MACEY = { tier = "gym", party = {
      { "JYNX", 39, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ICE_BEAM", "PSYCHIC", "FAKE_OUT", "LOVELY_KISS" } },
      { "DELPHOX", 40, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "MYSTICAL_FIRE", "PSYSHOCK", "SHADOW_BALL", "PROTECT" } },
      { "KADABRA", 39, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "REFLECT" } },
    } },
    MAURA = { tier = "gym", party = {
      { "BEHEEYEM", 40, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "SHADOW_BALL", "TRICK_ROOM", "THUNDERBOLT" } },
      { "ESPEON", 40, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "SHADOW_BALL", "MORNING_SUN" } },
      { "METANG", 39, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ZEN_HEADBUTT", "BULLET_PUNCH", "METEOR_MASH", "PROTECT" } },
    } },
    -- Tate and Liza: six, a double of their own; Solrock is the ace at 42 under Trick Room
    TATE_AND_LIZA_1 = { tier = "leader", party = {
      { "LUNATONE", 41, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "PSYCHIC", "POWER_GEM", "ICE_BEAM", "TRICK_ROOM" } },
      { "REUNICLUS", 41, ability = "MAGIC_GUARD", nature = "QUIET", spread = "stank", item = "SITRUS_BERRY", moves = { "PSYCHIC", "FOCUS_BLAST", "TRICK_ROOM", "PROTECT" } },
      { "SLOWBRO", 41, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "EXEGGUTOR", 41, ability = "HARVEST", nature = "QUIET", spread = "stank", item = "SITRUS_BERRY", moves = { "PSYCHIC", "ENERGY_BALL", "SLEEP_POWDER", "TRICK_ROOM" } },
      { "CLAYDOL", 41, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "EARTH_POWER", "PSYCHIC", "REFLECT", "LIGHT_SCREEN" } },
      { "SOLROCK", 42, ability = "LEVITATE", nature = "BRAVE", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "FLARE_BLITZ", "EXPLOSION" } },
    } },
    -- Mossdeep Space Center: Magma grunts alone with three; Maxie and Tabitha bring three each side by side
    GRUNT_SPACE_CENTER_1 = { tier = "grunt", party = {
      { "MIGHTYENA", 40, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "CAMERUPT", 41, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "YAWN" } },
      { "SHIFTRY", 40, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    GRUNT_SPACE_CENTER_2 = { tier = "grunt", party = {
      { "VIBRAVA", 40, ability = "LEVITATE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "DRAGON_BREATH", "ROCK_SLIDE", "TAILWIND" } },
      { "CROBAT", 41, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "CONFUSE_RAY", "TAILWIND" } },
      { "DRAPION", 40, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "CRUNCH", "POISON_JAB", "KNOCK_OFF", "PROTECT" } },
    } },
    GRUNT_SPACE_CENTER_3 = { tier = "grunt", party = {
      { "SALAZZLE", 41, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "SLUDGE_BOMB", "FAKE_OUT", "PROTECT" } },
      { "PALOSSAND", 40, ability = "WATER_COMPACTION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SHADOW_BALL", "GIGA_DRAIN", "IRON_DEFENSE" } },
      { "AMOONGUSS", 40, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "INGRAIN", "CLEAR_SMOG" } },
    } },
    GRUNT_SPACE_CENTER_4 = { tier = "grunt", party = {
      { "TORKOAL", 40, ability = "DROUGHT", nature = "MODEST", spread = "stank", item = "CHARCOAL", moves = { "LAVA_PLUME", "CLEAR_SMOG", "PROTECT", "YAWN" } },
      { "CLAYDOL", 40, ability = "LEVITATE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "EARTH_POWER", "PSYBEAM", "TRICK_ROOM", "REFLECT" } },
      { "RHYDON", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "DRILL_RUN", "MEGAHORN", "PROTECT" } },
    } },
    GRUNT_SPACE_CENTER_5 = { tier = "grunt", party = {
      { "PYROAR", 41, ability = "MOXIE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "HYPER_VOICE", "DARK_PULSE", "NOBLE_ROAR" } },
      { "PANGORO", 40, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HAMMER_ARM", "CRUNCH", "BULLET_PUNCH", "CIRCLE_THROW" } },
      { "NIDOKING", 40, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
    } },
    GRUNT_SPACE_CENTER_6 = { tier = "grunt", party = {
      { "HIPPOWDON", 41, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "CRUNCH", "YAWN", "SLACK_OFF" } },
      { "SANDSLASH", 40, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "CRUSH_CLAW", "ROCK_SLIDE", "RAPID_SPIN" } },
      { "EXCADRILL", 40, ability = "SAND_RUSH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "DRILL_RUN", "ROCK_SLIDE", "PROTECT" } },
    } },
    GRUNT_SPACE_CENTER_7 = { tier = "grunt", party = {
      { "LIEPARD", 40, ability = "PRANKSTER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FOUL_PLAY", "TORMENT", "ASSIST" } },
      { "INCINEROAR", 41, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FAKE_OUT", "FLARE_BLITZ", "DARKEST_LARIAT", "U_TURN" } },
      { "MAMOSWINE", 40, ability = "THICK_FAT", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "EARTHQUAKE", "ICICLE_CRASH", "PROTECT" } },
    } },
    TABITHA_MOSSDEEP = { tier = "gym", party = {
      { "EXCADRILL", 41, ability = "SAND_RUSH", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "DRILL_RUN", "ROCK_SLIDE", "PROTECT" } },
      { "GIGALITH", 41, ability = "SAND_STREAM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "EARTHQUAKE", "EXPLOSION", "PROTECT" } },
      { "STEELIX", 41, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "IRON_TAIL", "EARTHQUAKE", "ROCK_SLIDE", "STEALTH_ROCK" } },
    } },
    MAXIE_MOSSDEEP = { tier = "leader", party = {
      { "CROBAT", 41, ability = "INNER_FOCUS", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "VICTREEBEL", 41, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "SOLAR_BEAM", "SLUDGE_BOMB", "SLEEP_POWDER", "WEATHER_BALL" } },
      { "CAMERUPT", 42, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "PROTECT" } },
    } },
    -- Chapter 8: Mossdeep to Juan (draft 1, 2026-10-27; caps 43, 44, 46) --------------
    -- Routes 126-128 (Dive spots): tag battles at 41-42
    CAMDEN = { partner = "R126_TOD", party = {
      { "KLANG", 41, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "GEAR_GRIND", "CHARGE_BEAM", "SHIFT_GEAR", "AUTOTOMIZE" } },
      { "GRENINJA", 42, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DARK_PULSE", "ICE_BEAM", "PROTECT" } },
      { "EMOLGA", 41, ability = "MOTOR_DRIVE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDERBOLT", "AIR_SLASH", "NUZZLE", "ENCORE" } },
    } },
    PABLO_1 = { partner = "R126_ACE", party = {
      { "KABUTOPS", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ROCK_SLIDE", "AQUA_JET", "PROTECT" } },
      { "GOLDUCK", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
      { "QWILFISH", 41, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATERFALL", "TOXIC_SPIKES", "HARDEN" } },
    } },
    BRENDA = { partner = "R126_LIA", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "RAICHU", 41, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
    } },
    BARRY = { partner = "R126_GIL", party = {
      { "SWAMPERT", 42, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
      { "GOGOAT", 41, ability = "SAP_SIPPER", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "HORN_LEECH", "BULLDOZE", "LEECH_SEED", "MILK_DRINK" } },
    } },
    DEAN = { partner = "R126_JON", party = {
      { "FRAXURE", 42, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_CLAW", "CRUNCH", "DRAGON_DANCE", "TAUNT" } },
      { "LUDICOLO", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "RAIN_DANCE" } },
      { "QUAGSIRE", 41, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    ISAIAH_1 = { partner = "R126_SKY", party = {
      { "DODRIO", 42, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "JOLTEON", 41, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "SHADOW_BALL", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ISOBEL = { partner = "R126_MIA", party = {
      { "BEARTIC", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICICLE_CRASH", "AQUA_JET", "BRICK_BREAK", "SWORDS_DANCE" } },
      { "SWANNA", 41, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HURRICANE", "SURF", "TAILWIND", "ROOST" } },
    } },
    DONNY = { partner = "R126_DUN", party = {
      { "YANMEGA", 42, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "BUG_BUZZ", "DETECT", "ANCIENT_POWER" } },
      { "BLASTOISE", 42, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "ICE_BEAM", "FAKE_OUT", "PROTECT" } },
    } },
    KATELYN_1 = { partner = "R126_ELA", party = {
      { "FEAROW", 42, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "DRILL_RUN", "AERIAL_ACE", "PURSUIT", "FOCUS_ENERGY" } },
      { "ZEBSTRIKA", 41, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "MAGNET", moves = { "WILD_CHARGE", "FLAME_CHARGE", "STOMP", "THUNDER_WAVE" } },
    } },
    NIKKI = { partner = "R126_AMY", party = {
      { "LAPRAS", 42, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
      { "AUDINO", 41, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "HELPING_HAND", "DOUBLE_SLAP", "DISARMING_VOICE" } },
    } },
    SIENNA = { partner = "R126_KIM", party = {
      { "HUNTAIL", 41, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 41, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
      { "POLITOED", 42, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SURF", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
    } },
    CARLEE = { partner = "R126_PIA", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "DRAMPA", 42, ability = "BERSERK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAGON_PULSE", "HYPER_VOICE", "GLARE", "FLAMETHROWER" } },
    } },
    LEONARDO = { partner = "R126_LEO", party = {
      { "FLOATZEL", 42, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "BINACLE", 41, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "RAZOR_SHELL", "SHADOW_CLAW", "PROTECT" } },
    } },
    ATHENA = { partner = "R126_MAX", party = {
      { "INFERNAPE", 42, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "FAKE_OUT", "FLAME_WHEEL", "MACH_PUNCH", "U_TURN" } },
      { "ACCELGOR", 41, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "QUICK_ATTACK", "ENCORE" } },
    } },
    HARRISON = { partner = "R126_BEN", party = {
      { "LICKILICKY", 41, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BODY_SLAM", "KNOCK_OFF", "ROLLOUT", "DEFENSE_CURL" } },
      { "OMANYTE", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "SURF", "BITE", "PROTECT" } },
    } },
    JONAH = { partner = "R126_HAL", party = {
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
      { "TOXAPEX", 42, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "SURF", "WIDE_GUARD", "TOXIC_SPIKES" } },
    } },
    HENRY = { partner = "R126_NED", party = {
      { "TENTACRUEL", 42, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "FRILLISH", 41, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "WATER_PULSE", "RECOVER", "NIGHT_SHADE" } },
    } },
    ROGER = { partner = "R126_MAC", party = {
      { "CRAWDAUNT", 42, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
      { "PYUKUMUKU", 41, ability = "INNARDS_OUT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "HELPING_HAND", "PURIFY", "MUD_SPORT", "PAIN_SPLIT" } },
    } },
    KOJI_1 = { partner = "R126_KEN", party = {
      { "HARIYAMA", 42, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "LAIRON", 41, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "IRON_HEAD", "ROCK_SLIDE", "HEADBUTT", "PROTECT" } },
    } },
    WAYNE = { partner = "R126_WES", party = {
      { "WAILMER", 41, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "DHELMISE", 42, ability = "STEELWORKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCHOR_SHOT", "GIGA_DRAIN", "WHIRLPOOL", "PROTECT" } },
    } },
    AIDAN = { partner = "R126_SKY2", party = {
      { "PIDGEOT", 42, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "TALONFLAME", 41, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "FLARE_BLITZ", "TAILWIND", "QUICK_ATTACK" } },
    } },
    ALEXA = { partner = "R126_ANN", party = {
      { "FERALIGATR", 42, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "ICE_FANG", "CRUNCH", "PROTECT" } },
      { "SCIZOR", 42, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLET_PUNCH", "X_SCISSOR", "U_TURN", "PROTECT" } },
      { "AMPHAROS", 42, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "DRAGON_PULSE", "POWER_GEM", "THUNDER_WAVE" } },
    } },
    RUBEN = { partner = "R126_RAN", party = {
      { "MEGANIUM", 42, ability = "OVERGROW", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ENERGY_BALL", "LIGHT_SCREEN", "REFLECT", "SYNTHESIS" } },
      { "DRAGONAIR", 42, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_RUSH", "AQUA_TAIL", "THUNDER_WAVE", "DRAGON_DANCE" } },
      { "MILOTIC", 42, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    -- Seafloor Cavern: Aqua grunts alone with three
    GRUNT_SEAFLOOR_CAVERN_1 = { tier = "grunt", party = {
      { "MIGHTYENA", 42, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "CROBAT", 42, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "CONFUSE_RAY", "TAILWIND" } },
      { "SHARPEDO", 42, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    GRUNT_SEAFLOOR_CAVERN_2 = { tier = "grunt", party = {
      { "HUNTAIL", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "MUK", 42, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "BLACK_SLUDGE", moves = { "GUNK_SHOT", "SHADOW_SNEAK", "ICE_PUNCH", "MINIMIZE" } },
      { "SCRAFTY", 42, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DRAIN_PUNCH", "KNOCK_OFF", "PROTECT" } },
    } },
    GRUNT_SEAFLOOR_CAVERN_3 = { tier = "grunt", party = {
      { "WAILORD", 42, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SKUNTANK", 42, ability = "AFTERMATH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "POISON_JAB", "CRUNCH", "EXPLOSION" } },
      { "SEAKING", 42, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
    } },
    GRUNT_SEAFLOOR_CAVERN_4 = { tier = "grunt", party = {
      { "GOREBYSS", 42, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "PURUGLY", 42, ability = "THICK_FAT", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "BODY_SLAM", "SUCKER_PUNCH", "U_TURN" } },
      { "TOXAPEX", 42, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "SURF", "WIDE_GUARD", "TOXIC_SPIKES" } },
    } },
    GRUNT_SEAFLOOR_CAVERN_5 = { tier = "grunt", party = {
      { "MANDIBUZZ", 42, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "AIR_SLASH", "TAILWIND", "ROOST" } },
      { "GYARADOS", 42, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "ARBOK", 42, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "GUNK_SHOT", "CRUNCH", "GLARE", "SUCKER_PUNCH" } },
    } },
    -- Shelly: six, alone, rain team; Empoleon is the ace at 43
    SHELLY_SEAFLOOR_CAVERN = { tier = "leader", party = {
      { "PELIPPER", 42, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 42, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "RAIN_DANCE" } },
      { "CRAWDAUNT", 42, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
      { "CLEFABLE", 42, ability = "MAGIC_GUARD", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "FOLLOW_ME", "HELPING_HAND", "PROTECT" } },
      { "SHARPEDO", 42, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "EMPOLEON", 43, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "FLASH_CANNON", "ICE_BEAM", "PROTECT" } },
    } },
    -- Archie: six, alone; Sharpedo is the ace at 44
    ARCHIE = { tier = "leader", party = {
      { "POLITOED", 43, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SURF", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
      { "SLIGGOO", 43, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "WATER_PULSE", "ICE_BEAM", "PROTECT" } },
      { "TENTACRUEL", 43, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "POLIWRATH", 43, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "EELEKTROSS", 43, ability = "LEVITATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WILD_CHARGE", "CRUNCH", "DRAIN_PUNCH", "U_TURN" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    -- Routes 129-134 toward Pacifidlog: tag battles at 43-45
    RONALD = { party = {
      { "MAGIKARP", 43, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    FRANKLIN = { partner = "R130_LEO", party = {
      { "SEALEO", 43, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    JACK = { partner = "R130_BO", party = {
      { "LINOONE", 43, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "SLASH", "COVET", "PROTECT" } },
      { "SIMIPOUR", 43, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "CRUNCH", "TAUNT", "PLAY_NICE" } },
    } },
    HITOSHI = { partner = "R130_KEN", party = {
      { "HITMONCHAN", 44, ability = "IRON_FIST", nature = "ADAMANT", item = "BLACK_BELT", moves = { "DRAIN_PUNCH", "ICE_PUNCH", "MACH_PUNCH", "FEINT" } },
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "CRABOMINABLE", 43, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HAMMER_ARM", "ICE_HAMMER", "PAYBACK", "PROTECT" } },
    } },
    KIYO = { partner = "R130_GOR", party = {
      { "HAWLUCHA", 44, ability = "UNBURDEN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "DRAIN_PUNCH", "FEATHER_DANCE", "DETECT" } },
      { "PRIMEAPE", 43, ability = "DEFIANT", nature = "JOLLY", item = "ORAN_BERRY", moves = { "CLOSE_COMBAT", "U_TURN", "STONE_EDGE", "ENCORE" } },
      { "THROH", 43, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "STORM_THROW", "ROCK_SLIDE", "BULK_UP", "FACADE" } },
    } },
    ALEX = { partner = "R130_SKY", party = {
      { "SWELLOW", 44, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "TOGEKISS", 44, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
    } },
    BECK = { partner = "R130_ACE", party = {
      { "HONCHKROW", 44, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "BRAVE_BIRD", "SUCKER_PUNCH", "HAZE" } },
      { "ALTARIA", 43, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "NOCTOWL", 43, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    DEBRA = { partner = "R130_AMY", party = {
      { "QWILFISH", 43, ability = "INTIMIDATE", nature = "ADAMANT", item = "POISON_BARB", moves = { "FELL_STINGER", "WATERFALL", "TOXIC_SPIKES", "HARDEN" } },
      { "SEISMITOAD", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "SLUDGE_WAVE", "HYPER_VOICE", "PROTECT" } },
    } },
    LINDA = { partner = "R130_LIA", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "LUMINEON", 43, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
    } },
    LAUREL = { partner = "R130_ELA", party = {
      { "LUVDISC", 43, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "ALOMOMOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    KELVIN = { partner = "R130_WES", party = {
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "DHELMISE", 43, ability = "STEELWORKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCHOR_SHOT", "GIGA_DRAIN", "WHIRLPOOL", "PROTECT" } },
    } },
    REYNA = { partner = "R130_ROX", party = {
      { "BEWEAR", 44, ability = "FLUFFY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "HAMMER_ARM", "SHADOW_CLAW", "PAYBACK", "PROTECT" } },
      { "PASSIMIAN", 43, ability = "RECEIVER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "FEINT", "QUICK_GUARD", "BRICK_BREAK" } },
    } },
    HUDSON = { partner = "R130_BEN", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "RATICATE", 43, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "SUCKER_PUNCH", "U_TURN", "CRUNCH" } },
    } },
    RODNEY = { partner = "R131_GIL", party = {
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "WISHIWASHI", 44, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    RICHARD = { partner = "R131_JON", party = {
      { "TAUROS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "HORN_ATTACK", "SCARY_FACE" } },
      { "SLOWKING", 44, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
    } },
    SANTIAGO = { partner = "R131_HAL", party = {
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
    } },
    GILBERT = { partner = "R131_MAC", party = {
      { "NIDOKING", 44, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    KEVIN = { partner = "R131_DUN", party = {
      { "SNORLAX", 44, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "CRUNCH", "HIGH_HORSEPOWER", "PROTECT" } },
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    CHASE = { partner = "R131_SKY", party = {
      { "STARMIE", 44, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "BRAVIARY", 44, ability = "SHEER_FORCE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "CRUSH_CLAW", "TAILWIND", "ROCK_SLIDE" } },
    } },
    TALIA = { partner = "R131_PIA", party = {
      { "SCYTHER", 44, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "QUICK_ATTACK", "SWORDS_DANCE" } },
      { "DEDENNE", 44, ability = "CHEEK_POUCH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDERBOLT", "DAZZLING_GLEAM", "NUZZLE", "HELPING_HAND" } },
    } },
    ALLISON = { partner = "R131_TOD", party = {
      { "UNFEZANT", 44, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_SLASH", "QUICK_ATTACK", "TAILWIND", "ROOST" } },
      { "GALVANTULA", 44, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDER", "BUG_BUZZ", "ELECTROWEB", "STICKY_WEB" } },
    } },
    KATIE = { partner = "R132_KIM", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "BEARTIC", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICICLE_CRASH", "AQUA_JET", "BRICK_BREAK", "SWORDS_DANCE" } },
    } },
    KARA = { partner = "R132_ZOE", party = {
      { "MILTANK", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "ROLLOUT", "MILK_DRINK", "HELPING_HAND" } },
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    DANA = { partner = "R132_MIA", party = {
      { "NIDOQUEEN", 44, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
      { "PRIMARINA", 44, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "PROTECT" } },
    } },
    CLARENCE = { partner = "R132_LEO", party = {
      { "DIGGERSBY", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SOFT_SAND", moves = { "HIGH_HORSEPOWER", "QUICK_ATTACK", "ROCK_SLIDE", "PROTECT" } },
      { "EMPOLEON", 44, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "FLASH_CANNON", "ICE_BEAM", "PROTECT" } },
    } },
    REED = { partner = "R132_BO", party = {
      { "SEALEO", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    TISHA = { partner = "R132_ELA", party = {
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "SLURPUFF", 44, ability = "UNBURDEN", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "FLAMETHROWER", "CALM_MIND", "DRAINING_KISS" } },
    } },
    RELI_AND_IAN = { party = {
      { "PELIPPER", 44, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
    } },
    MOLLIE = { partner = "R133_ZEN", party = {
      { "GENGAR", 45, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "SLUDGE_BOMB", "HYPNOSIS", "PROTECT" } },
      { "CARRACOSTA", 44, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "AQUA_JET", "PROTECT" } },
      { "AROMATISSE", 44, ability = "AROMA_VEIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "MOONBLAST", "TRICK_ROOM", "HEAL_PULSE", "PROTECT" } },
    } },
    AARON = { partner = "R133_DRA", party = {
      { "DRUDDIGON", 45, ability = "ROUGH_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_CLAW", "SUCKER_PUNCH", "FIRE_PUNCH", "GLARE" } },
      { "TYRANTRUM", 45, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "DRAGON_CLAW", "CRUNCH", "EARTHQUAKE" } },
      { "NOIVERN", 44, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "DRAGON_PULSE", "TAILWIND", "SUPER_FANG" } },
    } },
    CONOR = { partner = "R133_KEN", party = {
      { "HARIYAMA", 45, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "FERROTHORN", 44, ability = "IRON_BARBS", nature = "RELAXED", spread = "tank", item = "SITRUS_BERRY", moves = { "GYRO_BALL", "POWER_WHIP", "LEECH_SEED", "PROTECT" } },
      { "GOTHITELLE", 44, ability = "COMPETITIVE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "FAKE_TEARS", "TRICK_ROOM", "HEAL_PULSE" } },
    } },
    PAXTON = { partner = "R133_GOR", party = {
      { "BRELOOM", 45, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "URSARING", 44, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "FACADE", "CLOSE_COMBAT", "CRUNCH", "PROTECT" } },
      { "LUXRAY", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "WILD_CHARGE", "CRUNCH", "ICE_FANG", "SWAGGER" } },
    } },
    MAKAYLA = { partner = "R133_WEN", party = {
      { "AMOONGUSS", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "CLEAR_SMOG", "INGRAIN" } },
      { "MEDICHAM", 45, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "FLAREON", 44, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "QUICK_ATTACK", "SUPERPOWER", "HELPING_HAND" } },
    } },
    WARREN = { partner = "R133_ACE", party = {
      { "GOLEM_ALOLAN", 45, ability = "GALVANIZE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "BODY_SLAM", "EARTHQUAKE", "EXPLOSION" } },
      { "TORTERRA", 45, ability = "SOLID_ROCK", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "EARTHQUAKE", "CRUNCH", "PROTECT" } },
      { "COFAGRIGUS", 44, ability = "MUMMY", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "WILL_O_WISP", "TRICK_ROOM", "PROTECT" } },
    } },
    HERMAN = { partner = "R134_GIL", party = {
      { "HERACROSS", 45, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MEGAHORN", "CLOSE_COMBAT", "KNOCK_OFF", "PROTECT" } },
      { "FLORGES", 44, ability = "FLOWER_VEIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "MOONBLAST", "PSYCHIC", "WISH", "PROTECT" } },
      { "BRONZONG", 44, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "GYRO_BALL", "PSYCHIC", "TRICK_ROOM", "HYPNOSIS" } },
    } },
    SUSIE = { partner = "R134_ELA", party = {
      { "PIDGEOT", 45, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "SCEPTILE", 45, ability = "OVERGROW", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "LEAF_BLADE", "DRAGON_CLAW", "QUICK_ATTACK", "DETECT" } },
      { "FROSLASS", 44, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "SHADOW_BALL", "WILL_O_WISP", "PROTECT" } },
    } },
    MARLEY = { partner = "R134_MAX", party = {
      { "VENUSAUR", 45, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "ESCAVALIER", 44, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "MEGAHORN", "KNOCK_OFF", "PROTECT" } },
      { "ARCANINE", 45, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "CRUNCH", "PROTECT" } },
    } },
    JONATHAN = { partner = "R134_DUN", party = {
      { "RAMPARDOS", 45, ability = "SHEER_FORCE", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "CRUNCH", "PROTECT" } },
      { "CHARIZARD", 45, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
      { "SAWSBUCK", 44, ability = "SAP_SIPPER", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "HORN_LEECH", "JUMP_KICK", "WILD_CHARGE", "PROTECT" } },
    } },
    DARCY = { partner = "R134_ANN", party = {
      { "CHARIZARD", 45, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
      { "LILLIGANT", 44, ability = "OWN_TEMPO", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLEEP_POWDER", "QUIVER_DANCE", "PROTECT" } },
      { "PORYGON_Z", 44, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "SHADOW_BALL", "THUNDERBOLT", "NASTY_PLOT" } },
    } },
    -- Sootopolis Gym: water trainers fight alone with three
    DAPHNE = { tier = "gym", party = {
      { "LUVDISC", 44, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "LAPRAS", 45, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
      { "SAMUROTT", 45, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "MEGAHORN", "AQUA_JET", "SWORDS_DANCE" } },
    } },
    BRIANNA = { tier = "gym", party = {
      { "GRENINJA", 45, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DARK_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DEWGONG", 44, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    CONNIE = { tier = "gym", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "STARMIE", 45, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LUMINEON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
    } },
    BRIDGET = { tier = "gym", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "OMASTAR", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "ANCIENT_POWER", "ICE_BEAM", "PROTECT" } },
      { "TOXAPEX", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "SURF", "WIDE_GUARD", "TOXIC_SPIKES" } },
    } },
    OLIVIA = { tier = "gym", party = {
      { "CARRACOSTA", 45, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "AQUA_JET", "PROTECT" } },
      { "ARAQUANID", 44, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "CRUNCH" } },
      { "WISHIWASHI", 44, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    TIFFANY = { tier = "gym", party = {
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
      { "FERALIGATR", 45, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "ICE_FANG", "CRUNCH", "PROTECT" } },
      { "GASTRODON_EAST_SEA", 44, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    BETHANY = { tier = "gym", party = {
      { "SLOWKING", 45, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
    } },
    ANNIKA = { tier = "gym", party = {
      { "MILOTIC", 45, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
      { "PRIMARINA", 44, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "PROTECT" } },
      { "GOLDUCK", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    ANDREA = { tier = "gym", party = {
      { "CLOYSTER", 44, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
      { "FLOATZEL", 44, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "JELLICENT", 45, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    CRISSY = { tier = "gym", party = {
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "GOLISOPOD", 45, ability = "EMERGENCY_EXIT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FIRST_IMPRESSION", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
      { "SWANNA", 44, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HURRICANE", "SURF", "TAILWIND", "ROOST" } },
    } },
    -- Juan: six, alone (2-vs-1), rain team under Drizzle; Kingdra is the ace at the cap
    JUAN_1 = { tier = "leader", party = {
      { "POLITOED", 45, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SURF", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
      { "LUDICOLO", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "ICE_BEAM" } },
      { "KABUTOPS", 45, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "ROCK_SLIDE", "AQUA_JET", "PROTECT" } },
      { "LAPRAS", 45, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "SURF", "THUNDERBOLT", "PROTECT" } },
      { "SWAMPERT", 45, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
      { "KINGDRA", 46, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
    } },
    -- Chapter 9: Victory Road and the League (draft 1, 2026-10-27; caps 48, 50, 52, 54, 56, 58) ----
    -- Trick House 7 (after the Rain Badge) and inner Meteor Falls (Waterfall): tag battles at 46-47
    PATRICIA = { partner = "VR_P1", party = {
      { "BANETTE", 47, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_CLAW", "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP" } },
      { "MISMAGIUS", 46, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "TAUNT" } },
      { "GOTHITELLE", 46, ability = "COMPETITIVE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "FAKE_TEARS", "TRICK_ROOM", "HEAL_PULSE" } },
    } },
    JOSHUA = { partner = "VR_P2", party = {
      { "ALAKAZAM", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "PROTECT" } },
      { "MR_MIME", 46, ability = "FILTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "DAZZLING_GLEAM", "FAKE_OUT", "WIDE_GUARD" } },
      { "DARMANITAN", 47, ability = "SHEER_FORCE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "ROCK_SLIDE", "U_TURN", "SUPERPOWER" } },
    } },
    ALEXIS = { partner = "VR_P3", party = {
      { "GARDEVOIR", 47, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "HYPNOSIS" } },
      { "ORANGURU", 46, ability = "INNER_FOCUS", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "INSTRUCT", "TRICK_ROOM", "FOUL_PLAY" } },
    } },
    MARIELA = { partner = "VR_P4", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "CHIMECHO", 46, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    ALVARO = { partner = "VR_P5", party = {
      { "GALLADE", 47, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
      { "GIRAFARIG", 46, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "HYPER_VOICE", "AGILITY", "BATON_PASS" } },
    } },
    EVERETT = { partner = "VR_P6", party = {
      { "WOBBUFFET", 46, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "BEHEEYEM", 47, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "SHADOW_BALL", "TRICK_ROOM", "THUNDERBOLT" } },
    } },
    NICOLAS_1 = { partner = "VR_P7", party = {
      { "ALTARIA", 47, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "FLYGON", 47, ability = "LEVITATE", nature = "JOLLY", item = "SOFT_SAND", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
    } },
    JOHN_AND_JAY_1 = { party = {
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "MEDICHAM", 47, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "LUCARIO", 47, ability = "INNER_FOCUS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "CLOSE_COMBAT", "BULLET_PUNCH", "CRUNCH", "DETECT" } },
    } },
    -- Victory Road: tag battles at 46-48
    ALBERT = { partner = "VR_A1", party = {
      { "MAGNEZONE", 47, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "MUK", 47, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "BLACK_SLUDGE", moves = { "GUNK_SHOT", "SHADOW_SNEAK", "ICE_PUNCH", "MINIMIZE" } },
      { "EXCADRILL", 47, ability = "SAND_RUSH", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
    } },
    HOPE = { partner = "VR_A2", party = {
      { "ROSERADE", 47, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "TOGEKISS", 47, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
      { "ARCANINE", 47, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "CRUNCH", "PROTECT" } },
    } },
    SHANNON = { partner = "VR_A3", party = {
      { "CLAYDOL", 47, ability = "LEVITATE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "EARTH_POWER", "PSYCHIC", "TRICK_ROOM", "REFLECT" } },
      { "CONKELDURR", 47, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "MILOTIC", 47, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    SAMUEL = { partner = "VR_A4", party = {
      { "DODRIO", 47, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "SCIZOR", 47, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLET_PUNCH", "X_SCISSOR", "U_TURN", "PROTECT" } },
      { "GOLEM", 47, ability = "STURDY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "EARTHQUAKE", "EXPLOSION", "PROTECT" } },
    } },
    JULIE = { partner = "VR_A5", party = {
      { "SANDSLASH", 47, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "CRUSH_CLAW", "ROCK_SLIDE", "RAPID_SPIN" } },
      { "NINETALES", 47, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "VENUSAUR", 47, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
    } },
    OWEN = { partner = "VR_A6", party = {
      { "KANGASKHAN", 47, ability = "SCRAPPY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DOUBLE_HIT", "SUCKER_PUNCH", "PROTECT" } },
      { "GYARADOS", 47, ability = "MOXIE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "TAUROS", 47, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "HORN_ATTACK", "SCARY_FACE" } },
    } },
    DIANNE = { partner = "VR_A7", party = {
      { "CLEFABLE", 47, ability = "MAGIC_GUARD", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "FOLLOW_ME", "HELPING_HAND", "PROTECT" } },
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "EXPLOUD", 47, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "HYPER_VOICE", "FLAMETHROWER", "ICE_BEAM", "PROTECT" } },
    } },
    FELIX = { partner = "VR_A8", party = {
      { "MEDICHAM", 47, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "CROBAT", 47, ability = "INNER_FOCUS", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "CROSS_POISON", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "SHIFTRY", 47, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    CAROLINE = { partner = "VR_A9", party = {
      { "SKARMORY", 47, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "STEEL_WING", "AIR_SLASH", "SPIKES", "TAILWIND" } },
      { "SABLEYE", 47, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "SALAMENCE", 48, ability = "INTIMIDATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "DRAGON_CLAW", "ROCK_SLIDE", "FLY", "PROTECT" } },
    } },
    VITO = { partner = "VR_A10", party = {
      { "DODRIO", 47, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "KADABRA", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "REFLECT" } },
      { "ELECTRODE", 47, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DISCHARGE", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    MICHELLE = { partner = "VR_A11", party = {
      { "TORKOAL", 47, ability = "DROUGHT", nature = "MODEST", spread = "stank", item = "HEAT_ROCK", moves = { "LAVA_PLUME", "CLEAR_SMOG", "PROTECT", "YAWN" } },
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LUDICOLO", 47, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "ICE_BEAM" } },
    } },
    MITCHELL = { partner = "VR_A12", party = {
      { "LUNATONE", 47, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "PSYCHIC", "POWER_GEM", "ICE_BEAM", "TRICK_ROOM" } },
      { "SOLROCK", 47, ability = "LEVITATE", nature = "BRAVE", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "FLARE_BLITZ", "EXPLOSION" } },
    } },
    HALLE = { partner = "VR_A13", party = {
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    EDGAR = { partner = "VR_A14", party = {
      { "CACTURNE", 47, ability = "SAND_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "NEEDLE_ARM", "SUCKER_PUNCH", "SPIKY_SHIELD", "FEINT_ATTACK" } },
      { "PELIPPER", 47, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
    } },
    QUINCY = { partner = "VR_A15", party = {
      { "DUSCLOPS", 47, ability = "FRISK", nature = "RELAXED", spread = "bulk", item = "EVIOLITE", moves = { "SHADOW_SNEAK", "WILL_O_WISP", "TRICK_ROOM", "PAIN_SPLIT" } },
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
    } },
    KATELYNN = { partner = "VR_A16", party = {
      { "GARDEVOIR", 47, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "HYPNOSIS" } },
      { "FLYGON", 47, ability = "LEVITATE", nature = "JOLLY", item = "SOFT_SAND", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
    } },
    -- Wally at the exit of Victory Road: six, alone; Gallade is the ace at 48
    WALLY_VR_1 = { tier = "gym", party = {
      { "ROSERADE", 47, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "TALONFLAME", 47, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "FLARE_BLITZ", "TAILWIND", "QUICK_ATTACK" } },
      { "AZUMARILL", 47, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "MAGNEZONE", 47, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "GARCHOMP", 47, ability = "ROUGH_SKIN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "PROTECT" } },
      { "GALLADE", 48, ability = "JUSTIFIED", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PSYCHO_CUT", "SACRED_SWORD", "SHADOW_SNEAK", "PROTECT" } },
    } },
    -- The Elite Four and Wallace: six each, alone (2-vs-1), aces at the caps
    SIDNEY = { tier = "leader", party = {
      { "SCRAFTY", 49, ability = "INTIMIDATE", nature = "CAREFUL", spread = "spdef", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DRAIN_PUNCH", "KNOCK_OFF", "PROTECT" } },
      { "WEAVILE", 49, ability = "PRESSURE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "KNOCK_OFF", "ICE_SHARD", "ICICLE_CRASH" } },
      { "KROOKODILE", 49, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "CRUNCH", "ROCK_SLIDE", "PROTECT" } },
      { "HONCHKROW", 49, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "BRAVE_BIRD", "SUCKER_PUNCH", "TAILWIND" } },
      { "SHIFTRY", 49, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "EXPLOSION" } },
      { "ABSOL", 50, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "PSYCHO_CUT", "SUCKER_PUNCH", "SWORDS_DANCE" } },
    } },
    PHOEBE = { tier = "leader", party = {
      { "DUSKNOIR", 51, ability = "FRISK", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "SHADOW_PUNCH", "ICE_PUNCH", "TRICK_ROOM", "WILL_O_WISP" } },
      { "GENGAR", 51, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "SLUDGE_BOMB", "HYPNOSIS", "PROTECT" } },
      { "MISMAGIUS", 51, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "TAUNT" } },
      { "BANETTE", 51, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_CLAW", "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP" } },
      { "COFAGRIGUS", 51, ability = "MUMMY", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "WILL_O_WISP", "TRICK_ROOM", "PROTECT" } },
      { "CHANDELURE", 52, ability = "FLASH_FIRE", nature = "QUIET", spread = "stank", item = "SITRUS_BERRY", moves = { "HEAT_WAVE", "SHADOW_BALL", "ENERGY_BALL", "PROTECT" } },
    } },
    GLACIA = { tier = "leader", party = {
      { "ABOMASNOW", 53, ability = "SNOW_WARNING", nature = "QUIET", spread = "stank", item = "SITRUS_BERRY", moves = { "BLIZZARD", "GIGA_DRAIN", "ICE_SHARD", "PROTECT" } },
      { "NINETALES_ALOLAN", 53, ability = "SNOW_CLOAK", nature = "TIMID", spread = "spa", item = "LIGHT_CLAY", moves = { "BLIZZARD", "MOONBLAST", "AURORA_VEIL", "PROTECT" } },
      { "FROSLASS", 53, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "SHADOW_BALL", "WILL_O_WISP", "PROTECT" } },
      { "GLALIE", 53, ability = "REFRIGERATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "EXPLOSION", "CRUNCH", "EARTHQUAKE", "PROTECT" } },
      { "MAMOSWINE", 53, ability = "THICK_FAT", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "EARTHQUAKE", "ICICLE_CRASH", "PROTECT" } },
      { "WALREIN", 54, ability = "THICK_FAT", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "BLIZZARD", "SURF", "ICE_BEAM", "PROTECT" } },
    } },
    DRAKE = { tier = "leader", party = {
      { "FLYGON", 55, ability = "LEVITATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
      { "KINGDRA", 55, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "ALTARIA", 55, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "GARCHOMP", 55, ability = "ROUGH_SKIN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "PROTECT" } },
      { "DRAGONITE", 55, ability = "INNER_FOCUS", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "EXTREME_SPEED", "DRAGON_CLAW", "FIRE_PUNCH", "PROTECT" } },
      { "SALAMENCE", 56, ability = "INTIMIDATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "DRAGON_CLAW", "ROCK_SLIDE", "FLY", "PROTECT" } },
    } },
    WALLACE = { tier = "leader", party = {
      { "PELIPPER", 57, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 57, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "ICE_BEAM" } },
      { "GYARADOS", 57, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "TENTACRUEL", 57, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "WAILORD", 57, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "AMNESIA", "PROTECT" } },
      { "MILOTIC", 58, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    -- Post-game and stragglers: Rusturf Mike, Jagged Pass grunt, S.S. Tidal, Trick House 8 (draft 1, 2026-10-27) ----
    -- Rusturf Tunnel, Verdanturf side: a tag battle at 21
    MIKE_2 = { partner = "RT_GUS", party = {
      { "GRAVELER", 21, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "MACHOP", 21, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    -- Jagged Pass: the grunt at the Magma Hideout entrance fights alone (35)
    GRUNT_JAGGED_PASS = { tier = "grunt", party = {
      { "MIGHTYENA", 35, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
      { "TURTONATOR", 35, ability = "SHELL_ARMOR", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAMETHROWER", "DRAGON_PULSE", "PROTECT", "INCINERATE" } },
      { "CAMERUPT", 34, ability = "SOLID_ROCK", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "YAWN" } },
    } },
    -- Post-game, S.S. Tidal: tag battles at 58-60
    NAOMI = { partner = "SS_ELA", party = {
      { "TSAREENA", 59, ability = "QUEENLY_MAJESTY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "TROP_KICK", "HIGH_JUMP_KICK", "KNOCK_OFF", "RAPID_SPIN" } },
      { "MAWILE", 59, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "PLAY_ROUGH", "SUCKER_PUNCH", "PROTECT" } },
      { "SALAZZLE", 59, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "FLAMETHROWER", "SLUDGE_BOMB", "FAKE_OUT", "PROTECT" } },
    } },
    GARRET = { partner = "SS_REX", party = {
      { "PORYGON2", 60, ability = "TRACE", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "TRI_ATTACK", "ICE_BEAM", "THUNDERBOLT", "TRICK_ROOM" } },
      { "PERSIAN", 59, ability = "TECHNICIAN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FOUL_PLAY", "U_TURN", "TAUNT" } },
      { "STARMIE", 59, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    MICAH = { partner = "SS_MAX", party = {
      { "ARCANINE", 60, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "CRUNCH", "PROTECT" } },
      { "KANGASKHAN", 59, ability = "SCRAPPY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "DOUBLE_HIT", "SUCKER_PUNCH", "PROTECT" } },
    } },
    THOMAS = { partner = "SS_HAL", party = {
      { "SLOWKING", 59, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "CONKELDURR", 60, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "MAGNEZONE", 59, ability = "STURDY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DISCHARGE", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
    } },
    COLTON = { party = {
      { "CLEFABLE", 59, ability = "MAGIC_GUARD", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "FOLLOW_ME", "HELPING_HAND", "PROTECT" } },
      { "PLUSLE", 59, ability = "PLUS", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "DISCHARGE", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "MINUN", 59, ability = "MINUS", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "DISCHARGE", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "AZUMARILL", 60, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    PHILLIP = { partner = "SS_BEN", party = {
      { "MACHAMP", 60, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "WAILORD", 59, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "AMNESIA", "PROTECT" } },
    } },
    LEONARD = { partner = "SS_WES", party = {
      { "GYARADOS", 60, ability = "MOXIE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "HARIYAMA", 59, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    LEA_AND_JED = { party = {
      { "MILTANK", 60, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "MILK_DRINK", "HELPING_HAND", "PROTECT" } },
      { "TAUROS", 60, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "EARTHQUAKE", "PROTECT" } },
    } },
    -- Post-game, Trick House 8: three cooltrainers alone with four (62-63)
    VINCENT = { tier = "gym", party = {
      { "SABLEYE", 62, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "MIENSHAO", 63, ability = "REGENERATOR", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "U_TURN", "DETECT" } },
      { "GLISCOR", 62, ability = "POISON_HEAL", nature = "IMPISH", spread = "bulk", item = "TOXIC_ORB", moves = { "EARTHQUAKE", "ACROBATICS", "KNOCK_OFF", "PROTECT" } },
      { "DARMANITAN", 63, ability = "SHEER_FORCE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "ROCK_SLIDE", "U_TURN", "SUPERPOWER" } },
    } },
    LEROY = { tier = "gym", party = {
      { "TYRANITAR", 63, ability = "SAND_STREAM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "CRUNCH", "EARTHQUAKE", "PROTECT" } },
      { "EXCADRILL", 62, ability = "SAND_RUSH", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
      { "METAGROSS", 63, ability = "CLEAR_BODY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "METEOR_MASH", "ZEN_HEADBUTT", "BULLET_PUNCH", "PROTECT" } },
      { "GARCHOMP", 62, ability = "ROUGH_SKIN", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "PROTECT" } },
    } },
    KEIRA = { tier = "gym", party = {
      { "TOGEKISS", 62, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
      { "HYDREIGON", 63, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DARK_PULSE", "DRAGON_PULSE", "FLAMETHROWER", "PROTECT" } },
      { "ROTOM", 62, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "THUNDERBOLT", "HEX", "WILL_O_WISP", "PROTECT" } },
      { "MILOTIC", 63, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
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
    -- Chapter 5: Lavaridge to Norman (draft 1, 2026-10-27; cap 31): partners ----------------------------------------
    R111N_ROY = { like = "TRAVIS", name = "ROY", defeat = "Dusty boots, dusty loss.", party = {
      { "SANDSHREW", 22, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "SWABLU", 22, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R111N_ADA = { like = "IRENE", name = "ADA", defeat = "Oh, my picnic!", party = {
      { "CHERUBI", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
      { "PICHU", 22, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "NUZZLE", "THUNDER_SHOCK", "SWEET_KISS", "CHARM" } },
    } },
    R111N_ZED = { like = "WILTON_1", name = "ZED", defeat = "Cool under pressure, still lost.", party = {
      { "DUSKULL", 22, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "AXEW", 23, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_RAGE", "BITE", "ASSURANCE", "TAUNT" } },
    } },
    R111N_MAY = { like = "BROOKE_1", name = "MAYA", defeat = "We were so in sync, too.", party = {
      { "STARYU", 22, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "SKIPLOOM", 22, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
    } },
    R111N_KEN = { like = "DAISUKE", name = "KENJI", defeat = "Osu! Respect.", party = {
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "MEDITITE", 22, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    TH2_OLI = { like = "PAUL", name = "OLI", defeat = "Lost in here AND lost the battle.", party = {
      { "HORSEA", 24, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
      { "PIKACHU", 24, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    TH2_ABI = { like = "TED", name = "ABI", defeat = "The Trick Master would laugh at us.", party = {
      { "SPOINK", 24, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "LEDIAN", 25, ability = "EARLY_BIRD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
    } },
    TH2_ZAC = { like = "GEORGIA", name = "ZAC", defeat = "We got tricked by you!", party = {
      { "VOLBEAT", 24, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
      { "ILLUMISE", 24, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    DES_RAE = { like = "DUSTY_1", name = "RAE", defeat = "The ruins keep their secrets.", party = {
      { "BALTOY", 27, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
      { "HIPPOPOTAS", 27, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "YAWN", "SAND_TOMB" } },
    } },
    DES_HAL = { like = "DREW", name = "HAL", defeat = "Buried in sand!", party = {
      { "TRAPINCH", 28, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "HIPPOPOTAS", 27, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "BULLDOZE", "BITE", "YAWN", "SAND_TOMB" } },
    } },
    DES_IKE = { like = "BEAU", name = "IKE", defeat = "Sandblasted.", party = {
      { "DRILBUR", 27, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "BULLDOZE", "RAPID_SPIN", "HONE_CLAWS" } },
      { "SHELLOS", 28, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "HIDDEN_POWER" } },
    } },
    DES_FLO = { like = "HEIDI", name = "FLO", defeat = "Goggles fogged up, sorry!", party = {
      { "MARACTUS", 28, ability = "WATER_ABSORB", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "PIN_MISSILE", "SYNTHESIS", "SWEET_SCENT" } },
      { "SANDILE", 27, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
    } },
    DES_LEA = { like = "BECKY", name = "LEA", defeat = "Too hot, too cold, too strong.", party = {
      { "SKIPLOOM", 27, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
      { "CACNEA", 28, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    DES_NIA = { like = "CELIA", name = "NIA", defeat = "The desert dried out our hopes.", party = {
      { "SANDSHREW", 27, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "HIPPOPOTAS", 27, ability = "SAND_STREAM", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "BULLDOZE", "BITE", "YAWN", "SAND_TOMB" } },
    } },
    DES_OTT = { like = "BRYAN", name = "OTTO", defeat = "Unearthed and defeated.", party = {
      { "ANORITH", 28, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "HARD_STONE", moves = { "ANCIENT_POWER", "FURY_CUTTER", "METAL_CLAW", "PROTECT" } },
      { "LILEEP", 27, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    DES_GIL = { like = "BRANDEN", name = "GILL", defeat = "Lost in the dunes.", party = {
      { "SANDILE", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
      { "SANDSLASH", 27, ability = "SAND_RUSH", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
    } },
    TH3_MO = { like = "JUSTIN", name = "MO", defeat = "I can see the exit from here!", party = {
      { "NUMEL", 27, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "SWABLU", 27, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    TH3_BO = { like = "MARTHA", name = "BOE", defeat = "Third time is not a charm.", party = {
      { "GLAMEOW", 27, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "FEINT_ATTACK", "CHARM" } },
      { "SPOINK", 28, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    TH3_AL = { like = "ALAN", name = "AL", defeat = "Hard as rock, soft as sand.", party = {
      { "GRAVELER", 28, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "MACHOKE", 27, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
    } },
    -- Chapter 6a: sea routes, ship, Route 115 north, Route 118, Trick House 4 (draft 1, 2026-10-27): partners ----------------------------------------
    R118_IKE = { like = "WADE", name = "IKE", defeat = "Big one got away.", party = {
      { "TENTACOOL", 21, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "WINGULL", 22, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    R118_POE = { like = "DEANDRE", name = "POE", defeat = "Dug ourselves a hole there.", party = {
      { "DRILBUR", 22, ability = "MOLD_BREAKER", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "BULLDOZE", "RAPID_SPIN", "HONE_CLAWS" } },
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R118_IVY = { like = "ROSE_1", name = "IVY", defeat = "The petals scattered.", party = {
      { "COMBEE", 22, ability = "HONEY_GATHER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "GUST", "BUG_BITE", "SWEET_SCENT", "BUG_BUZZ" } },
      { "ROSELIA", 21, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    R118_REX = { like = "DALTON_1", name = "REX", defeat = "Encore? No thanks.", party = {
      { "KRICKETUNE", 22, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "ELECTRIKE", 21, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    SEA_ORR = { like = "LUIS", name = "ORR", defeat = "Glub glub, we lost.", party = {
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
    } },
    SEA_GIL = { like = "DOMINIK", name = "GIL", defeat = "Sank like a stone.", party = {
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "BUIZEL", 28, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "SWIFT", "PURSUIT" } },
    } },
    SEA_JON = { like = "DOUGLAS", name = "JON", defeat = "Cramp! I lost!", party = {
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "SEEL", 28, ability = "HYDRATION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ICY_WIND", "HEADBUTT", "ENCORE" } },
    } },
    SEA_AMY = { like = "BEVERLY", name = "AMY", defeat = "Washed ashore again.", party = {
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SEA_ZOE = { like = "IMANI", name = "ZOE", defeat = "Too tired to swim back.", party = {
      { "GOLDEEN", 28, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SEA_FAY = { like = "KYLA", name = "FAY", defeat = "The current took us.", party = {
      { "LUVDISC", 28, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "CORSOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
    } },
    SEA_RAE = { like = "FOSTER", name = "RAE", defeat = "History repeats: we lost.", party = {
      { "BALTOY", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
      { "KABUTO", 28, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ANCIENT_POWER", "MUD_SHOT", "PROTECT" } },
    } },
    SEA_OTT = { like = "ANDRES_1", name = "OTTO", defeat = "Fossilized in defeat.", party = {
      { "ANORITH", 28, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "HARD_STONE", moves = { "ANCIENT_POWER", "FURY_CUTTER", "METAL_CLAW", "PROTECT" } },
      { "LILEEP", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    SEA_SKY = { like = "JOSUE", name = "SKY", defeat = "Clipped our wings.", party = {
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "SWABLU", 28, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    SEA_KIM = { like = "TARA", name = "KIM", defeat = "I need a lifeguard.", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_LEO = { like = "DARRIN", name = "LEO", defeat = "Gulls and jellies, all beaten.", party = {
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    SEA_MAC = { like = "TONY_1", name = "MAC", defeat = "Out-swum!", party = {
      { "BASCULIN", 28, ability = "ADAPTABILITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AQUA_JET", "BITE", "CHIP_AWAY", "TAIL_WHIP" } },
      { "CORPHISH", 28, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },
    SEA_HAL = { like = "JEROME", name = "HAL", defeat = "Brr, and beaten.", party = {
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    SEA_DUN = { like = "MATTHEW", name = "DUNN", defeat = "Riding the wave out.", party = {
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "CHINCHOU", 28, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "SPARK", "THUNDER_WAVE", "CONFUSE_RAY" } },
    } },
    SEA_ELA = { like = "DENISE", name = "ELA", defeat = "My goggles are full of water.", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "FINNEON", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "GUST", "ICY_WIND", "PROTECT" } },
    } },
    SEA_BEN = { like = "CORY_1", name = "BEN", defeat = "Aye, we sank.", party = {
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "PELIPPER", 28, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    SEA_LIA = { like = "MISSY", name = "LIA", defeat = "Pearls before swine...", party = {
      { "LUVDISC", 28, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_PIA = { like = "CAROLINA", name = "PIA", defeat = "Cool heads, hot loss.", party = {
      { "GOLDUCK", 29, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "LUXIO", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "MAGNET", moves = { "SPARK", "CRUNCH", "DOUBLE_KICK", "LEER" } },
    } },
    SEA_UMA = { like = "BETH", name = "UMA", defeat = "Swam into a wall.", party = {
      { "SEEL", 29, ability = "HYDRATION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ICY_WIND", "HEADBUTT", "ENCORE" } },
      { "HORSEA", 29, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    SEA_TOD = { like = "CAMRON", name = "TOD", defeat = "Last leg, lost leg.", party = {
      { "BUIZEL", 29, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "SWIFT", "PURSUIT" } },
      { "PIKACHU", 29, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    SHIP_BO = { like = "JANI", name = "BO", defeat = "This ship is spooky AND I lost!", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SHIP_WES = { like = "DUNCAN", name = "WES", defeat = "Abandon ship!", party = {
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "KRABBY", 28, ability = "HYPER_CUTTER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "MUD_SHOT", "STOMP", "PROTECT" } },
    } },
    SHIP_RIO = { like = "GARRISON", name = "RIO", defeat = "Sunk treasure, sunk hopes.", party = {
      { "KABUTO", 28, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ANCIENT_POWER", "MUD_SHOT", "PROTECT" } },
      { "BALTOY", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
    } },
    SHIP_DOT = { like = "CHARLIE", name = "DOT", defeat = "Waaah, my floatie!", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SHIP_LIV = { like = "THALIA_1", name = "LIV", defeat = "How dreadfully unfashionable.", party = {
      { "SWIRLIX", 28, ability = "SWEET_VEIL", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "COTTON_SPORE", "PLAY_NICE" } },
      { "GLAMEOW", 28, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "FEINT_ATTACK", "CHARM" } },
    } },
    SHIP_KIP = { like = "DEMETRIUS", name = "KIP", defeat = "Ghosts AND you? No fair.", party = {
      { "SHUPPET", 28, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "DUSKULL", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    R109S_ANN = { like = "GWEN", name = "ANNE", defeat = "I want my mommy!", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R109S_EVE = { like = "ALICE", name = "EVE", defeat = "Sea salt and sore losses.", party = {
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    R109S_KIT = { like = "AUSTINA", name = "KIT", defeat = "Splash! I lost.", party = {
      { "AZURILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUBBLE", "SLAM", "CHARM", "HELPING_HAND" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    R109S_GUS = { like = "DAVID", name = "GUS", defeat = "Swept away!", party = {
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "CARVANHA", 28, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
    } },
    R109S_NED = { like = "CARTER", name = "NED", defeat = "Line snapped.", party = {
      { "GOLDEEN", 28, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
      { "WHISCASH", 28, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
    } },
    R109S_ACE = { like = "ELIJAH", name = "ACE", defeat = "Grounded!", party = {
      { "PELIPPER", 28, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "SWELLOW", 28, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
    } },
    R103S_MEG = { like = "ISABELLE", name = "MEG", defeat = "Out of breath!", party = {
      { "LUVDISC", 28, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    R103S_SAM = { like = "PETE", name = "SAMI", defeat = "Gulp. Lost.", party = {
      { "SQUIRTLE", 28, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "BITE", "PROTECT", "RAPID_SPIN" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R115N_DAN = { like = "KOICHI", name = "DAN", defeat = "Our fists were not enough.", party = {
      { "MACHOKE", 28, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "MEDITITE", 28, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    R115N_JO = { like = "KYRA", name = "JO", defeat = "Finish line? What finish line?", party = {
      { "PONYTA", 28, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
      { "STARAVIA", 28, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    R115N_KO = { like = "JAIDEN", name = "KOTA", defeat = "Vanished... in defeat.", party = {
      { "GRIMER", 28, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
      { "ZUBAT", 28, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R115N_VIC = { like = "ALIX", name = "VIC", defeat = "My dreams said we would win.", party = {
      { "NATU", 28, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "NIGHT_SHADE", "TAILWIND", "CONFUSE_RAY" } },
      { "SPOINK", 28, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115N_ROX = { like = "HELENE", name = "ROX", defeat = "Hyah... we lost.", party = {
      { "MIENFOO", 28, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LOW_SWEEP", "U_TURN", "DETECT" } },
      { "CROAGUNK", 28, ability = "DRY_SKIN", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "SUCKER_PUNCH", "TAUNT" } },
    } },
    R115N_KEN = { like = "TIMOTHY_1", name = "KENT", defeat = "Expertly beaten.", party = {
      { "MACHOKE", 28, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "KIRLIA", 28, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    R118E_HAL = { like = "BARNY", name = "HALE", defeat = "Caught nothing but defeat.", party = {
      { "WHISCASH", 29, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
      { "GOLDEEN", 29, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
    } },
    R118E_JAY = { like = "PERRY", name = "JAY", defeat = "Ruffled feathers all around.", party = {
      { "SWABLU", 29, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "TAILLOW", 29, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R118E_KAY = { like = "CHESTER", name = "KAY", defeat = "Shot down!", party = {
      { "SKARMORY", 29, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
      { "NOCTOWL", 29, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "CONFUSION", "HYPNOSIS", "REFLECT" } },
    } },
    TH4_ZIA = { like = "CORA", name = "ZIA", defeat = "Tricked AND punched.", party = {
      { "MAKUHITA", 29, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "RIOLU", 29, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FORCE_PALM", "QUICK_ATTACK", "METAL_CLAW", "FEINT" } },
    } },
    TH4_MAE = { like = "PAULA", name = "MAE", defeat = "Strength wasn't the answer.", party = {
      { "MACHOKE", 29, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "MIENFOO", 29, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LOW_SWEEP", "U_TURN", "DETECT" } },
    } },
    TH4_GOR = { like = "YUJI", name = "GORO", defeat = "Oss! Defeated!", party = {
      { "SAWK", 29, ability = "STURDY", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "KARATE_CHOP", "ROCK_TOMB", "COUNTER" } },
      { "THROH", 29, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SEISMIC_TOSS", "VITAL_THROW", "BULK_UP", "ROCK_TOMB" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34): partners ----------------------------------------
    R119_BO = { like = "CHRIS", name = "BO", defeat = "Rain or shine, we lose.", party = {
      { "WHISCASH", 30, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
      { "LOTAD", 30, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R119_GUS = { like = "DONALD", name = "GUS", defeat = "My net has a hole in it.", party = {
      { "NINCADA", 30, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
      { "SURSKIT", 30, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "QUICK_ATTACK", "SWEET_SCENT", "AGILITY" } },
    } },
    R119_TED = { like = "TAYLOR", name = "TED", defeat = "Squashed in the grass.", party = {
      { "KRICKETUNE", 30, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "SCYTHER", 30, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "WING_ATTACK", "FALSE_SWIPE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
    } },
    R119_CY = { like = "HUGH", name = "CY", defeat = "Feathers everywhere.", party = {
      { "PIDGEOTTO", 30, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "TAILLOW", 30, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R119_KO = { like = "YASU", name = "KOTA", defeat = "We vanish... in shame.", party = {
      { "NINJASK", 30, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "GRIMER", 30, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R119_LIL = { like = "DOUG", name = "LIL", defeat = "Bugged out!", party = {
      { "JOLTIK", 30, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
      { "DUSTOX", 30, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SILVER_WIND", "CONFUSION", "MOONLIGHT", "PROTECT" } },
    } },
    R119_PIP = { like = "GREG", name = "PIP", defeat = "My bugs got stomped.", party = {
      { "BEAUTIFLY", 30, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "MEGA_DRAIN", "STUN_SPORE", "ATTRACT" } },
      { "SPINARAK", 30, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_FANG", "SHADOW_SNEAK", "INFESTATION", "STRING_SHOT" } },
    } },
    R119_SKY = { like = "PHIL", name = "SKYE", defeat = "Grounded by the rain.", party = {
      { "SWELLOW", 30, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "SWABLU", 30, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R119_ZEN = { like = "TAKASHI", name = "ZEN", defeat = "Defeated in silence.", party = {
      { "SHUPPET", 30, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "NINJASK", 30, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
    } },
    R119_RAN = { like = "JACKSON_1", name = "RANDY", defeat = "Protect the wild... from you.", party = {
      { "TROPIUS", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
      { "LINOONE", 30, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R119_WEN = { like = "CATHERINE_1", name = "WEN", defeat = "Nature wins. Wait, no, you do.", party = {
      { "KECLEON", 30, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
      { "ODDISH", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R119_ABE = { like = "KENT", name = "ABE", defeat = "We bugged out.", party = {
      { "VOLBEAT", 30, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
      { "ILLUMISE", 30, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    R119_JIN = { like = "HIDEO", name = "JIN", defeat = "Our shuriken missed.", party = {
      { "KOFFING", 30, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "ZUBAT", 30, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R119_JAX = { like = "FABIAN", name = "JAX", defeat = "Unplugged.", party = {
      { "LOUDRED", 30, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "BITE", "STOMP", "SUPERSONIC" } },
      { "ELECTRIKE", 30, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    R119_ASH = { like = "DAYTON", name = "ASH", defeat = "The rain put out our fire.", party = {
      { "NUMEL", 30, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "HOUNDOUR", 30, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "INCINERATE", "FEINT_ATTACK", "SMOG", "HOWL" } },
    } },
    R119_UMA = { like = "RACHEL", name = "UMA", defeat = "My parasol couldn't stop that.", party = {
      { "ROSELIA", 30, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
      { "PSYDUCK", 30, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R119_DON = { like = "BRENT", name = "DONN", defeat = "Cocooned in defeat.", party = {
      { "ILLUMISE", 30, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
      { "JOLTIK", 30, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },
    R120_RAE = { like = "CHIP", name = "RAE", defeat = "The ruins weren't on our side.", party = {
      { "RELICANTH", 31, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "SOLROCK", 31, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "MORNING_SUN" } },
    } },
    R120_GUS = { like = "JEFFREY_1", name = "GUSS", defeat = "Swatted!", party = {
      { "SCYTHER", 31, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "WING_ATTACK", "FALSE_SWIPE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "JOLTIK", 31, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },
    R120_SKY = { like = "COLIN", name = "SKY", defeat = "Flew straight into defeat.", party = {
      { "SWELLOW", 31, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "SWABLU", 31, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R120_KO = { like = "KEIGO", name = "KO", defeat = "Our smoke bomb fizzled.", party = {
      { "NINJASK", 31, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "SHUPPET", 31, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R120_ACE = { like = "ROBERT_1", name = "ACE", defeat = "Clipped!", party = {
      { "TRANQUILL", 31, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "AIR_CUTTER", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "NOCTOWL", 31, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R120_NIA = { like = "CLARISSA", name = "NIA", defeat = "Our garden party is ruined.", party = {
      { "BELLOSSOM", 31, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "SKIPLOOM", 31, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND" } },
    } },
    R120_PIA = { like = "ANGELICA", name = "PIA", defeat = "Under the weather today.", party = {
      { "SPOINK", 31, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "CHIMECHO", 31, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R120_RAN = { like = "LORENZO", name = "RANN", defeat = "The wild ones won today.", party = {
      { "KECLEON", 31, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
      { "STARMIE", 31, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
    } },
    R120_WEN = { like = "JENNA", name = "WENDA", defeat = "Rangers retreat!", party = {
      { "ABSOL", 31, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "CLOYSTER", 31, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R120_JIN = { like = "RILEY", name = "JINN", defeat = "Outwitted...", party = {
      { "ACCELGOR", 31, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "QUICK_ATTACK", "DOUBLE_TEAM" } },
      { "GOLBAT", 31, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
    } },
    R120_ROX = { like = "CALLIE", name = "ROXY", defeat = "Hyaah! We'll be back!", party = {
      { "HARIYAMA", 31, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "HAWLUCHA", 31, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
    } },
    R120_MAX = { like = "JENNIFER", name = "MAXI", defeat = "Cool trainers, cold loss.", party = {
      { "ABSOL", 31, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "BOUFFALANT", 31, ability = "SAP_SIPPER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HEADBUTT", "REVENGE", "PURSUIT", "FOCUS_ENERGY" } },
    } },
    R120_LEO = { like = "LEONEL", name = "LEON", defeat = "A shocking result.", party = {
      { "CHARJABUG", 31, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
      { "KECLEON", 31, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    -- Chapter 7a: Routes 121-123, Mt. Pyre, Lilycove rival (draft 1, 2026-10-27; cap 35): partners ----------------------------------------
    R121_ANN = { like = "JESSICA_1", name = "ANNA", defeat = "How utterly unbeautiful.", party = {
      { "GLAMEOW", 32, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "FEINT_ATTACK", "CHARM" } },
      { "ROSELIA", 32, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    R121_GUS = { like = "CALE", name = "GUSS", defeat = "Our cocoons cracked.", party = {
      { "DUSTOX", 32, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SILVER_WIND", "CONFUSION", "MOONLIGHT", "PROTECT" } },
      { "NINJASK", 32, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
    } },
    R121_WEN = { like = "TAMMY", name = "WEN", defeat = "The spirits abandoned us.", party = {
      { "DUSKULL", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "DRIFLOON", 32, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "HEX", "TAILWIND", "WILL_O_WISP" } },
    } },
    R121_MAX = { like = "WALTER_1", name = "MAX", defeat = "A gentleman loses graciously.", party = {
      { "PERSIAN", 32, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FURY_SWIPES", "BITE", "TAUNT" } },
      { "KECLEON", 32, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    R121_PIA = { like = "VANESSA", name = "PIA", defeat = "My darlings, are you all right?", party = {
      { "CLEFAIRY", 32, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FOLLOW_ME", "DISARMING_VOICE", "ENCORE", "SING" } },
      { "PLUSLE", 32, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
    } },
    R121_TOD = { like = "MARCEL", name = "TODD", defeat = "Cool as ever. Beaten as ever.", party = {
      { "ABSOL", 32, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "STARAVIA", 32, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    R121_ROX = { like = "CRISTIN_1", name = "ROXA", defeat = "Oof, too cool for us.", party = {
      { "SPOINK", 32, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "MIGHTYENA", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
    } },
    PYRE_DAN = { like = "ZANDER", name = "DANE", defeat = "The mountain humbles us.", party = {
      { "MAKUHITA", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "MEDITITE", 33, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "DETECT" } },
    } },
    PYRE_ELI = { like = "LEAH", name = "ELI", defeat = "The graves are restless...", party = {
      { "SHUPPET", 33, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "DUSKULL", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    PYRE_NIA = { like = "VALERIE_1", name = "NIA", defeat = "Rest in peace... us.", party = {
      { "MISDREAVUS", 33, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "HEX", "PSYBEAM", "CONFUSE_RAY", "PAIN_SPLIT" } },
      { "LITWICK", 33, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "HEX", "WILL_O_WISP", "MINIMIZE" } },
    } },
    PYRE_ZIA = { like = "TASHA", name = "ZIA", defeat = "Hee hee... we lost.", party = {
      { "SHUPPET", 33, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "PHANTUMP", 33, ability = "NATURAL_CURE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ASTONISH", "LEECH_SEED", "CONFUSE_RAY", "FEINT_ATTACK" } },
    } },
    PYRE_OTT = { like = "MARK", name = "OTTO", defeat = "Rare finds, common loss.", party = {
      { "SNORLAX", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BODY_SLAM", "BITE", "AMNESIA", "REST" } },
      { "DRATINI", 33, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "TWISTER", "THUNDER_WAVE", "AGILITY" } },
    } },
    PYRE_GOR = { like = "ATSUSHI", name = "GORO", defeat = "Hrr! Bested!", party = {
      { "THROH", 33, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SEISMIC_TOSS", "VITAL_THROW", "BULK_UP", "ROCK_TOMB" } },
      { "SAWK", 33, ability = "STURDY", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "KARATE_CHOP", "ROCK_TOMB", "COUNTER" } },
    } },
    PYRE_VIC = { like = "WILLIAM", name = "VICK", defeat = "I sensed a different outcome.", party = {
      { "KADABRA", 33, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "CHIMECHO", 33, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    PYRE_IVY = { like = "KAYLA", name = "IVY", defeat = "The future was foggy.", party = {
      { "NATU", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "NIGHT_SHADE", "TAILWIND", "CONFUSE_RAY" } },
      { "SPOINK", 33, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    PYRE_LEO = { like = "CEDRIC", name = "LEO", defeat = "Not even my mind could save us.", party = {
      { "KIRLIA", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "BALTOY", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "ANCIENT_POWER", "ROCK_TOMB", "REFLECT" } },
    } },
    R123_FAY = { like = "VIOLET", name = "FAYE", defeat = "The berries were sweeter than this.", party = {
      { "BELLOSSOM", 32, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "CHERUBI", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "LEECH_SEED", "MORNING_SUN" } },
    } },
    R123_GUS = { like = "DAVIS", name = "GUSTAV", defeat = "Squashed!", party = {
      { "HERACROSS", 32, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "HORN_ATTACK", "ARM_THRUST", "NIGHT_SLASH", "COUNTER" } },
      { "BEEDRILL", 32, ability = "SWARM", nature = "JOLLY", item = "POISON_BARB", moves = { "TWINEEDLE", "DRILL_PECK", "AGILITY", "PROTECT" } },
    } },
    R123_MAX = { like = "JAZMYN", name = "MAXINE", defeat = "Cooled off for good.", party = {
      { "SCYTHER", 33, ability = "TECHNICIAN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "WING_ATTACK", "FALSE_SWIPE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "ESPEON", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SWIFT", "QUICK_ATTACK", "MORNING_SUN" } },
    } },
    R123_SKY = { like = "ALBERTO", name = "SKYLER", defeat = "Feathers fly, we fall.", party = {
      { "SWELLOW", 33, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "NOCTOWL", 33, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R123_DON = { like = "ED", name = "DONNY", defeat = "Another hole in the collection.", party = {
      { "LICKITUNG", 33, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROLLOUT", "KNOCK_OFF", "STOMP", "DEFENSE_CURL" } },
      { "KECLEON", 33, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    R123_ZEN = { like = "KINDRA", name = "ZENNA", defeat = "Curses...", party = {
      { "DRIFLOON", 33, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "HEX", "TAILWIND", "WILL_O_WISP" } },
      { "SHUPPET", 33, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R123_JAX = { like = "FERNANDO_1", name = "JAXON", defeat = "The crowd went home.", party = {
      { "LOUDRED", 33, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "BITE", "STOMP", "SUPERSONIC" } },
      { "MANECTRIC", 33, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
    } },
    R123_VIC = { like = "CAMERON_1", name = "VICKI", defeat = "My visions were wrong.", party = {
      { "LUNATONE", 33, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "ROCK_SLIDE", "HYPNOSIS", "COSMIC_POWER" } },
      { "KADABRA", 33, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    R123_IVY = { like = "JACKI_1", name = "IVA", defeat = "Dreams don't always come true.", party = {
      { "GARDEVOIR", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "HYPNOSIS" } },
      { "SPOINK", 33, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R123_KEN = { like = "FREDRICK", name = "KENNY", defeat = "An expert knows when he's beaten.", party = {
      { "HARIYAMA", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "SKARMORY", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STEEL_WING", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
    } },
    R123_ACE = { like = "BRAXTON", name = "ACE", defeat = "Cool down, cool out.", party = {
      { "MANECTRIC", 33, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "TRAPINCH", 33, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
    } },
    R123_ELA = { like = "WENDY", name = "ELLA", defeat = "Out-cooled.", party = {
      { "KIRLIA", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "ZANGOOSE", 33, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "FACADE", "CRUSH_CLAW", "QUICK_ATTACK", "HONE_CLAWS" } },
    } },
    R123_KO = { like = "JONAS", name = "KOJI", defeat = "Into the shadows we go.", party = {
      { "NINJASK", 33, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "GRIMER", 33, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R123_UMA = { like = "KAYLEY", name = "UMI", defeat = "What a dreary day for it.", party = {
      { "SUNFLORA", 33, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "RAZOR_LEAF", "GROWTH", "HELPING_HAND" } },
      { "TOGETIC", 33, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    -- Chapter 7b: Magma and Aqua Hideouts (draft 1, 2026-10-27; caps 36, 37, 38): partners ----------------------------------------
    -- Chapter 7c: Routes 124-125, Mossdeep, Space Center (draft 1, 2026-10-27; cap 42): partners ----------------------------------------
    R124_LEO = { like = "CHAD", name = "LEO", defeat = "Washed up on Mossdeep.", party = {
      { "WAILMER", 38, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "SEALEO", 38, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "BRINE", "DEFENSE_CURL", "ENCORE" } },
    } },
    R124_MIA = { like = "JENNY_1", name = "MIA", defeat = "Out of air!", party = {
      { "LUVDISC", 38, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "PELIPPER", 38, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
    } },
    R124_GIL = { like = "DECLAN", name = "GILL", defeat = "Dragged under.", party = {
      { "SHARPEDO", 38, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "CLOYSTER", 38, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R124_HAL = { like = "SPENCER", name = "HALL", defeat = "Drifted off course.", party = {
      { "QUAGSIRE", 38, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "STARMIE", 38, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R124_DUN = { like = "ROLAND", name = "DUNN", defeat = "Sunk by the sea itself.", party = {
      { "KINGLER", 38, ability = "HYPER_CUTTER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "STOMP", "KNOCK_OFF", "PROTECT" } },
      { "TENTACRUEL", 38, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "WRAP" } },
    } },
    R124_LIA = { like = "GRACE", name = "LIA", defeat = "The current won.", party = {
      { "HUNTAIL", 38, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "SEAKING", 38, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
    } },
    R124_TOD = { like = "ISABELLA", name = "TODD", defeat = "Last lap, last place.", party = {
      { "FLOATZEL", 38, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "DOUBLE_HIT", "CRUNCH", "PURSUIT" } },
      { "STARAVIA", 38, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "REVENGE" } },
    } },
    R125_JON = { like = "NOLEN", name = "JONAH", defeat = "Tide's against me.", party = {
      { "GOLDUCK", 38, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
      { "SHARPEDO", 38, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R125_AMY = { like = "TANYA", name = "AMIE", defeat = "Too tired to keep kicking.", party = {
      { "DEWGONG", 38, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "CORSOLA", 38, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R125_BEN = { like = "ERNEST_1", name = "BENN", defeat = "Aye, ye beat us fair.", party = {
      { "WAILORD", 38, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "PELIPPER", 38, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "WATER_PULSE", "TAILWIND", "PROTECT" } },
    } },
    R125_MAC = { like = "STAN", name = "MACK", defeat = "Kelp in my hair, loss on my record.", party = {
      { "LANTURN", 38, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "CLAWITZER", 38, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "DARK_PULSE", "DRAGON_PULSE", "PROTECT" } },
    } },
    R125_SKY = { like = "PRESLEY", name = "SKYE", defeat = "Grounded at sea.", party = {
      { "PELIPPER", 38, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "SWELLOW", 38, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
    } },
    R125_ELA = { like = "SHARON", name = "ELA", defeat = "Glub.", party = {
      { "GOREBYSS", 38, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "LUMINEON", 38, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
    } },
    R125_KEN = { like = "AURON", name = "KENJI", defeat = "Expertly sunk.", party = {
      { "HARIYAMA", 39, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "ELECTRODE", 39, ability = "ELECTRIC_SURGE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DISCHARGE", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    TH6_SKY = { like = "BENNY", name = "SKAI", defeat = "The Trick Master tricked us both.", party = {
      { "NOCTOWL", 39, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "STARAPTOR", 39, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "CLOSE_COMBAT", "QUICK_ATTACK", "TAILWIND" } },
    } },
    TH6_RAN = { like = "SEBASTIAN", name = "RANDALL", defeat = "Lost in the maze AND the battle.", party = {
      { "ABSOL", 39, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "PSYCHO_CUT", "SUCKER_PUNCH", "DETECT" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    TH6_WEN = { like = "SOPHIA", name = "WENDA", defeat = "Even the walls laughed.", party = {
      { "TROPIUS", 39, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "ENERGY_BALL", "GROWTH", "SWEET_SCENT" } },
      { "SHIFTRY", 39, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    -- Chapter 8: Mossdeep to Juan (draft 1, 2026-10-27; caps 43, 44, 46): partners ----------------------------------------
    R126_TOD = { like = "CAMDEN", name = "CORA", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "GOLDUCK", 40, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    R126_ACE = { like = "PABLO_1", name = "GILL", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 42, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "LAPRAS", 41, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    R126_LIA = { like = "BRENDA", name = "LIA", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 41, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 40, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
    } },
    R126_GIL = { like = "BARRY", name = "GIL", defeat = "The sea floor's colder than this loss.", party = {
      { "FLOATZEL", 42, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_JON = { like = "DEAN", name = "JON", defeat = "The sea floor's colder than this loss.", party = {
      { "TENTACRUEL", 42, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "CRAWDAUNT", 41, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    R126_SKY = { like = "ISAIAH_1", name = "SKY", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILMER", 42, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SHARPEDO", 41, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R126_MIA = { like = "ISOBEL", name = "MIA", defeat = "The sea floor's colder than this loss.", party = {
      { "SEALEO", 42, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "STARMIE", 41, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R126_DUN = { like = "DONNY", name = "DUN", defeat = "The sea floor's colder than this loss.", party = {
      { "AZUMARILL", 42, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "LANTURN", 41, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    R126_ELA = { like = "KATELYN_1", name = "ELA", defeat = "The sea floor's colder than this loss.", party = {
      { "LUMINEON", 42, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
      { "ALOMOMOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    R126_AMY = { like = "NIKKI", name = "AMY", defeat = "The sea floor's colder than this loss.", party = {
      { "KINGDRA", 42, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "MANTINE", 41, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    R126_KIM = { like = "SIENNA", name = "KIM", defeat = "The sea floor's colder than this loss.", party = {
      { "DEWGONG", 41, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "CLOYSTER", 40, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R126_PIA = { like = "CARLEE", name = "PIA", defeat = "The sea floor's colder than this loss.", party = {
      { "GOREBYSS", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "JELLICENT", 40, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    R126_LEO = { like = "LEONARDO", name = "LEO", defeat = "The sea floor's colder than this loss.", party = {
      { "RELICANTH", 42, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "MILOTIC", 41, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    R126_MAX = { like = "ATHENA", name = "MAX", defeat = "The sea floor's colder than this loss.", party = {
      { "POLIWRATH", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "GASTRODON", 41, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    R126_BEN = { like = "HARRISON", name = "BEN", defeat = "The sea floor's colder than this loss.", party = {
      { "SLOWKING", 41, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "VAPOREON", 40, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R126_HAL = { like = "JONAH", name = "HAL", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "GOLDUCK", 40, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    R126_NED = { like = "HENRY", name = "NED", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 42, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "LAPRAS", 41, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    R126_MAC = { like = "ROGER", name = "MAC", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 41, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
    } },
    R126_KEN = { like = "KOJI_1", name = "KEN", defeat = "The sea floor's colder than this loss.", party = {
      { "FLOATZEL", 42, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_WES = { like = "WAYNE", name = "WES", defeat = "The sea floor's colder than this loss.", party = {
      { "TENTACRUEL", 41, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "CRAWDAUNT", 40, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    R126_SKY2 = { like = "AIDAN", name = "SKAI", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILMER", 42, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SHARPEDO", 41, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R126_ANN = { like = "ALEXA", name = "ANN", defeat = "The sea floor's colder than this loss.", party = {
      { "SEALEO", 42, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "STARMIE", 41, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R126_RAN = { like = "RUBEN", name = "RAN", defeat = "The sea floor's colder than this loss.", party = {
      { "AZUMARILL", 42, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "LANTURN", 41, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    R130_LEO = { like = "FRANKLIN", name = "LEO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "LUMINEON", 43, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
      { "ALOMOMOLA", 42, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    R130_BO = { like = "JACK", name = "BO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "KINGDRA", 43, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "MANTINE", 42, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    R130_KEN = { like = "HITOSHI", name = "KEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "DEWGONG", 44, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "CLOYSTER", 43, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R130_GOR = { like = "KIYO", name = "GORO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "JELLICENT", 43, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    R130_SKY = { like = "ALEX", name = "SKY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "MILOTIC", 43, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    R130_ACE = { like = "BECK", name = "ACE", defeat = "Pacifidlog is a long swim from here.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "GASTRODON", 43, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    R130_AMY = { like = "DEBRA", name = "AMY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "SLOWKING", 43, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "VAPOREON", 42, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R130_LIA = { like = "LINDA", name = "LIA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "GOLDUCK", 43, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    R130_ELA = { like = "LAUREL", name = "ELA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "QUAGSIRE", 43, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "LAPRAS", 42, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    R130_WES = { like = "KELVIN", name = "WES", defeat = "Pacifidlog is a long swim from here.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 43, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
    } },
    R130_ROX = { like = "REYNA", name = "ROX", defeat = "Pacifidlog is a long swim from here.", party = {
      { "FLOATZEL", 44, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "CORSOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R130_BEN = { like = "HUDSON", name = "BEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "TENTACRUEL", 44, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "CRAWDAUNT", 43, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    R131_GIL = { like = "RODNEY", name = "GIL", defeat = "Caught in the currents.", party = {
      { "WAILMER", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SHARPEDO", 43, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R131_JON = { like = "RICHARD", name = "JON", defeat = "Caught in the currents.", party = {
      { "SEALEO", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "STARMIE", 43, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R131_HAL = { like = "SANTIAGO", name = "HAL", defeat = "Caught in the currents.", party = {
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "LANTURN", 43, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    R131_MAC = { like = "GILBERT", name = "MAC", defeat = "Caught in the currents.", party = {
      { "LUMINEON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
      { "ALOMOMOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    R131_DUN = { like = "KEVIN", name = "DUN", defeat = "Caught in the currents.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "MANTINE", 43, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    R131_SKY = { like = "CHASE", name = "SKY", defeat = "Caught in the currents.", party = {
      { "DEWGONG", 44, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "CLOYSTER", 43, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R131_PIA = { like = "TALIA", name = "PIA", defeat = "Caught in the currents.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "JELLICENT", 43, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    R131_TOD = { like = "ALLISON", name = "TOD", defeat = "Caught in the currents.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "MILOTIC", 43, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    R132_KIM = { like = "KATIE", name = "KIM", defeat = "Even the fish feel sorry for us.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "GASTRODON", 43, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    R132_ZOE = { like = "KARA", name = "ZOE", defeat = "Even the fish feel sorry for us.", party = {
      { "SLOWKING", 44, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "VAPOREON", 43, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R132_MIA = { like = "DANA", name = "MIA", defeat = "Even the fish feel sorry for us.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "GOLDUCK", 43, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    R132_LEO = { like = "CLARENCE", name = "LEO", defeat = "Even the fish feel sorry for us.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "LAPRAS", 43, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    R132_BO = { like = "REED", name = "BO", defeat = "Even the fish feel sorry for us.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 43, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
    } },
    R132_ELA = { like = "TISHA", name = "ELA", defeat = "Even the fish feel sorry for us.", party = {
      { "FLOATZEL", 44, ability = "SWIFT_SWIM", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "CORSOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R133_ZEN = { like = "MOLLIE", name = "ZEN", defeat = "An expert loss, at least.", party = {
      { "TENTACRUEL", 45, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "CRAWDAUNT", 44, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    R133_DRA = { like = "AARON", name = "DRA", defeat = "An expert loss, at least.", party = {
      { "WAILMER", 45, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R133_KEN = { like = "CONOR", name = "KEN", defeat = "An expert loss, at least.", party = {
      { "SEALEO", 45, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "STARMIE", 44, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R133_GOR = { like = "PAXTON", name = "GORO", defeat = "An expert loss, at least.", party = {
      { "AZUMARILL", 45, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    R133_WEN = { like = "MAKAYLA", name = "WEN", defeat = "An expert loss, at least.", party = {
      { "LUMINEON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
      { "ALOMOMOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "HELPING_HAND", "HEAL_PULSE", "PROTECT" } },
    } },
    R133_ACE = { like = "WARREN", name = "ACE", defeat = "An expert loss, at least.", party = {
      { "KINGDRA", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    R134_GIL = { like = "HERMAN", name = "GIL", defeat = "The open sea humbled us.", party = {
      { "DEWGONG", 45, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "CLOYSTER", 44, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    R134_ELA = { like = "SUSIE", name = "ELA", defeat = "The open sea humbled us.", party = {
      { "GOREBYSS", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "JELLICENT", 44, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    R134_MAX = { like = "MARLEY", name = "MAX", defeat = "The open sea humbled us.", party = {
      { "RELICANTH", 45, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "MILOTIC", 44, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    R134_DUN = { like = "JONATHAN", name = "DUN", defeat = "The open sea humbled us.", party = {
      { "POLIWRATH", 45, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    R134_ANN = { like = "DARCY", name = "ANN", defeat = "The open sea humbled us.", party = {
      { "SLOWKING", 45, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    -- Chapter 9: Victory Road and the League (draft 1, 2026-10-27; caps 48, 50, 52, 54, 56, 58): partners ----------------------------------------
    VR_P1 = { like = "PATRICIA", name = "ROSA", defeat = "The road to the League ends here for us.", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "AZUMARILL", 46, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    VR_P2 = { like = "JOSHUA", name = "KAI", defeat = "The road to the League ends here for us.", party = {
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "KINGDRA", 46, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
    } },
    VR_P3 = { like = "ALEXIS", name = "MONA", defeat = "The road to the League ends here for us.", party = {
      { "MILOTIC", 47, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
      { "SLOWKING", 46, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
    } },
    VR_P4 = { like = "MARIELA", name = "OTTO", defeat = "The road to the League ends here for us.", party = {
      { "GASTRODON", 47, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
      { "CLOYSTER", 46, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    VR_P5 = { like = "ALVARO", name = "ZEKE", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "HARIYAMA", 46, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    VR_P6 = { like = "EVERETT", name = "LUNA", defeat = "The road to the League ends here for us.", party = {
      { "SWELLOW", 46, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "PIDGEOT", 45, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_P7 = { like = "NICOLAS_1", name = "IRIS", defeat = "The road to the League ends here for us.", party = {
      { "TALONFLAME", 47, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "FLARE_BLITZ", "TAILWIND", "QUICK_ATTACK" } },
      { "GYARADOS", 46, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    VR_A1 = { like = "ALBERT", name = "DREW", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "NIDOQUEEN", 46, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    VR_A2 = { like = "HOPE", name = "NORA", defeat = "The road to the League ends here for us.", party = {
      { "POLIWRATH", 47, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "JELLICENT", 46, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    VR_A3 = { like = "SHANNON", name = "TESS", defeat = "The road to the League ends here for us.", party = {
      { "DEWGONG", 47, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "LAPRAS", 46, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    VR_A4 = { like = "SAMUEL", name = "VERA", defeat = "The road to the League ends here for us.", party = {
      { "RELICANTH", 47, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "MANTINE", 46, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "AIR_SLASH", "WIDE_GUARD", "TAILWIND" } },
    } },
    VR_A5 = { like = "JULIE", name = "MILO", defeat = "The road to the League ends here for us.", party = {
      { "TOXAPEX", 47, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "SURF", "WIDE_GUARD", "TOXIC_SPIKES" } },
      { "CRAWDAUNT", 46, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    VR_A6 = { like = "OWEN", name = "JUNE", defeat = "The road to the League ends here for us.", party = {
      { "SHARPEDO", 47, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "QUAGSIRE", 46, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    VR_A7 = { like = "DIANNE", name = "RUSS", defeat = "The road to the League ends here for us.", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "AZUMARILL", 46, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    VR_A8 = { like = "FELIX", name = "FAYE", defeat = "The road to the League ends here for us.", party = {
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "KINGDRA", 46, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
    } },
    VR_A9 = { like = "CAROLINE", name = "COLE", defeat = "The road to the League ends here for us.", party = {
      { "MILOTIC", 47, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
      { "SLOWKING", 46, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
    } },
    VR_A10 = { like = "VITO", name = "GWEN", defeat = "The road to the League ends here for us.", party = {
      { "GASTRODON", 47, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
      { "CLOYSTER", 46, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
    } },
    VR_A11 = { like = "MICHELLE", name = "HUGO", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "HARIYAMA", 46, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    VR_A12 = { like = "MITCHELL", name = "NELL", defeat = "The road to the League ends here for us.", party = {
      { "SWELLOW", 47, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "PIDGEOT", 46, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_A13 = { like = "HALLE", name = "PERCY", defeat = "The road to the League ends here for us.", party = {
      { "TALONFLAME", 47, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "FLARE_BLITZ", "TAILWIND", "QUICK_ATTACK" } },
      { "GYARADOS", 46, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    VR_A14 = { like = "EDGAR", name = "RHEA", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "NIDOQUEEN", 46, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    VR_A15 = { like = "QUINCY", name = "SETH", defeat = "The road to the League ends here for us.", party = {
      { "POLIWRATH", 47, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "JELLICENT", 46, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    VR_A16 = { like = "KATELYNN", name = "ADA", defeat = "The road to the League ends here for us.", party = {
      { "DEWGONG", 47, ability = "FUR_COAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "LAPRAS", 46, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
    } },
    -- Post-game and stragglers: Rusturf Mike, Jagged Pass grunt, S.S. Tidal, Trick House 8 (draft 1, 2026-10-27): partners ----------------------------------------
    RT_GUS = { like = "MIKE_2", name = "GUSTAV", defeat = "The tunnel is ours no more.", party = {
      { "NOSEPASS", 21, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
      { "WHISMUR", 21, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
    } },
    SS_ELA = { like = "NAOMI", name = "ELAINE", defeat = "How rude, on a cruise no less.", party = {
      { "FLORGES", 59, ability = "FLOWER_VEIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "MOONBLAST", "PSYCHIC", "WISH", "PROTECT" } },
      { "MILOTIC", 58, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    SS_REX = { like = "GARRET", name = "REX", defeat = "Daddy owns this ship, you know.", party = {
      { "LAPRAS", 59, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
      { "NINETALES", 58, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "FLAMETHROWER", "EXTRASENSORY", "WILL_O_WISP", "PROTECT" } },
    } },
    SS_MAX = { like = "MICAH", name = "MAXWELL", defeat = "A gentleman accepts defeat.", party = {
      { "SLOWKING", 59, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "TRICK_ROOM" } },
      { "NOCTOWL", 58, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    SS_HAL = { like = "THOMAS", name = "HALE", defeat = "Most unexpected.", party = {
      { "STARMIE", 59, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "SNORLAX", 58, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "CRUNCH", "HIGH_HORSEPOWER", "PROTECT" } },
    } },
    SS_BEN = { like = "PHILLIP", name = "BENN", defeat = "Shipshape, but beaten.", party = {
      { "PELIPPER", 59, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
      { "CRAWDAUNT", 58, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    SS_WES = { like = "LEONARD", name = "WESLEY", defeat = "Back to swabbing the deck.", party = {
      { "KINGDRA", 59, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "TENTACRUEL", 58, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
    } },
  },
}
