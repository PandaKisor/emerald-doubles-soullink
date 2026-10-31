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
      { "PIDOVE", 8, ability = "BIG_PECKS", nature = "ADAMANT", item = "SILK_SCARF", moves = { "GUST", "LEER", "GROWL" } },
    } },
    RICK = { partner = "R102_OWEN", party = {
      { "SCATTERBUG", 7, ability = "SHIELD_DUST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "STRING_SHOT", "TACKLE", "STUN_SPORE" } },
      { "GRUBBIN", 8, ability = "SWARM", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "BUG_BITE", "BITE", "MUD_SLAP", "STRING_SHOT" } },
    } },
    ALLEN = { partner = "R102_BEN", party = {
      { "YUNGOOS", 7, ability = "STRONG_JAW", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "SAND_ATTACK", "PURSUIT", "LEER" } },
      { "TAILLOW", 8, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PECK", "QUICK_ATTACK", "FOCUS_ENERGY", "GROWL" } },
    } },
    TIANA = { partner = "R102_DANA", party = {
      { "SEEL", 8, ability = "THICK_FAT", nature = "HASTY", item = "MYSTIC_WATER", moves = { "GROWL", "HEADBUTT", "WATER_SPORT" } },
      { "SHROOMISH", 8, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "ABSORB", "LEECH_SEED", "TACKLE" } },
    } },

    -- Route 104 (south) ------------------------------------------------------------
    BILLY = { partner = "R104_SAM", party = {
      { "PONYTA", 10, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "EMBER", "TACKLE", "TAIL_WHIP", "GROWL" } },
      { "SEEDOT", 9, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "ASTONISH", "GROWTH", "HARDEN" } },
    } },
    DARIAN = { partner = "R104_NEIL", party = {
      { "GOLDEEN", 10, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "PECK", "SUPERSONIC", "WATER_SPORT" } },
      { "ARROKUDA", 9, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "AQUA_JET", "PECK", "FURY_ATTACK" } },
    } },
    CINDY_1 = { partner = "R104_PERCY", party = {
      { "MINCCINO", 10, ability = "SKILL_LINK", nature = "JOLLY", item = "SILK_SCARF", moves = { "POUND", "DEFENSE_CURL", "ENDURE", "BABY_DOLL_EYES" } },
      { "AZURILL", 9, ability = "THICK_FAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE", "WATER_GUN", "CHARM", "TAIL_WHIP" } },
    } },

    -- Petalburg Woods ----------------------------------------------------------------
    LYLE = { partner = "PW_WADE", party = {
      { "SEWADDLE", 10, ability = "OVERCOAT", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "DEFENSE_CURL", "SCREECH", "BUG_BITE", "TACKLE" } },
      { "DEWPIDER", 10, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", moves = { "BUBBLE", "WATER_SPORT", "INFESTATION", "SPIDER_WEB" } },
      { "VENIPEDE", 10, ability = "SPEED_BOOST", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BUG_BITE", "ROLLOUT", "POISON_STING", "SCREECH" } },
    } },
    JAMES_1 = { partner = "PW_COLE", party = {
      { "SNOM", 11, ability = "SHIELD_DUST", nature = "MODEST", moves = { "STRUGGLE_BUG", "POWDER_SNOW" } },
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
      { "LILLIPUP", 11, ability = "PICKUP", nature = "JOLLY", item = "SCOPE_LENS", moves = { "LEER", "TACKLE", "BITE", "ODOR_SLEUTH" } },
      { "SENTRET", 12, ability = "RUN_AWAY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "SCRATCH", "QUICK_ATTACK" } },
    } },
    HALEY_1 = { partner = "R104_TARA", party = {
      { "SOLOSIS", 11, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "ROLLOUT", "PROTECT", "SNATCH" } },
      { "PANSAGE", 11, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "VINE_WHIP", "LEECH_SEED", "SCRATCH", "PLAY_NICE" } },
      { "FLETCHLING", 11, ability = "GALE_WINGS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AERIAL_ACE", "GROWL", "DOUBLE_TEAM" } },
    } },
    -- the twins are a double on their own
    GINA_AND_MIA_1 = { party = {
      { "PETILIL", 11, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", moves = { "LEECH_SEED", "FAIRY_WIND", "MEGA_DRAIN", "ABSORB" } },
      { "FERROSEED", 11, ability = "IRON_BARBS", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "METAL_CLAW", "TACKLE", "HARDEN" } },
      { "LOTAD", 11, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", moves = { "MEGA_DRAIN", "BUBBLE", "MIST", "ASTONISH" } },
      { "SEEDOT", 11, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROLLOUT", "GROWTH", "ABSORB", "HARDEN" } },
    } },
    IVAN = { partner = "R104_HUGO", party = {
      { "FINNEON", 11, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "WATER_GUN", "POUND", "RAIN_DANCE" } },
      { "LUVDISC", 11, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },

    -- Rustboro Gym: trainers fight alone with three, sand like Roxanne (a setter, Sand
    -- Rush/Sand Force beside it) ------------------------------------------------------
    JOSH = { tier = "gym", party = {
      { "HIPPOPOTAS", 12, ability = "SAND_STREAM", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "SAND_TOMB", "BITE", "YAWN", "ROCK_TOMB" } },
      { "ROGGENROLA", 12, ability = "SAND_FORCE", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_BLAST", "MUD_SHOT", "SMACK_DOWN", "HARDEN" } },
      { "SANDSHREW", 12, ability = "SAND_RUSH", nature = "JOLLY", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROLLOUT", "FURY_CUTTER", "DEFENSE_CURL" } },
    } },
    TOMMY = { tier = "gym", party = {
      { "SILICOBRA", 13, ability = "SAND_SPIT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BULLDOZE", "BRUTAL_SWING", "MUD_SLAP", "PROTECT" } },
      { "DRILBUR", 13, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "MUD_SLAP", "ROCK_TOMB", "HONE_CLAWS" } },
      { "NOSEPASS", 12, ability = "SAND_FORCE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_THROW", "SHOCK_WAVE", "BLOCK", "THUNDER_WAVE" } },
    } },
    MARC = { tier = "gym", party = {
      { "SHIELDON", 13, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "SANDSTORM", "PROTECT", "METAL_SOUND", "TACKLE" } },
      { "CRANIDOS", 13, ability = "SHEER_FORCE", nature = "ADAMANT", item = "HARD_STONE", moves = { "HEADBUTT", "ROCK_TOMB", "PURSUIT", "FOCUS_ENERGY" } },
      { "SANDILE", 13, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "SAND_TOMB", "ASSURANCE", "ROCK_TOMB" } },
    } },

    -- Roxanne: six, alone (2-vs-1), sandstorm (0.41.0): Sand Stream lead, Sand Rush Drilbur,
    -- Bulldoze beside immune partners; Sand Force Nosepass is the ace at the cap ------------
    ROXANNE_1 = { tier = "leader", party = {
      { "HIPPOPOTAS", 14, ability = "SAND_STREAM", nature = "IMPISH", spread = "bulk", item = "SMOOTH_ROCK", moves = { "YAWN", "ROCK_TOMB", "BITE", "SAND_TOMB" } },
      { "DRILBUR", 14, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "METAL_CLAW", "MUD_SLAP", "ROCK_TOMB", "FURY_SWIPES" } },
      { "GLIGAR", 14, ability = "SAND_VEIL", nature = "ADAMANT", item = "SHARP_BEAK", moves = { "KNOCK_OFF", "WING_ATTACK", "QUICK_ATTACK", "PROTECT" } },
      { "LUNATONE", 14, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "LUM_BERRY", moves = { "HYPNOSIS", "CONFUSION", "ROCK_THROW", "PROTECT" } },
      { "RHYHORN", 14, ability = "LIGHTNING_ROD", nature = "ADAMANT", spread = "tank", item = "RINDO_BERRY", moves = { "BULLDOZE", "SMACK_DOWN", "HORN_ATTACK", "ROCK_TOMB" } },
      { "NOSEPASS", 15, ability = "SAND_FORCE", nature = "IMPISH", spread = "bulk", item = "BERRY_JUICE", moves = { "ROCK_TOMB", "BULLDOZE", "SPARK", "THUNDER_WAVE" } },
    } },
    -- Chapter 2: Rustboro to Brawly (draft 1, 2026-10-27; cap 17 then 19) ------------
    -- Route 116, west: tag battles at 13-14 ------------------------------------------
    JOEY = { partner = "R116_TIM", party = {
      { "ZORUA", 13, ability = "ILLUSION", nature = "TIMID", spread = "spa", item = "BLACK_GLASSES", moves = { "PURSUIT", "SCRATCH", "LEER", "FAKE_TEARS" } },
      { "SKITTY", 13, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    JOSE = { partner = "R116_GUS", party = {
      { "VENONAT", 13, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "TACKLE", "CONFUSION", "POISON_POWDER" } },
      { "SPINARAK", 13, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_STING", "SHADOW_SNEAK", "INFESTATION", "STRING_SHOT" } },
    } },
    KAREN_1 = { partner = "R116_EMMA", party = {
      { "PANSAGE", 13, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "VINE_WHIP", "LEECH_SEED", "BITE", "PLAY_NICE" } },
      { "EEVEE", 13, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
    } },
    CLARK = { partner = "R116_HANK", party = {
      { "ROLYCOLY", 14, ability = "HEATPROOF", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROLLOUT", "DEFENSE_CURL", "ROCK_POLISH", "SMACK_DOWN" } },
      { "ARON", 14, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    DEVAN = { partner = "R116_OLAF", party = {
      { "FURFROU", 14, ability = "FUR_COAT", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "PROTECT", "HEADBUTT", "TACKLE", "GROWL" } },
      { "TEDDIURSA", 14, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    JOHNSON = { partner = "R116_RAY", party = {
      { "TAILLOW", 14, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
      { "YAMPER", 14, ability = "BALL_FETCH", nature = "JOLLY", item = "MAGNET", moves = { "SHOCK_WAVE", "FLAME_CHARGE", "BITE", "TACKLE" } },
    } },

    -- Route 116, east (Cut): tag battles at 14-15 ------------------------------------
    SARAH = { partner = "R116_ELLA", party = {
      { "HOPPIP", 14, ability = "INFILTRATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HELPING_HAND", "ABSORB", "TACKLE", "SLEEP_POWDER" } },
      { "RALTS", 15, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DISARMING_VOICE", "CONFUSION", "MAGICAL_LEAF", "HYPNOSIS" } },
    } },
    DAWSON = { partner = "R116_REX", party = {
      { "AXEW", 15, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_RAGE", "BITE", "ASSURANCE", "LEER" } },
      { "MEOWTH", 14, ability = "UNNERVE", nature = "TIMID", spread = "spa", moves = { "FAKE_OUT", "SCRATCH", "BITE", "GROWL" } },
    } },
    JERRY_1 = { partner = "R116_LIAM", party = {
      { "SHUPPET", 15, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "MIENFOO", 14, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "POUND", "FAKE_OUT", "MEDITATE", "DETECT" } },
    } },
    JANICE = { partner = "R116_JUNE", party = {
      { "MARILL", 15, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "HOPPIP", 14, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", moves = { "ABSORB", "TACKLE", "SLEEP_POWDER", "SYNTHESIS" } },
    } },

    -- Rusturf Tunnel: the grunt with the Devon Goods fights alone -------------------
    GRUNT_RUSTURF_TUNNEL = { tier = "grunt", party = {
      { "CARVANHA", 16, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ASSURANCE", "PROTECT" } },
      { "SKRELP", 15, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "ZUBAT", 15, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },

    -- Route 106 beach: tag battles at 16 ---------------------------------------------
    NED = { partner = "R106_KAI", party = {
      { "TENTACOOL", 16, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SHELLOS", 16, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ICY_WIND", "PROTECT", "MUD_BOMB" } },
    } },
    ELLIOT_1 = { partner = "R106_ROY", party = {
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "FRILLISH", 16, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "BUBBLE_BEAM", "BUBBLE", "RAIN_DANCE", "WATER_SPORT" } },
    } },

    -- Dewford Gym: trainers fight alone with three, like Brawly: Fake Out and priority
    -- fighters beside an off-type partner ------------------------------------------
    JOCELYN = { tier = "gym", party = {
      { "MEDITITE", 16, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "BULLET_PUNCH", "DETECT" } },
      { "MINUN", 16, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "NUZZLE", "HELPING_HAND", "PROTECT" } },
      { "MANKEY", 16, ability = "DEFIANT", nature = "JOLLY", item = "BLACK_BELT", moves = { "KARATE_CHOP", "PURSUIT", "ROCK_TOMB", "FOCUS_ENERGY" } },
    } },
    LAURA = { tier = "gym", party = {
      { "MIENFOO", 16, ability = "REGENERATOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LOW_SWEEP", "U_TURN", "DETECT" } },
      { "MARILL", 16, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "MAKUHITA", 16, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "BULK_UP" } },
    } },
    BRENDEN = { tier = "gym", party = {
      { "TYROGUE", 17, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "MACH_PUNCH", "HELPING_HAND", "RAPID_SPIN" } },
      { "SANDSHREW_ALOLAN", 17, ability = "SNOW_CLOAK", nature = "JOLLY", item = "CHOPLE_BERRY", moves = { "ICE_SHARD", "METAL_CLAW", "ROLLOUT", "DEFENSE_CURL" } },
      { "TIMBURR", 17, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "ROCK_THROW", "FORCE_PALM", "BULK_UP" } },
    } },
    LILITH = { tier = "gym", party = {
      { "MONFERNO", 17, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "FAKE_OUT", "MACH_PUNCH", "FLAME_WHEEL", "TAUNT" } },
      { "HAWLUCHA", 17, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "KARATE_CHOP", "FEATHER_DANCE", "DETECT" } },
      { "PACHIRISU", 16, ability = "VOLT_ABSORB", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "NUZZLE", "SUPER_FANG", "HELPING_HAND", "PROTECT" } },
    } },
    CRISTIAN = { tier = "gym", party = {
      { "MACHOP", 16, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "BULLET_PUNCH", "KARATE_CHOP", "LOW_SWEEP", "REVENGE" } },
      { "PIGNITE", 17, ability = "THICK_FAT", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
      { "STUFFUL", 16, ability = "FLUFFY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BRUTAL_SWING", "FORCE_PALM", "BABY_DOLL_EYES", "PROTECT" } },
    } },
    TAKAO = { tier = "gym", party = {
      { "SCRAGGY", 16, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FEINT_ATTACK", "LOW_SWEEP", "PROTECT" } },
      { "RIOLU", 17, ability = "STEADFAST", nature = "JOLLY", item = "BLACK_BELT", moves = { "FORCE_PALM", "QUICK_ATTACK", "METAL_CLAW", "FEINT" } },
      { "SNORUNT", 17, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ICE_SHARD", "BITE", "ICY_WIND", "PROTECT" } },
    } },

    -- Brawly: six, alone (2-vs-1), Fake Out and priority with off-type support;
    -- Hitmontop is the ace at the cap ------------------------------------------------
    BRAWLY_1 = { tier = "leader", party = {
      { "MAKUHITA", 18, ability = "GUTS", nature = "ADAMANT", spread = "tank", item = "FLAME_ORB", moves = { "FAKE_OUT", "FACADE", "KNOCK_OFF", "BULLET_PUNCH" } },
      { "PLUSLE", 17, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "ELECTROWEB", "NUZZLE", "HELPING_HAND", "PROTECT" } },
      { "SANDSHREW_ALOLAN", 17, ability = "SNOW_CLOAK", nature = "JOLLY", item = "CHOPLE_BERRY", moves = { "ICE_SHARD", "METAL_CLAW", "ROLLOUT", "DEFENSE_CURL" } },
      { "TIMBURR", 18, ability = "IRON_FIST", nature = "ADAMANT", item = "EVIOLITE", moves = { "MACH_PUNCH", "LOW_SWEEP", "ROCK_THROW", "BULK_UP" } },
      { "CROAGUNK", 18, ability = "DRY_SKIN", nature = "ADAMANT", item = "BLACK_SLUDGE", moves = { "REVENGE", "VENOSHOCK", "FEINT_ATTACK", "TAUNT" } },
      { "HITMONTOP", 19, ability = "INTIMIDATE", nature = "ADAMANT", item = "LUM_BERRY", moves = { "FAKE_OUT", "MACH_PUNCH", "ROLLING_KICK", "WIDE_GUARD" } },
    } },
    -- Chapter 3: Dewford to Wattson (draft 1, 2026-10-27; caps 20, 21, 24) -----------
    -- Route 109 beach: tag battles at 16-17 ------------------------------------------
    HUEY = { partner = "R109_WES", party = {
      { "WINGULL", 17, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "MACHOP", 16, ability = "GUTS", nature = "ADAMANT", moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "KARATE_CHOP" } },
    } },
    EDMOND = { partner = "R109_PIP", party = {
      { "ARROKUDA", 17, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "BITE", "PECK", "FURY_ATTACK" } },
      { "FLETCHINDER", 17, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
    } },
    HAILEY = { partner = "R109_DOT", party = {
      { "SPHEAL", 16, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "FURRET", 16, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "QUICK_ATTACK", "SCRATCH" } },
    } },
    RICKY_1 = { partner = "R109_BO", party = {
      { "ZIGZAGOON", 17, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "SALANDIT", 16, ability = "CORROSION", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "EMBER", "SMOG", "POISON_GAS", "SWEET_SCENT" } },
    } },
    LOLA_1 = { partner = "R109_KIM", party = {
      { "WAILMER", 17, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "CORPHISH", 16, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "atk", moves = { "BUBBLE", "KNOCK_OFF", "VISE_GRIP", "HARDEN" } },
    } },
    CHANDLER = { partner = "R109_ZED", party = {
      { "BUIZEL", 17, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "QUICK_ATTACK", "PURSUIT", "GROWL" } },
      { "CORPHISH", 16, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },

    -- the Seashore House: three in a row, each alone with three ---------------------------
    SIMON = { party = {
      { "CLAUNCHER", 17, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", moves = { "ICY_WIND", "BUBBLE", "WATER_GUN", "WATER_SPORT" } },
      { "CROCONAW", 18, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "ICE_FANG", "WATER_GUN", "SCARY_FACE" } },
      { "PIDOVE", 17, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AIR_CUTTER", "GUST", "LEER" } },
    } },
    JOHANNA = { party = {
      { "GOLDEEN", 17, ability = "LIGHTNING_ROD", nature = "ADAMANT", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
      { "BASCULIN", 17, ability = "RECKLESS", nature = "ADAMANT", moves = { "BITE", "AQUA_JET", "TAKE_DOWN", "CRUNCH" } },
      { "QWILFISH", 17, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "PROTECT", "FELL_STINGER", "TACKLE" } },
    } },
    DWAYNE = { party = {
      { "MAKUHITA", 18, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "KRABBY", 17, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", moves = { "BUBBLE", "WATER_GUN", "VISE_GRIP", "METAL_CLAW" } },
      { "CORPHISH", 17, ability = "HYPER_CUTTER", nature = "ADAMANT", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "DOUBLE_HIT", "PROTECT" } },
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
      { "PLUSLE", 17, ability = "PLUS", nature = "TIMID", spread = "spa", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "PINCURCHIN", 17, ability = "ELECTRIC_SURGE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "SPARK", "ENDURE", "PECK", "FURY_ATTACK" } },
    } },
    KALEB = { partner = "R110_GIL", party = {
      { "MINUN", 17, ability = "MINUS", nature = "TIMID", spread = "spa", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "CRAMORANT", 17, ability = "GULP_MISSILE", nature = "TIMID", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "PECK", "FURY_ATTACK", "STOCKPILE" } },
    } },
    TIMMY = { partner = "R110_OTTO", party = {
      { "FOONGUS", 17, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", moves = { "PROTECT", "MEGA_DRAIN", "ABSORB", "ASTONISH" } },
      { "ELECTRIKE", 17, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    EDWIN_1 = { partner = "R110_MOE", party = {
      { "TYMPOLE", 18, ability = "SWIFT_SWIM", nature = "ADAMANT", spread = "atk", moves = { "BUBBLE", "MUD_SHOT", "GROWL", "SUPERSONIC" } },
      { "NUZLEAF", 18, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "AIR_CUTTER", "GROWTH", "TORMENT" } },
    } },
    JOSEPH = { partner = "R110_BRAD", party = {
      { "ELEKID", 18, ability = "STATIC", nature = "MODEST", item = "MAGNET", moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
      { "VOLTORB", 18, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
    } },
    EDWARD = { partner = "R110_VIC", party = {
      { "KADABRA", 18, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "GOTHITA", 17, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "PROTECT", "CONFUSION", "TICKLE" } },
    } },
    ALYSSA = { partner = "R110_LIZ", party = {
      { "MAGNEMITE", 18, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "SUPERSONIC" } },
      { "HERDIER", 18, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "TACKLE", "ODOR_SLEUTH", "BABY_DOLL_EYES" } },
    } },
    DALE = { partner = "R110_HAL", party = {
      { "WAILMER", 18, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "QWILFISH", 17, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "AQUA_JET", "PROTECT", "FELL_STINGER", "TACKLE" } },
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
      { "BUDEW", 18, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "SLEEP_POWDER", "STUN_SPORE", "ABSORB" } },
      { "TORRACAT", 18, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "DOUBLE_KICK", "LICK", "ROAR" } },
    } },
    ROBIN = { partner = "TH1_ZOE", party = {
      { "PIDGEOTTO", 18, ability = "KEEN_EYE", nature = "TIMID", item = "SHARP_BEAK", moves = { "QUICK_ATTACK", "TAILWIND", "AIR_CUTTER", "GUST" } },
      { "BRIONNE", 18, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "DISARMING_VOICE", "ICY_WIND", "AQUA_JET", "ENCORE" } },
    } },
    EDDIE = { partner = "TH1_KIP", party = {
      { "BINACLE", 18, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_GUN", "SCRATCH", "FURY_CUTTER", "SAND_ATTACK" } },
      { "DARTRIX", 18, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PECK", "FORESIGHT" } },
    } },

    -- Route 103 east: tag battles at 18-19 --------------------------------------------------
    DAISY = { partner = "R103_FAY", party = {
      { "MORELULL", 18, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "ROSELIA", 19, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "MEGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    -- the twins are a double on their own
    AMY_AND_LIV_1 = { party = {
      { "JIGGLYPUFF", 18, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
      { "IMPIDIMP", 18, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
      { "PLUSLE", 18, ability = "PLUS", nature = "TIMID", spread = "spa", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "MINUN", 18, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
    } },
    MIGUEL_1 = { partner = "R103_GUY", party = {
      { "SKITTY", 19, ability = "WONDER_SKIN", nature = "JOLLY", item = "SILK_SCARF", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "WOOLOO", 19, ability = "RUN_AWAY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "DOUBLE_KICK", "COPYCAT", "GUARD_SPLIT" } },
    } },
    ANDREW = { partner = "R103_FINN", party = {
      { "BARBOACH", 19, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "WATER_GUN", "AMNESIA", "PROTECT" } },
      { "HORSEA", 18, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "LEER" } },
      { "ALOMOMOLA", 18, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "POUND", "HEAL_PULSE", "PLAY_NICE" } },
    } },
    MARCOS = { partner = "R103_JAX", party = {
      { "TYNAMO", 19, ability = "LEVITATE", nature = "TIMID", item = "MAGNET", moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "KRICKETUNE", 19, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    RHETT = { partner = "R103_DUKE", party = {
      { "THROH", 19, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
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
      { "GOTHITA", 20, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
      { "KADABRA", 21, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    JACOB = { partner = "CR_TOD", party = {
      { "LITLEO", 21, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "HELPING_HAND", "ROAR", "ECHOED_VOICE", "EMBER" } },
      { "ROCKRUFF", 21, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
    } },
    ANTHONY = { partner = "CR_WIN", party = {
      { "TYNAMO", 20, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MAGNET", moves = { "SPARK", "THUNDER_WAVE", "TACKLE", "CHARGE_BEAM" } },
      { "CHARJABUG", 20, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
    } },
    BENJAMIN_1 = { partner = "CR_ACE", party = {
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "TYNAMO", 20, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SPARK", "TACKLE", "THUNDER_WAVE", "CHARGE_BEAM" } },
    } },
    ABIGAIL_1 = { partner = "CR_ADA", party = {
      { "CRAMORANT", 20, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", moves = { "AIR_CUTTER", "PECK", "FURY_ATTACK", "STOCKPILE" } },
      { "PACHIRISU", 20, ability = "PICKUP", nature = "TIMID", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    JASMINE = { partner = "CR_SKY", party = {
      { "FLETCHINDER", 20, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
      { "HONEDGE", 20, ability = "NO_GUARD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "METAL_SOUND", "AUTOTOMIZE", "SHADOW_SNEAK", "TACKLE" } },
    } },

    -- Route 117: tag battles at 20-21; the breeders and the twins fight alone ------------------
    DEREK = { partner = "R117_KAI", party = {
      { "MOTHIM", 21, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "CONFUSION", "QUIVER_DANCE", "PROTECT" } },
      { "VENONAT", 20, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "TACKLE", "PSYBEAM", "POISON_POWDER" } },
    } },
    ANNA_AND_MEG_1 = { party = {
      { "GLAMEOW", 21, ability = "KEEN_EYE", nature = "JOLLY", item = "SILK_SCARF", moves = { "SWIFT", "SCRATCH", "FEINT_ATTACK", "GROWL" } },
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "SKITTY", 20, ability = "WONDER_SKIN", nature = "JOLLY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "MACHOP", 20, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    DYLAN_1 = { partner = "R117_LEE", party = {
      { "LARVESTA", 21, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "FLAME_CHARGE", "EMBER", "TAKE_DOWN" } },
      { "DODUO", 20, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
    } },
    MARIA_1 = { partner = "R117_MAE", party = {
      { "HERDIER", 20, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
      { "PASSIMIAN", 21, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "ROCK_SMASH", "TACKLE" } },
    } },
    ISAAC_1 = { party = {
      { "EEVEE", 19, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
      { "BONSLY", 19, ability = "STURDY", nature = "IMPISH", spread = "bulk", moves = { "ROCK_THROW", "LOW_KICK", "FAKE_TEARS", "FLAIL" } },
      { "GIBLE", 19, ability = "SAND_VEIL", nature = "ADAMANT", moves = { "DRAGON_BREATH", "TAKE_DOWN", "SAND_TOMB", "SAND_ATTACK" } },
      { "GASTLY", 19, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ASTONISH", "CONFUSE_RAY", "PAYBACK", "LICK" } },
    } },
    LYDIA_1 = { party = {
      { "TYNAMO", 19, ability = "LEVITATE", nature = "TIMID", moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "LITWICK", 19, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", moves = { "EMBER", "SMOG", "HEX", "MINIMIZE" } },
      { "INKAY", 19, ability = "CONTRARY", nature = "ADAMANT", spread = "atk", moves = { "FOUL_PLAY", "TACKLE", "REFLECT", "TOPSY_TURVY" } },
      { "GOOMY", 19, ability = "SAP_SIPPER", nature = "MODEST", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "BUBBLE", "PROTECT", "ABSORB" } },
    } },
    MELINA = { partner = "R117_ROX", party = {
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
      { "MURKROW", 21, ability = "INSOMNIA", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "ICY_WIND", "TAUNT", "AERIAL_ACE" } },
    } },
    BRANDI = { partner = "R117_IVY", party = {
      { "ESPURR", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MIME_JR", 21, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    AISHA = { partner = "R117_JO", party = {
      { "CRABOMINABLE", 21, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "ROCK_SMASH", "LEER" } },
      { "MEDITITE", 20, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },

    -- Route 111 south: tag battles at 21 ----------------------------------------------------------
    TYRON = { partner = "R111_ABE", party = {
      { "SANDSHREW", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "DWEBBLE", 21, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SMACK_DOWN", "FURY_CUTTER", "ROCK_BLAST", "WITHDRAW" } },
    } },
    CELINA = { partner = "R111_NIA", party = {
      { "BUDEW", 21, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", moves = { "SLEEP_POWDER", "MEGA_DRAIN", "ABSORB", "WATER_SPORT" } },
      { "CORVISQUIRE", 21, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    BIANCA = { partner = "R111_PIA", party = {
      { "DRIFLOON", 21, ability = "FLARE_BOOST", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ASTONISH", "SHADOW_BALL", "HEX", "MINIMIZE" } },
      { "BIBAREL", 21, ability = "UNAWARE", nature = "JOLLY", item = "SILK_SCARF", moves = { "HYPER_FANG", "QUICK_ATTACK", "AQUA_TAIL", "YAWN" } },
    } },
    HAYDEN = { partner = "R111_CY", party = {
      { "NUMEL", 21, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
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

    -- Mauville Gym: trainers fight alone with three, like Wattson: Volt Switch and
    -- Shuca Berries -------------------------------------------------------------------------------
    KIRK = { tier = "gym", party = {
      { "VOLTORB", 22, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "SHUCA_BERRY", moves = { "VOLT_SWITCH", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
      { "BLITZLE", 21, ability = "MOTOR_DRIVE", nature = "JOLLY", item = "SHUCA_BERRY", moves = { "VOLT_SWITCH", "FLAME_CHARGE", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "ELECTRIKE", 22, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    SHAWN = { tier = "gym", party = {
      { "HELIOPTILE", 22, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "SHUCA_BERRY", moves = { "VOLT_SWITCH", "PARABOLIC_CHARGE", "QUICK_ATTACK", "MUD_SLAP" } },
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "VOLT_SWITCH", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "LUXIO", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "SHUCA_BERRY", moves = { "SPARK", "BITE", "DOUBLE_KICK", "LEER" } },
    } },
    BEN = { tier = "gym", party = {
      { "STUNFISK", 22, ability = "STATIC", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "MUD_BOMB", "THUNDER_SHOCK", "MUD_SHOT", "SUCKER_PUNCH" } },
      { "TOGEDEMARU", 22, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "SHUCA_BERRY", moves = { "SPARK", "NUZZLE", "U_TURN", "ROLLOUT" } },
      { "CHARJABUG", 21, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "EVIOLITE", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
    } },
    VIVIAN = { tier = "gym", party = {
      { "ELEKID", 22, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "SHUCA_BERRY", moves = { "VOLT_SWITCH", "LOW_KICK", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "MAGNEMITE", 21, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "VOLT_SWITCH", "MIRROR_SHOT", "SONIC_BOOM", "THUNDER_WAVE" } },
      { "PACHIRISU", 21, ability = "VOLT_ABSORB", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "NUZZLE", "SPARK", "SUPER_FANG", "ENDURE" } },
    } },
    ANGELO = { tier = "gym", party = {
      { "VOLBEAT", 22, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "U_TURN", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
      { "EMOLGA", 22, ability = "MOTOR_DRIVE", nature = "JOLLY", item = "SHUCA_BERRY", moves = { "VOLT_SWITCH", "ACROBATICS", "NUZZLE", "ENCORE" } },
      { "JOLTIK", 21, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "THUNDER_WAVE", "SPIDER_WEB" } },
    } },

    -- Wattson: six, alone (2-vs-1), Volt Switch and resist berries; Manectric is the ace
    -- at the cap ----------------------------------------------------------------------------------
    WATTSON_1 = { tier = "leader", party = {
      { "MAGNEMITE", 23, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "VOLT_SWITCH", "MIRROR_SHOT", "ELECTROWEB", "THUNDER_WAVE" } },
      { "EMOLGA", 23, ability = "MOTOR_DRIVE", nature = "JOLLY", moves = { "ACROBATICS", "NUZZLE", "ENCORE", "U_TURN" } },
      { "HELIOPTILE", 23, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "SHUCA_BERRY", moves = { "PARABOLIC_CHARGE", "GRASS_KNOT", "QUICK_ATTACK", "THUNDER_WAVE" } },
      { "CHARJABUG", 23, ability = "BATTERY", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "BUG_BITE", "SPARK", "STRING_SHOT", "PROTECT" } },
      { "CHINCHOU", 23, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "SPARK", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "MANECTRIC", 24, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "SHUCA_BERRY", moves = { "DISCHARGE", "FIRE_FANG", "SNARL", "PROTECT" } },
    } },
    -- Chapter 4: Mauville to Flannery (draft 1, 2026-10-27; caps 25, 26, 29) ----------
    -- Route 111 north: Gabby and Ty interview you with a double of their own -------------
    GABBY_AND_TY_1 = { party = {
      { "TYNAMO", 22, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MAGNET", moves = { "SPARK", "THUNDER_WAVE", "TACKLE", "CHARGE_BEAM" } },
      { "LOUDRED", 22, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "BITE", "HOWL", "SUPERSONIC" } },
    } },

    -- Route 112: tag battles at 21-22 -----------------------------------------------------
    LARRY = { partner = "R112_BUD", party = {
      { "ROSELIA", 22, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "SLEEP_POWDER", "STUN_SPORE", "GIGA_DRAIN" } },
      { "LITLEO", 21, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "HELPING_HAND", "ROAR", "ECHOED_VOICE", "EMBER" } },
    } },
    CAROL = { partner = "R112_SUE", party = {
      { "WATCHOG", 21, ability = "ANALYTIC", nature = "ADAMANT", spread = "atk", moves = { "HYPNOSIS", "TACKLE", "CRUNCH", "DETECT" } },
      { "ODDISH", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BRICE = { partner = "R112_GUS", party = {
      { "SILICOBRA", 22, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", moves = { "BULLDOZE", "HEADBUTT", "SAND_ATTACK", "MINIMIZE" } },
      { "JOLTIK", 22, ability = "COMPOUND_EYES", nature = "MODEST", item = "SILVER_POWDER", moves = { "BUG_BITE", "PROTECT", "ELECTROWEB", "ABSORB" } },
    } },
    TRENT_1 = { partner = "R112_ROB", party = {
      { "GEODUDE", 22, ability = "SAND_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "SMACK_DOWN", "ROCK_POLISH", "BULLDOZE" } },
      { "GEODUDE", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    BRYANT = { partner = "R112_ASH", party = {
      { "DARUMAKA", 22, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "INCINERATE", "FIRE_FANG", "FACADE", "TAUNT" } },
      { "QUILAVA", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "SWIFT", "QUICK_ATTACK", "SMOKESCREEN" } },
    } },
    SHAYLA = { partner = "R112_LIL", party = {
      { "BAYLEEF", 22, ability = "LEAF_GUARD", nature = "BOLD", spread = "bulk", moves = { "RAZOR_LEAF", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "MORELULL", 22, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "MOONLIGHT" } },
    } },

    -- Route 113: tag battles at 21-22 in the ash ------------------------------------------------
    JAYLEN = { partner = "R113_PIP", party = {
      { "TRAPINCH", 22, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "PANSEAR", 21, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", moves = { "BITE", "FLAME_BURST", "INCINERATE", "ACROBATICS" } },
    } },
    DILLON = { partner = "R113_TAD", party = {
      { "ARON", 22, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
      { "TRANQUILL", 21, ability = "BIG_PECKS", nature = "ADAMANT", moves = { "QUICK_ATTACK", "AIR_CUTTER", "GUST", "GROWL" } },
    } },
    LAO_1 = { partner = "R113_ZEN", party = {
      { "FROGADIER", 22, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "ROUND" } },
      { "STUNKY", 21, ability = "STENCH", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SMOG", "SMOKESCREEN", "HAZE", "BITE" } },
    } },
    LUNG = { partner = "R113_KO", party = {
      { "NINJASK", 22, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "CROAGUNK", 21, ability = "ANTICIPATION", nature = "BOLD", spread = "bulk", moves = { "REVENGE", "POISON_STING", "VENOSHOCK", "FEINT_ATTACK" } },
    } },
    MADELINE_1 = { partner = "R113_UMA", party = {
      { "TROPIUS", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
      { "NUMEL", 22, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "HORSEA", 21, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "tank", moves = { "WATER_GUN", "BUBBLE_BEAM", "BUBBLE", "LEER" } },
    } },
    -- the twins are a double on their own
    TORI_AND_TIA = { party = {
      { "FURFROU", 22, ability = "FUR_COAT", nature = "JOLLY", moves = { "HEADBUTT", "TACKLE", "GROWL", "BABY_DOLL_EYES" } },
      { "SPINDA", 22, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    SOPHIE = { partner = "R113_BEA", party = {
      { "SUDOWOODO", 22, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "LOW_KICK", "BLOCK", "FAKE_TEARS" } },
      { "SPRITZEE", 21, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
    } },
    COBY = { partner = "R113_TAO", party = {
      { "SKARMORY", 22, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SAND_ATTACK", "SPIKES" } },
      { "CHANSEY", 21, ability = "SERENE_GRACE", nature = "TIMID", item = "SILK_SCARF", moves = { "ROCK_SMASH", "POUND", "DOUBLE_SLAP", "COPYCAT" } },
    } },
    LAWRENCE = { partner = "R113_RIO", party = {
      { "BALTOY", 22, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
      { "DRILBUR", 21, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", moves = { "BULLDOZE", "RAPID_SPIN", "METAL_CLAW", "MUD_SPORT" } },
    } },
    WYATT = { partner = "R113_MAX", party = {
      { "MAGBY", 22, ability = "FLAME_BODY", nature = "JOLLY", spread = "atk", item = "CHARCOAL", moves = { "FLAME_BURST", "SMOKESCREEN", "FEINT_ATTACK", "LEER" } },
      { "NIDORINO", 22, ability = "POISON_POINT", nature = "ADAMANT", item = "POISON_BARB", moves = { "POISON_TAIL", "DOUBLE_KICK", "HORN_ATTACK", "FOCUS_ENERGY" } },
    } },

    -- Route 114: tag battles at 22-23; Tyra and Ivy fight as a double ---------------------------------
    STEVE_1 = { partner = "R114_HAL", party = {
      { "RHYHORN", 23, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_BLAST", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "TURTONATOR", 22, ability = "SHELL_ARMOR", nature = "MODEST", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "REVENGE", "INCINERATE", "EMBER" } },
    } },
    BERNIE_1 = { partner = "R114_ED", party = {
      { "YANMA", 22, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", moves = { "BUG_BITE", "AIR_CUTTER", "AERIAL_ACE", "FORESIGHT" } },
      { "BUIZEL", 22, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "AQUA_JET", "QUICK_ATTACK", "GROWL" } },
    } },
    SHANE = { partner = "R114_IKE", party = {
      { "KANGASKHAN", 23, ability = "INNER_FOCUS", nature = "JOLLY", moves = { "FURY_CUTTER", "FAKE_OUT", "DOUBLE_HIT", "COMET_PUNCH" } },
      { "TRUBBISH", 22, ability = "STENCH", nature = "ADAMANT", item = "POISON_BARB", moves = { "SLUDGE", "CLEAR_SMOG", "ACID_SPRAY", "POUND" } },
    } },
    CLAUDE = { partner = "R114_JEB", party = {
      { "GYARADOS", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "ALOMOMOLA", 22, ability = "HYDRATION", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "POUND", "HEAL_PULSE", "PLAY_NICE" } },
    } },
    NOLAN = { partner = "R114_GUY", party = {
      { "WISHIWASHI", 22, ability = "SCHOOLING", nature = "MODEST", spread = "spa", moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "GOLDEEN", 22, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    NANCY = { partner = "R114_FLO", party = {
      { "SWIRLIX", 22, ability = "UNBURDEN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "TACKLE", "FAKE_TEARS" } },
      { "GROTLE", 22, ability = "OVERGROW", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "BITE", "CURSE", "MEGA_DRAIN" } },
    } },
    LENNY = { partner = "R114_OZ", party = {
      { "MUDBRAY", 23, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "SOFT_SAND", moves = { "ROCK_TOMB", "STEALTH_ROCK", "BULLDOZE", "MUD_SLAP" } },
      { "VANILLITE", 22, ability = "WEAK_ARMOR", nature = "MODEST", item = "ORAN_BERRY", moves = { "ICE_SHARD", "ICY_WIND", "MIST", "AVALANCHE" } },
    } },
    LUCAS_1 = { partner = "R114_BOB", party = {
      { "STONJOURNER", 23, ability = "POWER_SPOT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "SELF_DESTRUCT", "ROCK_THROW", "GRAVITY" } },
      { "FOONGUS", 22, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", moves = { "PROTECT", "MEGA_DRAIN", "ABSORB", "FEINT_ATTACK" } },
    } },
    TYRA_AND_IVY = { party = {
      { "LUXIO", 23, ability = "RIVALRY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "THUNDER_WAVE", "BITE", "CHARGE" } },
      { "PHANPY", 23, ability = "PICKUP", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "ROLLOUT", "DEFENSE_CURL", "SLAM" } },
    } },
    ANGELINA = { partner = "R114_MEL", party = {
      { "PRINPLUP", 22, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "METAL_CLAW", "PECK", "GROWL" } },
      { "PARAS", 22, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "STUN_SPORE", "SWEET_SCENT", "SLASH" } },
    } },
    KAI = { partner = "R114_NED", party = {
      { "WHISCASH", 23, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
      { "SLOWPOKE", 22, ability = "REGENERATOR", nature = "MODEST", spread = "spa", moves = { "WATER_GUN", "PROTECT", "TACKLE", "CONFUSION" } },
    } },
    CHARLOTTE = { partner = "R114_ROE", party = {
      { "SKIDDO", 23, ability = "GRASS_PELT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "VINE_WHIP", "TAKE_DOWN", "RAZOR_LEAF", "SYNTHESIS" } },
      { "VULPIX", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "INCINERATE", "CONFUSE_RAY", "QUICK_ATTACK", "WILL_O_WISP" } },
    } },

    -- Route 115 south: tag battles at 22-23 --------------------------------------------------------------
    NOB_1 = { partner = "R115_KEN", party = {
      { "MACHOKE", 23, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "WOOBAT", 22, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    HECTOR = { partner = "R115_DON", party = {
      { "AUDINO", 22, ability = "HEALER", nature = "TIMID", item = "ORAN_BERRY", moves = { "POUND", "DOUBLE_SLAP", "EXTRASENSORY", "DISARMING_VOICE" } },
      { "SEVIPER", 22, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
    } },
    MARLENE = { partner = "R115_EVE", party = {
      { "DROWZEE", 22, ability = "INSOMNIA", nature = "ADAMANT", spread = "atk", item = "TWISTED_SPOON", moves = { "PSYBEAM", "MAGIC_COAT", "HEADBUTT", "POUND" } },
      { "MEDITITE", 22, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    CYNDY_1 = { partner = "R115_JAN", party = {
      { "DEWOTT", 23, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "FURY_CUTTER", "REVENGE", "FOCUS_ENERGY" } },
      { "BUNEARY", 22, ability = "RUN_AWAY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "BABY_DOLL_EYES", "PROTECT", "POUND", "QUICK_ATTACK" } },
    } },

    -- Mt. Chimney: tag battles at 23-24; Team Magma fights alone ------------------------------------------------
    SAWYER_1 = { partner = "MC_BRAM", party = {
      { "ROCKRUFF", 23, ability = "STEADFAST", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
      { "LUNATONE", 23, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "REFLECT", "SMACK_DOWN", "STEALTH_ROCK" } },
    } },
    MELISSA = { partner = "MC_LIV", party = {
      { "TOGETIC", 24, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "CHERUBI", 23, ability = "CHLOROPHYLL", nature = "ADAMANT", moves = { "MAGICAL_LEAF", "TACKLE", "SUNNY_DAY", "HELPING_HAND" } },
    } },
    SHEILA = { partner = "MC_FAE", party = {
      { "GLAMEOW", 24, ability = "KEEN_EYE", nature = "JOLLY", item = "SILK_SCARF", moves = { "SCRATCH", "FAKE_OUT", "FURY_SWIPES", "FEINT_ATTACK" } },
      { "SKIPLOOM", 23, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "BULLET_SEED", "MEGA_DRAIN", "ABSORB" } },
    } },
    SHIRLEY = { partner = "MC_DEE", party = {
      { "SIGILYPH", 24, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "PSYBEAM", "GRAVITY", "MIRACLE_EYE" } },
      { "WOOLOO", 23, ability = "RUN_AWAY", nature = "JOLLY", moves = { "HEADBUTT", "TACKLE", "COPYCAT", "GUARD_SPLIT" } },
    } },
    SHELBY_1 = { partner = "MC_RUE", party = {
      { "PANCHAM", 24, ability = "MOLD_BREAKER", nature = "JOLLY", moves = { "LOW_SWEEP", "KARATE_CHOP", "SLASH", "LEER" } },
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
      { "PONYTA", 25, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "EMBER", "FIRE_SPIN" } },
      { "SERVINE", 25, ability = "CONTRARY", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "LEAF_TORNADO", "MEGA_DRAIN", "GLARE", "LEECH_SEED" } },
    } },
    JULIO = { partner = "JP_ROD", party = {
      { "MAGNEMITE", 25, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "MIRROR_SHOT" } },
      { "ELEKID", 26, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", moves = { "SWAGGER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
    } },
    DIANA_1 = { partner = "JP_BEL", party = {
      { "QUILLADIN", 25, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "PIN_MISSILE", "BITE", "ROLLOUT", "LEECH_SEED" } },
      { "STARAVIA", 25, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    ETHAN_1 = { partner = "JP_GUS", party = {
      { "STUFFUL", 25, ability = "CUTE_CHARM", nature = "JOLLY", item = "BLACK_BELT", moves = { "AERIAL_ACE", "TACKLE", "BRUTAL_SWING", "LEER" } },
      { "SANDSLASH", 26, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
    } },

    -- Lavaridge Gym: trainers fight alone with three, sun like Flannery: Drought or Sunny
    -- Day beside fire and Chlorophyll grass -----------------------------------------------------------------
    COLE = { tier = "gym", party = {
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "HEAT_ROCK", moves = { "SUNNY_DAY", "LAVA_PLUME", "AMNESIA", "MAGNITUDE" } },
      { "MAROWAK_ALOLAN", 27, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "FLAME_WHEEL", "BONE_CLUB", "HEX", "FALSE_SWIPE" } },
      { "SIMISEAR", 26, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_BURST", "SOLAR_BEAM", "BITE", "TAUNT" } },
    } },
    JEFF = { tier = "gym", party = {
      { "SLUGMA", 26, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
      { "BRAIXEN", 27, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SUNNY_DAY", "FLAME_CHARGE", "PSYBEAM", "LUCKY_CHANT" } },
      { "GLOOM", 26, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "SUNNY_DAY", "GIGA_DRAIN", "ACID", "SLEEP_POWDER" } },
    } },
    AXLE = { tier = "gym", party = {
      { "MAGBY", 26, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_BURST", "FEINT_ATTACK", "CLEAR_SMOG", "SUNNY_DAY" } },
      { "PONYTA", 27, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
      { "CHERRIM", 26, ability = "FLOWER_GIFT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "HELPING_HAND", "GROWTH", "PROTECT" } },
    } },
    JACE = { tier = "gym", party = {
      { "PIGNITE", 27, ability = "THICK_FAT", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
      { "FLAREON", 26, ability = "FLASH_FIRE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FIRE_FANG", "BITE", "QUICK_ATTACK", "HELPING_HAND" } },
      { "GROWLITHE", 26, ability = "INTIMIDATE", nature = "ADAMANT", item = "HEAT_ROCK", moves = { "SUNNY_DAY", "FLAME_WHEEL", "BITE", "ROAR" } },
    } },
    KEEGAN = { tier = "gym", party = {
      { "LITWICK", 26, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "HEX", "WILL_O_WISP", "MINIMIZE" } },
      { "SUNFLORA", 27, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "GIGA_DRAIN", "GROWTH", "LEECH_SEED" } },
      { "VULPIX", 26, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "HEAT_ROCK", moves = { "INCINERATE", "CONFUSE_RAY", "QUICK_ATTACK", "WILL_O_WISP" } },
    } },
    ELI = { tier = "gym", party = {
      { "TORKOAL", 26, ability = "DROUGHT", nature = "QUIET", spread = "stank", item = "ORAN_BERRY", moves = { "LAVA_PLUME", "SMOKESCREEN", "CURSE", "PROTECT" } },
      { "HEATMOR", 27, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", moves = { "INCINERATE", "BUG_BITE", "FURY_SWIPES", "HONE_CLAWS" } },
      { "WEEPINBELL", 26, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "POISON_JAB", "SLEEP_POWDER", "GROWTH" } },
    } },
    GERALD = { tier = "gym", party = {
      { "TORRACAT", 27, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "DOUBLE_KICK", "BITE", "FAKE_OUT" } },
      { "EXEGGCUTE", 26, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SUNNY_DAY", "BULLET_SEED", "CONFUSION", "HYPNOSIS" } },
      { "HOUNDOOM", 26, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "INCINERATE", "FEINT_ATTACK", "SMOG", "ROAR" } },
    } },
    DANIELLE = { tier = "gym", party = {
      { "MONFERNO", 27, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "MACH_PUNCH", "FLAME_WHEEL", "FAKE_OUT", "TAUNT" } },
      { "SKIPLOOM", 26, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SUNNY_DAY", "BULLET_SEED", "SLEEP_POWDER", "U_TURN" } },
      { "PONYTA", 26, ability = "FLAME_BODY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "STOMP", "FLAME_CHARGE", "DOUBLE_KICK" } },
    } },

    -- Flannery: six, alone (2-vs-1); Drought Torkoal sets the sun, it's the ace at the cap ----
    FLANNERY_1 = { tier = "leader", party = {
      { "TORKOAL", 29, ability = "DROUGHT", nature = "QUIET", spread = "stank", item = "HEAT_ROCK", moves = { "LAVA_PLUME", "SOLAR_BEAM", "YAWN", "PROTECT" } },
      { "LILLIGANT", 28, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLEEP_POWDER", "HELPING_HAND", "PROTECT" } },
      { "MAROWAK_ALOLAN", 28, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "FLAME_WHEEL", "SHADOW_BONE", "BONE_CLUB", "WILL_O_WISP" } },
      { "SALANDIT", 28, ability = "CORROSION", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "TOXIC", "FLAME_BURST", "DRAGON_RAGE", "PROTECT" } },
      { "MAGMAR", 28, ability = "FLAME_BODY", nature = "NAIVE", item = "CHARCOAL", moves = { "FIRE_PUNCH", "THUNDER_PUNCH", "FEINT_ATTACK", "PROTECT" } },
      { "NINETALES", 28, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "FLAME_BURST", "SOLAR_BEAM", "HYPNOSIS", "PROTECT" } },
    } },
    -- Chapter 5: Lavaridge to Norman (draft 1, 2026-10-27; cap 31) --------------------
    -- Route 111 north of the desert (met on the way to Fallarbor): tag battles at 22-23
    TRAVIS = { partner = "R111N_ROY", party = {
      { "SANDYGAST", 22, ability = "WATER_COMPACTION", nature = "MODEST", item = "SPELL_TAG", moves = { "MUD_SLAP", "MEGA_DRAIN", "ABSORB", "SAND_ATTACK" } },
      { "STARAVIA", 22, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "AERIAL_ACE" } },
    } },
    IRENE = { partner = "R111N_ADA", party = {
      { "YAMASK", 22, ability = "MUMMY", nature = "IMPISH", spread = "bulk", moves = { "ASTONISH", "WILL_O_WISP", "CRAFTY_SHIELD" } },
      { "AZUMARILL", 22, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "ROLLOUT", "HELPING_HAND", "DEFENSE_CURL" } },
    } },
    WILTON_1 = { partner = "R111N_ZED", party = {
      { "KLINK", 23, ability = "PLUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "METAL_SOUND", "VISE_GRIP", "BIND", "AUTOTOMIZE" } },
      { "DRATINI", 22, ability = "MARVEL_SCALE", nature = "JOLLY", item = "DRAGON_FANG", moves = { "DRAGON_RAGE", "SLAM", "WRAP", "LEER" } },
      { "GOTHITA", 22, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
    } },
    BROOKE_1 = { partner = "R111N_MAY", party = {
      { "MONFERNO", 23, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "MACH_PUNCH", "FLAME_WHEEL", "FAKE_OUT", "TAUNT" } },
      { "KRABBY", 22, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "WATER_PULSE", "HIDDEN_POWER", "RAZOR_SHELL", "VISE_GRIP" } },
      { "ROSELIA", 22, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    DAISUKE = { partner = "R111N_KEN", party = {
      { "TIMBURR", 23, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "CRABRAWLER", 22, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "POWER_UP_PUNCH", "LEER", "PURSUIT" } },
    } },
    -- Trick House 2 (after the Dynamo Badge): tag battles at 24-25
    PAUL = { partner = "TH2_OLI", party = {
      { "EKANS", 24, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", moves = { "POISON_FANG", "POISON_STING", "BITE", "SCREECH" } },
      { "GOSSIFLEUR", 25, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "RAZOR_LEAF", "LEAFAGE", "LEAF_TORNADO" } },
    } },
    TED = { partner = "TH2_ABI", party = {
      { "KIRLIA", 25, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "WOOLOO", 24, ability = "RUN_AWAY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "HEADBUTT", "TACKLE", "COPYCAT", "GUARD_SPLIT" } },
    } },
    GEORGIA = { partner = "TH2_ZAC", party = {
      { "IMPIDIMP", 24, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "BITE", "ASSURANCE", "FLATTER" } },
      { "BEAUTIFLY", 25, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "MEGA_DRAIN", "ATTRACT", "STUN_SPORE" } },
    } },
    -- Route 111 desert: tag battles at 27-28 in the sandstorm
    DUSTY_1 = { partner = "DES_RAE", party = {
      { "SANDYGAST", 27, ability = "WATER_COMPACTION", nature = "MODEST", item = "SPELL_TAG", moves = { "BULLDOZE", "MEGA_DRAIN", "ABSORB", "HYPNOSIS" } },
      { "INDEEDEE", 28, ability = "SYNCHRONIZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "DISARMING_VOICE", "AFTER_YOU", "PLAY_NICE" } },
      { "SHIELDON", 27, ability = "STURDY", nature = "IMPISH", spread = "bulk", moves = { "IRON_DEFENSE", "ANCIENT_POWER", "PROTECT", "TAUNT" } },
    } },
    DREW = { partner = "DES_HAL", party = {
      { "SANDSLASH", 28, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
      { "PANSAGE", 27, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "SEED_BOMB", "VINE_WHIP", "RECYCLE" } },
    } },
    BEAU = { partner = "DES_IKE", party = {
      { "AMBIPOM", 28, ability = "TECHNICIAN", nature = "JOLLY", item = "SILK_SCARF", moves = { "FAKE_OUT", "FURY_SWIPES", "SWIFT", "BATON_PASS" } },
      { "ZORUA", 27, ability = "ILLUSION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "FEINT_ATTACK", "PURSUIT", "TAUNT" } },
    } },
    HEIDI = { partner = "DES_FLO", party = {
      { "HIPPOPOTAS", 28, ability = "SAND_STREAM", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "ROCK_SMASH", "DIG", "TAKE_DOWN" } },
      { "GLOOM", 27, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BECKY = { partner = "DES_LEA", party = {
      { "SNOVER", 28, ability = "SNOW_WARNING", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "RAZOR_LEAF", "MIST", "ICE_SHARD" } },
      { "GOLDEEN", 27, ability = "WATER_VEIL", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "WATER_PULSE", "HORN_ATTACK", "PECK", "WATER_SPORT" } },
    } },
    CELIA = { partner = "DES_NIA", party = {
      { "IVYSAUR", 28, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
      { "SKIPLOOM", 27, ability = "CHLOROPHYLL", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "SEED_BOMB", "ACROBATICS", "SYNTHESIS" } },
    } },
    BRYAN = { partner = "DES_OTT", party = {
      { "SINISTEA", 27, ability = "WEAK_ARMOR", nature = "BOLD", spread = "bulk", moves = { "HEX", "WILL_O_WISP", "PROTECT", "MEGA_DRAIN" } },
      { "TYRUNT", 28, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "ROCK_TOMB", "STOMP", "DRAGON_TAIL" } },
    } },
    BRANDEN = { partner = "DES_GIL", party = {
      { "CHATOT", 28, ability = "KEEN_EYE", nature = "TIMID", moves = { "AERIAL_ACE", "PLUCK", "PECK", "MIRROR_MOVE" } },
      { "LEAFEON", 27, ability = "LEAF_GUARD", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "QUICK_ATTACK", "BITE", "SYNTHESIS" } },
    } },
    -- Trick House 3 (after the Heat Badge): tag battles at 27-28
    JUSTIN = { partner = "TH3_MO", party = {
      { "KECLEON", 28, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
      { "ARROKUDA", 27, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", moves = { "WATER_PULSE", "DIVE", "AQUA_JET", "AGILITY" } },
      { "SANDSLASH_ALOLAN", 27, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
    } },
    MARTHA = { partner = "TH3_BO", party = {
      { "MEOWSTIC_FEMALE", 28, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "PANSAGE", 27, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "SEED_BOMB", "VINE_WHIP", "RECYCLE" } },
      { "IMPIDIMP", 27, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "BITE", "ASSURANCE", "FLATTER" } },
    } },
    ALAN = { partner = "TH3_AL", party = {
      { "CUBONE", 28, ability = "ROCK_HEAD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "BONE_CLUB", "HEADBUTT", "FALSE_SWIPE", "FOCUS_ENERGY" } },
      { "PROBOPASS", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
      { "RHYHORN", 27, ability = "LIGHTNING_ROD", nature = "IMPISH", spread = "tank", moves = { "ROCK_TOMB", "PROTECT", "BULLDOZE", "SMACK_DOWN" } },
    } },
    -- Petalburg Gym: trainers fight alone with three, like Norman: slow bruisers behind
    -- Trick Room, or Guts/Quick Feet with a status orb
    RANDALL = { tier = "gym", party = {
      { "SWELLOW", 29, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "AERIAL_ACE", "QUICK_ATTACK", "PROTECT" } },
      { "RATICATE", 28, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "FACADE", "SUCKER_PUNCH", "QUICK_ATTACK", "CRUNCH" } },
      { "LOPUNNY", 28, ability = "LIMBER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "CIRCLE_THROW", "QUICK_ATTACK", "BOUNCE" } },
    } },
    PARKER = { tier = "gym", party = {
      { "GIRAFARIG", 28, ability = "SAP_SIPPER", nature = "QUIET", spread = "stank", item = "TWISTED_SPOON", moves = { "TRICK_ROOM", "PSYBEAM", "STOMP", "PROTECT" } },
      { "SPINDA", 28, ability = "OWN_TEMPO", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
      { "STANTLER", 29, ability = "INTIMIDATE", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "STOMP", "TAKE_DOWN", "HYPNOSIS", "CONFUSE_RAY" } },
    } },
    GEORGE = { tier = "gym", party = {
      { "PORYGON", 28, ability = "TRACE", nature = "QUIET", spread = "stank", item = "EVIOLITE", moves = { "TRICK_ROOM", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
      { "CHANSEY", 29, ability = "NATURAL_CURE", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "SOFT_BOILED", "HELPING_HAND", "CHARM", "SING" } },
      { "DUNSPARCE", 28, ability = "SERENE_GRACE", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BODY_SLAM", "ROLLOUT", "YAWN" } },
    } },
    BERKE = { tier = "gym", party = {
      { "LICKITUNG", 28, ability = "OWN_TEMPO", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "ROLLOUT", "KNOCK_OFF", "STOMP", "DEFENSE_CURL" } },
      { "MUNCHLAX", 29, ability = "THICK_FAT", nature = "BRAVE", spread = "tank", item = "EVIOLITE", moves = { "BODY_SLAM", "BITE", "CHIP_AWAY", "RECYCLE" } },
      { "TEDDIURSA", 28, ability = "QUICK_FEET", nature = "ADAMANT", item = "FLAME_ORB", moves = { "FACADE", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    MARY = { tier = "gym", party = {
      { "PORYGON", 28, ability = "DOWNLOAD", nature = "QUIET", spread = "stank", item = "EVIOLITE", moves = { "TRICK_ROOM", "SIGNAL_BEAM", "PSYBEAM", "RECOVER" } },
      { "RATICATE_ALOLAN", 28, ability = "HUSTLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HYPER_FANG", "BITE", "QUICK_ATTACK", "FOCUS_ENERGY" } },
      { "DRAMPA", 29, ability = "BERSERK", nature = "QUIET", spread = "stank", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "ECHOED_VOICE", "GLARE", "TWISTER" } },
    } },
    ALEXIA = { tier = "gym", party = {
      { "MUNCHLAX", 28, ability = "THICK_FAT", nature = "BRAVE", spread = "tank", item = "EVIOLITE", moves = { "BODY_SLAM", "BITE", "CHIP_AWAY", "RECYCLE" } },
      { "STUFFUL", 28, ability = "FLUFFY", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "BRUTAL_SWING", "TAKE_DOWN", "BABY_DOLL_EYES", "PROTECT" } },
      { "MILTANK", 29, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STOMP", "ROLLOUT", "MILK_DRINK", "DEFENSE_CURL" } },
    } },
    JODY = { tier = "gym", party = {
      { "PORYGON", 28, ability = "TRACE", nature = "QUIET", spread = "stank", item = "EVIOLITE", moves = { "TRICK_ROOM", "SIGNAL_BEAM", "PSYBEAM", "THUNDER_WAVE" } },
      { "BOUFFALANT", 28, ability = "SAP_SIPPER", nature = "BRAVE", spread = "tank", item = "ORAN_BERRY", moves = { "HEADBUTT", "REVENGE", "PURSUIT", "FOCUS_ENERGY" } },
      { "ZANGOOSE", 29, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "FACADE", "SLASH", "QUICK_ATTACK", "HONE_CLAWS" } },
    } },
    -- Norman: six, alone (2-vs-1), Trick Room bruisers; Guts Ursaring is the ace at the cap
    NORMAN_1 = { tier = "leader", party = {
      { "KANGASKHAN", 30, ability = "SCRAPPY", nature = "ADAMANT", item = "SILK_SCARF", moves = { "FAKE_OUT", "BODY_SLAM", "SUCKER_PUNCH", "PROTECT" } },
      { "PORYGON2", 30, ability = "DOWNLOAD", nature = "QUIET", spread = "stank", item = "EVIOLITE", moves = { "TRICK_ROOM", "THUNDERBOLT", "ICE_BEAM", "RECOVER" } },
      { "SNORLAX", 30, ability = "THICK_FAT", nature = "BRAVE", spread = "tank", item = "LEFTOVERS", moves = { "BODY_SLAM", "CRUNCH", "YAWN", "PROTECT" } },
      { "BOUFFALANT", 30, ability = "SAP_SIPPER", nature = "BRAVE", spread = "tank", item = "SITRUS_BERRY", moves = { "HEAD_CHARGE", "ROCK_SLIDE", "REVENGE", "PROTECT" } },
      { "LICKITUNG", 30, ability = "OWN_TEMPO", nature = "RELAXED", spread = "bulk", item = "EVIOLITE", moves = { "BODY_SLAM", "KNOCK_OFF", "WRAP", "PROTECT" } },
      { "URSARING", 31, ability = "GUTS", nature = "BRAVE", item = "FLAME_ORB", moves = { "FACADE", "CRUNCH", "HAMMER_ARM", "PROTECT" } },
    } },
    -- Chapter 6a: sea routes, ship, Route 115 north, Route 118, Trick House 4 (draft 1, 2026-10-27) ----
    -- Route 118 west (from Mauville, no Surf): tag battles at 21-22
    WADE = { partner = "R118_IKE", party = {
      { "GYARADOS", 22, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "FRILLISH", 21, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", moves = { "BUBBLE", "CONFUSE_RAY", "HEX", "BUBBLE_BEAM" } },
    } },
    DEANDRE = { partner = "R118_POE", party = {
      { "RATICATE", 22, ability = "HUSTLE", nature = "ADAMANT", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "HYPER_FANG", "CRUNCH", "FOCUS_ENERGY" } },
      { "ARON", 21, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    ROSE_1 = { partner = "R118_IVY", party = {
      { "TOGETIC", 22, ability = "HUSTLE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "MAGICAL_LEAF", "DRAINING_KISS", "FOLLOW_ME" } },
      { "IVYSAUR", 22, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
    } },
    DALTON_1 = { partner = "R118_REX", party = {
      { "COMBEE", 22, ability = "HONEY_GATHER", nature = "JOLLY", spread = "atk", moves = { "AIR_CUTTER", "TAILWIND", "BUG_BITE", "GUST" } },
      { "LOUDRED", 22, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "BITE", "HOWL", "SUPERSONIC" } },
    } },
    -- Routes 105-108 (Surf): tag battles at 28-29
    LUIS = { partner = "SEA_ORR", party = {
      { "CARVANHA", 28, ability = "SPEED_BOOST", nature = "ADAMANT", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "SPRITZEE", 28, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
    } },
    DOMINIK = { partner = "SEA_GIL", party = {
      { "GYARADOS", 29, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "BRINE", "ICE_FANG", "DRAGON_RAGE" } },
      { "BASCULIN", 28, ability = "RECKLESS", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "AQUA_JET", "ICE_FANG", "AQUA_TAIL" } },
    } },
    DOUGLAS = { partner = "SEA_JON", party = {
      { "CRYOGONAL", 29, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICY_WIND", "WATER_PULSE", "ICE_BEAM", "AURORA_BEAM" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    BEVERLY = { partner = "SEA_AMY", party = {
      { "PELIPPER", 29, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "SALANDIT", 28, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", moves = { "VENOSHOCK", "FLAME_BURST", "EMBER", "POISON_GAS" } },
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
    } },
    IMANI = { partner = "SEA_ZOE", party = {
      { "AZUMARILL", 29, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "CLAUNCHER", 28, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
    } },
    KYLA = { partner = "SEA_FAY", party = {
      { "NIDORINA", 28, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "MANTYKE", 28, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "WATER_PULSE", "CONFUSE_RAY", "WIDE_GUARD" } },
    } },
    FOSTER = { partner = "SEA_RAE", party = {
      { "OMANYTE", 29, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "WATER_PULSE", "BITE", "PROTECT" } },
      { "CUFANT", 28, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", moves = { "STOMP", "BULLDOZE", "GROWL", "IRON_DEFENSE" } },
      { "UNOWN", 28, ability = "LEVITATE", nature = "MODEST", spread = "spa", moves = { "HIDDEN_POWER" } },
    } },
    ANDRES_1 = { partner = "SEA_OTT", party = {
      { "ARCHEN", 29, ability = "DEFEATIST", nature = "JOLLY", item = "SHARP_BEAK", moves = { "ANCIENT_POWER", "PLUCK", "QUICK_ATTACK", "ROCK_THROW" } },
      { "NOSEPASS", 28, ability = "STURDY", nature = "ADAMANT", spread = "atk", moves = { "ROCK_THROW", "THUNDER_WAVE", "ROCK_SLIDE", "HARDEN" } },
      { "PROBOPASS", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
    } },
    JOSUE = { partner = "SEA_SKY", party = {
      { "HERDIER", 29, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "FARFETCHD", 28, ability = "INNER_FOCUS", nature = "JOLLY", item = "BLACK_BELT", moves = { "AERIAL_ACE", "KARATE_CHOP", "PECK", "AIR_CUTTER" } },
    } },
    TARA = { partner = "SEA_KIM", party = {
      { "CROCONAW", 29, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BITE", "ICE_FANG", "AQUA_TAIL", "SCARY_FACE" } },
      { "CASTFORM", 28, ability = "FORECAST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "WEATHER_BALL", "HEADBUTT", "TACKLE", "EMBER" } },
      { "HORSEA", 28, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    LISA_AND_RAY = { party = {
      { "DUCKLETT", 28, ability = "KEEN_EYE", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BUBBLE_BEAM", "AERIAL_ACE", "AQUA_RING" } },
      { "MAREANIE", 28, ability = "REGENERATOR", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BITE", "PECK", "TOXIC_SPIKES" } },
      { "BRUXISH", 28, ability = "STRONG_JAW", nature = "JOLLY", moves = { "AQUA_JET", "BITE", "CRUNCH", "DISABLE" } },
      { "QWILFISH", 28, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "AQUA_JET", "PROTECT", "REVENGE", "FELL_STINGER" } },
    } },
    DARRIN = { partner = "SEA_LEO", party = {
      { "SEEL", 28, ability = "THICK_FAT", nature = "JOLLY", spread = "atk", moves = { "HEADBUTT", "ICE_SHARD", "WATER_SPORT", "AQUA_RING" } },
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "PELIPPER", 29, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    TONY_1 = { partner = "SEA_MAC", party = {
      { "CARVANHA", 29, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "FEEBAS", 28, ability = "SWIFT_SWIM", nature = "JOLLY", moves = { "PROTECT", "TACKLE" } },
    } },
    JEROME = { partner = "SEA_HAL", party = {
      { "FRILLISH", 29, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "BRINE", "HEX", "BUBBLE_BEAM", "OMINOUS_WIND" } },
      { "BERGMITE", 28, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "ICE_FANG", "TAKE_DOWN", "HARDEN" } },
    } },
    MATTHEW = { partner = "SEA_DUN", party = {
      { "DREDNAW", 29, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
      { "PIKACHU", 28, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    DENISE = { partner = "SEA_ELA", party = {
      { "BINACLE", 28, ability = "SNIPER", nature = "MODEST", spread = "spa", moves = { "WATER_PULSE", "SLASH", "CLAMP", "WITHDRAW" } },
      { "GOLDEEN", 28, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
    } },
    CORY_1 = { partner = "SEA_BEN", party = {
      { "EMOLGA", 29, ability = "STATIC", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "THUNDER_SHOCK", "SHOCK_WAVE", "CHARGE", "NASTY_PLOT" } },
      { "POLIWHIRL", 28, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    MISSY = { partner = "SEA_LIA", party = {
      { "STARYU", 28, ability = "ILLUMINATE", nature = "MODEST", spread = "spa", moves = { "WATER_GUN", "BRINE", "BUBBLE_BEAM", "CONFUSE_RAY" } },
      { "PYUKUMUKU", 29, ability = "INNARDS_OUT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "HELPING_HAND", "BIDE", "PURIFY", "MUD_SPORT" } },
    } },
    CAROLINA = { partner = "SEA_PIA", party = {
      { "MANECTRIC", 29, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "PASSIMIAN", 29, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
      { "SNOVER", 28, ability = "SNOW_WARNING", nature = "JOLLY", moves = { "LEECH_SEED", "RAZOR_LEAF", "ICE_SHARD", "LEAFAGE" } },
    } },
    BETH = { partner = "SEA_UMA", party = {
      { "LOMBRE", 29, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "BODY_SLAM", "GIGA_DRAIN", "NATURE_POWER" } },
      { "LUVDISC", 29, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    CAMRON = { partner = "SEA_TOD", party = {
      { "STARMIE", 30, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "BINACLE", 29, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "SLASH", "CLAMP", "WITHDRAW" } },
    } },
    -- Abandoned Ship: tag battles at 28-29; the young couple is a double
    JANI = { partner = "SHIP_BO", party = {
      { "GOOMY", 28, ability = "SAP_SIPPER", nature = "MODEST", moves = { "DRAGON_BREATH", "WATER_PULSE", "PROTECT", "BUBBLE" } },
      { "FLOATZEL", 28, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "TAUNT", "CRUNCH", "ICE_FANG" } },
      { "FURRET", 28, ability = "FRISK", nature = "JOLLY", item = "SILK_SCARF", moves = { "SLAM", "QUICK_ATTACK", "HELPING_HAND", "FOLLOW_ME" } },
    } },
    DUNCAN = { partner = "SHIP_WES", party = {
      { "MACHOKE", 29, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "SPIRITOMB", 28, ability = "PRESSURE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "PURSUIT", "SHADOW_SNEAK", "OMINOUS_WIND" } },
    } },
    GARRISON = { partner = "SHIP_RIO", party = {
      { "TIRTOUGA", 29, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "BITE", "AQUA_JET", "PROTECT" } },
      { "MUDBRAY", 28, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "SOFT_SAND", moves = { "ROCK_TOMB", "STEALTH_ROCK", "HIGH_HORSEPOWER", "BULLDOZE" } },
      { "GRAVELER_ALOLAN", 28, ability = "GALVANIZE", nature = "ADAMANT", moves = { "ROCK_TOMB", "SPARK", "SMACK_DOWN", "ROCK_POLISH" } },
    } },
    CHARLIE = { partner = "SHIP_DOT", party = {
      { "SHELLOS", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "ICY_WIND", "PROTECT", "BUBBLE_BEAM" } },
      { "OCTILLERY", 29, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "OCTAZOOKA", "PSYBEAM", "AURORA_BEAM", "FOCUS_ENERGY" } },
    } },
    THALIA_1 = { partner = "SHIP_LIV", party = {
      { "TOGETIC", 29, ability = "HUSTLE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAIRY_WIND", "MAGICAL_LEAF", "WISH", "DRAINING_KISS" } },
      { "KIRLIA", 29, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    DEMETRIUS = { partner = "SHIP_KIP", party = {
      { "ELECTABUZZ", 29, ability = "STATIC", nature = "MODEST", item = "MAGNET", moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "THUNDER_PUNCH" } },
      { "TRANQUILL", 28, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AIR_CUTTER", "GUST", "TAUNT" } },
    } },
    KIRA_AND_DAN_1 = { party = {
      { "ILLUMISE", 29, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", moves = { "STRUGGLE_BUG", "CONFUSE_RAY", "MOONLIGHT", "TACKLE" } },
      { "ILLUMISE", 29, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    -- Route 109 and 103 (Surf): tag battles at 28-29
    GWEN = { partner = "R109S_ANN", party = {
      { "SEEL", 29, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
      { "QUAGSIRE", 28, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", moves = { "MUD_SHOT", "AQUA_TAIL", "YAWN", "PROTECT" } },
      { "LUVDISC", 28, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    ALICE = { partner = "R109S_EVE", party = {
      { "CORSOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
      { "SIMIPOUR", 29, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
      { "BOUFFALANT", 28, ability = "SAP_SIPPER", nature = "ADAMANT", moves = { "PROTECT", "HORN_ATTACK", "RAGE", "FURY_ATTACK" } },
    } },
    AUSTINA = { partner = "R109S_KIT", party = {
      { "SHELLOS_EAST_SEA", 28, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "HIDDEN_POWER" } },
      { "FURRET", 28, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "SLAM", "SCRATCH" } },
    } },
    DAVID = { partner = "R109S_GUS", party = {
      { "CORPHISH", 28, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
      { "PHANTUMP", 28, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "ASTONISH", "FEINT_ATTACK", "CONFUSE_RAY", "INGRAIN" } },
    } },
    CARTER = { partner = "R109S_NED", party = {
      { "LANTURN", 29, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "SPARK", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "BUIZEL", 28, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", moves = { "BUBBLE_BEAM", "AQUA_JET", "QUICK_ATTACK", "GROWL" } },
    } },
    MEL_AND_PAUL = { party = {
      { "BEEDRILL", 29, ability = "SWARM", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PROTECT", "BUG_BITE", "TWINEEDLE", "PIN_MISSILE" } },
      { "BEAUTIFLY", 29, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "MEGA_DRAIN", "STUN_SPORE", "ATTRACT" } },
    } },
    ELIJAH = { partner = "R109S_ACE", party = {
      { "SKARMORY", 29, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "METAL_CLAW", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
      { "WEAVILE", 28, ability = "PRESSURE", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "ASSURANCE", "NASTY_PLOT", "HONE_CLAWS" } },
    } },
    ISABELLE = { partner = "R103S_MEG", party = {
      { "SALANDIT", 28, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", moves = { "VENOSHOCK", "FLAME_BURST", "EMBER", "POISON_GAS" } },
      { "CRYOGONAL", 29, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICY_WIND", "WATER_PULSE", "ICE_BEAM", "AURORA_BEAM" } },
      { "QWILFISH", 28, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "AQUA_JET", "PROTECT", "REVENGE", "FELL_STINGER" } },
    } },
    PETE = { partner = "R103S_SAM", party = {
      { "WARTORTLE", 29, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BITE", "PROTECT", "RAPID_SPIN" } },
      { "WISHIWASHI", 28, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    -- Route 115 north (Surf): tag battles at 28-29
    KOICHI = { partner = "R115N_DAN", party = {
      { "CRABOMINABLE", 29, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "AVALANCHE", "LEER" } },
      { "HAWLUCHA", 28, ability = "LIMBER", nature = "ADAMANT", moves = { "ROCK_SMASH", "FEINT", "QUICK_GUARD", "BRICK_BREAK" } },
      { "MIENFOO", 28, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "POUND", "FAKE_OUT", "DETECT", "CALM_MIND" } },
    } },
    KYRA = { partner = "R115N_JO", party = {
      { "FLAREON", 29, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_FANG", "BITE", "QUICK_ATTACK", "HELPING_HAND" } },
      { "SWADLOON", 28, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", moves = { "BUG_BITE", "PROTECT", "RAZOR_LEAF", "GRASS_WHISTLE" } },
      { "DODUO", 28, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "PURSUIT", "QUICK_ATTACK", "AGILITY" } },
    } },
    JAIDEN = { partner = "R115N_KO", party = {
      { "NINJASK", 28, ability = "SPEED_BOOST", nature = "JOLLY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "SWALOT", 29, ability = "STICKY_HOLD", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "SLUDGE", "YAWN", "STOCKPILE", "ACID_SPRAY" } },
      { "CROAGUNK", 28, ability = "DRY_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "VENOSHOCK", "REVENGE", "SUCKER_PUNCH", "FLATTER" } },
    } },
    ALIX = { partner = "R115N_VIC", party = {
      { "MR_MIME", 29, ability = "FILTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "CONFUSION", "QUICK_GUARD" } },
      { "INKAY", 28, ability = "CONTRARY", nature = "ADAMANT", spread = "atk", moves = { "FOUL_PLAY", "PAYBACK", "PSYBEAM", "SWITCHEROO" } },
    } },
    HELENE = { partner = "R115N_ROX", party = {
      { "MEDITITE", 28, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "SKIPLOOM", 29, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "ACROBATICS", "BULLET_SEED", "MEGA_DRAIN" } },
    } },
    TIMOTHY_1 = { partner = "R115N_KEN", party = {
      { "PRIMEAPE", 29, ability = "VITAL_SPIRIT", nature = "ADAMANT", spread = "tank", moves = { "CROSS_CHOP", "KARATE_CHOP", "LEER", "FOCUS_ENERGY" } },
      { "DUSKULL", 29, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "KADABRA", 29, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    -- Route 118 east (Surf) and Trick House 4: tag battles at 29-30
    BARNY = { partner = "R118E_HAL", party = {
      { "TENTACOOL", 29, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "CARVANHA", 29, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
      { "FRILLISH", 29, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "BRINE", "HEX", "BUBBLE_BEAM", "OMINOUS_WIND" } },
    } },
    PERRY = { partner = "R118E_JAY", party = {
      { "CHANSEY", 30, ability = "SERENE_GRACE", nature = "TIMID", item = "SILK_SCARF", moves = { "TAKE_DOWN", "POUND", "DOUBLE_SLAP", "COPYCAT" } },
      { "HERDIER", 29, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "DARTRIX", 29, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PLUCK", "FORESIGHT" } },
    } },
    CHESTER = { partner = "R118E_KAY", party = {
      { "PIDGEOTTO", 30, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", moves = { "TAILWIND", "QUICK_ATTACK", "AIR_CUTTER", "GUST" } },
      { "ZORUA", 29, ability = "ILLUSION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "KNOCK_OFF", "FEINT_ATTACK", "TAUNT", "FAKE_TEARS" } },
    } },
    CORA = { partner = "TH4_ZIA", party = {
      { "MEDITITE", 29, ability = "PURE_POWER", nature = "JOLLY", moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "PASSIMIAN", 29, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
      { "SKORUPI", 29, ability = "SNIPER", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "TAUNT", "BUG_BITE", "POISON_FANG" } },
    } },
    PAULA = { partner = "TH4_MAE", party = {
      { "BRELOOM", 30, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "FORCE_PALM" } },
      { "MIENFOO", 29, ability = "INNER_FOCUS", nature = "ADAMANT", moves = { "FORCE_PALM", "POUND", "DETECT", "CALM_MIND" } },
      { "POLIWHIRL", 29, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    YUJI = { partner = "TH4_GOR", party = {
      { "HARIYAMA", 30, ability = "GUTS", nature = "ADAMANT", spread = "tank", item = "FLAME_ORB", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PAWNIARD", 29, ability = "PRESSURE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "LOW_SWEEP", "HEADBUTT", "PROTECT" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34) ----------
    -- Route 119: tag battles at 30-31 in the rain and long grass
    CHRIS = { partner = "R119_BO", party = {
      { "GYARADOS", 31, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "BITE", "ICE_FANG", "DRAGON_DANCE" } },
      { "BRUXISH", 30, ability = "STRONG_JAW", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "CRUNCH", "AQUA_TAIL", "DISABLE" } },
      { "BARBOACH", 30, ability = "HYDRATION", nature = "MODEST", spread = "stank", moves = { "MUD_BOMB", "WATER_PULSE", "AMNESIA", "PROTECT" } },
    } },
    DONALD = { partner = "R119_GUS", party = {
      { "WHIRLIPEDE", 30, ability = "POISON_POINT", nature = "IMPISH", spread = "bulk", moves = { "BUG_BITE", "PROTECT", "POISON_TAIL", "IRON_DEFENSE" } },
      { "BEEDRILL", 31, ability = "SWARM", nature = "JOLLY", spread = "atk", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "TAILWIND", "BUG_BITE", "TWINEEDLE" } },
      { "VENONAT", 30, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    TAYLOR = { partner = "R119_TED", party = {
      { "PARASECT", 31, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "STUN_SPORE", "X_SCISSOR", "CROSS_POISON" } },
      { "MASQUERAIN", 30, ability = "INTIMIDATE", nature = "MODEST", moves = { "LIQUIDATION", "AIR_CUTTER", "GUST", "BUBBLE_BEAM" } },
      { "VIVILLON", 30, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", moves = { "SLEEP_POWDER", "BUG_BUZZ", "GUST", "STRUGGLE_BUG" } },
    } },
    HUGH = { partner = "R119_CY", party = {
      { "NOCTOWL", 30, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "PERSIAN", 31, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", moves = { "AERIAL_ACE", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "TROPIUS", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
    } },
    YASU = { partner = "R119_KO", party = {
      { "FROGADIER", 31, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "GOLBAT", 30, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "STUNKY", 30, ability = "AFTERMATH", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "SCARY_FACE", "SUCKER_PUNCH", "BITE", "VENOSHOCK" } },
    } },
    DOUG = { partner = "R119_LIL", party = {
      { "ARAQUANID", 31, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "LEECH_LIFE", "BUG_BITE", "WIDE_GUARD" } },
      { "ARIADOS", 30, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_JAB", "SUCKER_PUNCH", "SPIDER_WEB", "SHADOW_SNEAK" } },
    } },
    GREG = { partner = "R119_PIP", party = {
      { "LEDIAN", 30, ability = "EARLY_BIRD", nature = "JOLLY", moves = { "MACH_PUNCH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
      { "BUTTERFREE", 31, ability = "COMPOUND_EYES", nature = "TIMID", item = "SILVER_POWDER", moves = { "PROTECT", "AIR_SLASH", "SILVER_WIND", "GUST" } },
      { "ACCELGOR", 30, ability = "STICKY_HOLD", nature = "MODEST", item = "ORAN_BERRY", moves = { "PROTECT", "STRUGGLE_BUG", "GIGA_DRAIN", "ME_FIRST" } },
    } },
    PHIL = { partner = "R119_SKY", party = {
      { "FLETCHINDER", 31, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
      { "CHATOT", 30, ability = "KEEN_EYE", nature = "TIMID", moves = { "AERIAL_ACE", "PLUCK", "PECK", "MIRROR_MOVE" } },
    } },
    TAKASHI = { partner = "R119_ZEN", party = {
      { "ESCAVALIER", 31, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "DOUBLE_TEAM", "DOUBLE_EDGE" } },
      { "KOFFING", 30, ability = "LEVITATE", nature = "BOLD", spread = "bulk", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
    } },
    JACKSON_1 = { partner = "R119_RAN", party = {
      { "DREDNAW", 31, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
      { "ROTOM", 30, ability = "LEVITATE", nature = "TIMID", spread = "spa", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "FROSMOTH", 30, ability = "SHIELD_DUST", nature = "MODEST", moves = { "LEECH_LIFE", "PROTECT", "AURORA_BEAM", "ICY_WIND" } },
    } },
    CATHERINE_1 = { partner = "R119_WEN", party = {
      { "GLOOM", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "POLIWHIRL", 31, ability = "WATER_ABSORB", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "MUD_SHOT", "BODY_SLAM", "DOUBLE_SLAP" } },
      { "BERGMITE", 30, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "ICE_FANG", "TAKE_DOWN", "HARDEN" } },
    } },
    KENT = { partner = "R119_ABE", party = {
      { "NINJASK", 31, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "SHEDINJA", 30, ability = "WONDER_GUARD", nature = "ADAMANT", item = "FOCUS_SASH", moves = { "SHADOW_SNEAK", "FURY_CUTTER", "CONFUSE_RAY", "MIND_READER" } },
    } },
    HIDEO = { partner = "R119_JIN", party = {
      { "SCRAGGY", 31, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
      { "GRIMER", 30, ability = "STICKY_HOLD", nature = "ADAMANT", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    FABIAN = { partner = "R119_JAX", party = {
      { "MANECTRIC", 31, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "DUNSPARCE", 30, ability = "RATTLED", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "TAKE_DOWN", "BODY_SLAM", "RAGE", "YAWN" } },
    } },
    DAYTON = { partner = "R119_ASH", party = {
      { "SLUGMA", 30, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
      { "PANSEAR", 31, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_PUNCH", "BITE", "CRUNCH", "YAWN" } },
    } },
    RACHEL = { partner = "R119_UMA", party = {
      { "LOMBRE", 30, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "KNOCK_OFF" } },
      { "ZEBSTRIKA", 31, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", item = "MAGNET", moves = { "THUNDERBOLT", "QUICK_ATTACK", "VOLT_SWITCH", "JUMP_KICK" } },
    } },
    BRENT = { partner = "R119_DON", party = {
      { "YANMA", 31, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", moves = { "BUG_BITE", "AIR_CUTTER", "UPROAR", "FORESIGHT" } },
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
      { "JOLTIK", 31, ability = "COMPOUND_EYES", nature = "MODEST", item = "SILVER_POWDER", moves = { "X_SCISSOR", "PROTECT", "ELECTROWEB", "ABSORB" } },
      { "BALTOY", 31, ability = "LEVITATE", nature = "BOLD", spread = "bulk", moves = { "PSYBEAM", "ANCIENT_POWER", "ROCK_TOMB", "REFLECT" } },
      { "AERODACTYL", 32, ability = "PRESSURE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BITE", "WING_ATTACK", "TAILWIND" } },
    } },
    JEFFREY_1 = { partner = "R120_GUS", party = {
      { "HEATMOR", 31, ability = "GLUTTONY", nature = "JOLLY", moves = { "IRON_HEAD", "METAL_CLAW", "BUG_BITE", "ODOR_SLEUTH" } },
      { "MOTHIM", 32, ability = "SWARM", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "AIR_SLASH", "SILVER_WIND", "PROTECT" } },
      { "MASQUERAIN", 31, ability = "INTIMIDATE", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "AIR_SLASH", "BUG_BUZZ", "STUN_SPORE", "TAILWIND" } },
    } },
    COLIN = { partner = "R120_SKY", party = {
      { "DODUO", 31, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "PURSUIT", "QUICK_ATTACK", "AGILITY" } },
      { "XATU", 32, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "SIGILYPH", 31, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", moves = { "AIR_SLASH", "SYNCHRONOISE", "PSYBEAM", "GRAVITY" } },
    } },
    KEIGO = { partner = "R120_KO", party = {
      { "FROGADIER", 32, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "KOFFING", 31, ability = "LEVITATE", nature = "BOLD", spread = "bulk", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "SCRAGGY", 31, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
    } },
    ROBERT_1 = { partner = "R120_ACE", party = {
      { "PERSIAN", 32, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", moves = { "AERIAL_ACE", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "FLETCHINDER", 32, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    CLARISSA = { partner = "R120_NIA", party = {
      { "GOGOAT", 32, ability = "GRASS_PELT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "SEED_BOMB", "TAKE_DOWN", "SYNTHESIS" } },
      { "WAILMER", 31, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "PONYTA", 31, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "BLAZE_KICK", "FLAME_WHEEL", "FLAME_CHARGE", "EMBER" } },
    } },
    ANGELICA = { partner = "R120_PIA", party = {
      { "MEOWSTIC_FEMALE", 32, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "CASTFORM", 31, ability = "FORECAST", nature = "MODEST", spread = "spa", moves = { "WEATHER_BALL", "RAIN_DANCE", "SUNNY_DAY", "ICE_BEAM" } },
      { "CRAMORANT", 31, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "AIR_SLASH", "DIVE", "PLUCK", "STOCKPILE" } },
    } },
    LORENZO = { partner = "R120_RAN", party = {
      { "LUDICOLO", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "RAIN_DANCE" } },
      { "KANGASKHAN", 31, ability = "INNER_FOCUS", nature = "JOLLY", moves = { "FACADE", "CRUSH_CLAW", "MEGA_PUNCH", "CHIP_AWAY" } },
      { "NIDOQUEEN", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    JENNA = { partner = "R120_WEN", party = {
      { "SHIFTRY", 32, ability = "CHLOROPHYLL", nature = "ADAMANT", moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "EXPLOSION" } },
      { "QWILFISH", 31, ability = "POISON_POINT", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "REVENGE", "FELL_STINGER", "STOCKPILE" } },
      { "NIDOKING", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
    } },
    RILEY = { partner = "R120_JIN", party = {
      { "CROAGUNK", 32, ability = "DRY_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUCKER_PUNCH", "VENOSHOCK", "POISON_JAB", "REVENGE" } },
      { "MOTHIM", 31, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "AIR_SLASH", "QUIVER_DANCE", "PROTECT" } },
    } },
    CALLIE = { partner = "R120_ROX", party = {
      { "MEDITITE", 31, ability = "PURE_POWER", nature = "JOLLY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "DETECT" } },
      { "CINCCINO", 32, ability = "SKILL_LINK", nature = "JOLLY", item = "ORAN_BERRY", moves = { "POUND", "TAIL_SLAP", "DOUBLE_SLAP", "SWIFT" } },
      { "PANCHAM", 31, ability = "MOLD_BREAKER", nature = "JOLLY", moves = { "DRAIN_PUNCH", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    JENNIFER = { partner = "R120_MAX", party = {
      { "SABLEYE", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "JANGMO_O", 31, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
      { "LILLIGANT", 32, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "GIGA_DRAIN", "ENERGY_BALL", "ENCORE", "MEGA_DRAIN" } },
    } },
    LEONEL = { partner = "R120_LEO", party = {
      { "VIKAVOLT", 32, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "BUG_BUZZ", "AIR_SLASH", "STRING_SHOT" } },
      { "STEENEE", 31, ability = "SWEET_VEIL", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "RAZOR_LEAF", "STOMP", "TEETER_DANCE" } },
      { "PSYDUCK", 31, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    -- Fortree Gym: trainers fight alone with three, like Winona: a Tailwind setter and a
    -- Steel or Ground partner (Earthquake beside the flyers)
    JARED = { tier = "gym", party = {
      { "NOIBAT", 33, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "AIR_SLASH", "DRAGON_PULSE", "BITE" } },
      { "SWOOBAT", 32, ability = "SIMPLE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "PSYCHIC", "CALM_MIND", "ROOST" } },
      { "SANDSLASH", 32, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "ROCK_SLIDE", "KNOCK_OFF", "PROTECT" } },
    } },
    HUMBERTO = { tier = "gym", party = {
      { "VULLABY", 32, ability = "OVERCOAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "TAILWIND", "KNOCK_OFF", "PLUCK", "IRON_DEFENSE" } },
      { "GLIGAR", 33, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "ACROBATICS", "KNOCK_OFF", "PROTECT" } },
      { "HAWLUCHA", 32, ability = "UNBURDEN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "FEATHER_DANCE", "DETECT" } },
    } },
    EDWARDO = { tier = "gym", party = {
      { "STARAVIA", 32, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "TAILWIND", "AERIAL_ACE", "QUICK_ATTACK", "REVENGE" } },
      { "SKARMORY", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STEEL_WING", "AIR_CUTTER", "SPIKES", "PROTECT" } },
      { "DRIFBLIM", 32, ability = "UNBURDEN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "HEX", "TAILWIND", "WILL_O_WISP" } },
    } },
    FLINT = { tier = "gym", party = {
      { "MANTINE", 32, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "TAILWIND", "WATER_PULSE", "AIR_SLASH", "WIDE_GUARD" } },
      { "VIBRAVA", 33, ability = "LEVITATE", nature = "JOLLY", item = "EVIOLITE", moves = { "EARTHQUAKE", "DRAGON_BREATH", "ROCK_SLIDE", "U_TURN" } },
      { "YANMEGA", 32, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "BUG_BUZZ", "DETECT", "ANCIENT_POWER" } },
    } },
    ASHLEY = { tier = "gym", party = {
      { "DUCKLETT", 33, ability = "BIG_PECKS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "WATER_PULSE", "AIR_SLASH", "FEATHER_DANCE" } },
      { "MAGNETON", 32, ability = "STURDY", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLASH_CANNON", "SPARK", "THUNDER_WAVE", "PROTECT" } },
      { "RUFFLET", 32, ability = "HUSTLE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "WING_ATTACK", "HONE_CLAWS", "SLASH" } },
    } },
    DARIUS = { tier = "gym", party = {
      { "TROPIUS", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "TAILWIND", "MAGICAL_LEAF", "AIR_SLASH", "PROTECT" } },
      { "DUGTRIO", 33, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", moves = { "EARTHQUAKE", "SUCKER_PUNCH", "ROCK_SLIDE", "PROTECT" } },
      { "DODRIO", 32, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
    } },
    -- Winona: six, alone (2-vs-1), Tailwind with Steel/Ground partners; Staraptor is the
    -- ace at the cap
    WINONA_1 = { tier = "leader", party = {
      { "PELIPPER", 33, ability = "KEEN_EYE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "TAILWIND", "AIR_SLASH", "SCALD", "WIDE_GUARD" } },
      { "VIBRAVA", 33, ability = "LEVITATE", nature = "JOLLY", item = "EVIOLITE", moves = { "EARTHQUAKE", "DRAGON_BREATH", "ROCK_SLIDE", "U_TURN" } },
      { "SKARMORY", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "STEEL_WING", "AIR_CUTTER", "TAUNT", "PROTECT" } },
      { "LAIRON", 33, ability = "ROCK_HEAD", nature = "ADAMANT", item = "EVIOLITE", moves = { "IRON_HEAD", "ROCK_SLIDE", "TAKE_DOWN", "PROTECT" } },
      { "ALTARIA", 33, ability = "NATURAL_CURE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DRAGON_DANCE", "DRAGON_CLAW", "EARTHQUAKE", "ROOST" } },
      { "STARAPTOR", 34, ability = "INTIMIDATE", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "CLOSE_COMBAT", "QUICK_ATTACK", "PROTECT" } },
    } },
    -- Chapter 7a: Routes 121-123, Mt. Pyre, Lilycove rival (draft 1, 2026-10-27; cap 35) ----
    -- Route 121: tag battles at 32-33; the breeders fight alone with four
    MYLES = { party = {
      { "CRABOMINABLE", 33, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "AVALANCHE", "LEER" } },
      { "TOGETIC", 32, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "LITWICK", 32, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "FLAME_BURST", "CLEAR_SMOG", "HEX", "CONFUSE_RAY" } },
      { "MILTANK", 33, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STOMP", "ROLLOUT", "MILK_DRINK", "DEFENSE_CURL" } },
    } },
    PAT = { party = {
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
      { "ZANGOOSE", 32, ability = "IMMUNITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "REVENGE", "PURSUIT", "FOCUS_ENERGY", "CRUSH_CLAW" } },
      { "TYNAMO", 32, ability = "LEVITATE", nature = "TIMID", item = "MAGNET", moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "LYCANROC", 33, ability = "SAND_RUSH", nature = "JOLLY", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BITE", "ACCELEROCK", "ROCK_TOMB" } },
    } },
    JESSICA_1 = { partner = "R121_ANN", party = {
      { "KROKOROK", 33, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "SAND_TOMB", "TORMENT" } },
      { "TRUBBISH", 32, ability = "STENCH", nature = "ADAMANT", item = "POISON_BARB", moves = { "SLUDGE_BOMB", "SLUDGE", "CLEAR_SMOG", "ACID_SPRAY" } },
      { "KECLEON", 32, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    CALE = { partner = "R121_GUS", party = {
      { "WORMADAM", 33, ability = "ANTICIPATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ENERGY_BALL", "CONFUSION", "PROTECT" } },
      { "WORMADAM", 32, ability = "ANTICIPATION", nature = "IMPISH", spread = "bulk", moves = { "BUG_BITE", "PROTECT", "SUCKER_PUNCH", "LEAF_STORM" } },
    } },
    TAMMY = { partner = "R121_WEN", party = {
      { "GOURGEIST", 33, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "MEGA_DRAIN" } },
      { "SHUPPET", 32, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    WALTER_1 = { partner = "R121_MAX", party = {
      { "ELECTIVIRE", 33, ability = "MOTOR_DRIVE", nature = "ADAMANT", item = "MAGNET", moves = { "SWAGGER", "CROSS_CHOP", "THUNDER_PUNCH", "DISCHARGE" } },
      { "BARRASKEWDA", 32, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "DIVE", "THROAT_CHOP", "AGILITY" } },
      { "LINOONE", 32, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "HEADBUTT", "COVET", "PROTECT" } },
    } },
    VANESSA = { partner = "R121_PIA", party = {
      { "RAICHU", 33, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
      { "PACHIRISU", 32, ability = "PICKUP", nature = "TIMID", moves = { "SPARK", "NUZZLE", "U_TURN", "DEFENSE_CURL" } },
      { "GRANBULL", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PLAY_ROUGH", "BITE", "ROAR", "HEADBUTT" } },
    } },
    MARCEL = { partner = "R121_TOD", party = {
      { "SHIFTRY", 33, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "FEINT_ATTACK" } },
      { "BOLTUND", 33, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", moves = { "SPARK", "FLAME_CHARGE", "CRUNCH", "CHARM" } },
      { "UNFEZANT", 32, ability = "BIG_PECKS", nature = "ADAMANT", moves = { "DRILL_PECK", "QUICK_ATTACK", "RAZOR_WIND", "AIR_SLASH" } },
    } },
    KATE_AND_JOY = { party = {
      { "ELGYEM", 33, ability = "SYNCHRONIZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "CALM_MIND", "PSYBEAM", "CONFUSION" } },
      { "VIGOROTH", 33, ability = "VITAL_SPIRIT", nature = "ADAMANT", item = "EVIOLITE", moves = { "SLASH", "FEINT_ATTACK", "SLACK_OFF", "BULK_UP" } },
    } },
    CRISTIN_1 = { partner = "R121_ROX", party = {
      { "NINETALES", 33, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "TRAPINCH", 32, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
      { "STARAVIA", 32, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "AIR_SLASH", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    -- Route 122 and Mt. Pyre: tag battles at 32-34; the Aqua grunts at the summit fight alone
    GABRIELLE_1 = { party = {
      { "CUBCHOO", 33, ability = "RATTLED", nature = "IMPISH", spread = "bulk", item = "NEVER_MELT_ICE", moves = { "AVALANCHE", "ICE_FANG", "THRASH", "SLASH" } },
      { "BAYLEEF", 33, ability = "LEAF_GUARD", nature = "BOLD", spread = "bulk", moves = { "RAZOR_LEAF", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "RAICHU_ALOLAN", 33, ability = "SURGE_SURFER", nature = "TIMID", spread = "spa", moves = { "PSYCHIC", "SPARK", "NUZZLE", "THUNDER_WAVE" } },
      { "DONPHAN", 33, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "ROLLOUT", "KNOCK_OFF", "RAPID_SPIN" } },
    } },
    ZANDER = { partner = "PYRE_DAN", party = {
      { "HARIYAMA", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PRIMEAPE", 33, ability = "ANGER_POINT", nature = "ADAMANT", item = "BLACK_BELT", moves = { "BRICK_BREAK", "CROSS_CHOP", "THRASH", "LEER" } },
      { "PIGNITE", 32, ability = "THICK_FAT", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLAME_CHARGE", "ARM_THRUST", "ROCK_TOMB", "HELPING_HAND" } },
    } },
    LEAH = { partner = "PYRE_ELI", party = {
      { "VICTREEBEL", 33, ability = "CHLOROPHYLL", nature = "JOLLY", spread = "atk", item = "MIRACLE_SEED", moves = { "SLUDGE_BOMB", "POISON_JAB", "RAZOR_LEAF", "SWALLOW" } },
      { "SPOINK", 32, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "MALAMAR", 32, ability = "INFILTRATOR", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "FOUL_PLAY", "PAYBACK", "PSYBEAM", "SWITCHEROO" } },
    } },
    VALERIE_1 = { partner = "PYRE_NIA", party = {
      { "SABLEYE", 33, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "HONEDGE", 32, ability = "NO_GUARD", nature = "BOLD", spread = "bulk", moves = { "SHADOW_SNEAK", "RETALIATE", "SLASH", "IRON_DEFENSE" } },
      { "SPIRITOMB", 33, ability = "INFILTRATOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "HEX", "SUCKER_PUNCH", "CONFUSE_RAY", "NASTY_PLOT" } },
    } },
    TASHA = { partner = "PYRE_ZIA", party = {
      { "HAUNTER", 33, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SPELL_TAG", moves = { "HEX", "WILL_O_WISP", "SHADOW_PUNCH", "SPITE" } },
      { "SHUPPET", 32, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "COFAGRIGUS", 33, ability = "MUMMY", nature = "MODEST", item = "ORAN_BERRY", moves = { "WILL_O_WISP", "MIRROR_SHOT", "HEX", "OMINOUS_WIND" } },
    } },
    MARK = { partner = "PYRE_OTT", party = {
      { "RHYHORN", 33, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "AXEW", 32, ability = "MOLD_BREAKER", nature = "ADAMANT", moves = { "DRAGON_CLAW", "CRUNCH", "ASSURANCE", "TAUNT" } },
      { "SNORLAX", 33, ability = "IMMUNITY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROLLOUT", "DEFENSE_CURL", "LAST_RESORT", "BODY_SLAM" } },
    } },
    ATSUSHI = { partner = "PYRE_GOR", party = {
      { "DEWOTT", 33, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "FURY_CUTTER", "REVENGE", "FOCUS_ENERGY" } },
      { "MACHOKE", 33, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_SLIDE", "BULK_UP" } },
      { "ROGGENROLA", 32, ability = "STURDY", nature = "IMPISH", spread = "stank", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "PROTECT", "DISCHARGE", "MUD_SHOT" } },
    } },
    WILLIAM = { partner = "PYRE_VIC", party = {
      { "SLOWPOKE", 32, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "atk", moves = { "ZEN_HEADBUTT", "HEADBUTT", "DISABLE", "YAWN" } },
      { "GARDEVOIR", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "HYPNOSIS" } },
      { "GALLADE", 33, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
    } },
    KAYLA = { partner = "PYRE_IVY", party = {
      { "WOBBUFFET", 33, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "ALAKAZAM", 33, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "MUSHARNA", 32, ability = "FOREWARN", nature = "CALM", spread = "spdef", moves = { "PSYBEAM", "HYPNOSIS", "SWAGGER", "SYNCHRONOISE" } },
    } },
    CEDRIC = { partner = "PYRE_LEO", party = {
      { "CUFANT", 32, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", moves = { "DIG", "STOMP", "GROWL", "IRON_DEFENSE" } },
      { "GOTHITA", 32, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYSHOCK", "PROTECT", "FUTURE_SIGHT", "EMBARGO" } },
      { "MEOWSTIC_FEMALE", 33, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
    } },
    DEZ_AND_LUKE = { party = {
      { "SIMIPOUR", 34, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
      { "MUDSDALE", 34, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BULLDOZE", "STEALTH_ROCK", "HIGH_HORSEPOWER" } },
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
      { "DARMANITAN", 33, ability = "ZEN_MODE", nature = "JOLLY", spread = "atk", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "WILL_O_WISP", "FIRE_PUNCH" } },
      { "NINETALES_ALOLAN", 33, ability = "SNOW_CLOAK", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "EXTRASENSORY", "CONFUSE_RAY", "AURORA_VEIL" } },
    } },
    VIOLET = { partner = "R123_FAY", party = {
      { "STEENEE", 32, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "RAZOR_LEAF", "STOMP" } },
      { "TROPIUS", 33, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "AIR_SLASH", "GROWTH", "SWEET_SCENT" } },
    } },
    DAVIS = { partner = "R123_GUS", party = {
      { "PINSIR", 33, ability = "MOXIE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "X_SCISSOR", "STORM_THROW", "BULLDOZE", "SWORDS_DANCE" } },
      { "SWADLOON", 32, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", moves = { "BUG_BITE", "PROTECT", "RAZOR_LEAF", "GRASS_WHISTLE" } },
    } },
    JAZMYN = { partner = "R123_MAX", party = {
      { "ABSOL", 33, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "DEINO", 32, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "PROTECT", "RAIN_DANCE", "CRUNCH" } },
      { "JOLTEON", 33, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "DOUBLE_KICK", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ALBERTO = { partner = "R123_SKY", party = {
      { "PELIPPER", 33, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "XATU", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "DODUO", 32, ability = "RUN_AWAY", nature = "CALM", spread = "spdef", moves = { "PECK", "PLUCK", "QUICK_ATTACK", "GROWL" } },
    } },
    ED = { partner = "R123_DON", party = {
      { "QWILFISH", 33, ability = "POISON_POINT", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "TAKE_DOWN", "REVENGE", "STOCKPILE" } },
      { "ZANGOOSE", 33, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", moves = { "FACADE", "CRUSH_CLAW", "QUICK_ATTACK", "HONE_CLAWS" } },
      { "GLACEON", 33, ability = "SNOW_CLOAK", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_FANG", "ICY_WIND", "BITE", "QUICK_ATTACK" } },
    } },
    KINDRA = { partner = "R123_ZEN", party = {
      { "SINISTEA", 32, ability = "WEAK_ARMOR", nature = "BOLD", spread = "bulk", moves = { "HEX", "WILL_O_WISP", "PROTECT", "MEGA_DRAIN" } },
      { "MAROWAK_ALOLAN", 33, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", moves = { "FLAME_WHEEL", "SHADOW_BONE", "BONE_CLUB", "FALSE_SWIPE" } },
      { "ROTOM", 33, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    FERNANDO_1 = { partner = "R123_JAX", party = {
      { "BOLTUND", 33, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", moves = { "SPARK", "FLAME_CHARGE", "CRUNCH", "CHARM" } },
      { "DUNSPARCE", 33, ability = "RATTLED", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "TAKE_DOWN", "BODY_SLAM", "RAGE", "ROOST" } },
      { "KRICKETUNE", 32, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "X_SCISSOR", "SING", "TAUNT" } },
    } },
    CAMERON_1 = { partner = "R123_VIC", party = {
      { "SOLROCK", 33, ability = "LEVITATE", nature = "ADAMANT", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "ROCK_POLISH", "MORNING_SUN" } },
      { "EXEGGUTOR_ALOLAN", 33, ability = "FRISK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAGON_HAMMER", "SEED_BOMB", "HYPNOSIS", "TRICK_ROOM" } },
      { "MAGMAR", 32, ability = "FLAME_BODY", nature = "TIMID", spread = "spa", moves = { "FLAME_CHARGE", "FLAME_BURST", "EMBER", "SMOKESCREEN" } },
    } },
    JACKI_1 = { partner = "R123_IVY", party = {
      { "MR_MIME", 33, ability = "FILTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "HYPNOSIS", "CONFUSION", "QUICK_GUARD" } },
      { "GIRAFARIG", 33, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "STOMP", "AGILITY", "BATON_PASS" } },
      { "ESPEON", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SWIFT", "QUICK_ATTACK", "MORNING_SUN" } },
    } },
    FREDRICK = { partner = "R123_KEN", party = {
      { "KLANG", 34, ability = "PLUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "GEAR_GRIND", "VISE_GRIP", "METAL_SOUND", "AUTOTOMIZE" } },
      { "MIMIKYU", 33, ability = "DISGUISE", nature = "BOLD", spread = "bulk", moves = { "DRAINING_KISS", "WOOD_HAMMER", "SHADOW_SNEAK", "HONE_CLAWS" } },
      { "PUPITAR", 33, ability = "SHED_SKIN", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "CRUNCH", "STOMPING_TANTRUM", "SCARY_FACE" } },
    } },
    BRAXTON = { partner = "R123_ACE", party = {
      { "STUFFUL", 33, ability = "CUTE_CHARM", nature = "JOLLY", item = "BLACK_BELT", moves = { "HAMMER_ARM", "TAKE_DOWN", "TACKLE", "LEER" } },
      { "DRAGONAIR", 34, ability = "MARVEL_SCALE", nature = "JOLLY", item = "DRAGON_FANG", moves = { "DRAGON_TAIL", "TWISTER", "SLAM", "THUNDER_WAVE" } },
      { "SWADLOON", 33, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", moves = { "BUG_BITE", "PROTECT", "RAZOR_LEAF", "GRASS_WHISTLE" } },
    } },
    WENDY = { partner = "R123_ELA", party = {
      { "MAWILE", 33, ability = "INTIMIDATE", nature = "ADAMANT", moves = { "IRON_HEAD", "PLAY_ROUGH", "SUCKER_PUNCH", "PROTECT" } },
      { "ROSERADE", 34, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "PANCHAM", 33, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "DRAIN_PUNCH", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    JONAS = { partner = "R123_KO", party = {
      { "KOFFING", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "EKANS", 33, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "STOCKPILE" } },
    } },
    KAYLEY = { partner = "R123_UMA", party = {
      { "CASTFORM", 33, ability = "FORECAST", nature = "MODEST", spread = "spa", moves = { "WEATHER_BALL", "SUNNY_DAY", "ICE_BEAM", "SOLAR_BEAM" } },
      { "SNOVER", 33, ability = "SNOW_WARNING", nature = "JOLLY", item = "ORAN_BERRY", moves = { "LEECH_SEED", "RAZOR_LEAF", "ICE_SHARD", "LEAFAGE" } },
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
      { "UNFEZANT", 38, ability = "BIG_PECKS", nature = "ADAMANT", moves = { "DRILL_PECK", "QUICK_ATTACK", "RAZOR_WIND", "AIR_SLASH" } },
      { "MANTYKE", 38, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", moves = { "WATER_PULSE", "AIR_SLASH", "CONFUSE_RAY", "WIDE_GUARD" } },
      { "GASTRODON", 38, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    JENNY_1 = { partner = "R124_MIA", party = {
      { "WAILORD", 39, ability = "PRESSURE", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "HUNTAIL", 38, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "CRUNCH", "BATON_PASS" } },
      { "BRIONNE", 38, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "ENCORE" } },
    } },
    DECLAN = { partner = "R124_GIL", party = {
      { "GYARADOS", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "CLAWITZER", 38, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    SPENCER = { partner = "R124_HAL", party = {
      { "TENTACRUEL", 39, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "BARRASKEWDA", 38, ability = "SWIFT_SWIM", nature = "ADAMANT", spread = "atk", item = "DAMP_ROCK", moves = { "WATER_PULSE", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    ROLAND = { partner = "R124_DUN", party = {
      { "OCTILLERY", 38, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "OCTAZOOKA", "ICE_BEAM", "PSYBEAM", "FOCUS_ENERGY" } },
      { "SWANNA", 39, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PROTECT", "AIR_SLASH", "AQUA_RING" } },
    } },
    GRACE = { partner = "R124_LIA", party = {
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "CLAWITZER", 38, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "BUBBLE_BEAM", "WATER_SPORT", "HEAL_PULSE" } },
    } },
    ISABELLA = { partner = "R124_TOD", party = {
      { "DREDNAW", 38, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", moves = { "SURF", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
      { "AZUMARILL", 39, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    LILA_AND_ROY_1 = { party = {
      { "KINGLER", 39, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    -- Route 125 and Shoal Cave: tag battles at 38-40
    NOLEN = { partner = "R125_JON", party = {
      { "POLIWRATH", 39, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "WISHIWASHI", 38, ability = "SCHOOLING", nature = "MODEST", spread = "spa", moves = { "BRINE", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "RAICHU", 38, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
    } },
    TANYA = { partner = "R125_AMY", party = {
      { "LUVDISC", 38, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "QWILFISH", 38, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
      { "VAPOREON", 39, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    ERNEST_1 = { partner = "R125_BEN", party = {
      { "CONKELDURR", 39, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "MILOTIC", 39, ability = "MARVEL_SCALE", nature = "MODEST", item = "ORAN_BERRY", moves = { "PROTECT", "BUBBLE_BEAM", "WATER_GUN", "AQUA_TAIL" } },
      { "BOUFFALANT", 38, ability = "SAP_SIPPER", nature = "ADAMANT", moves = { "PROTECT", "HEAD_CHARGE", "HORN_ATTACK", "RAGE" } },
    } },
    STAN = { partner = "R125_MAC", party = {
      { "KINGDRA", 39, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "SURF", "DRAGON_PULSE", "FOCUS_ENERGY", "PROTECT" } },
      { "FURRET", 38, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "CURSE", "ROLLOUT", "SLAM", "SCRATCH" } },
    } },
    PRESLEY = { partner = "R125_SKY", party = {
      { "TALONFLAME", 39, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "TAILWIND", "FLARE_BLITZ" } },
      { "GLIGAR", 39, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ACROBATICS", "EARTHQUAKE", "KNOCK_OFF", "PROTECT" } },
    } },
    SHARON = { partner = "R125_ELA", party = {
      { "SEAKING", 38, ability = "LIGHTNING_ROD", nature = "ADAMANT", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "BARRASKEWDA", 39, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "DIVE", "CRUNCH", "AGILITY" } },
    } },
    KIM_AND_IRIS = { party = {
      { "ALTARIA", 39, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "RHYDON", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "DRILL_RUN", "MEGAHORN", "PROTECT" } },
      { "EISCUE", 38, ability = "ICE_FACE", nature = "JOLLY", spread = "atk", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "FREEZE_DRY", "REFLECT", "HEADBUTT" } },
      { "ROTOM", 38, ability = "LEVITATE", nature = "TIMID", spread = "spa", moves = { "THUNDERBOLT", "HEX", "WILL_O_WISP", "THUNDER_WAVE" } },
    } },
    AURON = { partner = "R125_KEN", party = {
      { "MANECTRIC", 40, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "FLAMETHROWER", "THUNDER_WAVE", "SNARL" } },
      { "CRABOMINABLE", 40, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", moves = { "CLOSE_COMBAT", "ICE_HAMMER", "ICE_PUNCH", "LEER" } },
    } },
    -- Trick Houses 5 and 6: tag battles at 39-40
    BENNY = { partner = "TH6_SKY", party = {
      { "SWELLOW", 40, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "CHATOT", 39, ability = "KEEN_EYE", nature = "TIMID", moves = { "CHATTER", "ECHOED_VOICE", "PLUCK", "PECK" } },
    } },
    SEBASTIAN = { partner = "TH6_RAN", party = {
      { "CRUSTLE", 40, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "X_SCISSOR", "PROTECT", "ROCK_SLIDE", "STEALTH_ROCK" } },
      { "DONPHAN", 39, ability = "STURDY", nature = "ADAMANT", moves = { "EARTHQUAKE", "ICE_SHARD", "KNOCK_OFF", "RAPID_SPIN" } },
      { "FURFROU", 39, ability = "FUR_COAT", nature = "ADAMANT", spread = "tank", moves = { "BODY_SLAM", "TAKE_DOWN", "RETALIATE", "ODOR_SLEUTH" } },
    } },
    SOPHIA = { partner = "TH6_WEN", party = {
      { "FLAPPLE", 40, ability = "HUSTLE", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "DEFOG", "GRAV_APPLE", "DRAGON_PULSE", "DRAGON_BREATH" } },
      { "ORICORIO_POM_POM", 39, ability = "DANCER", nature = "TIMID", spread = "spa", moves = { "REVELATION_DANCE", "AIR_SLASH", "FEATHER_DANCE", "TEETER_DANCE" } },
      { "HIPPOWDON", 39, ability = "SAND_STREAM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HIGH_HORSEPOWER", "ROCK_SLIDE", "PROTECT", "DIG" } },
    } },
    -- Mossdeep Gym: psychic trainers fight alone with three, like Tate and Liza: screens
    -- (Light Clay), Calm Mind, Earthquake beside levitators
    PRESTON = { tier = "gym", party = {
      { "HYPNO", 39, ability = "INSOMNIA", nature = "CALM", spread = "spdef", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYCHIC", "HYPNOSIS" } },
      { "ALAKAZAM", 40, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "CALM_MIND" } },
      { "SLOWKING", 40, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "CALM_MIND" } },
    } },
    VIRGIL = { tier = "gym", party = {
      { "BRONZONG", 40, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "GYRO_BALL", "PSYCHIC" } },
      { "CLAYDOL", 39, ability = "LEVITATE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "PSYCHIC", "CALM_MIND", "PROTECT" } },
      { "SIGILYPH", 40, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "PSYCHIC", "AIR_SLASH", "CALM_MIND", "PROTECT" } },
    } },
    BLAKE = { tier = "gym", party = {
      { "MEOWSTIC_FEMALE", 40, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "LIGHT_CLAY", moves = { "LIGHT_SCREEN", "REFLECT", "PSYCHIC", "FAKE_OUT" } },
      { "GIRAFARIG", 39, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "HYPER_VOICE", "CALM_MIND", "BATON_PASS" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "POWER_GEM", "CALM_MIND", "MAGIC_COAT" } },
    } },
    HANNAH = { tier = "gym", party = {
      { "BRUXISH", 40, ability = "DAZZLING", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "PSYCHIC_FANGS", "AQUA_JET", "CRUNCH", "ICE_FANG" } },
      { "MALAMAR", 40, ability = "CONTRARY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SUPERPOWER", "FOUL_PLAY", "PSYCHO_CUT", "REFLECT" } },
      { "STARMIE", 39, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "LIGHT_SCREEN" } },
    } },
    SAMANTHA = { tier = "gym", party = {
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYCHIC", "AIR_SLASH" } },
      { "GARDEVOIR", 40, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "CALM_MIND", "HYPNOSIS" } },
      { "GALLADE", 39, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
    } },
    SYLVIA = { tier = "gym", party = {
      { "ORANGURU", 40, ability = "INNER_FOCUS", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "INSTRUCT", "CALM_MIND", "FOUL_PLAY" } },
      { "GOTHORITA", 39, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "CALM_MIND", "FAKE_TEARS", "FLATTER" } },
      { "CHIMECHO", 39, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "LIGHT_CLAY", moves = { "EXTRASENSORY", "REFLECT", "LIGHT_SCREEN", "YAWN" } },
    } },
    NATE = { tier = "gym", party = {
      { "MR_MIME", 39, ability = "FILTER", nature = "TIMID", spread = "spa", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYBEAM", "DAZZLING_GLEAM" } },
      { "STARMIE", 40, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "POWER_GEM", "CALM_MIND", "CONFUSE_RAY" } },
    } },
    KATHLEEN = { tier = "gym", party = {
      { "HYPNO", 39, ability = "INSOMNIA", nature = "CALM", spread = "spdef", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYCHIC", "HYPNOSIS" } },
      { "SWOOBAT", 40, ability = "SIMPLE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "PSYCHIC", "CALM_MIND", "ROOST" } },
      { "MISMAGIUS", 39, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "TAUNT" } },
    } },
    CLIFFORD = { tier = "gym", party = {
      { "MR_MIME", 39, ability = "FILTER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "DAZZLING_GLEAM", "FAKE_OUT", "WIDE_GUARD" } },
      { "RAICHU_ALOLAN", 40, ability = "SURGE_SURFER", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "THUNDERBOLT", "NUZZLE", "FOCUS_BLAST" } },
      { "SLOWBRO", 39, ability = "REGENERATOR", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "CALM_MIND" } },
    } },
    NICHOLAS = { tier = "gym", party = {
      { "MUSHARNA", 40, ability = "SYNCHRONIZE", nature = "BOLD", spread = "bulk", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYCHIC", "YAWN" } },
      { "WOBBUFFET", 39, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "ESPEON", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "CALM_MIND", "MORNING_SUN" } },
    } },
    MACEY = { tier = "gym", party = {
      { "KADABRA", 39, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "PSYCHIC", "SHADOW_BALL" } },
      { "JYNX", 39, ability = "DRY_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ICE_BEAM", "PSYCHIC", "FAKE_OUT", "LOVELY_KISS" } },
      { "DELPHOX", 40, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "MYSTICAL_FIRE", "PSYSHOCK", "CALM_MIND", "PROTECT" } },
    } },
    MAURA = { tier = "gym", party = {
      { "BEHEEYEM", 40, ability = "ANALYTIC", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "SHADOW_BALL", "CALM_MIND", "THUNDERBOLT" } },
      { "ESPEON", 40, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "SHADOW_BALL", "MORNING_SUN" } },
      { "METANG", 39, ability = "CLEAR_BODY", nature = "ADAMANT", item = "EVIOLITE", moves = { "ZEN_HEADBUTT", "BULLET_PUNCH", "EARTHQUAKE", "PROTECT" } },
    } },
    -- Tate and Liza: six, a double of their own: screens, Calm Mind and Earthquake beside
    -- levitators; Lunatone and Solrock are the aces at 42
    TATE_AND_LIZA_1 = { tier = "leader", party = {
      { "CLAYDOL", 41, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "EARTHQUAKE", "PSYCHIC" } },
      { "XATU", 41, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "TAILWIND", "PSYCHIC", "AIR_SLASH", "CONFUSE_RAY" } },
      { "BRONZONG", 41, ability = "LEVITATE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "GYRO_BALL", "EXTRASENSORY", "HYPNOSIS", "PROTECT" } },
      { "SIGILYPH", 41, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "LIFE_ORB", moves = { "PSYCHIC", "AIR_SLASH", "HEAT_WAVE", "PROTECT" } },
      { "LUNATONE", 42, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "CHESTO_BERRY", moves = { "CALM_MIND", "REST", "PSYCHIC", "EARTH_POWER" } },
      { "SOLROCK", 42, ability = "LEVITATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "SUNNY_DAY", "EARTHQUAKE", "ZEN_HEADBUTT", "FLARE_BLITZ" } },
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
      { "DOUBLADE", 41, ability = "NO_GUARD", nature = "ADAMANT", moves = { "AUTOTOMIZE", "SHADOW_SNEAK", "RETALIATE", "NIGHT_SLASH" } },
      { "GRENINJA", 42, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DARK_PULSE", "ICE_BEAM", "PROTECT" } },
      { "CRAMORANT", 41, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "AIR_SLASH", "DRILL_PECK", "DIVE", "STOCKPILE" } },
    } },
    PABLO_1 = { partner = "R126_ACE", party = {
      { "KABUTOPS", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ROCK_SLIDE", "AQUA_JET", "PROTECT" } },
      { "GOLDUCK", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
      { "ALOMOMOLA", 41, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "WAKE_UP_SLAP", "AQUA_JET", "HEAL_PULSE" } },
    } },
    BRENDA = { partner = "R126_LIA", party = {
      { "FLOATZEL", 41, ability = "WATER_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "AGILITY", "AQUA_TAIL", "CRUNCH" } },
      { "RAICHU", 41, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "NUZZLE", "FEINT", "NASTY_PLOT" } },
    } },
    BARRY = { partner = "R126_GIL", party = {
      { "SWAMPERT", 42, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
      { "SIMISAGE", 41, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "SEED_BOMB", "VINE_WHIP", "CRUNCH" } },
    } },
    DEAN = { partner = "R126_JON", party = {
      { "FRAXURE", 42, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_CLAW", "CRUNCH", "DRAGON_DANCE", "TAUNT" } },
      { "VICTREEBEL", 41, ability = "CHLOROPHYLL", nature = "ADAMANT", spread = "atk", moves = { "GIGA_DRAIN", "POISON_JAB", "RAZOR_LEAF", "SWALLOW" } },
      { "QUAGSIRE", 41, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    ISAIAH_1 = { partner = "R126_SKY", party = {
      { "DODRIO", 42, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "JOLTEON", 41, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "SHADOW_BALL", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ISOBEL = { partner = "R126_MIA", party = {
      { "AVALUGG", 42, ability = "STURDY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_FANG", "AVALANCHE", "ICE_BALL", "ICY_WIND" } },
      { "BARBARACLE", 41, ability = "PICKPOCKET", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "SURF", "SKULL_BASH", "RAZOR_SHELL", "HONE_CLAWS" } },
    } },
    DONNY = { partner = "R126_DUN", party = {
      { "LARVESTA", 42, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "DOUBLE_EDGE", "BUG_BITE", "AMNESIA" } },
      { "BLASTOISE", 42, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "ICE_BEAM", "FAKE_OUT", "PROTECT" } },
    } },
    KATELYN_1 = { partner = "R126_ELA", party = {
      { "PERSIAN", 42, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", moves = { "AERIAL_ACE", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "BOLTUND", 41, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", moves = { "WILD_CHARGE", "FLAME_CHARGE", "SPARK", "CHARGE" } },
    } },
    NIKKI = { partner = "R126_AMY", party = {
      { "CRYOGONAL", 42, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
      { "AUDINO", 41, ability = "HEALER", nature = "BOLD", spread = "bulk", moves = { "EXTRASENSORY", "HELPING_HAND", "DOUBLE_SLAP", "DISARMING_VOICE" } },
    } },
    SIENNA = { partner = "R126_KIM", party = {
      { "CLOYSTER", 41, ability = "SHELL_ARMOR", nature = "ADAMANT", moves = { "PROTECT", "ICICLE_CRASH", "RAZOR_SHELL", "ICE_SHARD" } },
      { "WHISCASH", 41, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
      { "POLITOED", 42, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SURF", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
    } },
    CARLEE = { partner = "R126_PIA", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "ORANGURU", 42, ability = "INNER_FOCUS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "STORED_POWER", "ZEN_HEADBUTT", "QUASH" } },
    } },
    LEONARDO = { partner = "R126_LEO", party = {
      { "DEWGONG", 42, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "PROTECT", "BRINE" } },
      { "FRILLISH", 41, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "PROTECT", "HYDRO_PUMP", "WATER_PULSE", "SHADOW_BALL" } },
    } },
    ATHENA = { partner = "R126_MAX", party = {
      { "INFERNAPE", 42, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "FAKE_OUT", "FLAME_WHEEL", "MACH_PUNCH", "U_TURN" } },
      { "ESCAVALIER", 41, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "ENCORE", "X_SCISSOR" } },
    } },
    HARRISON = { partner = "R126_BEN", party = {
      { "SNORLAX", 41, ability = "IMMUNITY", nature = "ADAMANT", spread = "tank", moves = { "BODY_SLAM", "ROLLOUT", "DEFENSE_CURL", "LAST_RESORT" } },
      { "OMANYTE", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "SURF", "BITE", "PROTECT" } },
    } },
    JONAH = { partner = "R126_HAL", party = {
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
      { "SALAZZLE", 42, ability = "OBLIVIOUS", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "FLAMETHROWER", "SLUDGE_BOMB", "TORMENT" } },
    } },
    HENRY = { partner = "R126_NED", party = {
      { "TENTACRUEL", 42, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "MANTYKE", 41, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", moves = { "WATER_PULSE", "AIR_SLASH", "AQUA_RING", "WIDE_GUARD" } },
    } },
    ROGER = { partner = "R126_MAC", party = {
      { "CRAWDAUNT", 42, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
      { "LUVDISC", 41, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "bulk", moves = { "MUD_SPORT", "BUBBLE_BEAM", "WATER_GUN", "DRAINING_KISS" } },
    } },
    KOJI_1 = { partner = "R126_KEN", party = {
      { "HARIYAMA", 42, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "MAGNETON", 41, ability = "MAGNET_PULL", nature = "IMPISH", spread = "stank", moves = { "PROTECT", "FLASH_CANNON", "DISCHARGE", "MIRROR_SHOT" } },
    } },
    WAYNE = { partner = "R126_WES", party = {
      { "WAILMER", 41, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SPIRITOMB", 42, ability = "PRESSURE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "SUCKER_PUNCH", "FEINT_ATTACK", "PURSUIT" } },
    } },
    AIDAN = { partner = "R126_SKY2", party = {
      { "STARAPTOR", 42, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "PIDGEOT", 41, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
    } },
    ALEXA = { partner = "R126_ANN", party = {
      { "FERALIGATR", 42, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "ICE_FANG", "CRUNCH", "PROTECT" } },
      { "CRUSTLE", 42, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "X_SCISSOR", "PROTECT", "ROCK_SLIDE", "STEALTH_ROCK" } },
      { "AMPHAROS", 42, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "DRAGON_PULSE", "POWER_GEM", "THUNDER_WAVE" } },
    } },
    RUBEN = { partner = "R126_RAN", party = {
      { "MEGANIUM", 42, ability = "OVERGROW", nature = "BOLD", spread = "bulk", moves = { "ENERGY_BALL", "LIGHT_SCREEN", "REFLECT", "SYNTHESIS" } },
      { "SLIGGOO", 42, ability = "SAP_SIPPER", nature = "MODEST", moves = { "DRAGON_PULSE", "DRAGON_BREATH", "PROTECT", "RAIN_DANCE" } },
      { "CLOYSTER", 42, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
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
      { "SHELLDER", 43, ability = "SHELL_ARMOR", nature = "TIMID", moves = { "TACKLE", "RAZOR_SHELL", "CLAMP", "WATER_GUN" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    FRANKLIN = { partner = "R130_LEO", party = {
      { "PALPITOAD", 43, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "stank", moves = { "SURF", "MUDDY_WATER", "BUBBLE_BEAM", "SUPERSONIC" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    JACK = { partner = "R130_BO", party = {
      { "LINOONE", 43, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "SLASH", "COVET", "PROTECT" } },
      { "FLOATZEL", 43, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "CRUNCH", "TAUNT", "AQUA_TAIL" } },
    } },
    HITOSHI = { partner = "R130_KEN", party = {
      { "PRIMEAPE", 44, ability = "ANGER_POINT", nature = "ADAMANT", item = "BLACK_BELT", moves = { "ICE_PUNCH", "CLOSE_COMBAT", "CROSS_CHOP", "KARATE_CHOP" } },
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "LUCARIO", 43, ability = "INNER_FOCUS", nature = "MODEST", moves = { "PAYBACK", "PROTECT", "AURA_SPHERE", "FORCE_PALM" } },
    } },
    KIYO = { partner = "R130_GOR", party = {
      { "PASSIMIAN", 44, ability = "RECEIVER", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "DRAIN_PUNCH", "CLOSE_COMBAT", "THRASH" } },
      { "GRAPPLOCT", 43, ability = "TECHNICIAN", nature = "JOLLY", moves = { "CLOSE_COMBAT", "SUBMISSION", "BRICK_BREAK", "BULK_UP" } },
      { "SAWK", 43, ability = "STURDY", nature = "ADAMANT", moves = { "ROCK_SLIDE", "BULK_UP", "FACADE", "CLOSE_COMBAT" } },
    } },
    ALEX = { partner = "R130_SKY", party = {
      { "FEAROW", 44, ability = "KEEN_EYE", nature = "JOLLY", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "TOGEKISS", 44, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
    } },
    BECK = { partner = "R130_ACE", party = {
      { "WEAVILE", 44, ability = "PRESSURE", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "PUNISHMENT", "NASTY_PLOT", "HONE_CLAWS" } },
      { "ALTARIA", 43, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", moves = { "DRAGON_PULSE", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "NOCTOWL", 43, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    DEBRA = { partner = "R130_AMY", party = {
      { "ALOMOMOLA", 43, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "WAKE_UP_SLAP", "AQUA_JET", "HEAL_PULSE" } },
      { "POLITOED", 44, ability = "WATER_ABSORB", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "PROTECT", "HYDRO_PUMP", "WATER_PULSE" } },
    } },
    LINDA = { partner = "R130_LIA", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "GASTRODON", 43, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    LAUREL = { partner = "R130_ELA", party = {
      { "LUVDISC", 43, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "QWILFISH", 44, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    KELVIN = { partner = "R130_WES", party = {
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "SPIRITOMB", 43, ability = "PRESSURE", nature = "ADAMANT", moves = { "PROTECT", "SUCKER_PUNCH", "FEINT_ATTACK", "PURSUIT" } },
    } },
    REYNA = { partner = "R130_ROX", party = {
      { "LOPUNNY", 44, ability = "CUTE_CHARM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PROTECT", "JUMP_KICK", "DIZZY_PUNCH", "CIRCLE_THROW" } },
      { "HAWLUCHA", 43, ability = "LIMBER", nature = "ADAMANT", moves = { "ROCK_SMASH", "FEINT", "QUICK_GUARD", "BRICK_BREAK" } },
    } },
    HUDSON = { partner = "R130_BEN", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "BIBAREL", 43, ability = "UNAWARE", nature = "JOLLY", moves = { "FACADE", "CRUNCH", "AQUA_TAIL", "TAKE_DOWN" } },
    } },
    RODNEY = { partner = "R131_GIL", party = {
      { "OCTILLERY", 44, ability = "SUCTION_CUPS", nature = "MODEST", moves = { "WATERFALL", "PROTECT", "HYDRO_PUMP", "OCTAZOOKA" } },
      { "WISHIWASHI", 44, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BRINE", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    RICHARD = { partner = "R131_JON", party = {
      { "KOMALA", 44, ability = "COMATOSE", nature = "ADAMANT", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "SLAM", "RAPID_SPIN" } },
      { "BARRASKEWDA", 44, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
    } },
    SANTIAGO = { partner = "R131_HAL", party = {
      { "KINGLER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
    } },
    GILBERT = { partner = "R131_MAC", party = {
      { "VICTREEBEL", 44, ability = "GLUTTONY", nature = "MODEST", spread = "spa", moves = { "SLUDGE_BOMB", "LEAF_BLADE", "POISON_JAB", "SWALLOW" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    KEVIN = { partner = "R131_DUN", party = {
      { "LICKILICKY", 44, ability = "OBLIVIOUS", nature = "ADAMANT", spread = "tank", moves = { "BODY_SLAM", "PROTECT", "SLAM", "CHIP_AWAY" } },
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    CHASE = { partner = "R131_SKY", party = {
      { "STARMIE", 44, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "BEWEAR", 44, ability = "KLUTZ", nature = "JOLLY", item = "BLACK_BELT", moves = { "ROCK_SLIDE", "THRASH", "HAMMER_ARM", "TAKE_DOWN" } },
    } },
    TALIA = { partner = "R131_PIA", party = {
      { "DWEBBLE", 44, ability = "SHELL_ARMOR", nature = "JOLLY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "ROCK_WRECKER" } },
      { "STUNFISK", 44, ability = "SAND_VEIL", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDERBOLT", "MUD_BOMB", "MUDDY_WATER", "MUD_SPORT" } },
    } },
    ALLISON = { partner = "R131_TOD", party = {
      { "STOUTLAND", 44, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "GIGA_IMPACT", "LAST_RESORT", "TAKE_DOWN", "RETALIATE" } },
      { "VENOMOTH", 44, ability = "SHIELD_DUST", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "SIGNAL_BEAM", "SILVER_WIND", "SLEEP_POWDER" } },
    } },
    KATIE = { partner = "R132_KIM", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "AVALUGG", 44, ability = "STURDY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICICLE_CRASH", "SKULL_BASH", "ICE_FANG", "IRON_DEFENSE" } },
    } },
    KARA = { partner = "R132_ZOE", party = {
      { "STANTLER", 44, ability = "INTIMIDATE", nature = "IMPISH", spread = "bulk", moves = { "TAKE_DOWN", "STOMP", "TACKLE", "JUMP_KICK" } },
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    DANA = { partner = "R132_MIA", party = {
      { "SCOLIPEDE", 44, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SLUDGE_BOMB", "POISON_JAB", "DOUBLE_EDGE", "IRON_DEFENSE" } },
      { "PRIMARINA", 44, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "PROTECT" } },
    } },
    CLARENCE = { partner = "R132_LEO", party = {
      { "RATICATE", 44, ability = "HUSTLE", nature = "ADAMANT", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "PROTECT", "DOUBLE_EDGE", "HYPER_FANG" } },
      { "EMPOLEON", 44, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "FLASH_CANNON", "ICE_BEAM", "PROTECT" } },
    } },
    REED = { partner = "R132_BO", party = {
      { "PALPITOAD", 44, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "stank", moves = { "SURF", "MUDDY_WATER", "BUBBLE_BEAM", "RAIN_DANCE" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    TISHA = { partner = "R132_ELA", party = {
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "AROMATISSE", 44, ability = "AROMA_VEIL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "CALM_MIND", "DRAINING_KISS", "MOONBLAST" } },
    } },
    RELI_AND_IAN = { party = {
      { "SWELLOW", 44, ability = "GUTS", nature = "ADAMANT", spread = "atk", item = "DAMP_ROCK", moves = { "HURRICANE", "TAILWIND", "PROTECT", "BRAVE_BIRD" } },
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
    } },
    MOLLIE = { partner = "R133_ZEN", party = {
      { "VICTREEBEL", 45, ability = "CHLOROPHYLL", nature = "JOLLY", spread = "atk", item = "MIRACLE_SEED", moves = { "SLUDGE_BOMB", "PROTECT", "LEAF_BLADE", "POISON_JAB" } },
      { "CARRACOSTA", 44, ability = "SOLID_ROCK", nature = "ADAMANT", moves = { "ROCK_SLIDE", "WATERFALL", "AQUA_JET", "PROTECT" } },
      { "SLURPUFF", 44, ability = "UNBURDEN", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PROTECT", "DRAINING_KISS", "FAIRY_WIND", "ENERGY_BALL" } },
    } },
    AARON = { partner = "R133_DRA", party = {
      { "TURTONATOR", 45, ability = "SHELL_ARMOR", nature = "MODEST", moves = { "DRAGON_CLAW", "SHELL_TRAP", "FLAMETHROWER", "IRON_DEFENSE" } },
      { "TYRANTRUM", 45, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "DRAGON_CLAW", "CRUNCH", "EARTHQUAKE" } },
      { "VESPIQUEN", 44, ability = "PRESSURE", nature = "JOLLY", spread = "atk", moves = { "AIR_SLASH", "TAILWIND", "ATTACK_ORDER", "BUG_BITE" } },
    } },
    CONOR = { partner = "R133_KEN", party = {
      { "HARIYAMA", 45, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "AMOONGUSS", 44, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", moves = { "PROTECT", "SOLAR_BEAM", "GIGA_DRAIN", "MEGA_DRAIN" } },
      { "REUNICLUS", 44, ability = "MAGIC_GUARD", nature = "CALM", spread = "spdef", moves = { "PSYCHIC", "TRICK_ROOM", "FUTURE_SIGHT", "SNATCH" } },
    } },
    PAXTON = { partner = "R133_GOR", party = {
      { "BRELOOM", 45, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "BULLET_SEED", "SPORE", "ROCK_TOMB" } },
      { "URSARING", 44, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "FACADE", "CLOSE_COMBAT", "CRUNCH", "PROTECT" } },
      { "ELECTIVIRE", 44, ability = "MOTOR_DRIVE", nature = "ADAMANT", item = "MAGNET", moves = { "WILD_CHARGE", "SWAGGER", "CROSS_CHOP", "THUNDER_PUNCH" } },
    } },
    MAKAYLA = { partner = "R133_WEN", party = {
      { "ELDEGOSS", 44, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", moves = { "GIGA_DRAIN", "LEAF_STORM", "LEAF_TORNADO", "SYNTHESIS" } },
      { "MEDICHAM", 45, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "FLAREON", 44, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "QUICK_ATTACK", "SUPERPOWER", "HELPING_HAND" } },
    } },
    WARREN = { partner = "R133_ACE", party = {
      { "GOLEM_ALOLAN", 45, ability = "GALVANIZE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "BODY_SLAM", "EARTHQUAKE", "EXPLOSION" } },
      { "TORTERRA", 45, ability = "OVERGROW", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "EARTHQUAKE", "CRUNCH", "PROTECT" } },
      { "POLTEAGEIST", 44, ability = "WEAK_ARMOR", nature = "RELAXED", spread = "bulk", moves = { "SHADOW_BALL", "WILL_O_WISP", "PROTECT", "GIGA_DRAIN" } },
    } },
    HERMAN = { partner = "R134_GIL", party = {
      { "HERACROSS", 45, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MEGAHORN", "CLOSE_COMBAT", "KNOCK_OFF", "PROTECT" } },
      { "TOGEKISS", 44, ability = "HUSTLE", nature = "CALM", spread = "spdef", moves = { "PSYCHIC", "WISH", "PROTECT", "AIR_SLASH" } },
      { "COPPERAJAH", 44, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "STRENGTH", "GROWL", "IRON_DEFENSE" } },
    } },
    SUSIE = { partner = "R134_ELA", party = {
      { "STARAPTOR", 45, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "SCEPTILE", 45, ability = "OVERGROW", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "LEAF_BLADE", "DRAGON_CLAW", "QUICK_ATTACK", "DETECT" } },
      { "FROSLASS", 44, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "SHADOW_BALL", "WILL_O_WISP", "PROTECT" } },
    } },
    MARLEY = { partner = "R134_MAX", party = {
      { "VENUSAUR", 45, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "ACCELGOR", 44, ability = "STICKY_HOLD", nature = "MODEST", moves = { "KNOCK_OFF", "PROTECT", "BUG_BUZZ", "STRUGGLE_BUG" } },
      { "PYROAR", 45, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "FLARE_BLITZ", "CRUNCH", "PROTECT", "HYPER_BEAM" } },
    } },
    JONATHAN = { partner = "R134_DUN", party = {
      { "RAMPARDOS", 45, ability = "SHEER_FORCE", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "CRUNCH", "PROTECT" } },
      { "CHARIZARD", 45, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
      { "ABOMASNOW", 44, ability = "SNOW_WARNING", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "PROTECT", "WOOD_HAMMER", "ICE_PUNCH", "RAZOR_LEAF" } },
    } },
    DARCY = { partner = "R134_ANN", party = {
      { "CHARIZARD", 45, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
      { "FERROTHORN", 44, ability = "IRON_BARBS", nature = "JOLLY", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "PROTECT", "SELF_DESTRUCT", "POWER_WHIP" } },
      { "PORYGON_Z", 44, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "SHADOW_BALL", "THUNDERBOLT", "NASTY_PLOT" } },
    } },
    -- Sootopolis Gym: water trainers fight alone with three, like Juan: Water with Fairy
    -- partners, no rain
    DAPHNE = { tier = "gym", party = {
      { "CLEFABLE", 44, ability = "MAGIC_GUARD", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "MOONBLAST", "FOLLOW_ME", "ICE_BEAM", "PROTECT" } },
      { "LAPRAS", 45, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "CONFUSE_RAY", "SING" } },
      { "SAMUROTT", 45, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "RAZOR_SHELL", "MEGAHORN", "AQUA_JET", "SWORDS_DANCE" } },
    } },
    BRIANNA = { tier = "gym", party = {
      { "GRENINJA", 45, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DARK_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FAKE_OUT", "ENCORE", "SURF" } },
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    CONNIE = { tier = "gym", party = {
      { "TOGEKISS", 44, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "PROTECT" } },
      { "STARMIE", 45, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LUMINEON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "U_TURN", "TAILWIND", "PROTECT" } },
    } },
    BRIDGET = { tier = "gym", party = {
      { "GOREBYSS", 44, ability = "HYDRATION", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "DRAINING_KISS", "AQUA_RING" } },
      { "OMASTAR", 45, ability = "SHELL_ARMOR", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "SURF", "ANCIENT_POWER", "ICE_BEAM", "PROTECT" } },
      { "TOXAPEX", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "SURF", "WIDE_GUARD", "TOXIC_SPIKES" } },
    } },
    OLIVIA = { tier = "gym", party = {
      { "CARRACOSTA", 45, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "AQUA_JET", "PROTECT" } },
      { "ARAQUANID", 44, ability = "WATER_BUBBLE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LIQUIDATION", "LEECH_LIFE", "WIDE_GUARD", "CRUNCH" } },
      { "WIGGLYTUFF", 44, ability = "COMPETITIVE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "DAZZLING_GLEAM", "SING", "HELPING_HAND" } },
    } },
    TIFFANY = { tier = "gym", party = {
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
      { "FERALIGATR", 45, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "ICE_FANG", "CRUNCH", "PROTECT" } },
      { "GASTRODON_EAST_SEA", 44, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "ICY_WIND" } },
    } },
    BETHANY = { tier = "gym", party = {
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "SLOWKING", 45, ability = "REGENERATOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "PSYCHIC", "SLACK_OFF", "YAWN" } },
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
    } },
    ANNIKA = { tier = "gym", party = {
      { "MILOTIC", 45, ability = "MARVEL_SCALE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
      { "PRIMARINA", 44, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "PROTECT" } },
      { "GOLDUCK", 44, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
    } },
    ANDREA = { tier = "gym", party = {
      { "CLOYSTER", 44, ability = "SKILL_LINK", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "PROTECT", "AURORA_BEAM" } },
      { "FLOATZEL", 44, ability = "WATER_VEIL", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "JELLICENT", 45, ability = "CURSED_BODY", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "SURF", "RECOVER", "WILL_O_WISP" } },
    } },
    CRISSY = { tier = "gym", party = {
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "GOLISOPOD", 45, ability = "EMERGENCY_EXIT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FIRST_IMPRESSION", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
      { "SYLVEON", 44, ability = "PIXILATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "DRAINING_KISS", "HELPING_HAND", "PROTECT" } },
    } },
    -- Juan: six, alone (2-vs-1), Water/Fairy without rain; Sniper Kingdra is the ace at the cap
    JUAN_1 = { tier = "leader", party = {
      { "AZUMARILL", 45, ability = "HUGE_POWER", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "PROTECT" } },
      { "PRIMARINA", 45, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "HYPER_VOICE", "MOONBLAST", "ICE_BEAM", "PROTECT" } },
      { "LAPRAS", 45, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "SING", "FREEZE_DRY", "THUNDERBOLT", "PROTECT" } },
      { "QUAGSIRE", 45, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "LEFTOVERS", moves = { "EARTHQUAKE", "SCALD", "YAWN", "RECOVER" } },
      { "GASTRODON", 45, ability = "STORM_DRAIN", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "EARTH_POWER", "SCALD", "RECOVER", "PROTECT" } },
      { "KINGDRA", 46, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "DRAGON_PULSE", "MUDDY_WATER", "FOCUS_ENERGY", "ICE_BEAM" } },
    } },
    -- Chapter 9: Victory Road and the League (draft 1, 2026-10-27; caps 48, 50, 52, 54, 56, 58) ----
    -- Trick House 7 (after the Rain Badge) and inner Meteor Falls (Waterfall): tag battles at 46-47
    PATRICIA = { partner = "VR_P1", party = {
      { "BANETTE", 47, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_CLAW", "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP" } },
      { "GOURGEIST", 46, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "MEGA_DRAIN" } },
      { "REUNICLUS", 46, ability = "MAGIC_GUARD", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "TRICK_ROOM", "FUTURE_SIGHT", "HEAL_BLOCK" } },
    } },
    JOSHUA = { partner = "VR_P2", party = {
      { "ALAKAZAM", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "PROTECT" } },
      { "WHIMSICOTT", 46, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DAZZLING_GLEAM", "SOLAR_BEAM", "ENERGY_BALL", "TAILWIND" } },
      { "SIMISEAR", 47, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "ROCK_SLIDE", "SUPERPOWER", "CRUNCH" } },
    } },
    ALEXIS = { partner = "VR_P3", party = {
      { "GARDEVOIR", 47, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "HYPNOSIS" } },
      { "AUDINO", 46, ability = "HEALER", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PSYCHIC", "HYPER_VOICE", "DOUBLE_EDGE", "TAKE_DOWN" } },
    } },
    MARIELA = { partner = "VR_P4", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "MUSHARNA", 46, ability = "FOREWARN", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "YAWN", "HEALING_WISH", "SYNCHRONOISE", "DREAM_EATER" } },
    } },
    ALVARO = { partner = "VR_P5", party = {
      { "GALLADE", 47, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
      { "ORANGURU", 46, ability = "SYMBIOSIS", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "FUTURE_SIGHT", "QUASH", "INSTRUCT" } },
    } },
    EVERETT = { partner = "VR_P6", party = {
      { "WOBBUFFET", 46, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "SLOWBRO", 47, ability = "OWN_TEMPO", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYCHIC", "SHADOW_BALL", "TRICK_ROOM", "BUBBLE_BEAM" } },
    } },
    NICOLAS_1 = { partner = "VR_P7", party = {
      { "XATU", 47, ability = "SYNCHRONIZE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "TAILWIND", "ROOST", "FUTURE_SIGHT", "PSYCHIC" } },
      { "FLYGON", 47, ability = "LEVITATE", nature = "JOLLY", item = "SOFT_SAND", moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
    } },
    JOHN_AND_JAY_1 = { party = {
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "MEDICHAM", 47, ability = "PURE_POWER", nature = "JOLLY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "CRABOMINABLE", 47, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", moves = { "CLOSE_COMBAT", "DYNAMIC_PUNCH", "HAMMER_ARM", "LEER" } },
    } },
    -- Victory Road: tag battles at 46-48
    ALBERT = { partner = "VR_A1", party = {
      { "MAGNEZONE", 47, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "MUK", 47, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "BLACK_SLUDGE", moves = { "GUNK_SHOT", "SHADOW_SNEAK", "ICE_PUNCH", "MINIMIZE" } },
      { "SANDACONDA", 47, ability = "SAND_SPIT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
    } },
    HOPE = { partner = "VR_A2", party = {
      { "ROSERADE", 47, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "TOGEKISS", 47, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
      { "PYROAR", 47, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "FLARE_BLITZ", "CRUNCH", "PROTECT", "HYPER_BEAM" } },
    } },
    SHANNON = { partner = "VR_A3", party = {
      { "CLAYDOL", 47, ability = "LEVITATE", nature = "CALM", spread = "spdef", moves = { "EARTH_POWER", "PSYCHIC", "TRICK_ROOM", "REFLECT" } },
      { "CONKELDURR", 47, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "CLOYSTER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
    } },
    SAMUEL = { partner = "VR_A4", party = {
      { "DODRIO", 47, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "KNOCK_OFF", "AGILITY" } },
      { "CRUSTLE", 47, ability = "SHELL_ARMOR", nature = "ADAMANT", moves = { "X_SCISSOR", "PROTECT", "ROCK_WRECKER", "STEALTH_ROCK" } },
      { "GOLEM", 47, ability = "STURDY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "EARTHQUAKE", "EXPLOSION", "PROTECT" } },
    } },
    JULIE = { partner = "VR_A5", party = {
      { "SANDACONDA", 47, ability = "SAND_VEIL", nature = "ADAMANT", item = "SOFT_SAND", moves = { "EARTHQUAKE", "ROCK_SLIDE", "SKULL_BASH", "DIG" } },
      { "NINETALES", 47, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "VENUSAUR", 47, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
    } },
    OWEN = { partner = "VR_A6", party = {
      { "BOUFFALANT", 47, ability = "SAP_SIPPER", nature = "ADAMANT", moves = { "PROTECT", "HEAD_CHARGE", "HORN_ATTACK", "RAGE" } },
      { "GYARADOS", 47, ability = "MOXIE", nature = "ADAMANT", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "KOMALA", 47, ability = "COMATOSE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "THRASH", "SLAM" } },
    } },
    DIANNE = { partner = "VR_A7", party = {
      { "GRIMMSNARL", 47, ability = "FRISK", nature = "BOLD", spread = "bulk", moves = { "DAZZLING_GLEAM", "PROTECT", "FOUL_PLAY", "PLAY_ROUGH" } },
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "EXPLOUD", 47, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "HYPER_VOICE", "FLAMETHROWER", "ICE_BEAM", "PROTECT" } },
    } },
    FELIX = { partner = "VR_A8", party = {
      { "SWOOBAT", 47, ability = "UNAWARE", nature = "TIMID", moves = { "ZEN_HEADBUTT", "PSYCHIC", "PSYSHOCK", "ODOR_SLEUTH" } },
      { "CROBAT", 47, ability = "INNER_FOCUS", nature = "JOLLY", moves = { "CROSS_POISON", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "SHIFTRY", 47, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    CAROLINE = { partner = "VR_A9", party = {
      { "TOGEDEMARU", 47, ability = "LIGHTNING_ROD", nature = "IMPISH", spread = "bulk", moves = { "VOLT_TACKLE", "WILD_CHARGE", "ZING_ZAP", "SPARK" } },
      { "SABLEYE", 47, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "SALAMENCE", 48, ability = "INTIMIDATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "DRAGON_CLAW", "ROCK_SLIDE", "FLY", "PROTECT" } },
    } },
    VITO = { partner = "VR_A10", party = {
      { "SAWSBUCK", 47, ability = "SAP_SIPPER", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "AGILITY", "DOUBLE_EDGE", "TAKE_DOWN", "HORN_LEECH" } },
      { "KADABRA", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "REFLECT" } },
      { "ELECTRODE", 47, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DISCHARGE", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    MICHELLE = { partner = "VR_A11", party = {
      { "ORICORIO", 47, ability = "DANCER", nature = "ADAMANT", spread = "tank", item = "HEAT_ROCK", moves = { "PROTECT", "AIR_SLASH", "AIR_CUTTER", "PECK" } },
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LUDICOLO", 47, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "ICE_BEAM" } },
    } },
    MITCHELL = { partner = "VR_A12", party = {
      { "SHUCKLE", 47, ability = "STURDY", nature = "ADAMANT", spread = "atk", moves = { "POWER_GEM", "ROCK_SLIDE", "BUG_BITE", "SHELL_SMASH" } },
      { "SOLROCK", 47, ability = "LEVITATE", nature = "BRAVE", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "FLARE_BLITZ", "EXPLOSION" } },
    } },
    HALLE = { partner = "VR_A13", party = {
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    EDGAR = { partner = "VR_A14", party = {
      { "FERROTHORN", 47, ability = "IRON_BARBS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "POWER_WHIP", "IRON_HEAD", "METAL_CLAW", "FLASH_CANNON" } },
      { "PELIPPER", 47, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
    } },
    QUINCY = { partner = "VR_A15", party = {
      { "LAMPENT", 47, ability = "INFILTRATOR", nature = "RELAXED", spread = "bulk", moves = { "WILL_O_WISP", "TRICK_ROOM", "PAIN_SPLIT", "INFERNO" } },
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
    } },
    KATELYNN = { partner = "VR_A16", party = {
      { "HATTERENE", 47, ability = "ANTICIPATION", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "PLAY_NICE" } },
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
    -- The Elite Four and Wallace: six each, alone (2-vs-1), aces at the caps. Sidney:
    -- Prankster disruption; Phoebe: burns, Destiny Bond, No Guard Golurk; Glacia: hail,
    -- Shell Smash Cloyster; Drake: Tailwind and Dragon Dance; Wallace: rain with sleep
    SIDNEY = { tier = "leader", party = {
      { "SABLEYE", 49, ability = "PRANKSTER", nature = "CAREFUL", spread = "spdef", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "LIEPARD", 49, ability = "PRANKSTER", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "ENCORE", "TAUNT", "KNOCK_OFF" } },
      { "BISHARP", 49, ability = "DEFIANT", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "IRON_HEAD", "KNOCK_OFF", "SUCKER_PUNCH", "PROTECT" } },
      { "CRAWDAUNT", 49, ability = "ADAPTABILITY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "CRABHAMMER", "KNOCK_OFF", "AQUA_JET", "SWORDS_DANCE" } },
      { "MANDIBUZZ", 49, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "TAILWIND", "FOUL_PLAY", "ROOST", "KNOCK_OFF" } },
      { "ABSOL", 50, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SUPERPOWER", "PLAY_ROUGH", "SUCKER_PUNCH" } },
    } },
    PHOEBE = { tier = "leader", party = {
      { "SPIRITOMB", 51, ability = "INFILTRATOR", nature = "CAREFUL", spread = "spdef", item = "SITRUS_BERRY", moves = { "WILL_O_WISP", "PAIN_SPLIT", "SUCKER_PUNCH", "SHADOW_SNEAK" } },
      { "GENGAR", 51, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "SHADOW_BALL", "SLUDGE_BOMB", "DESTINY_BOND", "PROTECT" } },
      { "GOLURK", 51, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "EARTHQUAKE", "SHADOW_PUNCH", "PROTECT" } },
      { "DRIFBLIM", 51, ability = "UNBURDEN", nature = "TIMID", spread = "bulk", item = "SITRUS_BERRY", moves = { "TAILWIND", "WILL_O_WISP", "SHADOW_BALL", "DESTINY_BOND" } },
      { "DOUBLADE", 51, ability = "NO_GUARD", nature = "ADAMANT", item = "EVIOLITE", moves = { "SACRED_SWORD", "SHADOW_CLAW", "SWORDS_DANCE", "PROTECT" } },
      { "DUSKNOIR", 52, ability = "PRESSURE", nature = "ADAMANT", spread = "tank", item = "LEFTOVERS", moves = { "SHADOW_PUNCH", "ICE_PUNCH", "WILL_O_WISP", "PAIN_SPLIT" } },
    } },
    GLACIA = { tier = "leader", party = {
      { "VANILLUXE", 53, ability = "SNOW_WARNING", nature = "MODEST", spread = "spa", item = "ICY_ROCK", moves = { "BLIZZARD", "FREEZE_DRY", "FLASH_CANNON", "PROTECT" } },
      { "SANDSLASH_ALOLAN", 53, ability = "SLUSH_RUSH", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ICICLE_CRASH", "IRON_HEAD", "EARTHQUAKE", "PROTECT" } },
      { "CLOYSTER", 53, ability = "SKILL_LINK", nature = "ADAMANT", item = "FOCUS_SASH", moves = { "ICICLE_SPEAR", "ROCK_BLAST", "SHELL_SMASH", "PROTECT" } },
      { "BEARTIC", 53, ability = "SLUSH_RUSH", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ICICLE_CRASH", "SUPERPOWER", "AQUA_JET", "PROTECT" } },
      { "GLALIE", 53, ability = "ICE_BODY", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "SPIKES", "EXPLOSION", "ICE_SHARD", "FREEZE_DRY" } },
      { "WALREIN", 54, ability = "THICK_FAT", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "BLIZZARD", "SURF", "YAWN", "PROTECT" } },
    } },
    DRAKE = { tier = "leader", party = {
      { "NOIVERN", 55, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "TAILWIND", "DRAGON_PULSE", "AIR_SLASH", "PROTECT" } },
      { "KOMMO_O", 55, ability = "BULLETPROOF", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "CLOSE_COMBAT", "DRAGON_CLAW", "POISON_JAB", "PROTECT" } },
      { "DRAGALGE", 55, ability = "ADAPTABILITY", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "SLUDGE_BOMB", "DRAGON_PULSE", "SCALD", "PROTECT" } },
      { "HAXORUS", 55, ability = "MOLD_BREAKER", nature = "JOLLY", item = "LUM_BERRY", moves = { "DRAGON_DANCE", "DRAGON_CLAW", "EARTHQUAKE", "POISON_JAB" } },
      { "GOODRA", 55, ability = "GOOEY", nature = "MODEST", spread = "stank", item = "ASSAULT_VEST", moves = { "DRAGON_PULSE", "FIRE_BLAST", "SLUDGE_BOMB", "THUNDERBOLT" } },
      { "SALAMENCE", 56, ability = "INTIMIDATE", nature = "JOLLY", item = "LIFE_ORB", moves = { "DRAGON_DANCE", "DRAGON_CLAW", "ROCK_SLIDE", "PROTECT" } },
    } },
    WALLACE = { tier = "leader", party = {
      { "POLITOED", 57, ability = "DRIZZLE", nature = "BOLD", spread = "bulk", item = "DAMP_ROCK", moves = { "SCALD", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
      { "LUDICOLO", 57, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "GIGA_DRAIN", "HYDRO_PUMP", "ICE_BEAM" } },
      { "SWAMPERT", 57, ability = "TORRENT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "WATERFALL", "ICE_PUNCH", "YAWN", "PROTECT" } },
      { "GYARADOS", 57, ability = "INTIMIDATE", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "DRAGON_DANCE", "WATERFALL", "EARTHQUAKE", "PROTECT" } },
      { "TENTACRUEL", 57, ability = "RAIN_DISH", nature = "TIMID", spread = "spa", item = "BLACK_SLUDGE", moves = { "MUDDY_WATER", "SLUDGE_BOMB", "KNOCK_OFF", "TOXIC" } },
      { "MILOTIC", 58, ability = "COMPETITIVE", nature = "BOLD", spread = "bulk", item = "LEFTOVERS", moves = { "SCALD", "ICE_BEAM", "RECOVER", "HYPNOSIS" } },
    } },
    -- Post-game and stragglers: Rusturf Mike, Jagged Pass grunt, S.S. Tidal, Trick House 8 (draft 1, 2026-10-27) ----
    -- Rusturf Tunnel, Verdanturf side: a tag battle at 21
    MIKE_2 = { partner = "RT_GUS", party = {
      { "SWINUB", 21, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "SOFT_SAND", moves = { "ROCK_TOMB", "BULLDOZE", "DEFENSE_CURL", "ICE_SHARD" } },
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
      { "JUMPLUFF", 59, ability = "LEAF_GUARD", nature = "ADAMANT", moves = { "BOUNCE", "SEED_BOMB", "ACROBATICS", "BULLET_SEED" } },
      { "MAWILE", 59, ability = "INTIMIDATE", nature = "ADAMANT", moves = { "IRON_HEAD", "PLAY_ROUGH", "SUCKER_PUNCH", "PROTECT" } },
      { "ARBOK", 59, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "SITRUS_BERRY", moves = { "SLUDGE_BOMB", "PROTECT", "GUNK_SHOT", "POISON_JAB" } },
    } },
    GARRET = { partner = "SS_REX", party = {
      { "PORYGON2", 60, ability = "TRACE", nature = "MODEST", spread = "spa", item = "EVIOLITE", moves = { "TRI_ATTACK", "ICE_BEAM", "THUNDERBOLT", "TRICK_ROOM" } },
      { "DUBWOOL", 59, ability = "STEADFAST", nature = "TIMID", item = "SITRUS_BERRY", moves = { "LAST_RESORT", "DOUBLE_EDGE", "TAKE_DOWN", "HEADBUTT" } },
      { "STARMIE", 59, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    MICAH = { partner = "SS_MAX", party = {
      { "PYROAR", 60, ability = "RIVALRY", nature = "MODEST", item = "SITRUS_BERRY", moves = { "FLARE_BLITZ", "CRUNCH", "PROTECT", "HYPER_BEAM" } },
      { "BOUFFALANT", 59, ability = "SAP_SIPPER", nature = "ADAMANT", moves = { "PROTECT", "THRASH", "HEAD_CHARGE", "HORN_ATTACK" } },
    } },
    THOMAS = { partner = "SS_HAL", party = {
      { "BARRASKEWDA", 59, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
      { "CONKELDURR", 60, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "MAGNEZONE", 59, ability = "STURDY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DISCHARGE", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
    } },
    COLTON = { party = {
      { "GRIMMSNARL", 59, ability = "FRISK", nature = "BOLD", spread = "bulk", moves = { "DAZZLING_GLEAM", "PROTECT", "FOUL_PLAY", "PLAY_ROUGH" } },
      { "PLUSLE", 59, ability = "PLUS", nature = "TIMID", spread = "spa", moves = { "DISCHARGE", "NUZZLE", "HELPING_HAND", "ENCORE" } },
      { "MINUN", 59, ability = "MINUS", nature = "TIMID", spread = "spa", moves = { "DISCHARGE", "NUZZLE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "AZUMARILL", 60, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    PHILLIP = { partner = "SS_BEN", party = {
      { "MACHAMP", 60, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "GOLDUCK", 59, ability = "DAMP", nature = "ADAMANT", spread = "tank", moves = { "ICE_BEAM", "AMNESIA", "PROTECT", "HYDRO_PUMP" } },
    } },
    LEONARD = { partner = "SS_WES", party = {
      { "GYARADOS", 60, ability = "MOXIE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "PANGORO", 59, ability = "IRON_FIST", nature = "ADAMANT", spread = "tank", moves = { "CLOSE_COMBAT", "KNOCK_OFF", "HAMMER_ARM", "SKY_UPPERCUT" } },
    } },
    LEA_AND_JED = { party = {
      { "MILTANK", 60, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", moves = { "BODY_SLAM", "MILK_DRINK", "HELPING_HAND", "PROTECT" } },
      { "KOMALA", 60, ability = "COMATOSE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "EARTHQUAKE", "PROTECT" } },
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
      { "POLIWAG", 7, ability = "DAMP", nature = "MODEST", spread = "spa", moves = { "BUBBLE", "WATER_SPORT" } },
      { "SOLOSIS", 7, ability = "OVERCOAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "ROLLOUT", "RECOVER", "PROTECT" } },
    } },
    R102_OWEN = { like = "RICK", name = "OWEN", defeat = "My bugs got squished...", party = {
      { "DEWPIDER", 8, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUBBLE", "WATER_SPORT", "INFESTATION", "SPIDER_WEB" } },
      { "VENIPEDE", 7, ability = "SPEED_BOOST", nature = "ADAMANT", moves = { "BUG_BITE", "ROLLOUT", "POISON_STING", "DEFENSE_CURL" } },
    } },
    R102_BEN = { like = "ALLEN", name = "BEN", defeat = "Rolling didn't work out...", party = {
      { "SENTRET", 7, ability = "RUN_AWAY", nature = "IMPISH", spread = "tank", moves = { "DEFENSE_CURL", "ROLLOUT", "SCRATCH", "QUICK_ATTACK" } },
      { "SEEDOT", 7, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "ASTONISH", "HARDEN", "TACKLE" } },
    } },
    R102_DANA = { like = "TIANA", name = "DANA", defeat = "You two are too strong!", party = {
      { "HATENNA", 8, ability = "MAGIC_BOUNCE", nature = "MODEST", spread = "spa", moves = { "CONFUSION", "DISARMING_VOICE", "DOUBLE_TEAM", "PLAY_NICE" } },
      { "LOTAD", 8, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ABSORB", "BUBBLE", "ASTONISH", "GROWL" } },
    } },
    R104_SAM = { like = "BILLY", name = "SAM", defeat = "Next time we'll win!", party = {
      { "RATTATA", 9, ability = "GUTS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "MUD_SLAP", "TACKLE", "TAIL_WHIP" } },
      { "LILLIPUP", 9, ability = "PICKUP", nature = "JOLLY", item = "SILK_SCARF", moves = { "LEER", "TACKLE", "BITE", "ODOR_SLEUTH" } },
    } },
    R104_NEIL = { like = "DARIAN", name = "NEIL", defeat = "The big one got away...", party = {
      { "PYUKUMUKU", 9, ability = "UNAWARE", nature = "JOLLY", spread = "atk", moves = { "BLOCK", "WATER_SPORT" } },
      { "MAGIKARP", 12, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
    } },
    R104_PERCY = { like = "WINSTON_1", name = "PERCY", defeat = "Hmph. Money can't buy everything.", party = {
      { "LEDYBA", 9, ability = "SWARM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "SWIFT", "SUPERSONIC", "REFLECT" } },
      { "STARLY", 9, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "QUICK_ATTACK", "SAND_ATTACK", "TACKLE", "AERIAL_ACE" } },
    } },
    PW_WADE = { like = "LYLE", name = "WADE", defeat = "The woods are full of tough bugs... and you.", party = {
      { "COMBEE", 10, ability = "HONEY_GATHER", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "GUST", "SWEET_SCENT" } },
      { "GRUBBIN", 11, ability = "SWARM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "BITE", "VISE_GRIP", "STRING_SHOT" } },
    } },
    PW_COLE = { like = "JAMES_1", name = "COLE", defeat = "Our spores weren't enough!", party = {
      { "PARAS", 11, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", moves = { "STUN_SPORE", "STRUGGLE_BUG", "ABSORB", "SCRATCH" } },
      { "LEDYBA", 11, ability = "SWARM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SWIFT", "TACKLE", "LIGHT_SCREEN", "REFLECT" } },
    } },
    R104_ROSA = { like = "CINDY_1", name = "ROSA", defeat = "My, how unladylike of me to lose.", party = {
      { "FERROSEED", 11, ability = "IRON_BARBS", nature = "ADAMANT", spread = "atk", moves = { "LEECH_SEED", "METAL_CLAW", "TACKLE", "HARDEN" } },
      { "MORELULL", 11, ability = "ILLUMINATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "ABSORB", "ASTONISH", "FLASH" } },
    } },
    R104_TARA = { like = "HALEY_1", name = "TARA", defeat = "Haley, they're too good!", party = {
      { "BOUNSWEET", 11, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "RAPID_SPIN", "PLAY_NICE" } },
      { "RALTS", 11, ability = "TELEPATHY", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "DISARMING_VOICE", "HYPNOSIS", "DOUBLE_TEAM" } },
    } },
    R104_HUGO = { like = "IVAN", name = "HUGO", defeat = "Reeled in by you two...", party = {
      { "POLIWAG", 12, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", moves = { "MUD_SHOT", "BUBBLE", "BUBBLE_BEAM", "HYPNOSIS" } },
      { "GOLDEEN", 12, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "FLAIL", "SUPERSONIC", "PECK" } },
    } },
    -- Chapter 2 partners -----------------------------------------------------------------
    R116_TIM = { like = "JOEY", name = "TIM", defeat = "Joey, they're way better than us!", party = {
      { "FLETCHLING", 13, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "GROWL" } },
      { "ELEKID", 13, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "LEER", "THUNDER_SHOCK", "SWIFT" } },
    } },
    R116_GUS = { like = "JOSE", name = "GUS", defeat = "My bugs need more training...", party = {
      { "APPLIN", 13, ability = "RIPEN", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "ASTONISH", "WITHDRAW" } },
      { "NINCADA", 13, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "ABSORB", "SAND_ATTACK" } },
    } },
    R116_EMMA = { like = "KAREN_1", name = "EMMA", defeat = "We studied so hard for this!", party = {
      { "ELEKID", 13, ability = "STATIC", nature = "MODEST", spread = "spa", moves = { "THUNDER_SHOCK", "THUNDER_WAVE", "SWIFT", "LEER" } },
      { "CHINGLING", 13, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "HELPING_HAND", "YAWN", "ASTONISH" } },
    } },
    R116_HANK = { like = "CLARK", name = "HANK", defeat = "Hard as rock, and still we lost!", party = {
      { "SILICOBRA", 14, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", moves = { "MUD_SLAP", "BRUTAL_SWING", "WRAP", "SAND_ATTACK" } },
      { "LARVITAR", 14, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_THROW", "BITE", "PAYBACK", "SCARY_FACE" } },
    } },
    R116_OLAF = { like = "DEVAN", name = "OLAF", defeat = "Back to the tunnel for us...", party = {
      { "WHISMUR", 14, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "ASTONISH", "HOWL" } },
      { "COMBEE", 14, ability = "HONEY_GATHER", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "GUST", "TAILWIND", "BUG_BITE", "SWEET_SCENT" } },
    } },
    R116_RAY = { like = "JOHNSON", name = "RAY", defeat = "Aw, I wanted to win that one.", party = {
      { "CRABRAWLER", 14, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "COUNTER", "ROCK_SMASH", "PURSUIT", "LEER" } },
      { "POOCHYENA", 14, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "THIEF", "HOWL", "SAND_ATTACK" } },
    } },
    R116_ELLA = { like = "SARAH", name = "ELLA", defeat = "How terribly rude of you to win.", party = {
      { "SIZZLIPEDE", 15, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FLAME_WHEEL", "EMBER", "BITE", "SMOKESCREEN" } },
      { "LOTAD", 14, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R116_REX = { like = "DAWSON", name = "REX", defeat = "Daddy will hear about this!", party = {
      { "STARYU", 15, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "MAGNEMITE", 14, ability = "MAGNET_PULL", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDER_SHOCK", "THUNDER_WAVE", "MAGNET_BOMB", "LIGHT_SCREEN" } },
    } },
    R116_LIAM = { like = "JERRY_1", name = "LIAM", defeat = "That wasn't in the textbook!", party = {
      { "PIKIPEK", 14, ability = "KEEN_EYE", nature = "JOLLY", moves = { "AIR_CUTTER", "ROCK_SMASH", "PECK", "GROWL" } },
      { "EXEGGCUTE", 15, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "BULLET_SEED", "LEECH_SEED", "HYPNOSIS", "REFLECT" } },
    } },
    R116_JUNE = { like = "JANICE", name = "JUNE", defeat = "Janice, they beat us both!", party = {
      { "WINGULL", 15, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_GUN", "AERIAL_ACE", "SUPERSONIC", "MIST" } },
      { "DODUO", 14, ability = "RUN_AWAY", nature = "ADAMANT", moves = { "FEINT_ATTACK", "QUICK_ATTACK", "PECK", "RAGE" } },
    } },
    R106_KAI = { like = "NED", name = "KAI", defeat = "Even the sea's on your side.", party = {
      { "SEEL", 16, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "HEADBUTT", "ICY_WIND", "ENCORE", "WATER_SPORT" } },
      { "PANPOUR", 16, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATER_GUN", "BITE", "SCRATCH", "WATER_SPORT" } },
    } },
    R106_ROY = { like = "ELLIOT_1", name = "ROY", defeat = "Nothing's biting today, huh.", party = {
      { "DUNSPARCE", 16, ability = "RATTLED", nature = "JOLLY", spread = "atk", moves = { "RAGE", "PURSUIT", "SPITE", "YAWN" } },
      { "PURRLOIN", 16, ability = "LIMBER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FOUL_PLAY", "ASSURANCE", "PURSUIT", "GROWL" } },
    } },
    -- Chapter 3 partners -------------------------------------------------------------------
    R109_WES = { like = "HUEY", name = "WES", defeat = "Shiver me timbers!", party = {
      { "CLAUNCHER", 16, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "ICY_WIND", "BUBBLE", "WATER_GUN", "WATER_SPORT" } },
      { "CORPHISH", 17, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },
    R109_PIP = { like = "EDMOND", name = "PIP", defeat = "Swabbed the deck with us, you did.", party = {
      { "BERGMITE", 17, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICY_WIND", "TAKE_DOWN", "BITE", "HARDEN" } },
      { "BUIZEL", 16, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "WATER_SPORT", "QUICK_ATTACK", "PURSUIT" } },
    } },
    R109_DOT = { like = "HAILEY", name = "DOT", defeat = "My floatie popped...", party = {
      { "MARILL", 16, ability = "HUGE_POWER", nature = "ADAMANT", moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SEEL", 16, ability = "THICK_FAT", nature = "JOLLY", item = "ORAN_BERRY", moves = { "HEADBUTT", "ICY_WIND", "ENCORE", "WATER_SPORT" } },
    } },
    R109_BO = { like = "RICKY_1", name = "BO", defeat = "Aww, sand in my shoes AND I lost.", party = {
      { "POLIWAG", 16, ability = "DAMP", nature = "MODEST", spread = "spa", moves = { "BUBBLE", "MUD_SHOT", "DOUBLE_SLAP", "BUBBLE_BEAM" } },
      { "GOLDEEN", 16, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R109_KIM = { like = "LOLA_1", name = "KIM", defeat = "Let's go build sandcastles instead.", party = {
      { "SPHEAL", 16, ability = "THICK_FAT", nature = "MODEST", spread = "spa", moves = { "WATER_GUN", "POWDER_SNOW", "DEFENSE_CURL", "ENCORE" } },
      { "JIGGLYPUFF", 16, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R109_ZED = { like = "CHANDLER", name = "ZED", defeat = "The tide went out on us.", party = {
      { "TENTACOOL", 16, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SALANDIT", 17, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", moves = { "EMBER", "SMOG", "POISON_GAS", "SWEET_SCENT" } },
    } },
    R110_ANN = { like = "ISABEL_1", name = "ANN", defeat = "Our babies did their best!", party = {
      { "IMPIDIMP", 17, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
      { "WOOLOO", 17, ability = "RUN_AWAY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "DOUBLE_KICK", "COPYCAT", "GUARD_SPLIT" } },
    } },
    R110_GIL = { like = "KALEB", name = "GIL", defeat = "Zapped right back at us!", party = {
      { "PIKACHU", 17, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "PIDOVE", 17, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AIR_CUTTER", "GUST", "LEER" } },
    } },
    R110_OTTO = { like = "TIMMY", name = "OTTO", defeat = "I'll bike faster next time!", party = {
      { "DEERLING", 17, ability = "SAP_SIPPER", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "AGILITY", "TACKLE", "FEINT_ATTACK", "LEECH_SEED" } },
      { "ZUBAT", 17, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R110_MOE = { like = "EDWIN_1", name = "MOE", defeat = "A rare loss for my collection.", party = {
      { "HONEDGE", 17, ability = "NO_GUARD", nature = "ADAMANT", moves = { "METAL_SOUND", "AUTOTOMIZE", "TACKLE", "PURSUIT" } },
      { "ODDISH", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R110_BRAD = { like = "JOSEPH", name = "BRAD", defeat = "Feedback! Total feedback!", party = {
      { "WHISMUR", 18, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
      { "CLEFFA", 17, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R110_VIC = { like = "EDWARD", name = "VIC", defeat = "I foresaw this. Sort of.", party = {
      { "ESPURR", 17, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", moves = { "FAKE_OUT", "PSYBEAM", "CONFUSION", "LIGHT_SCREEN" } },
      { "MIME_JR", 17, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    R110_LIZ = { like = "ALYSSA", name = "LIZ", defeat = "You out-paced us both!", party = {
      { "GROWLITHE", 18, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "BITE", "HELPING_HAND" } },
      { "TYNAMO", 17, ability = "LEVITATE", nature = "TIMID", item = "ORAN_BERRY", moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
    } },
    R110_HAL = { like = "DALE", name = "HAL", defeat = "Reeled in by kids again.", party = {
      { "TENTACOOL", 17, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "FRILLISH", 18, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "BUBBLE_BEAM", "BUBBLE", "RAIN_DANCE", "WATER_SPORT" } },
    } },
    TH1_MIA = { like = "SALLY", name = "MIA", defeat = "This house is too tricky!", party = {
      { "MORELULL", 18, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "SKITTY", 18, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    TH1_ZOE = { like = "ROBIN", name = "ZOE", defeat = "Tricked us right back!", party = {
      { "WOOLOO", 18, ability = "RUN_AWAY", nature = "JOLLY", moves = { "TACKLE", "DOUBLE_KICK", "COPYCAT", "GUARD_SPLIT" } },
      { "WINGULL", 18, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    TH1_KIP = { like = "EDDIE", name = "KIP", defeat = "Which way is the exit?", party = {
      { "ZIGZAGOON", 18, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "ELEKID", 18, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
    } },
    R103_FAY = { like = "DAISY", name = "FAY", defeat = "What a lovely, lovely loss.", party = {
      { "ODDISH", 18, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "SKIPLOOM", 18, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "BULLET_SEED", "ABSORB", "TACKLE" } },
    } },
    R103_GUY = { like = "MIGUEL_1", name = "GUY", defeat = "My precious Pokémon!", party = {
      { "PIDOVE", 18, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AIR_CUTTER", "GUST", "GROWL" } },
      { "PIKACHU", 18, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    R103_FINN = { like = "ANDREW", name = "FINN", defeat = "That one got away from me.", party = {
      { "SEEL", 18, ability = "THICK_FAT", nature = "JOLLY", spread = "atk", moves = { "HEADBUTT", "ICE_SHARD", "ENCORE", "WATER_SPORT" } },
      { "GOLDEEN", 18, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R103_JAX = { like = "MARCOS", name = "JAX", defeat = "Our set got cut short!", party = {
      { "STARLY", 19, ability = "KEEN_EYE", nature = "MODEST", spread = "stank", moves = { "AERIAL_ACE", "TACKLE", "QUICK_ATTACK", "GROWL" } },
      { "VOLTORB", 19, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "CHARGE_BEAM", "EERIE_IMPULSE", "SCREECH" } },
    } },
    R103_DUKE = { like = "RHETT", name = "DUKE", defeat = "Hrrah! I yield!", party = {
      { "MACHOP", 19, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "MACHOP", 18, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "KARATE_CHOP" } },
    } },
    CR_NOVA = { like = "JACLYN", name = "NOVA", defeat = "I didn't see that coming...", party = {
      { "ESPURR", 20, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MIME_JR", 20, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    CR_TOD = { like = "JACOB", name = "TOD", defeat = "Out-pedaled AND out-battled.", party = {
      { "DODUO", 20, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
      { "GROWLITHE", 20, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "BITE" } },
    } },
    CR_WIN = { like = "ANTHONY", name = "WIN", defeat = "We blew a fuse!", party = {
      { "BLITZLE", 20, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", moves = { "QUICK_ATTACK", "MUD_SLAP", "CHARGE", "SHOCK_WAVE" } },
      { "PINCURCHIN", 20, ability = "ELECTRIC_SURGE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "SPARK", "ENDURE", "PECK", "CHARGE" } },
    } },
    CR_ACE = { like = "BENJAMIN_1", name = "ACE", defeat = "Can't win 'em all on the road.", party = {
      { "FLAAFFY", 20, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDER_SHOCK", "COTTON_SPORE", "THUNDER_WAVE", "TAKE_DOWN" } },
      { "HERDIER", 20, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
    } },
    CR_ADA = { like = "ABIGAIL_1", name = "ADA", defeat = "That was electrifying. For you.", party = {
      { "MORPEKO", 20, ability = "HUNGER_SWITCH", nature = "JOLLY", spread = "atk", moves = { "THUNDER_WAVE", "POWER_TRIP", "THUNDER_SHOCK", "QUICK_ATTACK" } },
      { "PLUSLE", 20, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
    } },
    CR_SKY = { like = "JASMINE", name = "SKY", defeat = "Wind's against us today.", party = {
      { "BLITZLE", 20, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", moves = { "QUICK_ATTACK", "MUD_SLAP", "CHARGE", "SHOCK_WAVE" } },
      { "BINACLE", 20, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CLAMP", "ANCIENT_POWER", "WATER_GUN", "SCRATCH" } },
    } },
    R117_KAI = { like = "DEREK", name = "TOBY", defeat = "My bugs... squashed.", party = {
      { "DWEBBLE", 20, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SMACK_DOWN", "FURY_CUTTER", "ROCK_BLAST", "WITHDRAW" } },
      { "KRICKETUNE", 20, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    R117_LEE = { like = "DYLAN_1", name = "LEE", defeat = "Lap time: too slow.", party = {
      { "HERDIER", 20, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
    } },
    R117_MAE = { like = "MARIA_1", name = "MAE", defeat = "We'll train harder for the next race.", party = {
      { "LARVESTA", 20, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", moves = { "BUG_BITE", "FLAME_CHARGE", "EMBER", "TAKE_DOWN" } },
      { "WOOBAT", 20, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    R117_ROX = { like = "MELINA", name = "ROX", defeat = "Hit the wall at the last mile.", party = {
      { "ELEKID", 21, ability = "STATIC", nature = "MODEST", item = "MAGNET", moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
      { "FLETCHINDER", 20, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
    } },
    R117_IVY = { like = "BRANDI", name = "IVY", defeat = "The future was cloudy today.", party = {
      { "KADABRA", 20, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "GOTHITA", 20, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
    } },
    R117_JO = { like = "AISHA", name = "JO", defeat = "You hit harder than we do!", party = {
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_KICK", "BULK_UP" } },
      { "CRABRAWLER", 20, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "PURSUIT", "LEER", "BUBBLE_BEAM" } },
    } },
    R111_ABE = { like = "TYRON", name = "ABE", defeat = "Our campfire's out.", party = {
      { "LITLEO", 21, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "HELPING_HAND", "ROAR", "ECHOED_VOICE", "EMBER" } },
      { "NINCADA", 21, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R111_NIA = { like = "CELINA", name = "NIA", defeat = "Such a sweet scent of defeat.", party = {
      { "MORELULL", 21, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "SKIPLOOM", 21, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "BULLET_SEED", "ABSORB", "TACKLE" } },
    } },
    R111_PIA = { like = "BIANCA", name = "PIA", defeat = "Picnic's ruined!", party = {
      { "SKWOVET", 21, ability = "GLUTTONY", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BODY_SLAM", "TACKLE", "SWALLOW", "STUFF_CHEEKS" } },
      { "TEDDIURSA", 21, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    R111_CY = { like = "HAYDEN", name = "CY", defeat = "Burnt out, just like that.", party = {
      { "EKANS", 21, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", moves = { "POISON_FANG", "POISON_STING", "BITE", "SCREECH" } },
      { "HOUNDOUR", 21, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "EMBER", "BITE", "SMOG", "HOWL" } },
    } },
    -- Chapter 4 partners -----------------------------------------------------------------------
    R112_BUD = { like = "LARRY", name = "BUD", defeat = "Back to camp for us.", party = {
      { "RUFFLET", 21, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PECK", "AERIAL_ACE", "TAILWIND", "HONE_CLAWS" } },
      { "NUMEL", 22, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    R112_SUE = { like = "CAROL", name = "SUE", defeat = "Our picnic basket's empty...", party = {
      { "JIGGLYPUFF", 21, ability = "COMPETITIVE", nature = "MODEST", moves = { "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE" } },
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    R112_GUS = { like = "BRICE", name = "GUS", defeat = "Rock solid, and still cracked.", party = {
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "ONIX", 21, ability = "ROCK_HEAD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "BLOCK", "HARDEN", "ROCK_SLIDE" } },
    } },
    R112_ROB = { like = "TRENT_1", name = "ROB", defeat = "Rockslide... on us.", party = {
      { "GEODUDE", 21, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "ROLYCOLY", 22, ability = "STEAM_ENGINE", nature = "ADAMANT", spread = "atk", item = "HARD_STONE", moves = { "ROCK_BLAST", "SMACK_DOWN", "STEALTH_ROCK", "RAPID_SPIN" } },
    } },
    R112_ASH = { like = "BRYANT", name = "ASH", defeat = "Snuffed out!", party = {
      { "HOUNDOUR", 22, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "EMBER", "BITE", "SMOG", "HOWL" } },
      { "PANSEAR", 21, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "FLAME_BURST", "INCINERATE", "ACROBATICS" } },
    } },
    R112_LIL = { like = "SHAYLA", name = "LIL", defeat = "The flowers wilted on us.", party = {
      { "STEENEE", 22, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "MAGICAL_LEAF", "RAZOR_LEAF", "RAPID_SPIN", "SWEET_SCENT" } },
      { "SPOINK", 21, ability = "THICK_FAT", nature = "MODEST", spread = "spa", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R113_PIP = { like = "JAYLEN", name = "PIP", defeat = "Ash in my eyes!", party = {
      { "DRILBUR", 21, ability = "MOLD_BREAKER", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "MUD_SLAP", "METAL_CLAW" } },
      { "SPINDA", 21, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    R113_TAD = { like = "DILLON", name = "TAD", defeat = "We're covered in soot and loss.", party = {
      { "EMOLGA", 21, ability = "STATIC", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "SHOCK_WAVE", "THUNDER_SHOCK", "TAIL_WHIP" } },
      { "NINCADA", 22, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R113_ZEN = { like = "LAO_1", name = "ZEN", defeat = "Our stealth was not enough.", party = {
      { "SHUPPET", 22, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "PARAS", 21, ability = "EFFECT_SPORE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "PROTECT", "SLASH" } },
    } },
    R113_KO = { like = "LUNG", name = "KO", defeat = "Smoked out ourselves.", party = {
      { "ESCAVALIER", 22, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "DOUBLE_TEAM", "DOUBLE_EDGE", "FELL_STINGER" } },
      { "GRIMER", 21, ability = "STICKY_HOLD", nature = "ADAMANT", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R113_UMA = { like = "MADELINE_1", name = "UMA", defeat = "My parasol's full of ash.", party = {
      { "DODUO", 21, ability = "RUN_AWAY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PECK", "PLUCK", "QUICK_ATTACK", "GROWL" } },
    } },
    R113_BEA = { like = "SOPHIE", name = "BEA", defeat = "Dessert is cancelled!", party = {
      { "SANDSLASH_ALOLAN", 22, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_SHARD", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
      { "DUNSPARCE", 21, ability = "RATTLED", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BODY_SLAM", "RAGE", "PURSUIT", "SPITE" } },
    } },
    R113_TAO = { like = "COBY", name = "TAO", defeat = "Grounded, both of us.", party = {
      { "SWABLU", 22, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
      { "SWELLOW", 21, ability = "SCRAPPY", nature = "ADAMANT", spread = "atk", moves = { "AIR_CUTTER", "WING_ATTACK", "EXTREME_SPEED", "GROWL" } },
    } },
    R113_RIO = { like = "LAWRENCE", name = "RIO", defeat = "The desert wind beat us.", party = {
      { "RHYHORN", 21, ability = "ROCK_HEAD", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "SMACK_DOWN", "TAIL_WHIP", "SCARY_FACE" } },
      { "CACNEA", 22, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    R113_MAX = { like = "WYATT", name = "MAX", defeat = "My rare ones weren't rare enough.", party = {
      { "NIDORINA", 22, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "SALANDIT", 21, ability = "CORROSION", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "EMBER", "SMOG", "POISON_GAS", "SWEET_SCENT" } },
    } },
    R114_HAL = { like = "STEVE_1", name = "HAL", defeat = "Fossil-fueled and still lost.", party = {
      { "YANMA", 22, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", moves = { "PROTECT", "AIR_CUTTER", "AERIAL_ACE", "FORESIGHT" } },
      { "LILEEP", 22, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    R114_ED = { like = "BERNIE_1", name = "ED", defeat = "Burned out by the river.", party = {
      { "DARUMAKA", 22, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "INCINERATE", "FIRE_FANG", "FACADE", "TAUNT" } },
      { "LOTAD", 22, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_IKE = { like = "SHANE", name = "IKE", defeat = "Sore losers, the pair of us.", party = {
      { "SEVIPER", 22, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
      { "ACCELGOR", 23, ability = "STICKY_HOLD", nature = "MODEST", item = "ORAN_BERRY", moves = { "PURSUIT", "STRUGGLE_BUG", "SWIFT", "YAWN" } },
    } },
    R114_JEB = { like = "CLAUDE", name = "JEB", defeat = "The big one bit back.", party = {
      { "GOOMY", 22, ability = "SAP_SIPPER", nature = "MODEST", moves = { "DRAGON_BREATH", "BUBBLE", "PROTECT", "ABSORB" } },
      { "LOTAD", 22, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_GUY = { like = "NOLAN", name = "GUY", defeat = "Only minnows today.", party = {
      { "CLAUNCHER", 22, ability = "MEGA_LAUNCHER", nature = "ADAMANT", spread = "tank", moves = { "BUBBLE_BEAM", "BUBBLE", "WATER_SPORT", "WATER_GUN" } },
      { "MAGIKARP", 23, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
    } },
    R114_FLO = { like = "NANCY", name = "FLO", defeat = "Oh dear, oh dear.", party = {
      { "RUFFLET", 22, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", moves = { "PECK", "AERIAL_ACE", "TAILWIND", "HONE_CLAWS" } },
      { "SEEDOT", 22, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ROLLOUT", "GROWTH", "HARDEN" } },
    } },
    R114_OZ = { like = "LENNY", name = "OZ", defeat = "Avalanche of defeat.", party = {
      { "SWINUB", 22, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "SOFT_SAND", moves = { "ROCK_TOMB", "BULLDOZE", "DEFENSE_CURL", "ICE_SHARD" } },
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    R114_BOB = { like = "LUCAS_1", name = "BOB", defeat = "Meteor shower of losses.", party = {
      { "NOSEPASS", 23, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "HARDEN" } },
      { "LUNATONE", 22, ability = "LEVITATE", nature = "MODEST", moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "PSYSHOCK" } },
    } },
    R114_MEL = { like = "ANGELINA", name = "MEL", defeat = "No fair, you two!", party = {
      { "DEWPIDER", 22, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", moves = { "BUBBLE_BEAM", "BUG_BITE", "BITE", "SPIDER_WEB" } },
      { "CORVISQUIRE", 22, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    R114_NED = { like = "KAI", name = "NED", defeat = "Let's call it a day.", party = {
      { "BARBOACH", 22, ability = "HYDRATION", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "MUD_BOMB", "MUD_SPORT", "WATER_SPORT" } },
      { "TENTACOOL", 23, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R114_ROE = { like = "CHARLOTTE", name = "ROE", defeat = "My garden's been trampled.", party = {
      { "SHIFTRY", 22, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", moves = { "MEGA_DRAIN", "EXPLOSION", "RAZOR_LEAF", "NATURE_POWER" } },
      { "SPOINK", 22, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115_KEN = { like = "NOB_1", name = "KEN", defeat = "Osu! A fine defeat.", party = {
      { "MACHOP", 22, ability = "GUTS", nature = "ADAMANT", moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "REVENGE" } },
      { "TAILLOW", 22, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R115_DON = { like = "HECTOR", name = "DON", defeat = "A gap in my collection.", party = {
      { "SWELLOW", 23, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
      { "PIDGEOTTO", 22, ability = "BIG_PECKS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "GUST", "TACKLE", "QUICK_ATTACK" } },
    } },
    R115_EVE = { like = "MARLENE", name = "EVE", defeat = "I sensed this would happen.", party = {
      { "CLEFFA", 22, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "PIXIE_PLATE", moves = { "DISARMING_VOICE", "MAGICAL_LEAF", "ENCORE", "COPYCAT" } },
      { "CHIMECHO", 23, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R115_JAN = { like = "CYNDY_1", name = "JAN", defeat = "Hyah! We'll train harder!", party = {
      { "CRABRAWLER", 22, ability = "IRON_FIST", nature = "ADAMANT", moves = { "ROCK_SMASH", "POWER_UP_PUNCH", "LEER", "PURSUIT" } },
      { "JANGMO_O", 22, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
    } },
    MC_BRAM = { like = "SAWYER_1", name = "BRAM", defeat = "Like a boulder down the mountain.", party = {
      { "GRAVELER", 24, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "ORICORIO", 23, ability = "DANCER", nature = "RELAXED", spread = "stank", item = "ORAN_BERRY", moves = { "CURSE", "PROTECT", "AIR_CUTTER", "PECK" } },
    } },
    MC_LIV = { like = "MELISSA", name = "LIV", defeat = "Not a hair out of place, and still lost.", party = {
      { "CASTFORM", 23, ability = "FORECAST", nature = "TIMID", item = "SILK_SCARF", moves = { "HEADBUTT", "EMBER", "POWDER_SNOW", "SUNNY_DAY" } },
      { "IMPIDIMP", 23, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
    } },
    MC_FAE = { like = "SHEILA", name = "FAE", defeat = "How very unglamorous.", party = {
      { "PATRAT", 23, ability = "ANALYTIC", nature = "JOLLY", moves = { "HELPING_HAND", "TACKLE", "CRUNCH", "DETECT" } },
      { "TOGETIC", 23, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    MC_DEE = { like = "SHIRLEY", name = "DEE", defeat = "Our dance fell flat.", party = {
      { "SIGILYPH", 23, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", moves = { "AIR_CUTTER", "PSYBEAM", "GRAVITY", "MIRACLE_EYE" } },
      { "DEERLING", 23, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "LEECH_SEED" } },
    } },
    MC_RUE = { like = "SHELBY_1", name = "RUE", defeat = "Well fought. Truly.", party = {
      { "SWOOBAT", 24, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
      { "CHIMECHO", 23, ability = "LEVITATE", nature = "MODEST", spread = "spa", moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    JP_COL = { like = "ERIC", name = "COL", defeat = "Down the pass we go.", party = {
      { "DWEBBLE", 25, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ROCK_TOMB", "BLOCK", "BUG_BITE", "SMACK_DOWN" } },
      { "MACHOKE", 25, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
    } },
    JP_IDA = { like = "AUTUMN", name = "IDA", defeat = "The leaves are falling. So are we.", party = {
      { "NATU", 25, ability = "SYNCHRONIZE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PECK", "OMINOUS_WIND", "STORED_POWER", "CONFUSE_RAY" } },
      { "NUMEL", 25, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    JP_ROD = { like = "JULIO", name = "ROD", defeat = "Out of breath and out of Pokémon.", party = {
      { "SPOINK", 25, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "FLETCHINDER", 25, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    JP_BEL = { like = "DIANA_1", name = "BEL", defeat = "The view was nice, at least.", party = {
      { "CORVISQUIRE", 25, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
      { "MACHOP", 25, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    JP_GUS = { like = "ETHAN_1", name = "WALT", defeat = "Cold camp tonight.", party = {
      { "ORICORIO", 25, ability = "DANCER", nature = "RELAXED", spread = "stank", moves = { "CURSE", "PROTECT", "AIR_CUTTER", "PECK" } },
      { "SPINDA", 25, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    -- Chapter 5: Lavaridge to Norman (draft 1, 2026-10-27; cap 31): partners ----------------------------------------
    R111N_ROY = { like = "TRAVIS", name = "ROY", defeat = "Dusty boots, dusty loss.", party = {
      { "HIPPOPOTAS", 22, ability = "SAND_FORCE", nature = "JOLLY", item = "SOFT_SAND", moves = { "SAND_TOMB", "DIG", "CRUNCH", "SAND_ATTACK" } },
      { "SWABLU", 22, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R111N_ADA = { like = "IRENE", name = "ADA", defeat = "Oh, my picnic!", party = {
      { "MORELULL", 22, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "MOONLIGHT" } },
      { "PICHU", 22, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "NUZZLE", "THUNDER_SHOCK", "SWEET_KISS", "CHARM" } },
    } },
    R111N_ZED = { like = "WILTON_1", name = "ZED", defeat = "Cool under pressure, still lost.", party = {
      { "HONEDGE", 22, ability = "NO_GUARD", nature = "BOLD", spread = "bulk", moves = { "SHADOW_SNEAK", "AERIAL_ACE", "METAL_SOUND", "AUTOTOMIZE" } },
      { "AXEW", 23, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_RAGE", "BITE", "ASSURANCE", "TAUNT" } },
    } },
    R111N_MAY = { like = "BROOKE_1", name = "MAYA", defeat = "We were so in sync, too.", party = {
      { "STARYU", 22, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "CORVISQUIRE", 22, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    R111N_KEN = { like = "DAISUKE", name = "KENJI", defeat = "Osu! Respect.", party = {
      { "MACHOP", 22, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "WOOBAT", 22, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    TH2_OLI = { like = "PAUL", name = "OLI", defeat = "Lost in here AND lost the battle.", party = {
      { "POLIWAG", 24, ability = "DAMP", nature = "ADAMANT", spread = "atk", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "BODY_SLAM", "DOUBLE_SLAP", "RAIN_DANCE" } },
      { "PIKACHU", 24, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    TH2_ABI = { like = "TED", name = "ABI", defeat = "The Trick Master would laugh at us.", party = {
      { "CHINGLING", 24, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "MAGIC_COAT", "CONFUSION", "LAST_RESORT", "YAWN" } },
      { "LEDIAN", 25, ability = "EARLY_BIRD", nature = "JOLLY", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
    } },
    TH2_ZAC = { like = "GEORGIA", name = "ZAC", defeat = "We got tricked by you!", party = {
      { "STUNFISK", 24, ability = "SAND_VEIL", nature = "IMPISH", spread = "bulk", moves = { "MUD_BOMB", "MUD_SHOT", "THUNDER_SHOCK", "MUD_SLAP" } },
      { "ILLUMISE", 24, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    DES_RAE = { like = "DUSTY_1", name = "RAE", defeat = "The ruins keep their secrets.", party = {
      { "BALTOY", 27, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
      { "DRILBUR", 27, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_HAL = { like = "DREW", name = "HAL", defeat = "Buried in sand!", party = {
      { "TRAPINCH", 28, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "DRILBUR", 27, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_IKE = { like = "BEAU", name = "IKE", defeat = "Sandblasted.", party = {
      { "SILICOBRA", 27, ability = "SAND_SPIT", nature = "JOLLY", item = "SOFT_SAND", moves = { "BULLDOZE", "HEADBUTT", "MINIMIZE", "GLARE" } },
      { "KRABBY", 28, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "WATER_PULSE", "HIDDEN_POWER", "RAZOR_SHELL", "STOMP" } },
    } },
    DES_FLO = { like = "HEIDI", name = "FLO", defeat = "Goggles fogged up, sorry!", party = {
      { "CARNIVINE", 28, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "SYNTHESIS", "SWEET_SCENT", "VINE_WHIP" } },
      { "SANDILE", 27, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
    } },
    DES_LEA = { like = "BECKY", name = "LEA", defeat = "Too hot, too cold, too strong.", party = {
      { "CORVISQUIRE", 27, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
      { "CACNEA", 28, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    DES_NIA = { like = "CELIA", name = "NIA", defeat = "The desert dried out our hopes.", party = {
      { "SANDSHREW", 27, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", moves = { "RAPID_SPIN", "FURY_CUTTER", "SAND_TOMB", "DEFENSE_CURL" } },
      { "DRILBUR", 27, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_OTT = { like = "BRYAN", name = "OTTO", defeat = "Unearthed and defeated.", party = {
      { "ANORITH", 28, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "HARD_STONE", moves = { "ANCIENT_POWER", "FURY_CUTTER", "METAL_CLAW", "PROTECT" } },
      { "SNOVER", 27, ability = "SOUNDPROOF", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "RAZOR_LEAF", "ICE_SHARD", "LEAFAGE", "ICY_WIND" } },
    } },
    DES_GIL = { like = "BRANDEN", name = "GILL", defeat = "Lost in the dunes.", party = {
      { "SANDILE", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
      { "MUDBRAY", 27, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BULLDOZE", "HIGH_HORSEPOWER", "MUD_SPORT", "ROTOTILLER" } },
    } },
    TH3_MO = { like = "JUSTIN", name = "MO", defeat = "I can see the exit from here!", party = {
      { "DRILBUR", 27, ability = "SAND_FORCE", nature = "ADAMANT", spread = "atk", item = "SOFT_SAND", moves = { "MUD_SLAP", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
      { "SWABLU", 27, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    TH3_BO = { like = "MARTHA", name = "BOE", defeat = "Third time is not a charm.", party = {
      { "DEERLING", 27, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "JUMP_KICK" } },
      { "SPOINK", 28, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    TH3_AL = { like = "ALAN", name = "AL", defeat = "Hard as rock, soft as sand.", party = {
      { "GRAVELER", 28, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "GURDURR", 27, ability = "GUTS", nature = "ADAMANT", moves = { "REVENGE", "ROCK_TOMB", "BULK_UP", "WAKE_UP_SLAP" } },
    } },
    -- Chapter 6a: sea routes, ship, Route 115 north, Route 118, Trick House 4 (draft 1, 2026-10-27): partners ----------------------------------------
    R118_IKE = { like = "WADE", name = "IKE", defeat = "Big one got away.", party = {
      { "KRABBY", 21, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "VISE_GRIP" } },
      { "WINGULL", 22, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    R118_POE = { like = "DEANDRE", name = "POE", defeat = "Dug ourselves a hole there.", party = {
      { "SILICOBRA", 22, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", moves = { "BULLDOZE", "HEADBUTT", "SAND_ATTACK", "MINIMIZE" } },
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R118_IVY = { like = "ROSE_1", name = "IVY", defeat = "The petals scattered.", party = {
      { "BURMY", 22, ability = "SHED_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUG_BITE", "BUG_BUZZ", "TACKLE", "PROTECT" } },
      { "STEENEE", 21, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", moves = { "MAGICAL_LEAF", "RAZOR_LEAF", "RAPID_SPIN", "SWEET_SCENT" } },
    } },
    R118_REX = { like = "DALTON_1", name = "REX", defeat = "Encore? No thanks.", party = {
      { "KRICKETUNE", 22, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "JOLTIK", 21, ability = "UNNERVE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "ELECTROWEB", "BUG_BITE", "FURY_CUTTER", "ABSORB" } },
    } },
    SEA_ORR = { like = "LUIS", name = "ORR", defeat = "Glub glub, we lost.", party = {
      { "ARROKUDA", 28, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", moves = { "WATER_PULSE", "PROTECT", "DIVE", "AQUA_JET" } },
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
    } },
    SEA_GIL = { like = "DOMINIK", name = "GIL", defeat = "Sank like a stone.", party = {
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SEEL", 28, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
    } },
    SEA_JON = { like = "DOUGLAS", name = "JON", defeat = "Cramp! I lost!", party = {
      { "WAILMER", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "CLAUNCHER", 28, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
    } },
    SEA_AMY = { like = "BEVERLY", name = "AMY", defeat = "Washed ashore again.", party = {
      { "CLAUNCHER", 28, ability = "MEGA_LAUNCHER", nature = "TIMID", spread = "spa", moves = { "BUBBLE_BEAM", "BUBBLE", "SWORDS_DANCE", "WATER_SPORT" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SEA_ZOE = { like = "IMANI", name = "ZOE", defeat = "Too tired to swim back.", party = {
      { "BUIZEL", 28, ability = "WATER_VEIL", nature = "ADAMANT", moves = { "WATERFALL", "AGILITY", "AQUA_JET", "QUICK_ATTACK" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SEA_FAY = { like = "KYLA", name = "FAY", defeat = "The current took us.", party = {
      { "PYUKUMUKU", 28, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", moves = { "WATER_SPORT", "PURIFY" } },
      { "CORSOLA", 28, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
    } },
    SEA_RAE = { like = "FOSTER", name = "RAE", defeat = "History repeats: we lost.", party = {
      { "BRONZOR", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", moves = { "ROCK_TOMB", "REFLECT", "EXTRASENSORY", "CONFUSION" } },
      { "KABUTO", 28, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "ANCIENT_POWER", "MUD_SHOT", "PROTECT" } },
    } },
    SEA_OTT = { like = "ANDRES_1", name = "OTTO", defeat = "Fossilized in defeat.", party = {
      { "BINACLE", 28, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", moves = { "ANCIENT_POWER", "FURY_CUTTER", "PROTECT", "SLASH" } },
      { "LILEEP", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    SEA_SKY = { like = "JOSUE", name = "SKY", defeat = "Clipped our wings.", party = {
      { "ARROKUDA", 28, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", moves = { "WATER_PULSE", "PROTECT", "DIVE", "AQUA_JET" } },
      { "SWABLU", 28, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    SEA_KIM = { like = "TARA", name = "KIM", defeat = "I need a lifeguard.", party = {
      { "JIGGLYPUFF", 28, ability = "COMPETITIVE", nature = "MODEST", moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "POUND" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_LEO = { like = "DARRIN", name = "LEO", defeat = "Gulls and jellies, all beaten.", party = {
      { "KRABBY", 28, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "STOMP" } },
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    SEA_MAC = { like = "TONY_1", name = "MAC", defeat = "Out-swum!", party = {
      { "BRUXISH", 28, ability = "STRONG_JAW", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AQUA_JET", "BITE", "CRUNCH", "DISABLE" } },
      { "CORPHISH", 28, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "BUBBLE_BEAM", "KNOCK_OFF", "VISE_GRIP", "TAUNT" } },
    } },
    SEA_HAL = { like = "JEROME", name = "HAL", defeat = "Brr, and beaten.", party = {
      { "LOTAD", 28, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "tank", moves = { "WATER_GUN", "GIGA_DRAIN", "BUBBLE_BEAM", "MIST" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    SEA_DUN = { like = "MATTHEW", name = "DUNN", defeat = "Riding the wave out.", party = {
      { "CORPHISH", 28, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", moves = { "WATER_PULSE", "PROTECT", "NIGHT_SLASH", "KNOCK_OFF" } },
      { "CHINCHOU", 28, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_PULSE", "SPARK", "THUNDER_WAVE", "CONFUSE_RAY" } },
    } },
    SEA_ELA = { like = "DENISE", name = "ELA", defeat = "My goggles are full of water.", party = {
      { "MARILL", 28, ability = "HUGE_POWER", nature = "ADAMANT", moves = { "AQUA_JET", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SHELLOS", 28, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "ICY_WIND", "PROTECT", "BUBBLE_BEAM" } },
    } },
    SEA_BEN = { like = "CORY_1", name = "BEN", defeat = "Aye, we sank.", party = {
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "tank", moves = { "WATER_PULSE", "ROLLOUT", "BRINE", "BUBBLE_BEAM" } },
      { "PELIPPER", 28, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    SEA_LIA = { like = "MISSY", name = "LIA", defeat = "Pearls before swine...", party = {
      { "PYUKUMUKU", 28, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", moves = { "WATER_SPORT", "PURIFY" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_PIA = { like = "CAROLINA", name = "PIA", defeat = "Cool heads, hot loss.", party = {
      { "GOLDUCK", 29, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "ELECTABUZZ", 28, ability = "STATIC", nature = "MODEST", item = "MAGNET", moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
    } },
    SEA_UMA = { like = "BETH", name = "UMA", defeat = "Swam into a wall.", party = {
      { "CLAUNCHER", 29, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
      { "HORSEA", 29, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    SEA_TOD = { like = "CAMRON", name = "TOD", defeat = "Last leg, lost leg.", party = {
      { "SEEL", 29, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", moves = { "AQUA_JET", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
      { "PIKACHU", 29, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    SHIP_BO = { like = "JANI", name = "BO", defeat = "This ship is spooky AND I lost!", party = {
      { "JIGGLYPUFF", 28, ability = "COMPETITIVE", nature = "MODEST", moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "POUND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SHIP_WES = { like = "DUNCAN", name = "WES", defeat = "Abandon ship!", party = {
      { "WINGULL", 28, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", moves = { "WATER_PULSE", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "FINNEON", 28, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "BUBBLE_BEAM", "WATER_GUN", "POUND" } },
    } },
    SHIP_RIO = { like = "GARRISON", name = "RIO", defeat = "Sunk treasure, sunk hopes.", party = {
      { "MANTYKE", 28, ability = "SWIFT_SWIM", nature = "MODEST", moves = { "PROTECT", "WATER_PULSE", "BUBBLE_BEAM", "BUBBLE" } },
      { "BALTOY", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "MUD_SLAP", "ROCK_TOMB", "REFLECT" } },
    } },
    SHIP_DOT = { like = "CHARLIE", name = "DOT", defeat = "Waaah, my floatie!", party = {
      { "JIGGLYPUFF", 28, ability = "COMPETITIVE", nature = "MODEST", moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "POUND" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SHIP_LIV = { like = "THALIA_1", name = "LIV", defeat = "How dreadfully unfashionable.", party = {
      { "SPRITZEE", 28, ability = "HEALER", nature = "BOLD", spread = "bulk", moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
      { "DEERLING", 28, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "JUMP_KICK" } },
    } },
    SHIP_KIP = { like = "DEMETRIUS", name = "KIP", defeat = "Ghosts AND you? No fair.", party = {
      { "SANDYGAST", 28, ability = "SAND_VEIL", nature = "MODEST", item = "SPELL_TAG", moves = { "BULLDOZE", "SAND_TOMB", "ASTONISH", "MEGA_DRAIN" } },
      { "DUSKULL", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    R109S_ANN = { like = "GWEN", name = "ANNE", defeat = "I want my mommy!", party = {
      { "JIGGLYPUFF", 28, ability = "COMPETITIVE", nature = "MODEST", moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "POUND" } },
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R109S_EVE = { like = "ALICE", name = "EVE", defeat = "Sea salt and sore losses.", party = {
      { "PSYDUCK", 28, ability = "CLOUD_NINE", nature = "ADAMANT", spread = "tank", moves = { "WATER_PULSE", "BUBBLE_BEAM", "WATER_GUN", "SCREECH" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    R109S_KIT = { like = "AUSTINA", name = "KIT", defeat = "Splash! I lost.", party = {
      { "IGGLYBUFF", 28, ability = "COMPETITIVE", nature = "MODEST", moves = { "CHARM", "HELPING_HAND", "POUND", "COPYCAT" } },
      { "SPHEAL", 28, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    R109S_GUS = { like = "DAVID", name = "GUS", defeat = "Swept away!", party = {
      { "KRABBY", 28, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "STOMP" } },
      { "CARVANHA", 28, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ICE_FANG", "PROTECT" } },
    } },
    R109S_NED = { like = "CARTER", name = "NED", defeat = "Line snapped.", party = {
      { "CLAUNCHER", 28, ability = "MEGA_LAUNCHER", nature = "MODEST", moves = { "WATERFALL", "BUBBLE_BEAM", "BUBBLE", "SWORDS_DANCE" } },
      { "WHISCASH", 28, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
    } },
    R109S_ACE = { like = "ELIJAH", name = "ACE", defeat = "Grounded!", party = {
      { "SWELLOW", 28, ability = "GUTS", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "TAILWIND", "PROTECT", "WING_ATTACK" } },
      { "SWELLOW", 28, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
    } },
    R103S_MEG = { like = "ISABELLE", name = "MEG", defeat = "Out of breath!", party = {
      { "PYUKUMUKU", 28, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", moves = { "WATER_SPORT", "PURIFY" } },
      { "STARYU", 28, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    R103S_SAM = { like = "PETE", name = "SAMI", defeat = "Gulp. Lost.", party = {
      { "SPHEAL", 28, ability = "OBLIVIOUS", nature = "MODEST", spread = "spa", moves = { "WATER_PULSE", "PROTECT", "BRINE", "AURORA_BEAM" } },
      { "TENTACOOL", 28, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R115N_DAN = { like = "KOICHI", name = "DAN", defeat = "Our fists were not enough.", party = {
      { "MACHOKE", 28, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "WOOBAT", 28, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "CONFUSION", "PSYSHOCK", "AIR_CUTTER", "IMPRISON" } },
    } },
    R115N_JO = { like = "KYRA", name = "JO", defeat = "Finish line? What finish line?", party = {
      { "GROWLITHE", 28, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
      { "FLETCHINDER", 28, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    R115N_KO = { like = "JAIDEN", name = "KOTA", defeat = "Vanished... in defeat.", party = {
      { "STUNKY", 28, ability = "AFTERMATH", nature = "ADAMANT", moves = { "MUD_SLAP", "BITE", "VENOSHOCK", "ACID_SPRAY" } },
      { "ZUBAT", 28, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R115N_VIC = { like = "ALIX", name = "VIC", defeat = "My dreams said we would win.", party = {
      { "DODUO", 28, ability = "TANGLED_FEET", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "PLUCK", "QUICK_ATTACK", "PECK", "DOUBLE_HIT" } },
      { "SPOINK", 28, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115N_ROX = { like = "HELENE", name = "ROX", defeat = "Hyah... we lost.", party = {
      { "PANCHAM", 28, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "LOW_SWEEP", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
      { "SKORUPI", 28, ability = "SNIPER", nature = "ADAMANT", item = "POISON_BARB", moves = { "VENOSHOCK", "TAUNT", "BUG_BITE", "POISON_FANG" } },
    } },
    R115N_KEN = { like = "TIMOTHY_1", name = "KENT", defeat = "Expertly beaten.", party = {
      { "GURDURR", 28, ability = "GUTS", nature = "ADAMANT", moves = { "REVENGE", "ROCK_TOMB", "BULK_UP", "WAKE_UP_SLAP" } },
      { "KIRLIA", 28, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    R118E_HAL = { like = "BARNY", name = "HALE", defeat = "Caught nothing but defeat.", party = {
      { "SLOWPOKE", 29, ability = "OBLIVIOUS", nature = "ADAMANT", moves = { "AQUA_TAIL", "PROTECT", "HEADBUTT", "TACKLE" } },
      { "GOLDEEN", 29, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
    } },
    R118E_JAY = { like = "PERRY", name = "JAY", defeat = "Ruffled feathers all around.", party = {
      { "DUCKLETT", 29, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WING_ATTACK", "AERIAL_ACE", "WATER_PULSE", "AIR_SLASH" } },
      { "TAILLOW", 29, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R118E_KAY = { like = "CHESTER", name = "KAY", defeat = "Shot down!", party = {
      { "CRAMORANT", 29, ability = "GULP_MISSILE", nature = "IMPISH", spread = "bulk", moves = { "AIR_CUTTER", "TAILWIND", "DIVE", "PLUCK" } },
      { "NOCTOWL", 29, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "CONFUSION", "HYPNOSIS", "REFLECT" } },
    } },
    TH4_ZIA = { like = "CORA", name = "ZIA", defeat = "Tricked AND punched.", party = {
      { "MAKUHITA", 29, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "CRABRAWLER", 29, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SMASH", "POWER_UP_PUNCH", "MACH_PUNCH", "DIZZY_PUNCH" } },
    } },
    TH4_MAE = { like = "PAULA", name = "MAE", defeat = "Strength wasn't the answer.", party = {
      { "MACHOKE", 29, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "KARATE_CHOP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "PANCHAM", 29, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "LOW_SWEEP", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    TH4_GOR = { like = "YUJI", name = "GORO", defeat = "Oss! Defeated!", party = {
      { "THROH", 29, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
      { "SAWK", 29, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SEISMIC_TOSS", "BULK_UP", "ROCK_TOMB", "BRICK_BREAK" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34): partners ----------------------------------------
    R119_BO = { like = "CHRIS", name = "BO", defeat = "Rain or shine, we lose.", party = {
      { "BARRASKEWDA", 30, ability = "SWIFT_SWIM", nature = "ADAMANT", moves = { "AQUA_TAIL", "PROTECT", "DIVE", "THROAT_CHOP" } },
      { "LOTAD", 30, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R119_GUS = { like = "DONALD", name = "GUS", defeat = "My net has a hole in it.", party = {
      { "NINCADA", 30, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
      { "DEWPIDER", 30, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "LEECH_LIFE", "BUG_BITE", "WATER_SPORT" } },
    } },
    R119_TED = { like = "TAYLOR", name = "TED", defeat = "Squashed in the grass.", party = {
      { "KRICKETUNE", 30, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "FURY_CUTTER", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "DWEBBLE", 30, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
    } },
    R119_CY = { like = "HUGH", name = "CY", defeat = "Feathers everywhere.", party = {
      { "STARAVIA", 30, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "AIR_CUTTER", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "TAILLOW", 30, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
    } },
    R119_KO = { like = "YASU", name = "KOTA", defeat = "We vanish... in shame.", party = {
      { "PARASECT", 30, ability = "EFFECT_SPORE", nature = "JOLLY", moves = { "FURY_CUTTER", "AERIAL_ACE", "PROTECT", "X_SCISSOR" } },
      { "GRIMER", 30, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R119_LIL = { like = "DOUG", name = "LIL", defeat = "Bugged out!", party = {
      { "VENONAT", 30, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
      { "DUSTOX", 30, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SILVER_WIND", "CONFUSION", "MOONLIGHT", "PROTECT" } },
    } },
    R119_PIP = { like = "GREG", name = "PIP", defeat = "My bugs got stomped.", party = {
      { "BUTTERFREE", 30, ability = "COMPOUND_EYES", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", moves = { "SILVER_WIND", "STUN_SPORE", "ATTRACT", "AIR_SLASH" } },
      { "SPINARAK", 30, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "POISON_FANG", "SHADOW_SNEAK", "INFESTATION", "STRING_SHOT" } },
    } },
    R119_SKY = { like = "PHIL", name = "SKYE", defeat = "Grounded by the rain.", party = {
      { "LINOONE", 30, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "TAKE_DOWN", "EXTREME_SPEED", "HEADBUTT", "SLASH" } },
      { "SWABLU", 30, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R119_ZEN = { like = "TAKASHI", name = "ZEN", defeat = "Defeated in silence.", party = {
      { "PUMPKABOO", 30, ability = "INSOMNIA", nature = "MODEST", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "WILL_O_WISP", "MEGA_DRAIN", "EMBER" } },
      { "NINJASK", 30, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FURY_CUTTER", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
    } },
    R119_RAN = { like = "JACKSON_1", name = "RANDY", defeat = "Protect the wild... from you.", party = {
      { "ORICORIO", 30, ability = "DANCER", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "PECK", "TEETER_DANCE", "ROOST" } },
      { "LINOONE", 30, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R119_WEN = { like = "CATHERINE_1", name = "WEN", defeat = "Nature wins. Wait, no, you do.", party = {
      { "MILTANK", 30, ability = "SAP_SIPPER", nature = "ADAMANT", moves = { "BODY_SLAM", "STOMP", "TACKLE", "DEFENSE_CURL" } },
      { "ODDISH", 30, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R119_ABE = { like = "KENT", name = "ABE", defeat = "We bugged out.", party = {
      { "ILLUMISE", 30, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", moves = { "STRUGGLE_BUG", "CONFUSE_RAY", "MOONLIGHT", "TACKLE" } },
      { "ILLUMISE", 30, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    R119_JIN = { like = "HIDEO", name = "JIN", defeat = "Our shuriken missed.", party = {
      { "CROAGUNK", 30, ability = "ANTICIPATION", nature = "BOLD", spread = "bulk", moves = { "REVENGE", "POISON_STING", "VENOSHOCK", "SUCKER_PUNCH" } },
      { "ZUBAT", 30, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R119_JAX = { like = "FABIAN", name = "JAX", defeat = "Unplugged.", party = {
      { "TRANQUILL", 30, ability = "RIVALRY", nature = "MODEST", spread = "spa", moves = { "QUICK_ATTACK", "AIR_SLASH", "AIR_CUTTER", "GUST" } },
      { "ELECTRIKE", 30, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "THUNDER_FANG", "QUICK_ATTACK", "HOWL" } },
    } },
    R119_ASH = { like = "DAYTON", name = "ASH", defeat = "The rain put out our fire.", party = {
      { "SIZZLIPEDE", 30, ability = "WHITE_SMOKE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "EMBER", "BUG_BITE", "FLAME_WHEEL", "SMOKESCREEN" } },
      { "HOUNDOUR", 30, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "INCINERATE", "FEINT_ATTACK", "SMOG", "HOWL" } },
    } },
    R119_UMA = { like = "RACHEL", name = "UMA", defeat = "My parasol couldn't stop that.", party = {
      { "STEENEE", 30, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "RAZOR_LEAF", "STOMP" } },
      { "PSYDUCK", 30, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R119_DON = { like = "BRENT", name = "DONN", defeat = "Cocooned in defeat.", party = {
      { "ILLUMISE", 30, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", moves = { "STRUGGLE_BUG", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
      { "VENONAT", 30, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    R120_RAE = { like = "CHIP", name = "RAE", defeat = "The ruins weren't on our side.", party = {
      { "BRUXISH", 31, ability = "STRONG_JAW", nature = "ADAMANT", moves = { "WATERFALL", "CRUNCH", "AQUA_JET", "DISABLE" } },
      { "SOLROCK", 31, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "MORNING_SUN" } },
    } },
    R120_GUS = { like = "JEFFREY_1", name = "GUSS", defeat = "Swatted!", party = {
      { "DWEBBLE", 31, ability = "SHELL_ARMOR", nature = "JOLLY", moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
      { "VENONAT", 31, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    R120_SKY = { like = "COLIN", name = "SKY", defeat = "Flew straight into defeat.", party = {
      { "NOCTOWL", 31, ability = "TINTED_LENS", nature = "TIMID", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "ROOST", "TAILWIND", "AIR_SLASH" } },
      { "SWABLU", 31, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "DISARMING_VOICE", "PECK", "SING", "MIST" } },
    } },
    R120_KO = { like = "KEIGO", name = "KO", defeat = "Our smoke bomb fizzled.", party = {
      { "MASQUERAIN", 31, ability = "INTIMIDATE", nature = "TIMID", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "PROTECT", "AIR_CUTTER", "BUBBLE_BEAM" } },
      { "SHUPPET", 31, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R120_ACE = { like = "ROBERT_1", name = "ACE", defeat = "Clipped!", party = {
      { "HERDIER", 31, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "NOCTOWL", 31, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R120_NIA = { like = "CLARISSA", name = "NIA", defeat = "Our garden party is ruined.", party = {
      { "BELLOSSOM", 31, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", moves = { "MEGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "CORVISQUIRE", 31, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DRILL_PECK", "PLUCK", "PECK", "TAUNT" } },
    } },
    R120_PIA = { like = "ANGELICA", name = "PIA", defeat = "Under the weather today.", party = {
      { "NATU", 31, ability = "SYNCHRONIZE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSE_RAY", "MAGIC_COAT", "STORED_POWER", "PECK" } },
      { "CHIMECHO", 31, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R120_RAN = { like = "LORENZO", name = "RANN", defeat = "The wild ones won today.", party = {
      { "CASTFORM", 31, ability = "FORECAST", nature = "MODEST", item = "ORAN_BERRY", moves = { "WEATHER_BALL", "HEADBUTT", "TACKLE", "EMBER" } },
      { "STARMIE", 31, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
    } },
    R120_WEN = { like = "JENNA", name = "WENDA", defeat = "Rangers retreat!", party = {
      { "ABSOL", 31, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "SIMIPOUR", 31, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R120_JIN = { like = "RILEY", name = "JINN", defeat = "Outwitted...", party = {
      { "ESCAVALIER", 31, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", moves = { "BUG_BUZZ", "ACID_SPRAY", "DOUBLE_TEAM", "DOUBLE_EDGE" } },
      { "GOLBAT", 31, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
    } },
    R120_ROX = { like = "CALLIE", name = "ROXY", defeat = "Hyaah! We'll be back!", party = {
      { "HARIYAMA", 31, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PASSIMIAN", 31, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AERIAL_ACE", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
    } },
    R120_MAX = { like = "JENNIFER", name = "MAXI", defeat = "Cool trainers, cold loss.", party = {
      { "ABSOL", 31, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "ZANGOOSE", 31, ability = "IMMUNITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "REVENGE", "PURSUIT", "FOCUS_ENERGY", "CRUSH_CLAW" } },
    } },
    R120_LEO = { like = "LEONEL", name = "LEON", defeat = "A shocking result.", party = {
      { "CHARJABUG", 31, ability = "BATTERY", nature = "RELAXED", spread = "tank", moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
      { "KECLEON", 31, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    -- Chapter 7a: Routes 121-123, Mt. Pyre, Lilycove rival (draft 1, 2026-10-27; cap 35): partners ----------------------------------------
    R121_ANN = { like = "JESSICA_1", name = "ANNA", defeat = "How utterly unbeautiful.", party = {
      { "DEERLING", 32, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "ENERGY_BALL" } },
      { "STEENEE", 32, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "RAZOR_LEAF", "STOMP" } },
    } },
    R121_GUS = { like = "CALE", name = "GUSS", defeat = "Our cocoons cracked.", party = {
      { "BEEDRILL", 32, ability = "SWARM", nature = "BOLD", spread = "bulk", moves = { "PROTECT", "BUG_BITE", "TWINEEDLE", "PIN_MISSILE" } },
      { "NINJASK", 32, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
    } },
    R121_WEN = { like = "TAMMY", name = "WEN", defeat = "The spirits abandoned us.", party = {
      { "DUSKULL", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "RUFFLET", 32, ability = "SHEER_FORCE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "TAILWIND", "SLASH", "AERIAL_ACE" } },
    } },
    R121_MAX = { like = "WALTER_1", name = "MAX", defeat = "A gentleman loses graciously.", party = {
      { "DUBWOOL", 32, ability = "STEADFAST", nature = "TIMID", moves = { "TAKE_DOWN", "HEADBUTT", "TACKLE", "GUARD_SWAP" } },
      { "KECLEON", 32, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    R121_PIA = { like = "VANESSA", name = "PIA", defeat = "My darlings, are you all right?", party = {
      { "MORGREM", 32, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", moves = { "FALSE_SURRENDER", "SUCKER_PUNCH", "BITE", "ASSURANCE" } },
      { "PLUSLE", 32, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SPARK", "NUZZLE", "HELPING_HAND", "ENCORE" } },
    } },
    R121_TOD = { like = "MARCEL", name = "TODD", defeat = "Cool as ever. Beaten as ever.", party = {
      { "ABSOL", 32, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "FLETCHINDER", 32, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    R121_ROX = { like = "CRISTIN_1", name = "ROXA", defeat = "Oof, too cool for us.", party = {
      { "NATU", 32, ability = "SYNCHRONIZE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSE_RAY", "MAGIC_COAT", "STORED_POWER", "PECK" } },
      { "MIGHTYENA", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
    } },
    PYRE_DAN = { like = "ZANDER", name = "DANE", defeat = "The mountain humbles us.", party = {
      { "MAKUHITA", 33, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "WOOBAT", 33, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", moves = { "ZEN_HEADBUTT", "PSYSHOCK", "AIR_CUTTER", "IMPRISON" } },
    } },
    PYRE_ELI = { like = "LEAH", name = "ELI", defeat = "The graves are restless...", party = {
      { "PUMPKABOO", 33, ability = "INSOMNIA", nature = "MODEST", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "WILL_O_WISP", "MEGA_DRAIN", "EMBER" } },
      { "DUSKULL", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "NIGHT_SHADE", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    PYRE_NIA = { like = "VALERIE_1", name = "NIA", defeat = "Rest in peace... us.", party = {
      { "PUMPKABOO", 33, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", moves = { "HEX", "CONFUSE_RAY", "PAIN_SPLIT", "MEGA_DRAIN" } },
      { "GASTLY", 33, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SPELL_TAG", moves = { "HEX", "WILL_O_WISP", "SUCKER_PUNCH", "SPITE" } },
    } },
    PYRE_ZIA = { like = "TASHA", name = "ZIA", defeat = "Hee hee... we lost.", party = {
      { "SHUPPET", 33, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "YAMASK", 33, ability = "MUMMY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ASTONISH", "HEX", "OMINOUS_WIND", "GRUDGE" } },
    } },
    PYRE_OTT = { like = "MARK", name = "OTTO", defeat = "Rare finds, common loss.", party = {
      { "LICKILICKY", 33, ability = "OBLIVIOUS", nature = "ADAMANT", spread = "tank", moves = { "BODY_SLAM", "AMNESIA", "REST", "SLAM" } },
      { "GOOMY", 33, ability = "SAP_SIPPER", nature = "MODEST", item = "ORAN_BERRY", moves = { "DRAGON_BREATH", "WATER_PULSE", "PROTECT", "RAIN_DANCE" } },
    } },
    PYRE_GOR = { like = "ATSUSHI", name = "GORO", defeat = "Hrr! Bested!", party = {
      { "SAWK", 33, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SEISMIC_TOSS", "BULK_UP", "ROCK_TOMB", "BRICK_BREAK" } },
      { "THROH", 33, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
    } },
    PYRE_VIC = { like = "WILLIAM", name = "VICK", defeat = "I sensed a different outcome.", party = {
      { "HATTREM", 33, ability = "ANTICIPATION", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DAZZLING_GLEAM", "PLAY_NICE" } },
      { "CHIMECHO", 33, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    PYRE_IVY = { like = "KAYLA", name = "IVY", defeat = "The future was foggy.", party = {
      { "MIME_JR", 33, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSE_RAY", "PSYBEAM", "CONFUSION", "TICKLE" } },
      { "SPOINK", 33, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    PYRE_LEO = { like = "CEDRIC", name = "LEO", defeat = "Not even my mind could save us.", party = {
      { "MORGREM", 33, ability = "FRISK", nature = "MODEST", spread = "spa", item = "BLACK_GLASSES", moves = { "DRAINING_KISS", "DARK_PULSE", "FALSE_SURRENDER", "FLATTER" } },
      { "BALTOY", 33, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "PSYBEAM", "ANCIENT_POWER", "ROCK_TOMB", "REFLECT" } },
    } },
    R123_FAY = { like = "VIOLET", name = "FAYE", defeat = "The berries were sweeter than this.", party = {
      { "BELLOSSOM", 32, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", moves = { "MEGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "MORELULL", 32, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "GIGA_DRAIN", "MEGA_DRAIN", "ABSORB" } },
    } },
    R123_GUS = { like = "DAVIS", name = "GUSTAV", defeat = "Squashed!", party = {
      { "HERACROSS", 32, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "HORN_ATTACK", "ARM_THRUST", "NIGHT_SLASH", "COUNTER" } },
      { "BUTTERFREE", 32, ability = "COMPOUND_EYES", nature = "TIMID", item = "SILVER_POWDER", moves = { "PROTECT", "BUG_BUZZ", "AIR_SLASH", "SILVER_WIND" } },
    } },
    R123_MAX = { like = "JAZMYN", name = "MAXINE", defeat = "Cooled off for good.", party = {
      { "DWEBBLE", 33, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
      { "ESPEON", 33, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SWIFT", "QUICK_ATTACK", "MORNING_SUN" } },
    } },
    R123_SKY = { like = "ALBERTO", name = "SKYLER", defeat = "Feathers fly, we fall.", party = {
      { "GREEDENT", 33, ability = "GLUTTONY", nature = "JOLLY", item = "SILK_SCARF", moves = { "BODY_SLAM", "COVET", "TACKLE", "SWALLOW" } },
      { "NOCTOWL", 33, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R123_DON = { like = "ED", name = "DONNY", defeat = "Another hole in the collection.", party = {
      { "MUNCHLAX", 33, ability = "PICKUP", nature = "MODEST", spread = "stank", moves = { "ROLLOUT", "DEFENSE_CURL", "BODY_SLAM", "CHIP_AWAY" } },
      { "KECLEON", 33, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    R123_ZEN = { like = "KINDRA", name = "ZENNA", defeat = "Curses...", party = {
      { "RUFFLET", 33, ability = "SHEER_FORCE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "OMINOUS_WIND", "TAILWIND", "SLASH", "AERIAL_ACE" } },
      { "SHUPPET", 33, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R123_JAX = { like = "FERNANDO_1", name = "JAXON", defeat = "The crowd went home.", party = {
      { "TRUMBEAK", 33, ability = "PICKUP", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "SUPERSONIC", "DRILL_PECK", "PLUCK" } },
      { "MANECTRIC", 33, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
    } },
    R123_VIC = { like = "CAMERON_1", name = "VICKI", defeat = "My visions were wrong.", party = {
      { "CARBINK", 33, ability = "CLEAR_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "PSYCHIC", "ROCK_SLIDE", "SMACK_DOWN", "ROCK_THROW" } },
      { "KADABRA", 33, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    R123_IVY = { like = "JACKI_1", name = "IVA", defeat = "Dreams don't always come true.", party = {
      { "FLORGES", 33, ability = "SYMBIOSIS", nature = "MODEST", spread = "spa", item = "PIXIE_PLATE", moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "GRASSY_TERRAIN" } },
      { "SPOINK", 33, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R123_KEN = { like = "FREDRICK", name = "KENNY", defeat = "An expert knows when he's beaten.", party = {
      { "HITMONCHAN", 33, ability = "KEEN_EYE", nature = "ADAMANT", spread = "tank", moves = { "FAKE_OUT", "DRAIN_PUNCH", "REVENGE", "MACH_PUNCH" } },
      { "SKARMORY", 33, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "STEEL_WING", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
    } },
    R123_ACE = { like = "BRAXTON", name = "ACE", defeat = "Cool down, cool out.", party = {
      { "LANTURN", 33, ability = "ILLUMINATE", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "SPARK", "THUNDER_WAVE", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "TRAPINCH", 33, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
    } },
    R123_ELA = { like = "WENDY", name = "ELLA", defeat = "Out-cooled.", party = {
      { "KIRLIA", 33, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "KANGASKHAN", 33, ability = "INNER_FOCUS", nature = "JOLLY", moves = { "FACADE", "CRUSH_CLAW", "MEGA_PUNCH", "CHIP_AWAY" } },
    } },
    R123_KO = { like = "JONAS", name = "KOJI", defeat = "Into the shadows we go.", party = {
      { "PARASECT", 33, ability = "EFFECT_SPORE", nature = "JOLLY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "GRIMER", 33, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R123_UMA = { like = "KAYLEY", name = "UMI", defeat = "What a dreary day for it.", party = {
      { "BRELOOM", 33, ability = "EFFECT_SPORE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "GIGA_DRAIN", "GROWTH", "HELPING_HAND", "FORCE_PALM" } },
      { "TOGETIC", 33, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    -- Chapter 7b: Magma and Aqua Hideouts (draft 1, 2026-10-27; caps 36, 37, 38): partners ----------------------------------------
    -- Chapter 7c: Routes 124-125, Mossdeep, Space Center (draft 1, 2026-10-27; cap 42): partners ----------------------------------------
    R124_LEO = { like = "CHAD", name = "LEO", defeat = "Washed up on Mossdeep.", party = {
      { "PSYDUCK", 38, ability = "CLOUD_NINE", nature = "ADAMANT", spread = "tank", moves = { "WATER_PULSE", "BUBBLE_BEAM", "WATER_GUN", "WATER_SPORT" } },
      { "SEALEO", 38, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "BRINE", "DEFENSE_CURL", "ENCORE" } },
    } },
    R124_MIA = { like = "JENNY_1", name = "MIA", defeat = "Out of air!", party = {
      { "PYUKUMUKU", 38, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", moves = { "GASTRO_ACID", "PURIFY" } },
      { "PELIPPER", 38, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
    } },
    R124_GIL = { like = "DECLAN", name = "GILL", defeat = "Dragged under.", party = {
      { "SHARPEDO", 38, ability = "SPEED_BOOST", nature = "ADAMANT", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "SIMIPOUR", 38, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R124_HAL = { like = "SPENCER", name = "HALL", defeat = "Drifted off course.", party = {
      { "ARAQUANID", 38, ability = "WATER_ABSORB", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "WATERFALL", "PROTECT", "LUNGE", "LEECH_LIFE" } },
      { "STARMIE", 38, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R124_DUN = { like = "ROLAND", name = "DUNN", defeat = "Sunk by the sea itself.", party = {
      { "LUMINEON", 38, ability = "SWIFT_SWIM", nature = "MODEST", moves = { "PROTECT", "BUBBLE_BEAM", "WATER_GUN", "WHIRLPOOL" } },
      { "TENTACRUEL", 38, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "WRAP" } },
    } },
    R124_LIA = { like = "GRACE", name = "LIA", defeat = "The current won.", party = {
      { "STARMIE", 38, ability = "ILLUMINATE", nature = "MODEST", moves = { "WATERFALL", "PROTECT", "BRINE", "PSYBEAM" } },
      { "SEAKING", 38, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
    } },
    R124_TOD = { like = "ISABELLA", name = "TODD", defeat = "Last lap, last place.", party = {
      { "DEWGONG", 38, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "BRINE", "AURORA_BEAM", "WATER_SPORT" } },
      { "FLETCHINDER", 38, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    R125_JON = { like = "NOLEN", name = "JONAH", defeat = "Tide's against me.", party = {
      { "DEWGONG", 38, ability = "ICE_BODY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DISABLE", "ICY_WIND", "BRINE" } },
      { "SHARPEDO", 38, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R125_AMY = { like = "TANYA", name = "AMIE", defeat = "Too tired to keep kicking.", party = {
      { "CLAWITZER", 38, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "CORSOLA", 38, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R125_BEN = { like = "ERNEST_1", name = "BENN", defeat = "Aye, ye beat us fair.", party = {
      { "STARMIE", 38, ability = "ILLUMINATE", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ROLLOUT", "BRINE", "PSYBEAM" } },
      { "PELIPPER", 38, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "WATER_PULSE", "TAILWIND", "PROTECT" } },
    } },
    R125_MAC = { like = "STAN", name = "MACK", defeat = "Kelp in my hair, loss on my record.", party = {
      { "LANTURN", 38, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "SWANNA", 38, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PROTECT", "AIR_SLASH", "AQUA_RING" } },
    } },
    R125_SKY = { like = "PRESLEY", name = "SKYE", defeat = "Grounded at sea.", party = {
      { "BARRASKEWDA", 38, ability = "SWIFT_SWIM", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "DIVE", "CRUNCH" } },
      { "SWELLOW", 38, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "ROOST", "TAILWIND" } },
    } },
    R125_ELA = { like = "SHARON", name = "ELA", defeat = "Glub.", party = {
      { "GOREBYSS", 38, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "GASTRODON", 38, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    R125_KEN = { like = "AURON", name = "KENJI", defeat = "Expertly sunk.", party = {
      { "LUCARIO", 39, ability = "STEADFAST", nature = "MODEST", spread = "stank", moves = { "CLOSE_COMBAT", "FORCE_PALM", "METAL_CLAW", "WORK_UP" } },
      { "ELECTRODE", 39, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "DISCHARGE", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    TH6_SKY = { like = "BENNY", name = "SKAI", defeat = "The Trick Master tricked us both.", party = {
      { "NOCTOWL", 39, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "TALONFLAME", 39, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "TAILWIND", "FLARE_BLITZ" } },
    } },
    TH6_RAN = { like = "SEBASTIAN", name = "RANDALL", defeat = "Lost in the maze AND the battle.", party = {
      { "MORPEKO", 39, ability = "HUNGER_SWITCH", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "SPARK", "BITE", "POWER_TRIP", "THUNDER_SHOCK" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "SHADOW_SNEAK", "KNOCK_OFF", "ANCIENT_POWER", "FURY_SWIPES" } },
    } },
    TH6_WEN = { like = "SOPHIA", name = "WENDA", defeat = "Even the walls laughed.", party = {
      { "HAWLUCHA", 39, ability = "LIMBER", nature = "MODEST", spread = "spa", moves = { "SUBMISSION", "BOUNCE", "WING_ATTACK", "AERIAL_ACE" } },
      { "SHIFTRY", 39, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    -- Chapter 8: Mossdeep to Juan (draft 1, 2026-10-27; caps 43, 44, 46): partners ----------------------------------------
    R126_TOD = { like = "CAMDEN", name = "CORA", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "SIMIPOUR", 40, ability = "TORRENT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "ICY_WIND", "CRUNCH", "BITE" } },
    } },
    R126_ACE = { like = "PABLO_1", name = "GILL", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 42, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 41, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R126_LIA = { like = "BRENDA", name = "LIA", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 41, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "BARRASKEWDA", 40, ability = "SWIFT_SWIM", nature = "ADAMANT", moves = { "WATERFALL", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    R126_GIL = { like = "BARRY", name = "GIL", defeat = "The sea floor's colder than this loss.", party = {
      { "DEWGONG", 42, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_JON = { like = "DEAN", name = "JON", defeat = "The sea floor's colder than this loss.", party = {
      { "TENTACRUEL", 42, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "SHARPEDO", 41, ability = "SPEED_BOOST", nature = "ADAMANT", moves = { "AQUA_JET", "PROTECT", "LIQUIDATION", "CRUNCH" } },
    } },
    R126_SKY = { like = "ISAIAH_1", name = "SKY", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILMER", 42, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "LANTURN", 41, ability = "WATER_ABSORB", nature = "MODEST", moves = { "PROTECT", "WATER_PULSE", "DISCHARGE", "BUBBLE_BEAM" } },
    } },
    R126_MIA = { like = "ISOBEL", name = "MIA", defeat = "The sea floor's colder than this loss.", party = {
      { "SEALEO", 42, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "CLAWITZER", 41, ability = "MEGA_LAUNCHER", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "WATER_PULSE", "BUBBLE_BEAM", "WATER_SPORT" } },
    } },
    R126_DUN = { like = "DONNY", name = "DUN", defeat = "The sea floor's colder than this loss.", party = {
      { "AZUMARILL", 42, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "GASTRODON", 41, ability = "STICKY_HOLD", nature = "MODEST", spread = "stank", moves = { "SURF", "MUDDY_WATER", "EARTH_POWER", "RAIN_DANCE" } },
    } },
    R126_ELA = { like = "KATELYN_1", name = "ELA", defeat = "The sea floor's colder than this loss.", party = {
      { "GASTRODON", 42, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "QWILFISH", 41, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    R126_AMY = { like = "NIKKI", name = "AMY", defeat = "The sea floor's colder than this loss.", party = {
      { "KINGDRA", 42, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 41, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
    } },
    R126_KIM = { like = "SIENNA", name = "KIM", defeat = "The sea floor's colder than this loss.", party = {
      { "CLAWITZER", 41, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 40, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R126_PIA = { like = "CARLEE", name = "PIA", defeat = "The sea floor's colder than this loss.", party = {
      { "GOREBYSS", 41, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 40, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R126_LEO = { like = "LEONARDO", name = "LEO", defeat = "The sea floor's colder than this loss.", party = {
      { "RELICANTH", 42, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "CLOYSTER", 41, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R126_MAX = { like = "ATHENA", name = "MAX", defeat = "The sea floor's colder than this loss.", party = {
      { "POLIWRATH", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 41, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R126_BEN = { like = "HARRISON", name = "BEN", defeat = "The sea floor's colder than this loss.", party = {
      { "BARRASKEWDA", 41, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "DIVE", "CRUNCH", "AGILITY" } },
      { "VAPOREON", 40, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R126_HAL = { like = "JONAH", name = "HAL", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 41, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "DEWGONG", 40, ability = "ICE_BODY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DISABLE", "ICY_WIND", "BRINE" } },
    } },
    R126_NED = { like = "HENRY", name = "NED", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 42, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 41, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R126_MAC = { like = "ROGER", name = "MAC", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 42, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "OCTILLERY", 41, ability = "SUCTION_CUPS", nature = "MODEST", moves = { "WATERFALL", "PROTECT", "OCTAZOOKA", "WATER_PULSE" } },
    } },
    R126_KEN = { like = "KOJI_1", name = "KEN", defeat = "The sea floor's colder than this loss.", party = {
      { "DEWGONG", 42, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 41, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_WES = { like = "WAYNE", name = "WES", defeat = "The sea floor's colder than this loss.", party = {
      { "TENTACRUEL", 41, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "BARRASKEWDA", 40, ability = "PROPELLER_TAIL", nature = "ADAMANT", moves = { "AQUA_JET", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    R126_SKY2 = { like = "AIDAN", name = "SKAI", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILMER", 42, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SWANNA", 41, ability = "HYDRATION", nature = "MODEST", moves = { "AQUA_JET", "PROTECT", "WATER_PULSE", "AIR_SLASH" } },
    } },
    R126_ANN = { like = "ALEXA", name = "ANN", defeat = "The sea floor's colder than this loss.", party = {
      { "SEALEO", 42, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "SEAKING", 41, ability = "WATER_VEIL", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "WATERFALL", "POISON_JAB", "AQUA_RING" } },
    } },
    R126_RAN = { like = "RUBEN", name = "RAN", defeat = "The sea floor's colder than this loss.", party = {
      { "AZUMARILL", 42, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "SHARPEDO", 41, ability = "ROUGH_SKIN", nature = "ADAMANT", spread = "tank", moves = { "SURF", "LIQUIDATION", "CRUNCH", "FOCUS_ENERGY" } },
    } },
    R130_LEO = { like = "FRANKLIN", name = "LEO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "GASTRODON", 43, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "QWILFISH", 42, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    R130_BO = { like = "JACK", name = "BO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "KINGDRA", 43, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 42, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R130_KEN = { like = "HITOSHI", name = "KEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 43, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R130_GOR = { like = "KIYO", name = "GORO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 43, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R130_SKY = { like = "ALEX", name = "SKY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "CLOYSTER", 43, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R130_ACE = { like = "BECK", name = "ACE", defeat = "Pacifidlog is a long swim from here.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 43, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R130_AMY = { like = "DEBRA", name = "AMY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "BARRASKEWDA", 43, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
      { "VAPOREON", 42, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R130_LIA = { like = "LINDA", name = "LIA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "SIMIPOUR", 43, ability = "TORRENT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "ICY_WIND", "CRUNCH", "BITE" } },
    } },
    R130_ELA = { like = "LAUREL", name = "ELA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "QUAGSIRE", 43, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 42, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R130_WES = { like = "KELVIN", name = "WES", defeat = "Pacifidlog is a long swim from here.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "BARRASKEWDA", 43, ability = "SWIFT_SWIM", nature = "ADAMANT", moves = { "WATERFALL", "PROTECT", "LIQUIDATION", "DIVE" } },
    } },
    R130_ROX = { like = "REYNA", name = "ROX", defeat = "Pacifidlog is a long swim from here.", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R130_BEN = { like = "HUDSON", name = "BEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "TENTACRUEL", 44, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "KINGLER", 43, ability = "SHEER_FORCE", nature = "ADAMANT", moves = { "RAZOR_SHELL", "KNOCK_OFF", "PROTECT", "CRABHAMMER" } },
    } },
    R131_GIL = { like = "RODNEY", name = "GIL", defeat = "Caught in the currents.", party = {
      { "WAILMER", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "SLOWBRO", 43, ability = "REGENERATOR", nature = "MODEST", moves = { "PROTECT", "BUBBLE_BEAM", "CONFUSION", "WATER_GUN" } },
    } },
    R131_JON = { like = "RICHARD", name = "JON", defeat = "Caught in the currents.", party = {
      { "SEALEO", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "DEWGONG", 43, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "BRINE", "AURORA_BEAM", "WATER_SPORT" } },
    } },
    R131_HAL = { like = "SANTIAGO", name = "HAL", defeat = "Caught in the currents.", party = {
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "GASTRODON", 43, ability = "STICKY_HOLD", nature = "MODEST", spread = "stank", moves = { "SURF", "MUDDY_WATER", "EARTH_POWER", "RAIN_DANCE" } },
    } },
    R131_MAC = { like = "GILBERT", name = "MAC", defeat = "Caught in the currents.", party = {
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "QWILFISH", 43, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    R131_DUN = { like = "KEVIN", name = "DUN", defeat = "Caught in the currents.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 43, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R131_SKY = { like = "CHASE", name = "SKY", defeat = "Caught in the currents.", party = {
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 43, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R131_PIA = { like = "TALIA", name = "PIA", defeat = "Caught in the currents.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 43, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R131_TOD = { like = "ALLISON", name = "TOD", defeat = "Caught in the currents.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "CLOYSTER", 43, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R132_KIM = { like = "KATIE", name = "KIM", defeat = "Even the fish feel sorry for us.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 43, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R132_ZOE = { like = "KARA", name = "ZOE", defeat = "Even the fish feel sorry for us.", party = {
      { "BARRASKEWDA", 44, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
      { "VAPOREON", 43, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R132_MIA = { like = "DANA", name = "MIA", defeat = "Even the fish feel sorry for us.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "CLAWITZER", 43, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "ICY_WIND", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    R132_LEO = { like = "CLARENCE", name = "LEO", defeat = "Even the fish feel sorry for us.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 43, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R132_BO = { like = "REED", name = "BO", defeat = "Even the fish feel sorry for us.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "SLOWBRO", 43, ability = "OBLIVIOUS", nature = "MODEST", moves = { "EARTHQUAKE", "AMNESIA", "PROTECT", "BUBBLE_BEAM" } },
    } },
    R132_ELA = { like = "TISHA", name = "ELA", defeat = "Even the fish feel sorry for us.", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 43, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R133_ZEN = { like = "MOLLIE", name = "ZEN", defeat = "An expert loss, at least.", party = {
      { "TENTACRUEL", 45, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "GASTRODON", 44, ability = "SAND_FORCE", nature = "MODEST", moves = { "PROTECT", "MUDDY_WATER", "EARTH_POWER", "MUD_BOMB" } },
    } },
    R133_DRA = { like = "AARON", name = "DRA", defeat = "An expert loss, at least.", party = {
      { "WAILMER", 45, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "ROLLOUT", "AMNESIA" } },
      { "GASTRODON", 44, ability = "SAND_FORCE", nature = "MODEST", moves = { "PROTECT", "MUDDY_WATER", "EARTH_POWER", "MUD_BOMB" } },
    } },
    R133_KEN = { like = "CONOR", name = "KEN", defeat = "An expert loss, at least.", party = {
      { "SEALEO", 45, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "SIMIPOUR", 44, ability = "GLUTTONY", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "CRUNCH", "BITE", "WATER_SPORT" } },
    } },
    R133_GOR = { like = "PAXTON", name = "GORO", defeat = "An expert loss, at least.", party = {
      { "AZUMARILL", 45, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_JET", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
      { "JELLICENT", 44, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", moves = { "SURF", "CONFUSE_RAY", "HYDRO_PUMP", "WATER_PULSE" } },
    } },
    R133_WEN = { like = "MAKAYLA", name = "WEN", defeat = "An expert loss, at least.", party = {
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "QWILFISH", 43, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    R133_ACE = { like = "WARREN", name = "ACE", defeat = "An expert loss, at least.", party = {
      { "KINGDRA", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 44, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R134_GIL = { like = "HERMAN", name = "GIL", defeat = "The open sea humbled us.", party = {
      { "CLAWITZER", 45, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 44, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    R134_ELA = { like = "SUSIE", name = "ELA", defeat = "The open sea humbled us.", party = {
      { "GOREBYSS", 45, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_PULSE", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R134_MAX = { like = "MARLEY", name = "MAX", defeat = "The open sea humbled us.", party = {
      { "RELICANTH", 45, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
    } },
    R134_DUN = { like = "JONATHAN", name = "DUN", defeat = "The open sea humbled us.", party = {
      { "POLIWRATH", 45, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R134_ANN = { like = "DARCY", name = "ANN", defeat = "The open sea humbled us.", party = {
      { "BARRASKEWDA", 45, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    -- Chapter 9: Victory Road and the League (draft 1, 2026-10-27; caps 48, 50, 52, 54, 56, 58): partners ----------------------------------------
    VR_P1 = { like = "PATRICIA", name = "ROSA", defeat = "The road to the League ends here for us.", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "WIGGLYTUFF", 46, ability = "COMPETITIVE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND", "HYPER_VOICE" } },
    } },
    VR_P2 = { like = "JOSHUA", name = "KAI", defeat = "The road to the League ends here for us.", party = {
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "WALREIN", 46, ability = "THICK_FAT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "ICE_BEAM", "PROTECT", "BLIZZARD" } },
    } },
    VR_P3 = { like = "ALEXIS", name = "MONA", defeat = "The road to the League ends here for us.", party = {
      { "CLOYSTER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
      { "BARRASKEWDA", 46, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
    } },
    VR_P4 = { like = "MARIELA", name = "OTTO", defeat = "The road to the League ends here for us.", party = {
      { "KINGLER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
      { "SIMIPOUR", 46, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    VR_P5 = { like = "ALVARO", name = "ZEKE", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "PRIMEAPE", 46, ability = "VITAL_SPIRIT", nature = "ADAMANT", spread = "tank", moves = { "CLOSE_COMBAT", "CROSS_CHOP", "SCREECH", "FOCUS_ENERGY" } },
    } },
    VR_P6 = { like = "EVERETT", name = "LUNA", defeat = "The road to the League ends here for us.", party = {
      { "SWELLOW", 46, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "STARAPTOR", 45, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_P7 = { like = "NICOLAS_1", name = "IRIS", defeat = "The road to the League ends here for us.", party = {
      { "PIDGEOT", 47, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
      { "GYARADOS", 46, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    VR_A1 = { like = "ALBERT", name = "DREW", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "VILEPLUME", 46, ability = "EFFECT_SPORE", nature = "ADAMANT", spread = "atk", moves = { "EARTH_POWER", "SLUDGE_BOMB", "SOLAR_BEAM", "PETAL_DANCE" } },
    } },
    VR_A2 = { like = "HOPE", name = "NORA", defeat = "The road to the League ends here for us.", party = {
      { "POLIWRATH", 47, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "MANTINE", 46, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    VR_A3 = { like = "SHANNON", name = "TESS", defeat = "The road to the League ends here for us.", party = {
      { "CLAWITZER", 47, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "CRYOGONAL", 46, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    VR_A4 = { like = "SAMUEL", name = "VERA", defeat = "The road to the League ends here for us.", party = {
      { "RELICANTH", 47, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "ANCIENT_POWER" } },
      { "DREDNAW", 46, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    VR_A5 = { like = "JULIE", name = "MILO", defeat = "The road to the League ends here for us.", party = {
      { "SALAZZLE", 47, ability = "OBLIVIOUS", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "FLAMETHROWER", "SLUDGE_BOMB", "NASTY_PLOT" } },
      { "CRAWDAUNT", 46, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
    } },
    VR_A6 = { like = "OWEN", name = "JUNE", defeat = "The road to the League ends here for us.", party = {
      { "SHARPEDO", 47, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "WHISCASH", 46, ability = "HYDRATION", nature = "RELAXED", spread = "bulk", moves = { "EARTHQUAKE", "WATERFALL", "PROTECT", "AQUA_TAIL" } },
    } },
    VR_A7 = { like = "DIANNE", name = "RUSS", defeat = "The road to the League ends here for us.", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "WIGGLYTUFF", 46, ability = "COMPETITIVE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND", "HYPER_VOICE" } },
    } },
    VR_A8 = { like = "FELIX", name = "FAYE", defeat = "The road to the League ends here for us.", party = {
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "SEISMITOAD", 46, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PROTECT", "LIQUIDATION", "DRAIN_PUNCH" } },
    } },
    VR_A9 = { like = "CAROLINE", name = "COLE", defeat = "The road to the League ends here for us.", party = {
      { "CLOYSTER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
      { "BARRASKEWDA", 46, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
    } },
    VR_A10 = { like = "VITO", name = "GWEN", defeat = "The road to the League ends here for us.", party = {
      { "KINGLER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
      { "SIMIPOUR", 46, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "WATER_GUN" } },
    } },
    VR_A11 = { like = "MICHELLE", name = "HUGO", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "CRABOMINABLE", 46, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", moves = { "CLOSE_COMBAT", "WIDE_GUARD", "DYNAMIC_PUNCH", "HAMMER_ARM" } },
    } },
    VR_A12 = { like = "MITCHELL", name = "NELL", defeat = "The road to the League ends here for us.", party = {
      { "SWELLOW", 47, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "STARAPTOR", 46, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_A13 = { like = "HALLE", name = "PERCY", defeat = "The road to the League ends here for us.", party = {
      { "PIDGEOT", 47, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
      { "GYARADOS", 46, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
    } },
    VR_A14 = { like = "EDGAR", name = "RHEA", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "EARTH_POWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "SCOLIPEDE", 46, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", moves = { "SLUDGE_BOMB", "POISON_JAB", "DOUBLE_EDGE", "IRON_DEFENSE" } },
    } },
    VR_A15 = { like = "QUINCY", name = "SETH", defeat = "The road to the League ends here for us.", party = {
      { "POLIWRATH", 47, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "MANTINE", 46, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    VR_A16 = { like = "KATELYNN", name = "ADA", defeat = "The road to the League ends here for us.", party = {
      { "CLAWITZER", 47, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "CRYOGONAL", 46, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    -- Post-game and stragglers: Rusturf Mike, Jagged Pass grunt, S.S. Tidal, Trick House 8 (draft 1, 2026-10-27): partners ----------------------------------------
    RT_GUS = { like = "MIKE_2", name = "GUSTAV", defeat = "The tunnel is ours no more.", party = {
      { "BINACLE", 21, ability = "TOUGH_CLAWS", nature = "IMPISH", spread = "bulk", moves = { "ROCK_TOMB", "CLAMP", "SCRATCH", "SAND_ATTACK" } },
      { "WHISMUR", 21, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
    } },
    SS_ELA = { like = "NAOMI", name = "ELAINE", defeat = "How rude, on a cruise no less.", party = {
      { "TOGEKISS", 59, ability = "HUSTLE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "MOONBLAST", "PSYCHIC", "WISH", "PROTECT" } },
      { "CLOYSTER", 58, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
    } },
    SS_REX = { like = "GARRET", name = "REX", defeat = "Daddy owns this ship, you know.", party = {
      { "CRYOGONAL", 59, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "CONFUSE_RAY", "FREEZE_DRY", "ACID_ARMOR" } },
      { "NINETALES", 58, ability = "DROUGHT", nature = "TIMID", spread = "spa", moves = { "FLAMETHROWER", "EXTRASENSORY", "WILL_O_WISP", "PROTECT" } },
    } },
    SS_MAX = { like = "MICAH", name = "MAXWELL", defeat = "A gentleman accepts defeat.", party = {
      { "BARRASKEWDA", 59, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "AGILITY" } },
      { "NOCTOWL", 58, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    SS_HAL = { like = "THOMAS", name = "HALE", defeat = "Most unexpected.", party = {
      { "STARMIE", 59, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LICKILICKY", 58, ability = "OBLIVIOUS", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "PROTECT", "SLAM", "POWER_WHIP" } },
    } },
    SS_BEN = { like = "PHILLIP", name = "BENN", defeat = "Shipshape, but beaten.", party = {
      { "PELIPPER", 59, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
      { "GASTRODON", 58, ability = "SAND_FORCE", nature = "MODEST", item = "ORAN_BERRY", moves = { "PROTECT", "MUDDY_WATER", "EARTH_POWER", "MUD_BOMB" } },
    } },
    SS_WES = { like = "LEONARD", name = "WESLEY", defeat = "Back to swabbing the deck.", party = {
      { "KINGDRA", 59, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "LUMINEON", 58, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "HYDRO_PUMP", "BUBBLE_BEAM", "QUIVER_DANCE" } },
    } },
  },
}
