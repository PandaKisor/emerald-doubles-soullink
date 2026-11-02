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
      { "GROOKEY", 16, ability = "GRASSY_SURGE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "BRANCH_POKE", "ROCK_SMASH", "PROTECT" } },
      { "COTTONEE", 16, ability = "PRANKSTER", nature = "TIMID", spread = "stank", item = "ORAN_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND", "HELPING_HAND" } },
      { "GROWLITHE", 16, ability = "INTIMIDATE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "ROAR", "PROTECT" } },
      { "GROVYLE", 17, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "GRASSY_GLIDE", "DRAGON_BREATH", "ROCK_TOMB", "DETECT" } },
    } },
    BRENDAN_RUSTBORO_TORCHIC = { tier = "gym", party = {
      { "WINGULL", 16, ability = "RAIN_DISH", nature = "TIMID", spread = "spa", item = "DAMP_ROCK", moves = { "RAIN_DANCE", "AIR_CUTTER", "WATER_GUN", "PROTECT" } },
      { "LOMBRE", 16, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "WATER_PULSE", "MEGA_DRAIN", "KNOCK_OFF" } },
      { "FLAAFFY", 16, ability = "STATIC", nature = "MODEST", spread = "stank", item = "MAGNET", moves = { "SHOCK_WAVE", "THUNDER_WAVE", "ELECTROWEB", "PROTECT" } },
      { "MARSHTOMP", 17, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "MUD_SHOT", "ROCK_TOMB", "PROTECT" } },
    } },
    BRENDAN_RUSTBORO_TREECKO = { tier = "gym", party = {
      { "CLEFAIRY", 16, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "FOLLOW_ME", "DISARMING_VOICE", "THUNDER_WAVE", "HELPING_HAND" } },
      { "TYROGUE", 16, ability = "GUTS", nature = "ADAMANT", item = "EVIOLITE", moves = { "FAKE_OUT", "MACH_PUNCH", "ROCK_SMASH", "PROTECT" } },
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "PROTECT" } },
      { "COMBUSKEN", 17, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "DOUBLE_KICK", "ROCK_TOMB", "PROTECT" } },
    } },
    MAY_RUSTBORO_MUDKIP = { tier = "gym", party = {
      { "GROOKEY", 16, ability = "GRASSY_SURGE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "BRANCH_POKE", "ROCK_SMASH", "PROTECT" } },
      { "COTTONEE", 16, ability = "PRANKSTER", nature = "TIMID", spread = "stank", item = "ORAN_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND", "HELPING_HAND" } },
      { "GROWLITHE", 16, ability = "INTIMIDATE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "ROAR", "PROTECT" } },
      { "GROVYLE", 17, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "GRASSY_GLIDE", "DRAGON_BREATH", "ROCK_TOMB", "DETECT" } },
    } },
    MAY_RUSTBORO_TORCHIC = { tier = "gym", party = {
      { "WINGULL", 16, ability = "RAIN_DISH", nature = "TIMID", spread = "spa", item = "DAMP_ROCK", moves = { "RAIN_DANCE", "AIR_CUTTER", "WATER_GUN", "PROTECT" } },
      { "LOMBRE", 16, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "FAKE_OUT", "WATER_PULSE", "MEGA_DRAIN", "KNOCK_OFF" } },
      { "FLAAFFY", 16, ability = "STATIC", nature = "MODEST", spread = "stank", item = "MAGNET", moves = { "SHOCK_WAVE", "THUNDER_WAVE", "ELECTROWEB", "PROTECT" } },
      { "MARSHTOMP", 17, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "MUD_SHOT", "ROCK_TOMB", "PROTECT" } },
    } },
    MAY_RUSTBORO_TREECKO = { tier = "gym", party = {
      { "CLEFAIRY", 16, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "FOLLOW_ME", "DISARMING_VOICE", "THUNDER_WAVE", "HELPING_HAND" } },
      { "TYROGUE", 16, ability = "GUTS", nature = "ADAMANT", item = "EVIOLITE", moves = { "FAKE_OUT", "MACH_PUNCH", "ROCK_SMASH", "PROTECT" } },
      { "SWELLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "PROTECT" } },
      { "COMBUSKEN", 17, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "FLAME_CHARGE", "DOUBLE_KICK", "ROCK_TOMB", "PROTECT" } },
    } },

    -- Route 102 ---------------------------------------------------------------
    CALVIN_1 = { partner = "R102_DALE", party = {
      { "POOCHYENA", 12, ability = "QUICK_FEET", nature = "JOLLY", item = "ORAN_BERRY", moves = { "BITE", "HOWL", "TACKLE", "SAND_ATTACK" } },
      { "PIDOVE", 12, ability = "BIG_PECKS", nature = "ADAMANT", item = "SILK_SCARF", moves = { "GUST", "LEER", "GROWL", "DUAL_WINGBEAT" } },
    } },
    RICK = { partner = "R102_OWEN", party = {
      { "VIVILLON", 12, ability = "SHIELD_DUST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "STRING_SHOT", "STRUGGLE_BUG", "STUN_SPORE" } },
      { "GRUBBIN", 12, ability = "SWARM", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "BUG_BITE", "BITE", "MUD_SLAP", "STRING_SHOT" } },
    } },
    ALLEN = { partner = "R102_BEN", party = {
      { "YUNGOOS", 12, ability = "STRONG_JAW", nature = "JOLLY", item = "ORAN_BERRY", moves = { "TACKLE", "SAND_ATTACK", "PURSUIT", "LEER" } },
      { "TAILLOW", 12, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "PECK", "QUICK_ATTACK", "FOCUS_ENERGY", "GROWL" } },
    } },
    TIANA = { partner = "R102_DANA", party = {
      { "SEEL", 12, ability = "THICK_FAT", nature = "HASTY", item = "MYSTIC_WATER", moves = { "GROWL", "HEADBUTT", "WATER_SPORT" } },
      { "SHROOMISH", 12, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "BULLET_SEED", "LEECH_SEED", "TACKLE" } },
    } },

    -- Route 104 (south) ------------------------------------------------------------
    BILLY = { partner = "R104_SAM", party = {
      { "PONYTA", 12, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", moves = { "FLAME_CHARGE", "TACKLE", "TAIL_WHIP", "GROWL" } },
      { "SEEDOT", 12, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "BULLET_SEED", "GROWTH", "HARDEN" } },
    } },
    DARIAN = { partner = "R104_NEIL", party = {
      { "GOLDEEN", 12, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "PECK", "SUPERSONIC", "WATER_SPORT" } },
      { "ARROKUDA", 12, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "AQUA_JET", "PECK", "FURY_ATTACK" } },
    } },
    CINDY_1 = { partner = "R104_PERCY", party = {
      { "MINCCINO", 12, ability = "SKILL_LINK", nature = "JOLLY", item = "SILK_SCARF", moves = { "POUND", "DEFENSE_CURL", "ENDURE", "BABY_DOLL_EYES" } },
      { "AZURILL", 12, ability = "THICK_FAT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "BUBBLE", "WATER_GUN", "CHARM", "TAIL_WHIP" } },
    } },

    -- Petalburg Woods ----------------------------------------------------------------
    LYLE = { partner = "PW_WADE", party = {
      { "SEWADDLE", 12, ability = "OVERCOAT", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "DEFENSE_CURL", "SCREECH", "BUG_BITE", "TACKLE" } },
      { "DEWPIDER", 12, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", moves = { "BUBBLE", "WATER_SPORT", "FURY_CUTTER", "SPIDER_WEB" } },
      { "VENIPEDE", 12, ability = "SPEED_BOOST", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BUG_BITE", "ROLLOUT", "POISON_STING", "SCREECH" } },
    } },
    JAMES_1 = { partner = "PW_COLE", party = {
      { "SNOM", 12, ability = "SHIELD_DUST", nature = "MODEST", moves = { "STRUGGLE_BUG", "POWDER_SNOW" } },
      { "SHROOMISH", 12, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "MEGA_DRAIN", "BULLET_SEED" } },
    } },
    -- the story grunt fights alone (co-op shares this scene)
    GRUNT_PETALBURG_WOODS = { tier = "grunt", party = {
      { "CARVANHA", 12, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "RAGE", "LEER" } },
      { "SKRELP", 11, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "POOCHYENA", 11, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", moves = { "BITE", "HOWL", "SAND_ATTACK", "TACKLE" } },
    } },

    -- Route 104 (north) --------------------------------------------------------------
    WINSTON_1 = { partner = "R104_ROSA", party = {
      { "LILLIPUP", 12, ability = "PICKUP", nature = "JOLLY", item = "SCOPE_LENS", moves = { "LEER", "TACKLE", "BITE", "ODOR_SLEUTH" } },
      { "SENTRET", 12, ability = "RUN_AWAY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "DEFENSE_CURL", "ROLLOUT", "SCRATCH", "QUICK_ATTACK" } },
    } },
    HALEY_1 = { partner = "R104_TARA", party = {
      { "SOLOSIS", 12, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "ROLLOUT", "PROTECT", "SNATCH" } },
      { "PANSAGE", 12, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "VINE_WHIP", "LEECH_SEED", "SCRATCH", "PLAY_NICE" } },
      { "FLETCHLING", 12, ability = "GALE_WINGS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "AERIAL_ACE", "GROWL", "DOUBLE_TEAM" } },
    } },
    -- the twins are a double on their own
    GINA_AND_MIA_1 = { party = {
      { "PETILIL", 12, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", moves = { "LEECH_SEED", "FAIRY_WIND", "MEGA_DRAIN", "ABSORB" } },
      { "FERROSEED", 12, ability = "IRON_BARBS", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "METAL_CLAW", "TACKLE", "HARDEN" } },
      { "LOTAD", 12, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", moves = { "MEGA_DRAIN", "BUBBLE", "MIST", "ASTONISH" } },
      { "SEEDOT", 12, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "BULLET_SEED", "GROWTH", "ABSORB", "HARDEN" } },
    } },
    IVAN = { partner = "R104_HUGO", party = {
      { "FINNEON", 12, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "WATER_GUN", "POUND", "RAIN_DANCE" } },
      { "LUVDISC", 12, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "DRAINING_KISS", "CHARM", "AGILITY" } },
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
      { "ZORUA", 16, ability = "ILLUSION", nature = "TIMID", spread = "spa", item = "BLACK_GLASSES", ev = 128, moves = { "SNARL", "SCRATCH", "LEER", "FAKE_TEARS" } },
      { "SKITTY", 16, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "COVET", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    JOSE = { partner = "R116_GUS", party = {
      { "VENONAT", 16, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "TACKLE", "CONFUSION", "POISON_POWDER" } },
      { "SPINARAK", 16, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "BUG_BITE", "SHADOW_SNEAK", "INFESTATION", "STRING_SHOT" } },
    } },
    KAREN_1 = { partner = "R116_EMMA", party = {
      { "PANSAGE", 16, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "GRASSY_GLIDE", "LEECH_SEED", "BITE", "PLAY_NICE" } },
      { "EEVEE", 16, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
    } },
    CLARK = { partner = "R116_HANK", party = {
      { "ROLYCOLY", 16, ability = "HEATPROOF", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROLLOUT", "DEFENSE_CURL", "ROCK_POLISH", "SMACK_DOWN" } },
      { "ARON", 16, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    DEVAN = { partner = "R116_OLAF", party = {
      { "FURFROU", 16, ability = "FUR_COAT", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "HEADBUTT", "TACKLE", "GROWL" } },
      { "TEDDIURSA", 16, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", ev = 128, moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    JOHNSON = { partner = "R116_RAY", party = {
      { "TAILLOW", 16, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "PURSUIT", "TAILWIND" } },
      { "YAMPER", 16, ability = "BALL_FETCH", nature = "JOLLY", item = "MAGNET", ev = 128, moves = { "SHOCK_WAVE", "FLAME_CHARGE", "BITE", "NUZZLE" } },
    } },

    -- Route 116, east (Cut): tag battles at 14-15 ------------------------------------
    SARAH = { partner = "R116_ELLA", party = {
      { "HOPPIP", 16, ability = "INFILTRATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "HELPING_HAND", "AERIAL_ACE", "TACKLE", "SLEEP_POWDER" } },
      { "RALTS", 16, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "DISARMING_VOICE", "CONFUSION", "MAGICAL_LEAF", "HYPNOSIS" } },
    } },
    DAWSON = { partner = "R116_REX", party = {
      { "AXEW", 16, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DUAL_CHOP", "BITE", "ASSURANCE", "LEER" } },
      { "MEOWTH", 16, ability = "UNNERVE", nature = "TIMID", spread = "spa", ev = 128, moves = { "COVET", "SCRATCH", "BITE", "GROWL" } },
    } },
    JERRY_1 = { partner = "R116_LIAM", party = {
      { "SHUPPET", 16, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "SHADOW_SNEAK", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "MIENFOO", 16, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "REVENGE", "FAKE_OUT", "MEDITATE", "DETECT" } },
    } },
    JANICE = { partner = "R116_JUNE", party = {
      { "MARILL", 16, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "ROLLOUT", "DEFENSE_CURL", "HELPING_HAND" } },
      { "HOPPIP", 16, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "AERIAL_ACE", "TACKLE", "SLEEP_POWDER", "SYNTHESIS" } },
    } },

    -- Rusturf Tunnel: the grunt with the Devon Goods fights alone -------------------
    GRUNT_RUSTURF_TUNNEL = { tier = "grunt", party = {
      { "CARVANHA", 16, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BITE", "AQUA_JET", "ASSURANCE", "PROTECT" } },
      { "SKRELP", 15, ability = "ADAPTABILITY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "WATER_GUN", "ACID", "FEINT_ATTACK", "SMOKESCREEN" } },
      { "ZUBAT", 15, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },

    -- Route 106 beach: tag battles at 16 ---------------------------------------------
    NED = { partner = "R106_KAI", party = {
      { "TENTACOOL", 16, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SHELLOS", 16, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ICY_WIND", "PROTECT", "MUD_BOMB" } },
    } },
    ELLIOT_1 = { partner = "R106_ROY", party = {
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "FRILLISH", 16, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BUBBLE_BEAM", "BUBBLE", "RAIN_DANCE", "WATER_SPORT" } },
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
      { "WINGULL", 21, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "MACHOP", 21, ability = "GUTS", nature = "ADAMANT", ev = 128, moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "KARATE_CHOP" } },
    } },
    EDMOND = { partner = "R109_PIP", party = {
      { "ARROKUDA", 21, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "BITE", "PECK", "FURY_ATTACK" } },
      { "FLETCHINDER", 21, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
    } },
    HAILEY = { partner = "R109_DOT", party = {
      { "SPHEAL", 21, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", ev = 128, moves = { "WATER_PULSE", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "FURRET", 21, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DEFENSE_CURL", "COVET", "QUICK_ATTACK", "SCRATCH" } },
    } },
    RICKY_1 = { partner = "R109_BO", party = {
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "SALANDIT", 21, ability = "CORROSION", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "EMBER", "VENOSHOCK", "POISON_GAS", "SWEET_SCENT" } },
    } },
    LOLA_1 = { partner = "R109_KIM", party = {
      { "WAILMER", 21, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "CORPHISH", 21, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "AQUA_JET", "KNOCK_OFF", "VISE_GRIP", "HARDEN" } },
    } },
    CHANDLER = { partner = "R109_ZED", party = {
      { "BUIZEL", 21, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "AQUA_JET", "PURSUIT", "GROWL" } },
      { "CORPHISH", 21, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "KNOCK_OFF", "AQUA_JET", "TAUNT" } },
    } },

    -- the Seashore House: three in a row, each alone with three ---------------------------
    SIMON = { party = {
      { "CLAUNCHER", 21, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", ev = 128, moves = { "ICY_WIND", "WATER_PULSE", "WATER_GUN", "WATER_SPORT" } },
      { "CROCONAW", 21, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BITE", "ICE_FANG", "AQUA_JET", "SCARY_FACE" } },
      { "TRANQUILL", 21, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "AIR_CUTTER", "GUST", "LEER" } },
    } },
    JOHANNA = { party = {
      { "GOLDEEN", 21, ability = "LIGHTNING_ROD", nature = "ADAMANT", ev = 128, moves = { "FLIP_TURN", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
      { "BASCULIN", 21, ability = "RECKLESS", nature = "ADAMANT", ev = 128, moves = { "BITE", "FLIP_TURN", "TAKE_DOWN", "CRUNCH" } },
      { "QWILFISH", 21, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "PROTECT", "FELL_STINGER", "TACKLE" } },
    } },
    DWAYNE = { party = {
      { "MAKUHITA", 21, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "ARM_THRUST" } },
      { "KRABBY", 21, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "BUBBLE", "WATER_GUN", "VISE_GRIP", "METAL_CLAW" } },
      { "CORPHISH", 21, ability = "HYPER_CUTTER", nature = "ADAMANT", ev = 128, moves = { "BUBBLE_BEAM", "KNOCK_OFF", "AQUA_JET", "PROTECT" } },
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
      { "PLUSLE", 21, ability = "PLUS", nature = "TIMID", spread = "spa", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "HELPING_HAND", "ENCORE" } },
      { "PINCURCHIN", 21, ability = "ELECTRIC_SURGE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "ENDURE", "PECK", "FURY_ATTACK" } },
    } },
    KALEB = { partner = "R110_GIL", party = {
      { "MINUN", 21, ability = "MINUS", nature = "TIMID", spread = "spa", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "HELPING_HAND", "THUNDER_WAVE" } },
      { "CRAMORANT", 21, ability = "GULP_MISSILE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "PECK", "PLUCK", "STOCKPILE" } },
    } },
    TIMMY = { partner = "R110_OTTO", party = {
      { "FOONGUS", 21, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", ev = 128, moves = { "PROTECT", "MEGA_DRAIN", "ABSORB", "GRASSY_GLIDE" } },
      { "ELECTRIKE", 21, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "THUNDER_FANG", "SHOCK_WAVE", "HOWL" } },
    } },
    EDWIN_1 = { partner = "R110_MOE", party = {
      { "TYMPOLE", 21, ability = "SWIFT_SWIM", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "BUBBLE", "MUD_SHOT", "GROWL", "SUPERSONIC" } },
      { "NUZLEAF", 21, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "RAZOR_LEAF", "AIR_CUTTER", "GROWTH", "TORMENT" } },
    } },
    JOSEPH = { partner = "R110_BRAD", party = {
      { "ELEKID", 21, ability = "STATIC", nature = "MODEST", item = "MAGNET", ev = 128, moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
      { "VOLTORB", 21, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "EERIE_IMPULSE", "SCREECH" } },
    } },
    EDWARD = { partner = "R110_VIC", party = {
      { "KADABRA", 21, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "GOTHITA", 21, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "PROTECT", "CONFUSION", "TICKLE" } },
    } },
    ALYSSA = { partner = "R110_LIZ", party = {
      { "MAGNEMITE", 21, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "THUNDER_WAVE", "SUPERSONIC" } },
      { "HERDIER", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "TACKLE", "ODOR_SLEUTH", "BABY_DOLL_EYES" } },
    } },
    DALE = { partner = "R110_HAL", party = {
      { "WAILMER", 21, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "QWILFISH", 21, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "AQUA_JET", "PROTECT", "FELL_STINGER", "TACKLE" } },
    } },

    -- Rival, Route 110: five, alone; the starter is the ace at 20 ---------------------------
    BRENDAN_ROUTE_110_MUDKIP = { tier = "gym", party = {
      { "THWACKEY", 19, ability = "GRASSY_SURGE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "BRANCH_POKE", "KNOCK_OFF", "PROTECT" } },
      { "COTTONEE", 19, ability = "PRANKSTER", nature = "TIMID", spread = "stank", item = "SITRUS_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND", "HELPING_HAND" } },
      { "GROWLITHE", 19, ability = "INTIMIDATE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "PROTECT" } },
      { "MAGNEMITE", 19, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "PROTECT" } },
      { "GROVYLE", 20, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "GRASSY_GLIDE", "DRAGON_BREATH", "ROCK_SLIDE", "DETECT" } },
    } },
    BRENDAN_ROUTE_110_TORCHIC = { tier = "gym", party = {
      { "PELIPPER", 19, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "LOMBRE", 19, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "FAKE_OUT", "BUBBLE_BEAM", "GIGA_DRAIN", "KNOCK_OFF" } },
      { "FLAAFFY", 19, ability = "STATIC", nature = "MODEST", spread = "stank", item = "MAGNET", moves = { "SHOCK_WAVE", "THUNDER_WAVE", "ELECTROWEB", "PROTECT" } },
      { "BUIZEL", 19, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "SILK_SCARF", moves = { "AQUA_JET", "ICE_PUNCH", "SWIFT", "PROTECT" } },
      { "MARSHTOMP", 20, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "BULLDOZE", "ROCK_SLIDE", "PROTECT" } },
    } },
    BRENDAN_ROUTE_110_TREECKO = { tier = "gym", party = {
      { "CLEFAIRY", 19, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "FOLLOW_ME", "DISARMING_VOICE", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 19, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "MACH_PUNCH", "ROLLING_KICK", "PROTECT" } },
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "PROTECT" } },
      { "KIRLIA", 19, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "HELPING_HAND", "PROTECT" } },
      { "COMBUSKEN", 20, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLAME_CHARGE", "DOUBLE_KICK", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_ROUTE_110_MUDKIP = { tier = "gym", party = {
      { "THWACKEY", 19, ability = "GRASSY_SURGE", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "BRANCH_POKE", "KNOCK_OFF", "PROTECT" } },
      { "COTTONEE", 19, ability = "PRANKSTER", nature = "TIMID", spread = "stank", item = "SITRUS_BERRY", moves = { "STUN_SPORE", "LEECH_SEED", "FAIRY_WIND", "HELPING_HAND" } },
      { "GROWLITHE", 19, ability = "INTIMIDATE", nature = "JOLLY", item = "CHARCOAL", moves = { "FLAME_WHEEL", "BITE", "HELPING_HAND", "PROTECT" } },
      { "MAGNEMITE", 19, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "PROTECT" } },
      { "GROVYLE", 20, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "GRASSY_GLIDE", "DRAGON_BREATH", "ROCK_SLIDE", "DETECT" } },
    } },
    MAY_ROUTE_110_TORCHIC = { tier = "gym", party = {
      { "PELIPPER", 19, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "WATER_PULSE", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "LOMBRE", 19, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "FAKE_OUT", "BUBBLE_BEAM", "GIGA_DRAIN", "KNOCK_OFF" } },
      { "FLAAFFY", 19, ability = "STATIC", nature = "MODEST", spread = "stank", item = "MAGNET", moves = { "SHOCK_WAVE", "THUNDER_WAVE", "ELECTROWEB", "PROTECT" } },
      { "BUIZEL", 19, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "SILK_SCARF", moves = { "AQUA_JET", "ICE_PUNCH", "SWIFT", "PROTECT" } },
      { "MARSHTOMP", 20, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATER_PULSE", "BULLDOZE", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_ROUTE_110_TREECKO = { tier = "gym", party = {
      { "CLEFAIRY", 19, ability = "FRIEND_GUARD", nature = "BOLD", spread = "bulk", item = "EVIOLITE", moves = { "FOLLOW_ME", "DISARMING_VOICE", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 19, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "MACH_PUNCH", "ROLLING_KICK", "PROTECT" } },
      { "SWELLOW", 19, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "PROTECT" } },
      { "KIRLIA", 19, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "DRAINING_KISS", "PSYBEAM", "HELPING_HAND", "PROTECT" } },
      { "COMBUSKEN", 20, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLAME_CHARGE", "DOUBLE_KICK", "ROCK_SLIDE", "PROTECT" } },
    } },

    -- Trick House 1: tag battles at 18 ---------------------------------------------------
    SALLY = { partner = "TH1_MIA", party = {
      { "BUDEW", 21, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "SLEEP_POWDER", "STUN_SPORE", "ABSORB" } },
      { "TORRACAT", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "FIRE_FANG", "DOUBLE_KICK", "LICK", "ROAR" } },
    } },
    ROBIN = { partner = "TH1_ZOE", party = {
      { "PIDGEOTTO", 21, ability = "KEEN_EYE", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "TAILWIND", "AIR_CUTTER", "GUST" } },
      { "BRIONNE", 21, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "DISARMING_VOICE", "ICY_WIND", "WATER_PULSE", "ENCORE" } },
    } },
    EDDIE = { partner = "TH1_KIP", party = {
      { "BINACLE", 21, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "ROLLOUT", "SCRATCH", "FURY_CUTTER", "SAND_ATTACK" } },
      { "DARTRIX", 21, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PECK", "FORESIGHT" } },
    } },

    -- Route 103 east: tag battles at 18-19 --------------------------------------------------
    DAISY = { partner = "R103_FAY", party = {
      { "MORELULL", 21, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "ROSELIA", 21, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "MEGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    -- the twins are a double on their own
    AMY_AND_LIV_1 = { party = {
      { "JIGGLYPUFF", 21, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", ev = 128, moves = { "DISARMING_VOICE", "SING", "COVET", "DEFENSE_CURL" } },
      { "IMPIDIMP", 21, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", ev = 128, moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
      { "PLUSLE", 21, ability = "PLUS", nature = "TIMID", spread = "spa", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "HELPING_HAND", "ENCORE" } },
      { "MINUN", 21, ability = "MINUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "HELPING_HAND", "THUNDER_WAVE" } },
    } },
    MIGUEL_1 = { partner = "R103_GUY", party = {
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "COVET", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "WOOLOO", 21, ability = "RUN_AWAY", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "TACKLE", "COVET", "COPYCAT", "GUARD_SPLIT" } },
    } },
    ANDREW = { partner = "R103_FINN", party = {
      { "BARBOACH", 21, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "MUD_BOMB", "BULLDOZE", "AMNESIA", "PROTECT" } },
      { "HORSEA", 21, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "LEER" } },
      { "ALOMOMOLA", 21, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "AQUA_JET", "POUND", "HEAL_PULSE", "PLAY_NICE" } },
    } },
    MARCOS = { partner = "R103_JAX", party = {
      { "EELEKTRIK", 21, ability = "LEVITATE", nature = "TIMID", item = "MAGNET", ev = 128, moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "KRICKETUNE", 21, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    RHETT = { partner = "R103_DUKE", party = {
      { "THROH", 21, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
      { "MAKUHITA", 21, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "VITAL_THROW" } },
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
      { "GOTHITA", 21, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
      { "KADABRA", 21, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    JACOB = { partner = "CR_TOD", party = {
      { "LITLEO", 21, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", ev = 128, moves = { "HELPING_HAND", "ROAR", "INCINERATE", "EMBER" } },
      { "ROCKRUFF", 21, ability = "VITAL_SPIRIT", nature = "JOLLY", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
    } },
    ANTHONY = { partner = "CR_WIN", party = {
      { "EELEKTRIK", 21, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MAGNET", ev = 128, moves = { "SPARK", "THUNDER_WAVE", "TACKLE", "CHARGE_BEAM" } },
      { "CHARJABUG", 21, ability = "BATTERY", nature = "RELAXED", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
    } },
    BENJAMIN_1 = { partner = "CR_ACE", party = {
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "EELEKTRIK", 21, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "TACKLE", "THUNDER_WAVE", "CHARGE_BEAM" } },
    } },
    ABIGAIL_1 = { partner = "CR_ADA", party = {
      { "CRAMORANT", 21, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", ev = 128, moves = { "AIR_CUTTER", "PECK", "PLUCK", "STOCKPILE" } },
      { "PACHIRISU", 21, ability = "PICKUP", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "NUZZLE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    JASMINE = { partner = "CR_SKY", party = {
      { "FLETCHINDER", 21, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
      { "HONEDGE", 21, ability = "NO_GUARD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "METAL_SOUND", "AUTOTOMIZE", "SHADOW_SNEAK", "TACKLE" } },
    } },

    -- Route 117: tag battles at 20-21; the breeders and the twins fight alone ------------------
    DEREK = { partner = "R117_KAI", party = {
      { "MOTHIM", 21, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "SILVER_WIND", "BUG_BITE", "QUIVER_DANCE", "PROTECT" } },
      { "VENONAT", 21, ability = "COMPOUND_EYES", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "TACKLE", "PSYBEAM", "POISON_POWDER" } },
    } },
    ANNA_AND_MEG_1 = { party = {
      { "GLAMEOW", 21, ability = "KEEN_EYE", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "SWIFT", "COVET", "FEINT_ATTACK", "GROWL" } },
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_SWEEP", "BULK_UP" } },
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", ev = 128, moves = { "COVET", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
      { "MACHOP", 21, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    DYLAN_1 = { partner = "R117_LEE", party = {
      { "LARVESTA", 21, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "FLAME_CHARGE", "EMBER", "TAKE_DOWN" } },
      { "DODUO", 21, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
    } },
    MARIA_1 = { partner = "R117_MAE", party = {
      { "HERDIER", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
      { "PASSIMIAN", 21, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "LOW_SWEEP", "ROCK_SMASH", "TACKLE" } },
    } },
    ISAAC_1 = { party = {
      { "EEVEE", 21, ability = "ADAPTABILITY", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "QUICK_ATTACK", "COVET", "HELPING_HAND", "BABY_DOLL_EYES" } },
      { "BONSLY", 21, ability = "STURDY", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "ROCK_THROW", "LOW_KICK", "FAKE_TEARS", "FLAIL" } },
      { "GIBLE", 21, ability = "SAND_VEIL", nature = "ADAMANT", ev = 128, moves = { "DRAGON_BREATH", "TAKE_DOWN", "BULLDOZE", "SAND_ATTACK" } },
      { "GASTLY", 21, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "HEX", "CONFUSE_RAY", "PAYBACK", "LICK" } },
    } },
    LYDIA_1 = { party = {
      { "EELEKTRIK", 21, ability = "LEVITATE", nature = "TIMID", ev = 128, moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "LITWICK", 21, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "EMBER", "SMOG", "HEX", "MINIMIZE" } },
      { "INKAY", 21, ability = "CONTRARY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "FOUL_PLAY", "TACKLE", "REFLECT", "TOPSY_TURVY" } },
      { "GOOMY", 21, ability = "SAP_SIPPER", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_BREATH", "BUBBLE", "PROTECT", "ABSORB" } },
    } },
    MELINA = { partner = "R117_ROX", party = {
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
      { "MURKROW", 21, ability = "INSOMNIA", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "ICY_WIND", "TAUNT", "AERIAL_ACE" } },
    } },
    BRANDI = { partner = "R117_IVY", party = {
      { "ESPURR", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", ev = 128, moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MIME_JR", 21, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    AISHA = { partner = "R117_JO", party = {
      { "CRABOMINABLE", 21, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", ev = 128, moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "ROCK_SMASH", "LEER" } },
      { "MEDITITE", 21, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },

    -- Route 111 south: tag battles at 21 ----------------------------------------------------------
    TYRON = { partner = "R111_ABE", party = {
      { "SANDSLASH", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "RAPID_SPIN", "FURY_CUTTER", "BULLDOZE", "DEFENSE_CURL" } },
      { "DWEBBLE", 21, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SMACK_DOWN", "FURY_CUTTER", "BUG_BITE", "WITHDRAW" } },
    } },
    CELINA = { partner = "R111_NIA", party = {
      { "BUDEW", 21, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "SLEEP_POWDER", "MEGA_DRAIN", "ABSORB", "WATER_SPORT" } },
      { "CORVISQUIRE", 21, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    BIANCA = { partner = "R111_PIA", party = {
      { "DRIFLOON", 21, ability = "FLARE_BOOST", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ASTONISH", "SHADOW_BALL", "HEX", "MINIMIZE" } },
      { "BIBAREL", 21, ability = "UNAWARE", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "HYPER_FANG", "QUICK_ATTACK", "AQUA_TAIL", "YAWN" } },
    } },
    HAYDEN = { partner = "R111_CY", party = {
      { "NUMEL", 21, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
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
      { "EELEKTRIK", 26, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MAGNET", ev = 128, moves = { "SPARK", "THUNDER_WAVE", "TACKLE", "CHARGE_BEAM" } },
      { "LOUDRED", 26, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "STOMP", "BITE", "HOWL", "SUPERSONIC" } },
    } },

    -- Route 112: tag battles at 21-22 -----------------------------------------------------
    LARRY = { partner = "R112_BUD", party = {
      { "ROSELIA", 26, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "RAZOR_LEAF", "SLEEP_POWDER", "STUN_SPORE", "GIGA_DRAIN" } },
      { "LITLEO", 26, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", ev = 128, moves = { "HELPING_HAND", "ROAR", "INCINERATE", "EMBER" } },
    } },
    CAROL = { partner = "R112_SUE", party = {
      { "WATCHOG", 26, ability = "ANALYTIC", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "HYPNOSIS", "SECRET_POWER", "CRUNCH", "DETECT" } },
      { "GLOOM", 26, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BRICE = { partner = "R112_GUS", party = {
      { "SILICOBRA", 26, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "HEADBUTT", "SAND_ATTACK", "MINIMIZE" } },
      { "JOLTIK", 26, ability = "COMPOUND_EYES", nature = "MODEST", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "PROTECT", "ELECTROWEB", "RISING_VOLTAGE" } },
    } },
    TRENT_1 = { partner = "R112_ROB", party = {
      { "GRAVELER", 26, ability = "SAND_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "SMACK_DOWN", "ROCK_POLISH", "BULLDOZE" } },
      { "GRAVELER", 26, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    BRYANT = { partner = "R112_ASH", party = {
      { "DARUMAKA", 26, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "INCINERATE", "FIRE_FANG", "FACADE", "TAUNT" } },
      { "QUILAVA", 26, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FLAME_WHEEL", "SWIFT", "SCORCHING_SANDS", "SMOKESCREEN" } },
    } },
    SHAYLA = { partner = "R112_LIL", party = {
      { "BAYLEEF", 26, ability = "LEAF_GUARD", nature = "BOLD", spread = "bulk", ev = 128, moves = { "MAGICAL_LEAF", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "SHIINOTIC", 26, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "MOONLIGHT" } },
    } },

    -- Route 113: tag battles at 21-22 in the ash ------------------------------------------------
    JAYLEN = { partner = "R113_PIP", party = {
      { "TRAPINCH", 26, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "PANSEAR", 26, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "BITE", "FLAME_BURST", "INCINERATE", "FLAME_CHARGE" } },
    } },
    DILLON = { partner = "R113_TAD", party = {
      { "ARON", 26, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
      { "TRANQUILL", 26, ability = "BIG_PECKS", nature = "ADAMANT", ev = 128, moves = { "AERIAL_ACE", "AIR_CUTTER", "SECRET_POWER", "GROWL" } },
    } },
    LAO_1 = { partner = "R113_ZEN", party = {
      { "FROGADIER", 26, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "ROUND" } },
      { "STUNKY", 26, ability = "STENCH", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SMOG", "SMOKESCREEN", "HAZE", "BITE" } },
    } },
    LUNG = { partner = "R113_KO", party = {
      { "NINJASK", 26, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SKITTER_SMACK", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "CROAGUNK", 26, ability = "ANTICIPATION", nature = "BOLD", spread = "bulk", ev = 128, moves = { "REVENGE", "WAKE_UP_SLAP", "VENOSHOCK", "FEINT_ATTACK" } },
    } },
    MADELINE_1 = { partner = "R113_UMA", party = {
      { "TROPIUS", 26, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MAGICAL_LEAF", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
      { "HORSEA", 26, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "tank", ev = 128, moves = { "WATER_GUN", "BUBBLE_BEAM", "BUBBLE", "LEER" } },
    } },
    -- the twins are a double on their own
    TORI_AND_TIA = { party = {
      { "FURFROU", 26, ability = "FUR_COAT", nature = "JOLLY", ev = 128, moves = { "HEADBUTT", "TACKLE", "GROWL", "BABY_DOLL_EYES" } },
      { "SPINDA", 26, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    SOPHIE = { partner = "R113_BEA", party = {
      { "SUDOWOODO", 26, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "LOW_KICK", "BLOCK", "FAKE_TEARS" } },
      { "SPRITZEE", 26, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
    } },
    COBY = { partner = "R113_TAO", party = {
      { "SKARMORY", 26, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "AIR_CUTTER", "SAND_ATTACK", "SPIKES" } },
      { "CHANSEY", 26, ability = "SERENE_GRACE", nature = "TIMID", item = "SILK_SCARF", ev = 128, moves = { "ROCK_SMASH", "POUND", "HIDDEN_POWER", "COPYCAT" } },
    } },
    LAWRENCE = { partner = "R113_RIO", party = {
      { "BALTOY", 26, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "BULLDOZE", "ROCK_TOMB", "REFLECT" } },
      { "DRILBUR", 26, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "RAPID_SPIN", "METAL_CLAW", "MUD_SPORT" } },
    } },
    WYATT = { partner = "R113_MAX", party = {
      { "MAGBY", 26, ability = "FLAME_BODY", nature = "JOLLY", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "SMOKESCREEN", "FLAME_CHARGE", "LEER" } },
      { "NIDORINO", 26, ability = "POISON_POINT", nature = "ADAMANT", item = "POISON_BARB", ev = 128, moves = { "POISON_TAIL", "DOUBLE_KICK", "HORN_ATTACK", "FOCUS_ENERGY" } },
    } },

    -- Route 114: tag battles at 22-23; Tyra and Ivy fight as a double ---------------------------------
    STEVE_1 = { partner = "R114_HAL", party = {
      { "RHYHORN", 26, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_BLAST", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "TURTONATOR", 26, ability = "SHELL_ARMOR", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_TAIL", "REVENGE", "INCINERATE", "EMBER" } },
    } },
    BERNIE_1 = { partner = "R114_ED", party = {
      { "YANMA", 26, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "AIR_CUTTER", "AERIAL_ACE", "FORESIGHT" } },
      { "FLOATZEL", 26, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "AQUA_JET", "QUICK_ATTACK", "GROWL" } },
    } },
    SHANE = { partner = "R114_IKE", party = {
      { "KANGASKHAN", 26, ability = "INNER_FOCUS", nature = "JOLLY", ev = 128, moves = { "FURY_CUTTER", "FAKE_OUT", "DOUBLE_HIT", "STOMP" } },
      { "TRUBBISH", 26, ability = "STENCH", nature = "ADAMANT", item = "POISON_BARB", ev = 128, moves = { "SLUDGE", "CLEAR_SMOG", "ACID_SPRAY", "POUND" } },
    } },
    CLAUDE = { partner = "R114_JEB", party = {
      { "GYARADOS", 26, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "ALOMOMOLA", 26, ability = "HYDRATION", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "AQUA_JET", "POUND", "HEAL_PULSE", "PLAY_NICE" } },
    } },
    NOLAN = { partner = "R114_GUY", party = {
      { "WISHIWASHI", 26, ability = "SCHOOLING", nature = "MODEST", spread = "spa", ev = 128, moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "GOLDEEN", 26, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FLIP_TURN", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    NANCY = { partner = "R114_FLO", party = {
      { "SWIRLIX", 26, ability = "UNBURDEN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "FAIRY_WIND", "DRAINING_KISS", "TACKLE", "FAKE_TEARS" } },
      { "GROTLE", 26, ability = "OVERGROW", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "RAZOR_LEAF", "BITE", "CURSE", "MEGA_DRAIN" } },
    } },
    LENNY = { partner = "R114_OZ", party = {
      { "MUDBRAY", 26, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "SOFT_SAND", ev = 128, moves = { "ROCK_TOMB", "STEALTH_ROCK", "BULLDOZE", "MUD_SLAP" } },
      { "VANILLISH", 26, ability = "WEAK_ARMOR", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "AURORA_BEAM", "ICY_WIND", "MIST", "AVALANCHE" } },
    } },
    LUCAS_1 = { partner = "R114_BOB", party = {
      { "STONJOURNER", 26, ability = "POWER_SPOT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "SELF_DESTRUCT", "ROCK_THROW", "GRAVITY" } },
      { "FOONGUS", 26, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", ev = 128, moves = { "PROTECT", "MEGA_DRAIN", "GRASSY_GLIDE", "FEINT_ATTACK" } },
    } },
    TYRA_AND_IVY = { party = {
      { "LUXIO", 26, ability = "RIVALRY", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "SPARK", "THUNDER_WAVE", "BITE", "CHARGE" } },
      { "DONPHAN", 26, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "ROLLOUT", "DEFENSE_CURL", "SLAM" } },
    } },
    ANGELINA = { partner = "R114_MEL", party = {
      { "PRINPLUP", 26, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "METAL_CLAW", "PECK", "GROWL" } },
      { "PARASECT", 26, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "SKITTER_SMACK", "STUN_SPORE", "SWEET_SCENT", "SLASH" } },
    } },
    KAI = { partner = "R114_NED", party = {
      { "WHISCASH", 26, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
      { "SLOWPOKE", 26, ability = "REGENERATOR", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_GUN", "PROTECT", "TACKLE", "CONFUSION" } },
    } },
    CHARLOTTE = { partner = "R114_ROE", party = {
      { "SKIDDO", 26, ability = "GRASS_PELT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "VINE_WHIP", "TAKE_DOWN", "RAZOR_LEAF", "SYNTHESIS" } },
      { "VULPIX", 26, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "INCINERATE", "CONFUSE_RAY", "FLAME_BURST", "WILL_O_WISP" } },
    } },

    -- Route 115 south: tag battles at 22-23 --------------------------------------------------------------
    NOB_1 = { partner = "R115_KEN", party = {
      { "MACHOKE", 26, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "WAKE_UP_SLAP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "WOOBAT", 26, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    HECTOR = { partner = "R115_DON", party = {
      { "AUDINO", 26, ability = "HEALER", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "COVET", "EXTRASENSORY", "DISARMING_VOICE" } },
      { "SEVIPER", 26, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
    } },
    MARLENE = { partner = "R115_EVE", party = {
      { "HYPNO", 26, ability = "INSOMNIA", nature = "ADAMANT", spread = "atk", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "MAGIC_COAT", "HEADBUTT", "PSYCHO_CUT" } },
      { "MEDITITE", 26, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHO_CUT", "FORCE_PALM", "CONFUSION", "DETECT" } },
    } },
    CYNDY_1 = { partner = "R115_JAN", party = {
      { "DEWOTT", 26, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "RAZOR_SHELL", "BRINE", "REVENGE", "FOCUS_ENERGY" } },
      { "BUNEARY", 26, ability = "RUN_AWAY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BABY_DOLL_EYES", "PROTECT", "COVET", "SECRET_POWER" } },
    } },

    -- Mt. Chimney: tag battles at 23-24; Team Magma fights alone ------------------------------------------------
    SAWYER_1 = { partner = "MC_BRAM", party = {
      { "ROCKRUFF", 26, ability = "STEADFAST", nature = "JOLLY", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "BITE", "ROCK_THROW", "SAND_ATTACK" } },
      { "LUNATONE", 26, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "REFLECT", "ANCIENT_POWER", "STEALTH_ROCK" } },
    } },
    MELISSA = { partner = "MC_LIV", party = {
      { "TOGETIC", 26, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "CHERRIM", 26, ability = "FLOWER_GIFT", nature = "ADAMANT", ev = 128, moves = { "MAGICAL_LEAF", "TACKLE", "SUNNY_DAY", "HELPING_HAND" } },
    } },
    SHEILA = { partner = "MC_FAE", party = {
      { "GLAMEOW", 26, ability = "KEEN_EYE", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "SECRET_POWER", "FAKE_OUT", "COVET", "FEINT_ATTACK" } },
      { "SKIPLOOM", 26, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "SEED_BOMB", "BULLET_SEED", "MEGA_DRAIN", "ABSORB" } },
    } },
    SHIRLEY = { partner = "MC_DEE", party = {
      { "SIGILYPH", 26, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "PSYBEAM", "GRAVITY", "MIRACLE_EYE" } },
      { "DUBWOOL", 26, ability = "STEADFAST", nature = "JOLLY", ev = 128, moves = { "HEADBUTT", "TACKLE", "COPYCAT", "GUARD_SPLIT" } },
    } },
    SHELBY_1 = { partner = "MC_RUE", party = {
      { "PANCHAM", 26, ability = "MOLD_BREAKER", nature = "JOLLY", ev = 128, moves = { "LOW_SWEEP", "KARATE_CHOP", "SLASH", "LEER" } },
      { "WOBBUFFET", 26, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", ev = 128, moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
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
    -- Tabitha: five, alone; a ground-and-rock team on Bulldoze and Rock Slide, Gligar is the ace at 25
    TABITHA_MT_CHIMNEY = { tier = "gym", party = {
      { "SANDSLASH", 24, ability = "SAND_VEIL", nature = "ADAMANT", item = "SOFT_SAND", moves = { "BULLDOZE", "ROCK_SLIDE", "SLASH", "KNOCK_OFF" } },
      { "GRAVELER", 24, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "BULLDOZE", "SMACK_DOWN", "ROCK_POLISH" } },
      { "DARUMAKA", 24, ability = "HUSTLE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FIRE_PUNCH", "HEADBUTT", "BRICK_BREAK", "WORK_UP" } },
      { "ONIX", 24, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "ROCK_TOMB", "DRAGON_BREATH", "SCREECH", "STEALTH_ROCK" } },
      { "GLIGAR", 25, ability = "IMMUNITY", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "BULLDOZE", "ROCK_SLIDE", "KNOCK_OFF" } },
    } },
    -- Maxie: six, alone; Camerupt is the ace at 26
    MAXIE_MT_CHIMNEY = { tier = "leader", party = {
      { "GOLBAT", 25, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "POISON_FANG" } },
      { "KOFFING", 24, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "MIGHTYENA", 25, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", moves = { "CRUNCH", "FIRE_FANG", "THUNDER_FANG", "ROAR" } },
      { "WEEPINBELL", 24, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", moves = { "RAZOR_LEAF", "ACID", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "HOUNDOOM", 25, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "DARK_PULSE", "SNARL", "WILL_O_WISP" } },
      { "CAMERUPT", 26, ability = "MAGMA_ARMOR", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "LAVA_PLUME", "EARTH_POWER", "ROCK_SLIDE", "AMNESIA" } },
    } },

    -- Jagged Pass: tag battles at 25-26 -----------------------------------------------------------------------
    ERIC = { partner = "JP_COL", party = {
      { "LARVITAR", 26, ability = "GUTS", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_SLIDE", "BITE", "STOMPING_TANTRUM", "SCARY_FACE" } },
      { "METANG", 26, ability = "CLEAR_BODY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "METAL_CLAW", "CONFUSION", "PSYCHO_CUT", "TAKE_DOWN" } },
    } },
    AUTUMN = { partner = "JP_IDA", party = {
      { "PONYTA", 26, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "EMBER", "FIRE_SPIN" } },
      { "SERVINE", 26, ability = "CONTRARY", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "LEAF_TORNADO", "GRASSY_GLIDE", "GLARE", "LEECH_SEED" } },
    } },
    JULIO = { partner = "JP_ROD", party = {
      { "MAGNEMITE", 26, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "SPARK", "MAGNET_BOMB", "THUNDER_WAVE", "MIRROR_SHOT" } },
      { "ELEKID", 26, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "SWAGGER", "SHOCK_WAVE", "VOLT_SWITCH", "SWIFT" } },
    } },
    DIANA_1 = { partner = "JP_BEL", party = {
      { "QUILLADIN", 26, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "GRASSY_GLIDE", "BITE", "ROLLOUT", "LEECH_SEED" } },
      { "STARAVIA", 26, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AIR_CUTTER", "SECRET_POWER", "FEATHER_DANCE", "ROOST" } },
    } },
    ETHAN_1 = { partner = "JP_GUS", party = {
      { "BEWEAR", 26, ability = "UNNERVE", nature = "JOLLY", item = "BLACK_BELT", ev = 128, moves = { "AERIAL_ACE", "SECRET_POWER", "BRUTAL_SWING", "LEER" } },
      { "SANDSLASH", 26, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
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
      { "SANDYGAST", 26, ability = "WATER_COMPACTION", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "HEX", "MEGA_DRAIN", "ABSORB", "SAND_ATTACK" } },
      { "STARAVIA", 26, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AIR_CUTTER", "SECRET_POWER", "FEATHER_DANCE", "AERIAL_ACE" } },
    } },
    IRENE = { partner = "R111N_ADA", party = {
      { "YAMASK", 26, ability = "MUMMY", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "ASTONISH", "WILL_O_WISP", "CRAFTY_SHIELD", "HEX" } },
      { "AZUMARILL", 26, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "AQUA_JET", "WATER_PULSE", "HELPING_HAND", "DEFENSE_CURL" } },
    } },
    WILTON_1 = { partner = "R111N_ZED", party = {
      { "KLINK", 26, ability = "PLUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "METAL_SOUND", "VISE_GRIP", "BIND", "AUTOTOMIZE" } },
      { "DRATINI", 26, ability = "MARVEL_SCALE", nature = "JOLLY", item = "DRAGON_FANG", ev = 128, moves = { "DRAGON_TAIL", "SLAM", "WRAP", "LEER" } },
      { "GOTHITA", 26, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", ev = 128, moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
    } },
    BROOKE_1 = { partner = "R111N_MAY", party = {
      { "MONFERNO", 26, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "MACH_PUNCH", "FLAME_WHEEL", "FAKE_OUT", "TAUNT" } },
      { "KRABBY", 26, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "HIDDEN_POWER", "RAZOR_SHELL", "VISE_GRIP" } },
      { "ROSELIA", 26, ability = "NATURAL_CURE", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "STUN_SPORE", "LEECH_SEED" } },
    } },
    DAISUKE = { partner = "R111N_KEN", party = {
      { "GURDURR", 26, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_SWEEP", "BULK_UP" } },
      { "CRABRAWLER", 26, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SMASH", "POWER_UP_PUNCH", "LEER", "PURSUIT" } },
    } },
    -- Trick House 2 (after the Dynamo Badge): tag battles at 24-25
    PAUL = { partner = "TH2_OLI", party = {
      { "ARBOK", 26, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", ev = 128, moves = { "POISON_FANG", "POISON_STING", "BITE", "SCREECH" } },
      { "ELDEGOSS", 26, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "STUN_SPORE", "RAZOR_LEAF", "LEAFAGE", "LEAF_TORNADO" } },
    } },
    TED = { partner = "TH2_ABI", party = {
      { "KIRLIA", 26, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "DUBWOOL", 26, ability = "STEADFAST", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "HEADBUTT", "TACKLE", "COPYCAT", "GUARD_SPLIT" } },
    } },
    GEORGIA = { partner = "TH2_ZAC", party = {
      { "IMPIDIMP", 26, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SUCKER_PUNCH", "BITE", "ASSURANCE", "FLATTER" } },
      { "BEAUTIFLY", 26, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "SILVER_WIND", "MEGA_DRAIN", "ATTRACT", "STUN_SPORE" } },
    } },
    -- Route 111 desert: tag battles at 27-28 in the sandstorm
    DUSTY_1 = { partner = "DES_RAE", party = {
      { "SANDYGAST", 28, ability = "WATER_COMPACTION", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BULLDOZE", "MEGA_DRAIN", "SCORCHING_SANDS", "HYPNOSIS" } },
      { "INDEEDEE", 28, ability = "SYNCHRONIZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "DISARMING_VOICE", "AFTER_YOU", "PLAY_NICE" } },
      { "SHIELDON", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "IRON_DEFENSE", "SMACK_DOWN", "PROTECT", "TAUNT" } },
    } },
    DREW = { partner = "DES_HAL", party = {
      { "SANDSLASH", 28, ability = "SAND_RUSH", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "RAPID_SPIN", "ROLLOUT" } },
      { "PANSAGE", 28, ability = "GLUTTONY", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "LEECH_SEED", "SEED_BOMB", "VINE_WHIP", "RECYCLE" } },
    } },
    BEAU = { partner = "DES_IKE", party = {
      { "AMBIPOM", 28, ability = "TECHNICIAN", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "FAKE_OUT", "SECRET_POWER", "SWIFT", "BATON_PASS" } },
      { "ZORUA", 28, ability = "ILLUSION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "KNOCK_OFF", "FEINT_ATTACK", "SNARL", "TAUNT" } },
    } },
    HEIDI = { partner = "DES_FLO", party = {
      { "HIPPOPOTAS", 28, ability = "SAND_STREAM", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "ROCK_SMASH", "DIG", "TAKE_DOWN" } },
      { "GLOOM", 28, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    BECKY = { partner = "DES_LEA", party = {
      { "SNOVER", 28, ability = "SNOW_WARNING", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICY_WIND", "RAZOR_LEAF", "MIST", "ICE_SHARD" } },
      { "GOLDEEN", 28, ability = "WATER_VEIL", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "HORN_ATTACK", "FLIP_TURN", "WATER_SPORT" } },
    } },
    CELIA = { partner = "DES_NIA", party = {
      { "IVYSAUR", 28, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "VENOSHOCK", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
      { "JUMPLUFF", 28, ability = "CHLOROPHYLL", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "SEED_BOMB", "ACROBATICS", "SYNTHESIS" } },
    } },
    BRYAN = { partner = "DES_OTT", party = {
      { "SINISTEA", 28, ability = "WEAK_ARMOR", nature = "BOLD", spread = "bulk", ev = 128, moves = { "HEX", "WILL_O_WISP", "PROTECT", "MEGA_DRAIN" } },
      { "TYRUNT", 28, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "ROCK_TOMB", "STOMP", "DRAGON_TAIL" } },
    } },
    BRANDEN = { partner = "DES_GIL", party = {
      { "CHATOT", 28, ability = "KEEN_EYE", nature = "TIMID", ev = 128, moves = { "AERIAL_ACE", "PLUCK", "ROUND", "MIRROR_MOVE" } },
      { "LEAFEON", 28, ability = "LEAF_GUARD", nature = "JOLLY", item = "MIRACLE_SEED", ev = 128, moves = { "RAZOR_LEAF", "QUICK_ATTACK", "BITE", "SYNTHESIS" } },
    } },
    -- Trick House 3 (after the Heat Badge): tag battles at 27-28
    JUSTIN = { partner = "TH3_MO", party = {
      { "KECLEON", 28, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "SECRET_POWER" } },
      { "BARRASKEWDA", 28, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "WATER_PULSE", "DIVE", "AQUA_JET", "AGILITY" } },
      { "SANDSLASH_ALOLAN", 28, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", ev = 128, moves = { "AVALANCHE", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
    } },
    MARTHA = { partner = "TH3_BO", party = {
      { "MEOWSTIC_FEMALE", 28, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "PANSAGE", 28, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "LEECH_SEED", "SEED_BOMB", "VINE_WHIP", "RECYCLE" } },
      { "IMPIDIMP", 28, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SUCKER_PUNCH", "BITE", "ASSURANCE", "FLATTER" } },
    } },
    ALAN = { partner = "TH3_AL", party = {
      { "MAROWAK", 28, ability = "ROCK_HEAD", nature = "ADAMANT", item = "THICK_CLUB", ev = 128, moves = { "BONE_CLUB", "HEADBUTT", "FALSE_SWIPE", "FOCUS_ENERGY" } },
      { "PROBOPASS", 28, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
      { "RHYHORN", 28, ability = "LIGHTNING_ROD", nature = "IMPISH", spread = "tank", ev = 128, moves = { "ROCK_TOMB", "PROTECT", "BULLDOZE", "SMACK_DOWN" } },
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
      { "GYARADOS", 21, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "BRINE", "DRAGON_RAGE", "LEER" } },
      { "FRILLISH", 21, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", ev = 128, moves = { "BUBBLE", "CONFUSE_RAY", "HEX", "BUBBLE_BEAM" } },
    } },
    DEANDRE = { partner = "R118_POE", party = {
      { "RATICATE", 21, ability = "HUSTLE", nature = "ADAMANT", item = "SILK_SCARF", ev = 128, moves = { "QUICK_ATTACK", "HYPER_FANG", "CRUNCH", "FOCUS_ENERGY" } },
      { "ARON", 21, ability = "STURDY", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "METAL_CLAW", "ROCK_TOMB", "HEADBUTT", "PROTECT" } },
    } },
    ROSE_1 = { partner = "R118_IVY", party = {
      { "TOGETIC", 21, ability = "HUSTLE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FAIRY_WIND", "MAGICAL_LEAF", "DRAINING_KISS", "FOLLOW_ME" } },
      { "IVYSAUR", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "VENOSHOCK", "SLEEP_POWDER", "LEECH_SEED", "POISON_POWDER" } },
    } },
    DALTON_1 = { partner = "R118_REX", party = {
      { "COMBEE", 21, ability = "HONEY_GATHER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "AIR_CUTTER", "TAILWIND", "BUG_BITE", "GUST" } },
      { "LOUDRED", 21, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "STOMP", "BITE", "HOWL", "SUPERSONIC" } },
    } },
    -- Routes 105-108 (Surf): tag battles at 28-29
    LUIS = { partner = "SEA_ORR", party = {
      { "SHARPEDO", 32, ability = "SPEED_BOOST", nature = "ADAMANT", ev = 128, moves = { "BITE", "NIGHT_SLASH", "ICE_FANG", "PROTECT" } },
      { "SPRITZEE", 32, ability = "HEALER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
    } },
    DOMINIK = { partner = "SEA_GIL", party = {
      { "GYARADOS", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "BRINE", "ICE_FANG", "DRAGON_RAGE" } },
      { "BASCULIN", 32, ability = "RECKLESS", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BITE", "AQUA_JET", "ICE_FANG", "AQUA_TAIL" } },
    } },
    DOUGLAS = { partner = "SEA_JON", party = {
      { "CRYOGONAL", 32, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "ICY_WIND", "WATER_PULSE", "ICE_BEAM", "AURORA_BEAM" } },
      { "TENTACRUEL", 32, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    BEVERLY = { partner = "SEA_AMY", party = {
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
      { "SALANDIT", 32, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", ev = 128, moves = { "VENOSHOCK", "FLAME_BURST", "EMBER", "POISON_GAS" } },
      { "WAILMER", 32, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", ev = 128, moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
    } },
    IMANI = { partner = "SEA_ZOE", party = {
      { "AZUMARILL", 32, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "DRAINING_KISS", "AQUA_TAIL", "KNOCK_OFF", "HELPING_HAND" } },
      { "CLAUNCHER", 32, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", ev = 128, moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
    } },
    KYLA = { partner = "SEA_FAY", party = {
      { "NIDORINA", 32, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", ev = 128, moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "MANTYKE", 32, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "AIR_SLASH", "CONFUSE_RAY", "WIDE_GUARD" } },
    } },
    FOSTER = { partner = "SEA_RAE", party = {
      { "OMANYTE", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "ANCIENT_POWER", "WATER_PULSE", "BITE", "PROTECT" } },
      { "CUFANT", 32, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "STOMP", "BULLDOZE", "GROWL", "IRON_DEFENSE" } },
      { "UNOWN", 32, ability = "LEVITATE", nature = "MODEST", spread = "spa", ev = 128, moves = { "HIDDEN_POWER" } },
    } },
    ANDRES_1 = { partner = "SEA_OTT", party = {
      { "ARCHEN", 32, ability = "DEFEATIST", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "ANCIENT_POWER", "PLUCK", "ROCK_SLIDE", "ROCK_THROW" } },
      { "NOSEPASS", 32, ability = "STURDY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "ROCK_THROW", "THUNDER_WAVE", "ROCK_SLIDE", "HARDEN" } },
      { "PROBOPASS", 32, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "SPARK" } },
    } },
    JOSUE = { partner = "SEA_SKY", party = {
      { "STOUTLAND", 32, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "FARFETCHD", 32, ability = "INNER_FOCUS", nature = "JOLLY", item = "BLACK_BELT", ev = 128, moves = { "AERIAL_ACE", "BRICK_BREAK", "SECRET_POWER", "AIR_CUTTER" } },
    } },
    TARA = { partner = "SEA_KIM", party = {
      { "FERALIGATR", 32, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BITE", "ICE_FANG", "AQUA_TAIL", "SCARY_FACE" } },
      { "CASTFORM", 32, ability = "FORECAST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "WEATHER_BALL", "HEADBUTT", "TACKLE", "EMBER" } },
      { "SEADRA", 32, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    LISA_AND_RAY = { party = {
      { "DUCKLETT", 32, ability = "KEEN_EYE", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "BUBBLE_BEAM", "AERIAL_ACE", "AQUA_RING" } },
      { "MAREANIE", 32, ability = "REGENERATOR", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "BITE", "POISON_STING", "TOXIC_SPIKES" } },
      { "BRUXISH", 32, ability = "STRONG_JAW", nature = "JOLLY", ev = 128, moves = { "AQUA_JET", "BITE", "CRUNCH", "DISABLE" } },
      { "QWILFISH", 32, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "PROTECT", "REVENGE", "FELL_STINGER" } },
    } },
    DARRIN = { partner = "SEA_LEO", party = {
      { "SEEL", 32, ability = "THICK_FAT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "HEADBUTT", "FLIP_TURN", "WATER_SPORT", "AQUA_RING" } },
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    TONY_1 = { partner = "SEA_MAC", party = {
      { "SHARPEDO", 32, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "NIGHT_SLASH", "ICE_FANG", "PROTECT" } },
      { "FEEBAS", 32, ability = "SWIFT_SWIM", nature = "JOLLY", ev = 128, moves = { "PROTECT", "TACKLE" } },
    } },
    JEROME = { partner = "SEA_HAL", party = {
      { "FRILLISH", 32, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BRINE", "HEX", "BUBBLE_BEAM", "OMINOUS_WIND" } },
      { "BERGMITE", 32, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICY_WIND", "ICE_FANG", "TAKE_DOWN", "HARDEN" } },
    } },
    MATTHEW = { partner = "SEA_DUN", party = {
      { "DREDNAW", 32, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
      { "PIKACHU", 32, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "THUNDER_PUNCH", "FEINT", "QUICK_ATTACK" } },
    } },
    DENISE = { partner = "SEA_ELA", party = {
      { "BINACLE", 32, ability = "SNIPER", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_PULSE", "SLASH", "RAZOR_SHELL", "WITHDRAW" } },
      { "GOLDEEN", 32, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "HORN_ATTACK", "WATERFALL", "SUPERSONIC", "AGILITY" } },
    } },
    CORY_1 = { partner = "SEA_BEN", party = {
      { "EMOLGA", 32, ability = "STATIC", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "CHARGE", "NASTY_PLOT" } },
      { "POLIWHIRL", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    MISSY = { partner = "SEA_LIA", party = {
      { "STARYU", 32, ability = "ILLUMINATE", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_GUN", "BRINE", "BUBBLE_BEAM", "CONFUSE_RAY" } },
      { "PYUKUMUKU", 32, ability = "INNARDS_OUT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "HELPING_HAND", "BIDE", "PURIFY", "MUD_SPORT" } },
    } },
    CAROLINA = { partner = "SEA_PIA", party = {
      { "MANECTRIC", 32, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "RISING_VOLTAGE", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "PASSIMIAN", 32, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
      { "SNOVER", 32, ability = "SNOW_WARNING", nature = "JOLLY", ev = 128, moves = { "LEECH_SEED", "RAZOR_LEAF", "ICE_PUNCH", "LEAFAGE" } },
    } },
    BETH = { partner = "SEA_UMA", party = {
      { "LOMBRE", 32, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "BODY_SLAM", "GIGA_DRAIN", "NATURE_POWER" } },
      { "LUVDISC", 32, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    CAMRON = { partner = "SEA_TOD", party = {
      { "STARMIE", 32, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "BINACLE", 32, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "SLASH", "RAZOR_SHELL", "WITHDRAW" } },
    } },
    -- Abandoned Ship: tag battles at 28-29; the young couple is a double
    JANI = { partner = "SHIP_BO", party = {
      { "GOOMY", 32, ability = "SAP_SIPPER", nature = "MODEST", ev = 128, moves = { "DRAGON_BREATH", "WATER_PULSE", "PROTECT", "BUBBLE" } },
      { "FLOATZEL", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "TAUNT", "CRUNCH", "AQUA_JET" } },
      { "FURRET", 32, ability = "FRISK", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "SLAM", "QUICK_ATTACK", "HELPING_HAND", "FOLLOW_ME" } },
    } },
    DUNCAN = { partner = "SHIP_WES", party = {
      { "MACHOKE", 32, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "BRICK_BREAK", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "SEALEO", 32, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", ev = 128, moves = { "BRINE", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
      { "SPIRITOMB", 32, ability = "PRESSURE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "PURSUIT", "SHADOW_SNEAK", "OMINOUS_WIND" } },
    } },
    GARRISON = { partner = "SHIP_RIO", party = {
      { "TIRTOUGA", 32, ability = "SOLID_ROCK", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ANCIENT_POWER", "BITE", "ROCK_SLIDE", "PROTECT" } },
      { "MUDSDALE", 32, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "SOFT_SAND", ev = 128, moves = { "ROCK_TOMB", "STEALTH_ROCK", "HIGH_HORSEPOWER", "BULLDOZE" } },
      { "GRAVELER_ALOLAN", 32, ability = "GALVANIZE", nature = "ADAMANT", ev = 128, moves = { "ROCK_TOMB", "SPARK", "ROCK_SLIDE", "ROCK_POLISH" } },
    } },
    CHARLIE = { partner = "SHIP_DOT", party = {
      { "GASTRODON", 32, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "ICY_WIND", "PROTECT", "BUBBLE_BEAM" } },
      { "OCTILLERY", 32, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "OCTAZOOKA", "PSYBEAM", "AURORA_BEAM", "FOCUS_ENERGY" } },
    } },
    THALIA_1 = { partner = "SHIP_LIV", party = {
      { "TOGETIC", 32, ability = "HUSTLE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FAIRY_WIND", "MAGICAL_LEAF", "WISH", "DRAINING_KISS" } },
      { "GARDEVOIR", 32, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    DEMETRIUS = { partner = "SHIP_KIP", party = {
      { "ELECTABUZZ", 32, ability = "STATIC", nature = "MODEST", item = "MAGNET", ev = 128, moves = { "LEER", "SHOCK_WAVE", "RISING_VOLTAGE", "THUNDER_PUNCH" } },
      { "TRANQUILL", 32, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "AIR_CUTTER", "GUST", "TAUNT" } },
    } },
    KIRA_AND_DAN_1 = { party = {
      { "ILLUMISE", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "STRUGGLE_BUG", "CONFUSE_RAY", "MOONLIGHT", "DRAINING_KISS" } },
      { "ILLUMISE", 32, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    -- Route 109 and 103 (Surf): tag battles at 28-29
    GWEN = { partner = "R109S_ANN", party = {
      { "SEEL", 32, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", ev = 128, moves = { "FLIP_TURN", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
      { "QUAGSIRE", 32, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "MUD_SHOT", "AQUA_TAIL", "YAWN", "PROTECT" } },
      { "LUVDISC", 32, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "DRAINING_KISS", "CHARM", "AGILITY" } },
    } },
    ALICE = { partner = "R109S_EVE", party = {
      { "CORSOLA", 32, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", ev = 128, moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
      { "SIMIPOUR", 32, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "SCALD", "BRINE", "FLIP_TURN" } },
      { "BOUFFALANT", 32, ability = "SAP_SIPPER", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "HORN_ATTACK", "RAGE", "FURY_ATTACK" } },
    } },
    AUSTINA = { partner = "R109S_KIT", party = {
      { "GASTRODON_EAST_SEA", 32, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", ev = 128, moves = { "MUD_BOMB", "WATER_PULSE", "RECOVER", "HIDDEN_POWER" } },
      { "FURRET", 32, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DEFENSE_CURL", "ROLLOUT", "SLAM", "SCRATCH" } },
    } },
    DAVID = { partner = "R109S_GUS", party = {
      { "CRAWDAUNT", 32, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "KNOCK_OFF", "RAZOR_SHELL", "TAUNT" } },
      { "PHANTUMP", 32, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "HORN_LEECH", "FEINT_ATTACK", "CONFUSE_RAY", "INGRAIN" } },
    } },
    CARTER = { partner = "R109S_NED", party = {
      { "LANTURN", 32, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "RISING_VOLTAGE", "SPARK", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "FLOATZEL", 32, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", ev = 128, moves = { "BUBBLE_BEAM", "AQUA_JET", "QUICK_ATTACK", "GROWL" } },
    } },
    MEL_AND_PAUL = { party = {
      { "BEEDRILL", 32, ability = "SWARM", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "BUG_BITE", "SKITTER_SMACK", "PIN_MISSILE" } },
      { "BEAUTIFLY", 32, ability = "SWARM", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "AIR_SLASH", "MEGA_DRAIN", "STUN_SPORE", "ATTRACT" } },
    } },
    ELIJAH = { partner = "R109S_ACE", party = {
      { "SKARMORY", 32, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "STEEL_WING", "AIR_CUTTER", "SPIKES", "TAILWIND" } },
      { "WEAVILE", 32, ability = "PRESSURE", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "NIGHT_SLASH", "ASSURANCE", "NASTY_PLOT", "HONE_CLAWS" } },
    } },
    ISABELLE = { partner = "R103S_MEG", party = {
      { "SALANDIT", 32, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", ev = 128, moves = { "VENOSHOCK", "FLAME_BURST", "EMBER", "POISON_GAS" } },
      { "CRYOGONAL", 32, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "ICY_WIND", "WATER_PULSE", "ICE_BEAM", "AURORA_BEAM" } },
      { "QWILFISH", 32, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "AQUA_JET", "PROTECT", "REVENGE", "FELL_STINGER" } },
    } },
    PETE = { partner = "R103S_SAM", party = {
      { "WARTORTLE", 32, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "BITE", "PROTECT", "RAPID_SPIN" } },
      { "WISHIWASHI", 32, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BRINE", "WATER_GUN", "HELPING_HAND", "TEARFUL_LOOK" } },
    } },
    -- Route 115 north (Surf): tag battles at 28-29
    KOICHI = { partner = "R115N_DAN", party = {
      { "CRABOMINABLE", 32, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", ev = 128, moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "AVALANCHE", "LEER" } },
      { "HAWLUCHA", 32, ability = "LIMBER", nature = "ADAMANT", ev = 128, moves = { "ROCK_SMASH", "FEINT", "QUICK_GUARD", "BRICK_BREAK" } },
      { "MIENFOO", 32, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "FAKE_OUT", "DETECT", "CALM_MIND" } },
    } },
    KYRA = { partner = "R115N_JO", party = {
      { "FLAREON", 32, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "FIRE_FANG", "BITE", "QUICK_ATTACK", "HELPING_HAND" } },
      { "SWADLOON", 32, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "PROTECT", "SKITTER_SMACK", "GRASS_WHISTLE" } },
      { "DODRIO", 32, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "PLUCK", "SECRET_POWER", "QUICK_ATTACK", "AGILITY" } },
    } },
    JAIDEN = { partner = "R115N_KO", party = {
      { "NINJASK", 32, ability = "SPEED_BOOST", nature = "JOLLY", ev = 128, moves = { "SKITTER_SMACK", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
      { "SWALOT", 32, ability = "STICKY_HOLD", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", ev = 128, moves = { "SLUDGE", "YAWN", "STOCKPILE", "ACID_SPRAY" } },
      { "CROAGUNK", 32, ability = "DRY_SKIN", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "VENOSHOCK", "DRAIN_PUNCH", "SUCKER_PUNCH", "FLATTER" } },
    } },
    ALIX = { partner = "R115N_VIC", party = {
      { "MR_MIME", 32, ability = "FILTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "HYPNOSIS", "CONFUSION", "QUICK_GUARD" } },
      { "MALAMAR", 32, ability = "CONTRARY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "FOUL_PLAY", "PAYBACK", "PSYBEAM", "SWITCHEROO" } },
    } },
    HELENE = { partner = "R115N_ROX", party = {
      { "MEDITITE", 32, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "JUMPLUFF", 32, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "SEED_BOMB", "ACROBATICS", "BULLET_SEED", "MEGA_DRAIN" } },
    } },
    TIMOTHY_1 = { partner = "R115N_KEN", party = {
      { "PRIMEAPE", 32, ability = "VITAL_SPIRIT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "CROSS_CHOP", "KARATE_CHOP", "LEER", "FOCUS_ENERGY" } },
      { "DUSKULL", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "KADABRA", 32, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
    } },
    -- Route 118 east (Surf) and Trick House 4: tag battles at 29-30
    BARNY = { partner = "R118E_HAL", party = {
      { "TENTACRUEL", 32, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SHARPEDO", 32, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "NIGHT_SLASH", "ICE_FANG", "PROTECT" } },
      { "FRILLISH", 32, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BRINE", "HEX", "BUBBLE_BEAM", "OMINOUS_WIND" } },
    } },
    PERRY = { partner = "R118E_JAY", party = {
      { "CHANSEY", 32, ability = "SERENE_GRACE", nature = "TIMID", item = "SILK_SCARF", ev = 128, moves = { "TAKE_DOWN", "POUND", "HIDDEN_POWER", "COPYCAT" } },
      { "STOUTLAND", 32, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "DARTRIX", 32, ability = "LONG_REACH", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "RAZOR_LEAF", "OMINOUS_WIND", "PLUCK", "FORESIGHT" } },
    } },
    CHESTER = { partner = "R118E_KAY", party = {
      { "PIDGEOTTO", 32, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "TAILWIND", "SECRET_POWER", "AIR_CUTTER", "GUST" } },
      { "ZOROARK", 32, ability = "ILLUSION", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "KNOCK_OFF", "SNARL", "TAUNT", "FAKE_TEARS" } },
    } },
    CORA = { partner = "TH4_ZIA", party = {
      { "MEDITITE", 32, ability = "PURE_POWER", nature = "JOLLY", ev = 128, moves = { "DRAIN_PUNCH", "FORCE_PALM", "CONFUSION", "DETECT" } },
      { "PASSIMIAN", 32, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
      { "SKORUPI", 32, ability = "SNIPER", nature = "ADAMANT", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "TAUNT", "BUG_BITE", "SKITTER_SMACK" } },
    } },
    PAULA = { partner = "TH4_MAE", party = {
      { "BRELOOM", 32, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "MACH_PUNCH", "DRAIN_PUNCH", "SPORE", "FORCE_PALM" } },
      { "MIENFOO", 32, ability = "INNER_FOCUS", nature = "ADAMANT", ev = 128, moves = { "FORCE_PALM", "DRAIN_PUNCH", "DETECT", "CALM_MIND" } },
      { "POLIWHIRL", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "HYPNOSIS", "BODY_SLAM", "BELLY_DRUM" } },
    } },
    YUJI = { partner = "TH4_GOR", party = {
      { "HARIYAMA", 32, ability = "GUTS", nature = "ADAMANT", spread = "tank", item = "FLAME_ORB", ev = 128, moves = { "BRICK_BREAK", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PAWNIARD", 32, ability = "PRESSURE", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "LOW_SWEEP", "HEADBUTT", "PROTECT" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34) ----------
    -- Route 119: tag battles at 30-31 in the rain and long grass
    CHRIS = { partner = "R119_BO", party = {
      { "GYARADOS", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "BITE", "ICE_FANG", "DRAGON_DANCE" } },
      { "BRUXISH", 32, ability = "STRONG_JAW", nature = "JOLLY", item = "MYSTIC_WATER", ev = 128, moves = { "AQUA_JET", "CRUNCH", "AQUA_TAIL", "DISABLE" } },
      { "WHISCASH", 32, ability = "HYDRATION", nature = "MODEST", spread = "stank", ev = 128, moves = { "MUD_BOMB", "STOMPING_TANTRUM", "AMNESIA", "PROTECT" } },
    } },
    DONALD = { partner = "R119_GUS", party = {
      { "SCOLIPEDE", 32, ability = "POISON_POINT", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "BUG_BITE", "PROTECT", "SKITTER_SMACK", "IRON_DEFENSE" } },
      { "BEEDRILL", 32, ability = "SWARM", nature = "JOLLY", spread = "atk", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BUZZ", "TAILWIND", "BUG_BITE", "SKITTER_SMACK" } },
      { "VENOMOTH", 32, ability = "SHIELD_DUST", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    TAYLOR = { partner = "R119_TED", party = {
      { "PARASECT", 32, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "STRUGGLE_BUG", "STUN_SPORE", "X_SCISSOR", "CROSS_POISON" } },
      { "MASQUERAIN", 32, ability = "INTIMIDATE", nature = "MODEST", ev = 128, moves = { "LIQUIDATION", "AIR_CUTTER", "AIR_SLASH", "BUBBLE_BEAM" } },
      { "VIVILLON", 32, ability = "COMPOUND_EYES", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "SLEEP_POWDER", "BUG_BUZZ", "GUST", "STRUGGLE_BUG" } },
    } },
    HUGH = { partner = "R119_CY", party = {
      { "NOCTOWL", 32, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", ev = 128, moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "PERSIAN", 32, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", ev = 128, moves = { "AERIAL_ACE", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "TROPIUS", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "GROWTH", "SWEET_SCENT" } },
    } },
    YASU = { partner = "R119_KO", party = {
      { "FROGADIER", 32, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "GOLBAT", 32, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "AERIAL_ACE" } },
      { "STUNKY", 32, ability = "AFTERMATH", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "SCARY_FACE", "SUCKER_PUNCH", "BITE", "VENOSHOCK" } },
    } },
    DOUG = { partner = "R119_LIL", party = {
      { "ARAQUANID", 32, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BUZZ", "LEECH_LIFE", "BUG_BITE", "WIDE_GUARD" } },
      { "ARIADOS", 32, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "POISON_JAB", "SUCKER_PUNCH", "SPIDER_WEB", "SHADOW_SNEAK" } },
    } },
    GREG = { partner = "R119_PIP", party = {
      { "LEDIAN", 32, ability = "EARLY_BIRD", nature = "JOLLY", ev = 128, moves = { "AIR_SLASH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
      { "BUTTERFREE", 32, ability = "COMPOUND_EYES", nature = "TIMID", item = "SILVER_POWDER", ev = 128, moves = { "PROTECT", "AIR_SLASH", "SILVER_WIND", "GUST" } },
      { "ACCELGOR", 32, ability = "STICKY_HOLD", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "SIGNAL_BEAM", "GIGA_DRAIN", "ME_FIRST" } },
    } },
    PHIL = { partner = "R119_SKY", party = {
      { "FLETCHINDER", 32, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
      { "CHATOT", 32, ability = "KEEN_EYE", nature = "TIMID", ev = 128, moves = { "AERIAL_ACE", "PLUCK", "ROUND", "MIRROR_MOVE" } },
    } },
    TAKASHI = { partner = "R119_ZEN", party = {
      { "ESCAVALIER", 32, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BUZZ", "BUG_BITE", "DOUBLE_TEAM", "DOUBLE_EDGE" } },
      { "KOFFING", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
    } },
    JACKSON_1 = { partner = "R119_RAN", party = {
      { "DREDNAW", 32, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "RAZOR_SHELL", "ROCK_TOMB", "PROTECT" } },
      { "ROTOM", 32, ability = "LEVITATE", nature = "TIMID", spread = "spa", ev = 128, moves = { "SHOCK_WAVE", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "FROSMOTH", 32, ability = "SHIELD_DUST", nature = "MODEST", ev = 128, moves = { "LEECH_LIFE", "PROTECT", "AURORA_BEAM", "SIGNAL_BEAM" } },
    } },
    CATHERINE_1 = { partner = "R119_WEN", party = {
      { "GLOOM", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "POLIWHIRL", 32, ability = "WATER_ABSORB", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "MUD_SHOT", "BODY_SLAM", "DOUBLE_SLAP" } },
      { "BERGMITE", 32, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICY_WIND", "ICE_FANG", "TAKE_DOWN", "HARDEN" } },
    } },
    KENT = { partner = "R119_ABE", party = {
      { "NINJASK", 32, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "SHEDINJA", 32, ability = "WONDER_GUARD", nature = "ADAMANT", item = "FOCUS_SASH", ev = 128, moves = { "SKITTER_SMACK", "FURY_CUTTER", "CONFUSE_RAY", "MIND_READER" } },
    } },
    HIDEO = { partner = "R119_JIN", party = {
      { "SCRAGGY", 32, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
      { "GRIMER", 32, ability = "STICKY_HOLD", nature = "ADAMANT", ev = 128, moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    FABIAN = { partner = "R119_JAX", party = {
      { "MANECTRIC", 32, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "RISING_VOLTAGE", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
      { "DUNSPARCE", 32, ability = "RATTLED", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "TAKE_DOWN", "BODY_SLAM", "RAGE", "YAWN" } },
    } },
    DAYTON = { partner = "R119_ASH", party = {
      { "SLUGMA", 32, ability = "FLAME_BODY", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "LAVA_PLUME", "ROCK_SLIDE", "CLEAR_SMOG", "YAWN" } },
      { "PANSEAR", 32, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "FIRE_PUNCH", "BITE", "CRUNCH", "YAWN" } },
    } },
    RACHEL = { partner = "R119_UMA", party = {
      { "LOMBRE", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "KNOCK_OFF" } },
      { "ZEBSTRIKA", 32, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", item = "MAGNET", ev = 128, moves = { "THUNDERBOLT", "SPARK", "VOLT_SWITCH", "JUMP_KICK" } },
    } },
    BRENT = { partner = "R119_DON", party = {
      { "YANMA", 32, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "UPROAR", "FORESIGHT" } },
      { "VOLBEAT", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "THUNDER_PUNCH", "TAIL_GLOW", "CONFUSE_RAY", "MOONLIGHT" } },
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
    BRENDAN_ROUTE_119_MUDKIP = { tier = "leader", party = {
      { "RILLABOOM", 32, ability = "GRASSY_SURGE", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "WOOD_HAMMER", "KNOCK_OFF", "PROTECT" } },
      { "WHIMSICOTT", 32, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "LEECH_SEED", "STUN_SPORE", "ENERGY_BALL", "HELPING_HAND" } },
      { "ARCANINE", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "CRUNCH", "PROTECT" } },
      { "MAGNETON", 32, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "GROVYLE", 33, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "LEAF_BLADE", "GRASSY_GLIDE", "ROCK_SLIDE", "DETECT" } },
    } },
    BRENDAN_ROUTE_119_TORCHIC = { tier = "leader", party = {
      { "PELIPPER", 32, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SCALD", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "FAKE_OUT", "GIGA_DRAIN", "SCALD", "ICE_BEAM" } },
      { "AMPHAROS", 32, ability = "STATIC", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "THUNDER", "DRAGON_PULSE", "THUNDER_WAVE", "PROTECT" } },
      { "FLOATZEL", 32, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_TAIL", "MUD_BOMB", "ROCK_SLIDE", "PROTECT" } },
    } },
    BRENDAN_ROUTE_119_TREECKO = { tier = "leader", party = {
      { "CLEFABLE", 32, ability = "UNAWARE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "FOLLOW_ME", "MOONLIGHT", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "ROLLING_KICK", "PROTECT" } },
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "GARDEVOIR", 32, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "HELPING_HAND", "PROTECT" } },
      { "COMBUSKEN", 33, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLAME_CHARGE", "BRICK_BREAK", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_ROUTE_119_MUDKIP = { tier = "leader", party = {
      { "RILLABOOM", 32, ability = "GRASSY_SURGE", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "WOOD_HAMMER", "KNOCK_OFF", "PROTECT" } },
      { "WHIMSICOTT", 32, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "LEECH_SEED", "STUN_SPORE", "ENERGY_BALL", "HELPING_HAND" } },
      { "ARCANINE", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "CRUNCH", "PROTECT" } },
      { "MAGNETON", 32, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "GROVYLE", 33, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "LEAF_BLADE", "GRASSY_GLIDE", "ROCK_SLIDE", "DETECT" } },
    } },
    MAY_ROUTE_119_TORCHIC = { tier = "leader", party = {
      { "PELIPPER", 32, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SCALD", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "FAKE_OUT", "GIGA_DRAIN", "SCALD", "ICE_BEAM" } },
      { "AMPHAROS", 32, ability = "STATIC", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "THUNDER", "DRAGON_PULSE", "THUNDER_WAVE", "PROTECT" } },
      { "FLOATZEL", 32, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "PROTECT" } },
      { "MARSHTOMP", 33, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "AQUA_TAIL", "MUD_BOMB", "ROCK_SLIDE", "PROTECT" } },
    } },
    MAY_ROUTE_119_TREECKO = { tier = "leader", party = {
      { "CLEFABLE", 32, ability = "UNAWARE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "FOLLOW_ME", "MOONLIGHT", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 32, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "ROLLING_KICK", "PROTECT" } },
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "GARDEVOIR", 32, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "PSYCHIC", "DAZZLING_GLEAM", "HELPING_HAND", "PROTECT" } },
      { "COMBUSKEN", 33, ability = "SPEED_BOOST", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FLAME_CHARGE", "BRICK_BREAK", "ROCK_SLIDE", "PROTECT" } },
    } },
    -- Route 120: tag battles at 31-32
    CHIP = { partner = "R120_RAE", party = {
      { "JOLTIK", 32, ability = "COMPOUND_EYES", nature = "MODEST", item = "SILVER_POWDER", ev = 128, moves = { "X_SCISSOR", "PROTECT", "ELECTROWEB", "SIGNAL_BEAM" } },
      { "BALTOY", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "PSYBEAM", "BULLDOZE", "ROCK_TOMB", "REFLECT" } },
      { "AERODACTYL", 32, ability = "PRESSURE", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "BITE", "WING_ATTACK", "TAILWIND" } },
    } },
    JEFFREY_1 = { partner = "R120_GUS", party = {
      { "HEATMOR", 32, ability = "GLUTTONY", nature = "JOLLY", ev = 128, moves = { "IRON_HEAD", "FLAME_BURST", "BUG_BITE", "ODOR_SLEUTH" } },
      { "MOTHIM", 32, ability = "SWARM", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BUZZ", "AIR_SLASH", "U_TURN", "PROTECT" } },
      { "MASQUERAIN", 32, ability = "INTIMIDATE", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "AIR_SLASH", "BUG_BUZZ", "STUN_SPORE", "TAILWIND" } },
    } },
    COLIN = { partner = "R120_SKY", party = {
      { "DODRIO", 32, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "PLUCK", "SECRET_POWER", "QUICK_ATTACK", "AGILITY" } },
      { "XATU", 32, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "SIGILYPH", 32, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", ev = 128, moves = { "AIR_SLASH", "SYNCHRONOISE", "PSYBEAM", "GRAVITY" } },
    } },
    KEIGO = { partner = "R120_KO", party = {
      { "FROGADIER", 32, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "QUICK_ATTACK", "SMOKESCREEN", "BOUNCE" } },
      { "KOFFING", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "SCRAGGY", 32, ability = "SHED_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "IRON_HEAD", "SUCKER_PUNCH", "FEINT_ATTACK", "TORMENT" } },
    } },
    ROBERT_1 = { partner = "R120_ACE", party = {
      { "PERSIAN", 32, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", ev = 128, moves = { "AERIAL_ACE", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "FLETCHINDER", 32, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    CLARISSA = { partner = "R120_NIA", party = {
      { "GOGOAT", 32, ability = "GRASS_PELT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "GIGA_DRAIN", "SEED_BOMB", "TAKE_DOWN", "SYNTHESIS" } },
      { "WAILMER", 32, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", ev = 128, moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "PONYTA", 32, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "BLAZE_KICK", "FLAME_WHEEL", "FLAME_CHARGE", "EMBER" } },
    } },
    ANGELICA = { partner = "R120_PIA", party = {
      { "MEOWSTIC_FEMALE", 32, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "CASTFORM", 32, ability = "FORECAST", nature = "MODEST", spread = "spa", ev = 128, moves = { "SECRET_POWER", "RAIN_DANCE", "SUNNY_DAY", "ICE_BEAM" } },
      { "CRAMORANT", 32, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "DIVE", "PLUCK", "STOCKPILE" } },
    } },
    LORENZO = { partner = "R120_RAN", party = {
      { "LUDICOLO", 32, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", ev = 128, moves = { "FAKE_OUT", "GIGA_DRAIN", "WATER_PULSE", "RAIN_DANCE" } },
      { "KANGASKHAN", 32, ability = "INNER_FOCUS", nature = "JOLLY", ev = 128, moves = { "FACADE", "CRUSH_CLAW", "MEGA_PUNCH", "CHIP_AWAY" } },
      { "NIDOQUEEN", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "STOMPING_TANTRUM", "SLUDGE_BOMB", "ICE_BEAM", "HELPING_HAND" } },
    } },
    JENNA = { partner = "R120_WEN", party = {
      { "SHIFTRY", 32, ability = "CHLOROPHYLL", nature = "ADAMANT", ev = 128, moves = { "FAKE_OUT", "RAZOR_LEAF", "SUCKER_PUNCH", "EXPLOSION" } },
      { "QWILFISH", 32, ability = "POISON_POINT", nature = "MODEST", spread = "spa", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "REVENGE", "AQUA_JET", "STOCKPILE" } },
      { "NIDOKING", 32, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "STOMPING_TANTRUM", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
    } },
    RILEY = { partner = "R120_JIN", party = {
      { "CROAGUNK", 32, ability = "DRY_SKIN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SUCKER_PUNCH", "VENOSHOCK", "POISON_JAB", "REVENGE" } },
      { "MOTHIM", 32, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BUZZ", "U_TURN", "QUIVER_DANCE", "PROTECT" } },
    } },
    CALLIE = { partner = "R120_ROX", party = {
      { "MEDITITE", 32, ability = "PURE_POWER", nature = "JOLLY", ev = 128, moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "DETECT" } },
      { "CINCCINO", 32, ability = "SKILL_LINK", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "POUND", "TAIL_SLAP", "SECRET_POWER", "SWIFT" } },
      { "PANCHAM", 32, ability = "MOLD_BREAKER", nature = "JOLLY", ev = 128, moves = { "DRAIN_PUNCH", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    JENNIFER = { partner = "R120_MAX", party = {
      { "SABLEYE", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "JANGMO_O", 32, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
      { "LILLIGANT", 32, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "GIGA_DRAIN", "ENERGY_BALL", "ENCORE", "MEGA_DRAIN" } },
    } },
    LEONEL = { partner = "R120_LEO", party = {
      { "VIKAVOLT", 32, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "THUNDERBOLT", "BUG_BUZZ", "AIR_SLASH", "STRING_SHOT" } },
      { "STEENEE", 32, ability = "SWEET_VEIL", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "RAZOR_LEAF", "STOMP", "TEETER_DANCE" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
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
      { "CRABOMINABLE", 39, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", ev = 128, moves = { "POWER_UP_PUNCH", "ICE_PUNCH", "AVALANCHE", "LEER" } },
      { "TOGETIC", 39, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", ev = 128, moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
      { "LAMPENT", 39, ability = "FLASH_FIRE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "SHADOW_BALL", "HEX", "CONFUSE_RAY" } },
      { "MILTANK", 39, ability = "THICK_FAT", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "STOMP", "STRENGTH", "MILK_DRINK", "DEFENSE_CURL" } },
    } },
    PAT = { party = {
      { "SWAMPERT", 39, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "MUD_SHOT", "AQUA_TAIL", "ROCK_SLIDE", "PROTECT" } },
      { "ZANGOOSE", 39, ability = "IMMUNITY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "REVENGE", "BODY_SLAM", "FOCUS_ENERGY", "CRUSH_CLAW" } },
      { "EELEKTRIK", 39, ability = "LEVITATE", nature = "TIMID", item = "MAGNET", ev = 128, moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
      { "LYCANROC", 39, ability = "SAND_RUSH", nature = "JOLLY", item = "HARD_STONE", ev = 128, moves = { "ROCK_SLIDE", "BITE", "ACCELEROCK", "ROCK_TOMB" } },
    } },
    JESSICA_1 = { partner = "R121_ANN", party = {
      { "KROKOROK", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "CRUNCH", "SAND_TOMB", "TORMENT" } },
      { "GARBODOR", 39, ability = "STENCH", nature = "ADAMANT", item = "POISON_BARB", ev = 128, moves = { "SLUDGE_BOMB", "SLUDGE", "CLEAR_SMOG", "METAL_CLAW" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "STRENGTH" } },
    } },
    CALE = { partner = "R121_GUS", party = {
      { "WORMADAM", 39, ability = "ANTICIPATION", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BUZZ", "ENERGY_BALL", "CONFUSION", "PROTECT" } },
      { "WORMADAM", 39, ability = "ANTICIPATION", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "BUG_BITE", "PROTECT", "SUCKER_PUNCH", "LEAF_STORM" } },
    } },
    TAMMY = { partner = "R121_WEN", party = {
      { "GOURGEIST", 39, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", ev = 128, moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "SEED_BOMB" } },
      { "BANETTE", 39, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "BODY_SLAM", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    WALTER_1 = { partner = "R121_MAX", party = {
      { "ELECTIVIRE", 39, ability = "MOTOR_DRIVE", nature = "ADAMANT", item = "MAGNET", ev = 128, moves = { "SWAGGER", "CROSS_CHOP", "THUNDER_PUNCH", "DISCHARGE" } },
      { "BARRASKEWDA", 39, ability = "PROPELLER_TAIL", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "DIVE", "THROAT_CHOP", "AGILITY" } },
      { "LINOONE", 39, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", ev = 128, moves = { "EXTREME_SPEED", "HEADBUTT", "COVET", "PROTECT" } },
    } },
    VANESSA = { partner = "R121_PIA", party = {
      { "RAICHU", 39, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "DISCHARGE", "THUNDER_PUNCH", "FEINT", "NASTY_PLOT" } },
      { "PACHIRISU", 39, ability = "PICKUP", nature = "TIMID", ev = 128, moves = { "SPARK", "THUNDER_PUNCH", "U_TURN", "DEFENSE_CURL" } },
      { "GRANBULL", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PLAY_ROUGH", "BITE", "ROAR", "HEADBUTT" } },
    } },
    MARCEL = { partner = "R121_TOD", party = {
      { "SHIFTRY", 39, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "THROAT_CHOP", "RAZOR_LEAF", "SUCKER_PUNCH", "FEINT_ATTACK" } },
      { "BOLTUND", 39, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", ev = 128, moves = { "SPARK", "FLAME_CHARGE", "CRUNCH", "CHARM" } },
      { "UNFEZANT", 39, ability = "BIG_PECKS", nature = "ADAMANT", ev = 128, moves = { "DRILL_PECK", "QUICK_ATTACK", "RAZOR_WIND", "AIR_SLASH" } },
    } },
    KATE_AND_JOY = { party = {
      { "ELGYEM", 39, ability = "SYNCHRONIZE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "CALM_MIND", "PSYBEAM", "CONFUSION" } },
      { "SLAKING", 39, ability = "TRUANT", nature = "ADAMANT", ev = 128, moves = { "SLASH", "STRENGTH", "SLACK_OFF", "BULK_UP" } },
    } },
    CRISTIN_1 = { partner = "R121_ROX", party = {
      { "NINETALES", 39, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "VIBRAVA", 39, ability = "LEVITATE", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "DIG", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
      { "STARAPTOR", 39, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AIR_SLASH", "WING_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    -- Route 122 and Mt. Pyre: tag battles at 32-34; the Aqua grunts at the summit fight alone
    GABRIELLE_1 = { party = {
      { "BEARTIC", 39, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "bulk", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICE_PUNCH", "ICICLE_CRASH", "THRASH", "SLASH" } },
      { "MEGANIUM", 39, ability = "LEAF_GUARD", nature = "BOLD", spread = "bulk", ev = 128, moves = { "GRASS_PLEDGE", "REFLECT", "POISON_POWDER", "SYNTHESIS" } },
      { "RAICHU_ALOLAN", 39, ability = "SURGE_SURFER", nature = "TIMID", spread = "spa", ev = 128, moves = { "PSYCHIC", "SPARK", "NUZZLE", "THUNDER_WAVE" } },
      { "DONPHAN", 39, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "STOMPING_TANTRUM", "KNOCK_OFF", "RAPID_SPIN" } },
    } },
    ZANDER = { partner = "PYRE_DAN", party = {
      { "HARIYAMA", 39, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", ev = 128, moves = { "BRICK_BREAK", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PRIMEAPE", 39, ability = "ANGER_POINT", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "BRICK_BREAK", "CROSS_CHOP", "THRASH", "LEER" } },
      { "EMBOAR", 39, ability = "RECKLESS", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "FLAME_CHARGE", "BODY_PRESS", "ROCK_TOMB", "HELPING_HAND" } },
    } },
    LEAH = { partner = "PYRE_ELI", party = {
      { "VICTREEBEL", 39, ability = "CHLOROPHYLL", nature = "JOLLY", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "SLUDGE_BOMB", "POISON_JAB", "RAZOR_LEAF", "SWALLOW" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "EXPANDING_FORCE", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "MALAMAR", 39, ability = "INFILTRATOR", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "FOUL_PLAY", "PAYBACK", "PSYBEAM", "SWITCHEROO" } },
    } },
    VALERIE_1 = { partner = "PYRE_NIA", party = {
      { "SABLEYE", 39, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "FAKE_OUT", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "DOUBLADE", 39, ability = "NO_GUARD", nature = "BOLD", spread = "bulk", ev = 128, moves = { "IRON_HEAD", "RETALIATE", "SLASH", "IRON_DEFENSE" } },
      { "SPIRITOMB", 39, ability = "INFILTRATOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "HEX", "SUCKER_PUNCH", "CONFUSE_RAY", "NASTY_PLOT" } },
    } },
    TASHA = { partner = "PYRE_ZIA", party = {
      { "HAUNTER", 39, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SPELL_TAG", ev = 128, moves = { "HEX", "WILL_O_WISP", "SHADOW_BALL", "SPITE" } },
      { "BANETTE", 39, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "BODY_SLAM", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "COFAGRIGUS", 39, ability = "MUMMY", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "WILL_O_WISP", "MIRROR_SHOT", "HEX", "SHADOW_BALL" } },
    } },
    MARK = { partner = "PYRE_OTT", party = {
      { "RHYHORN", 39, ability = "ROCK_HEAD", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_SLIDE", "BULLDOZE", "STOMP", "SCARY_FACE" } },
      { "FRAXURE", 39, ability = "MOLD_BREAKER", nature = "ADAMANT", ev = 128, moves = { "DRAGON_CLAW", "CRUNCH", "ASSURANCE", "TAUNT" } },
      { "SNORLAX", 39, ability = "IMMUNITY", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "ROLLOUT", "DEFENSE_CURL", "LAST_RESORT", "BODY_SLAM" } },
    } },
    ATSUSHI = { partner = "PYRE_GOR", party = {
      { "SAMUROTT", 39, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "RAZOR_SHELL", "WATER_PLEDGE", "REVENGE", "FOCUS_ENERGY" } },
      { "MACHOKE", 39, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "BRICK_BREAK", "REVENGE", "ROCK_SLIDE", "BULK_UP" } },
      { "BOLDORE", 39, ability = "STURDY", nature = "IMPISH", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "PROTECT", "DISCHARGE", "ROCK_SLIDE" } },
    } },
    WILLIAM = { partner = "PYRE_VIC", party = {
      { "SLOWBRO", 39, ability = "OWN_TEMPO", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "ZEN_HEADBUTT", "EXPANDING_FORCE", "DISABLE", "YAWN" } },
      { "GARDEVOIR", 39, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "HYPNOSIS" } },
      { "GALLADE", 39, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHO_CUT", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
    } },
    KAYLA = { partner = "PYRE_IVY", party = {
      { "WOBBUFFET", 39, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", ev = 128, moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "ALAKAZAM", 39, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "EXPANDING_FORCE", "DISABLE", "REFLECT" } },
      { "MUSHARNA", 39, ability = "FOREWARN", nature = "CALM", spread = "spdef", ev = 128, moves = { "PSYBEAM", "HYPNOSIS", "SWAGGER", "SYNCHRONOISE" } },
    } },
    CEDRIC = { partner = "PYRE_LEO", party = {
      { "COPPERAJAH", 39, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "DIG", "IRON_HEAD", "GROWL", "IRON_DEFENSE" } },
      { "GOTHORITA", 39, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYSHOCK", "PROTECT", "FUTURE_SIGHT", "EMBARGO" } },
      { "MEOWSTIC_FEMALE", 39, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYSHOCK", "FAKE_OUT", "DISARMING_VOICE", "LIGHT_SCREEN" } },
    } },
    DEZ_AND_LUKE = { party = {
      { "SIMIPOUR", 39, ability = "GLUTTONY", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "SCALD", "BRINE", "DIVE" } },
      { "MUDSDALE", 39, ability = "STAMINA", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "BULLDOZE", "STEALTH_ROCK", "HIGH_HORSEPOWER" } },
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
      { "DARMANITAN", 39, ability = "ZEN_MODE", nature = "JOLLY", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "FLAMETHROWER", "EXTRASENSORY", "WILL_O_WISP", "FIRE_PUNCH" } },
      { "NINETALES_ALOLAN", 39, ability = "SNOW_CLOAK", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICE_BEAM", "EXTRASENSORY", "CONFUSE_RAY", "AURORA_VEIL" } },
    } },
    VIOLET = { partner = "R123_FAY", party = {
      { "STEENEE", 39, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "SEED_BOMB", "STOMP" } },
      { "TROPIUS", 39, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MAGICAL_LEAF", "AIR_SLASH", "GROWTH", "SWEET_SCENT" } },
    } },
    DAVIS = { partner = "R123_GUS", party = {
      { "PINSIR", 39, ability = "MOXIE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "X_SCISSOR", "STORM_THROW", "BULLDOZE", "SWORDS_DANCE" } },
      { "SWADLOON", 39, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "PROTECT", "SEED_BOMB", "GRASS_WHISTLE" } },
    } },
    JAZMYN = { partner = "R123_MAX", party = {
      { "ABSOL", 39, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "THROAT_CHOP", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "DEINO", 39, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_BREATH", "PROTECT", "RAIN_DANCE", "CRUNCH" } },
      { "JOLTEON", 39, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "THUNDERBOLT", "DOUBLE_KICK", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ALBERTO = { partner = "R123_SKY", party = {
      { "PELIPPER", 39, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_PULSE", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "DODRIO", 39, ability = "RUN_AWAY", nature = "CALM", spread = "spdef", ev = 128, moves = { "SECRET_POWER", "PLUCK", "BODY_SLAM", "GROWL" } },
    } },
    ED = { partner = "R123_DON", party = {
      { "QWILFISH", 39, ability = "POISON_POINT", nature = "MODEST", spread = "spa", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "TAKE_DOWN", "POISON_JAB", "STOCKPILE" } },
      { "ZANGOOSE", 39, ability = "TOXIC_BOOST", nature = "JOLLY", item = "TOXIC_ORB", ev = 128, moves = { "FACADE", "CRUSH_CLAW", "BODY_SLAM", "HONE_CLAWS" } },
      { "GLACEON", 39, ability = "SNOW_CLOAK", nature = "MODEST", spread = "spa", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICE_FANG", "ICY_WIND", "BITE", "FREEZE_DRY" } },
    } },
    KINDRA = { partner = "R123_ZEN", party = {
      { "SINISTEA", 39, ability = "WEAK_ARMOR", nature = "BOLD", spread = "bulk", ev = 128, moves = { "HEX", "WILL_O_WISP", "PROTECT", "SHADOW_BALL" } },
      { "MAROWAK_ALOLAN", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "THICK_CLUB", ev = 128, moves = { "FLAME_WHEEL", "SHADOW_BONE", "BONE_CLUB", "FALSE_SWIPE" } },
      { "ROTOM", 39, ability = "LEVITATE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_BALL", "HEX", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    FERNANDO_1 = { partner = "R123_JAX", party = {
      { "BOLTUND", 39, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", ev = 128, moves = { "SPARK", "FLAME_CHARGE", "CRUNCH", "CHARM" } },
      { "DUNSPARCE", 39, ability = "RATTLED", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "TAKE_DOWN", "BODY_SLAM", "RAGE", "ROOST" } },
      { "KRICKETUNE", 39, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", ev = 128, moves = { "FURY_CUTTER", "X_SCISSOR", "SING", "TAUNT" } },
    } },
    CAMERON_1 = { partner = "R123_VIC", party = {
      { "SOLROCK", 39, ability = "LEVITATE", nature = "ADAMANT", ev = 128, moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "ROCK_POLISH", "MORNING_SUN" } },
      { "EXEGGUTOR_ALOLAN", 39, ability = "FRISK", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_HAMMER", "DRAGON_PULSE", "HYPNOSIS", "TRICK_ROOM" } },
      { "MAGMAR", 39, ability = "FLAME_BODY", nature = "TIMID", spread = "spa", ev = 128, moves = { "FLAME_CHARGE", "FLAME_BURST", "LAVA_PLUME", "SMOKESCREEN" } },
    } },
    JACKI_1 = { partner = "R123_IVY", party = {
      { "MR_MIME", 39, ability = "FILTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "HYPNOSIS", "EXPANDING_FORCE", "QUICK_GUARD" } },
      { "GIRAFARIG", 39, ability = "SAP_SIPPER", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "EXPANDING_FORCE", "STOMP", "AGILITY", "BATON_PASS" } },
      { "ESPEON", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SWIFT", "EXPANDING_FORCE", "MORNING_SUN" } },
    } },
    FREDRICK = { partner = "R123_KEN", party = {
      { "KLINKLANG", 39, ability = "PLUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "GEAR_GRIND", "VISE_GRIP", "METAL_SOUND", "AUTOTOMIZE" } },
      { "MIMIKYU", 39, ability = "DISGUISE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "DRAINING_KISS", "WOOD_HAMMER", "SHADOW_CLAW", "HONE_CLAWS" } },
      { "PUPITAR", 39, ability = "SHED_SKIN", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_SLIDE", "CRUNCH", "STOMPING_TANTRUM", "SCARY_FACE" } },
    } },
    BRAXTON = { partner = "R123_ACE", party = {
      { "BEWEAR", 39, ability = "UNNERVE", nature = "JOLLY", item = "BLACK_BELT", ev = 128, moves = { "HAMMER_ARM", "TAKE_DOWN", "TACKLE", "LEER" } },
      { "DRAGONAIR", 39, ability = "MARVEL_SCALE", nature = "JOLLY", item = "DRAGON_FANG", ev = 128, moves = { "DRAGON_TAIL", "TWISTER", "SLAM", "THUNDER_WAVE" } },
      { "SWADLOON", 39, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "PROTECT", "SEED_BOMB", "GRASS_WHISTLE" } },
    } },
    WENDY = { partner = "R123_ELA", party = {
      { "MAWILE", 39, ability = "INTIMIDATE", nature = "ADAMANT", ev = 128, moves = { "IRON_HEAD", "PLAY_ROUGH", "SUCKER_PUNCH", "PROTECT" } },
      { "ROSERADE", 39, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "PANCHAM", 39, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    JONAS = { partner = "R123_KO", party = {
      { "WEEZING", 39, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SLUDGE", "SMOKESCREEN", "WILL_O_WISP", "HAZE" } },
      { "ARBOK", 39, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "POISON_JAB", "BITE", "STOCKPILE" } },
    } },
    KAYLEY = { partner = "R123_UMA", party = {
      { "CASTFORM", 39, ability = "FORECAST", nature = "MODEST", spread = "spa", ev = 128, moves = { "BODY_SLAM", "SUNNY_DAY", "ICE_BEAM", "SOLAR_BEAM" } },
      { "SNOVER", 39, ability = "SNOW_WARNING", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "LEECH_SEED", "RAZOR_LEAF", "SEED_BOMB", "LEAFAGE" } },
    } },
    -- Rival in Lilycove: six, alone (first full team); fully evolved ace at 35
    BRENDAN_LILYCOVE_MUDKIP = { tier = "leader", party = {
      { "RILLABOOM", 34, ability = "GRASSY_SURGE", nature = "ADAMANT", spread = "tank", item = "TERRAIN_EXTENDER", moves = { "FAKE_OUT", "WOOD_HAMMER", "KNOCK_OFF", "PROTECT" } },
      { "WHIMSICOTT", 34, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "TAILWIND", "STUN_SPORE", "ENERGY_BALL", "HELPING_HAND" } },
      { "ARCANINE", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "LIFE_ORB", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "PLAY_ROUGH", "PROTECT" } },
      { "MAGNEZONE", 34, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "FLASH_CANNON", "VOLT_SWITCH", "PROTECT" } },
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "SCEPTILE", 35, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "LEAF_BLADE", "GRASSY_GLIDE", "DRAGON_PULSE", "DETECT" } },
    } },
    BRENDAN_LILYCOVE_TORCHIC = { tier = "leader", party = {
      { "PELIPPER", 34, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SCALD", "HURRICANE", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 34, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "LIFE_ORB", moves = { "FAKE_OUT", "GIGA_DRAIN", "HYDRO_PUMP", "ICE_BEAM" } },
      { "AMPHAROS", 34, ability = "STATIC", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "THUNDER", "DRAGON_PULSE", "VOLT_SWITCH", "PROTECT" } },
      { "FLOATZEL", 34, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "ICE_PUNCH" } },
      { "KABUTOPS", 34, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "EXPERT_BELT", moves = { "WATERFALL", "ROCK_SLIDE", "X_SCISSOR", "AQUA_JET" } },
      { "SWAMPERT", 35, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "LIQUIDATION", "HIGH_HORSEPOWER", "ICE_PUNCH", "PROTECT" } },
    } },
    BRENDAN_LILYCOVE_TREECKO = { tier = "leader", party = {
      { "CLEFABLE", 34, ability = "UNAWARE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "FOLLOW_ME", "DAZZLING_GLEAM", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "SUCKER_PUNCH", "WIDE_GUARD" } },
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "TAILWIND", "PROTECT" } },
      { "GARDEVOIR", 34, ability = "TRACE", nature = "MODEST", spread = "spa", item = "LIFE_ORB", moves = { "PSYCHIC", "DAZZLING_GLEAM", "HELPING_HAND", "SHADOW_BALL" } },
      { "CRADILY", 34, ability = "STORM_DRAIN", nature = "CALM", spread = "bulk", item = "LEFTOVERS", moves = { "GIGA_DRAIN", "ROCK_SLIDE", "RECOVER", "PROTECT" } },
      { "BLAZIKEN", 35, ability = "SPEED_BOOST", nature = "ADAMANT", item = "LIFE_ORB", moves = { "BLAZE_KICK", "SKY_UPPERCUT", "BRAVE_BIRD", "PROTECT" } },
    } },
    MAY_LILYCOVE_MUDKIP = { tier = "leader", party = {
      { "RILLABOOM", 34, ability = "GRASSY_SURGE", nature = "ADAMANT", spread = "tank", item = "TERRAIN_EXTENDER", moves = { "FAKE_OUT", "WOOD_HAMMER", "KNOCK_OFF", "PROTECT" } },
      { "WHIMSICOTT", 34, ability = "PRANKSTER", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "TAILWIND", "STUN_SPORE", "ENERGY_BALL", "HELPING_HAND" } },
      { "ARCANINE", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "LIFE_ORB", moves = { "FLARE_BLITZ", "EXTREME_SPEED", "PLAY_ROUGH", "PROTECT" } },
      { "MAGNEZONE", 34, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "FLASH_CANNON", "VOLT_SWITCH", "PROTECT" } },
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "SCEPTILE", 35, ability = "UNBURDEN", nature = "JOLLY", item = "GRASSY_SEED", moves = { "LEAF_BLADE", "GRASSY_GLIDE", "DRAGON_PULSE", "DETECT" } },
    } },
    MAY_LILYCOVE_TORCHIC = { tier = "leader", party = {
      { "PELIPPER", 34, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SCALD", "HURRICANE", "TAILWIND", "PROTECT" } },
      { "LUDICOLO", 34, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "LIFE_ORB", moves = { "FAKE_OUT", "GIGA_DRAIN", "HYDRO_PUMP", "ICE_BEAM" } },
      { "AMPHAROS", 34, ability = "STATIC", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", moves = { "THUNDER", "DRAGON_PULSE", "VOLT_SWITCH", "PROTECT" } },
      { "FLOATZEL", 34, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "AQUA_JET", "WATERFALL", "CRUNCH", "ICE_PUNCH" } },
      { "KABUTOPS", 34, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "EXPERT_BELT", moves = { "WATERFALL", "ROCK_SLIDE", "X_SCISSOR", "AQUA_JET" } },
      { "SWAMPERT", 35, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "LIQUIDATION", "HIGH_HORSEPOWER", "ICE_PUNCH", "PROTECT" } },
    } },
    MAY_LILYCOVE_TREECKO = { tier = "leader", party = {
      { "CLEFABLE", 34, ability = "UNAWARE", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "FOLLOW_ME", "DAZZLING_GLEAM", "THUNDER_WAVE", "HELPING_HAND" } },
      { "HITMONTOP", 34, ability = "INTIMIDATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "SUCKER_PUNCH", "WIDE_GUARD" } },
      { "SWELLOW", 34, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", moves = { "FACADE", "BRAVE_BIRD", "TAILWIND", "PROTECT" } },
      { "GARDEVOIR", 34, ability = "TRACE", nature = "MODEST", spread = "spa", item = "LIFE_ORB", moves = { "PSYCHIC", "DAZZLING_GLEAM", "HELPING_HAND", "SHADOW_BALL" } },
      { "CRADILY", 34, ability = "STORM_DRAIN", nature = "CALM", spread = "bulk", item = "LEFTOVERS", moves = { "GIGA_DRAIN", "ROCK_SLIDE", "RECOVER", "PROTECT" } },
      { "BLAZIKEN", 35, ability = "SPEED_BOOST", nature = "ADAMANT", item = "LIFE_ORB", moves = { "BLAZE_KICK", "SKY_UPPERCUT", "BRAVE_BIRD", "PROTECT" } },
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
      { "UNFEZANT", 39, ability = "BIG_PECKS", nature = "ADAMANT", ev = 128, moves = { "DRILL_PECK", "QUICK_ATTACK", "RAZOR_WIND", "AIR_SLASH" } },
      { "MANTYKE", 39, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", ev = 128, moves = { "WATER_PULSE", "AIR_SLASH", "CONFUSE_RAY", "WIDE_GUARD" } },
      { "GASTRODON", 39, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    JENNY_1 = { partner = "R124_MIA", party = {
      { "WAILORD", 39, ability = "PRESSURE", nature = "MODEST", spread = "stank", item = "SITRUS_BERRY", ev = 128, moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "HUNTAIL", 39, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "DIVE", "CRUNCH", "BATON_PASS" } },
      { "PRIMARINA", 39, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "ENCORE" } },
    } },
    DECLAN = { partner = "R124_GIL", party = {
      { "GYARADOS", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "ICE_FANG", "DRAGON_DANCE", "PROTECT" } },
      { "CLAWITZER", 39, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", ev = 128, moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    SPENCER = { partner = "R124_HAL", party = {
      { "TENTACRUEL", 39, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "BARRASKEWDA", 39, ability = "SWIFT_SWIM", nature = "ADAMANT", spread = "atk", item = "DAMP_ROCK", ev = 128, moves = { "WATER_PULSE", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    ROLAND = { partner = "R124_DUN", party = {
      { "OCTILLERY", 39, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "DIVE", "ICE_BEAM", "PSYBEAM", "FOCUS_ENERGY" } },
      { "SWANNA", 39, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "LIQUIDATION", "PROTECT", "AIR_SLASH", "AQUA_RING" } },
    } },
    GRACE = { partner = "R124_LIA", party = {
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "CLAWITZER", 39, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SCALD", "BUBBLE_BEAM", "WATER_SPORT", "HEAL_PULSE" } },
    } },
    ISABELLA = { partner = "R124_TOD", party = {
      { "DREDNAW", 39, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "RAZOR_SHELL", "LIQUIDATION", "PROTECT" } },
      { "AZUMARILL", 39, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "SCALD", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    LILA_AND_ROY_1 = { party = {
      { "KINGLER", 39, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
    } },
    -- Route 125 and Shoal Cave: tag battles at 38-40
    NOLEN = { partner = "R125_JON", party = {
      { "POLIWRATH", 39, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "WISHIWASHI", 39, ability = "SCHOOLING", nature = "MODEST", spread = "spa", ev = 128, moves = { "SCALD", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
      { "RAICHU", 39, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "DISCHARGE", "THUNDER_PUNCH", "FEINT", "NASTY_PLOT" } },
    } },
    TANYA = { partner = "R125_AMY", party = {
      { "LUVDISC", 39, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", ev = 128, moves = { "SCALD", "DRAINING_KISS", "CHARM", "AGILITY" } },
      { "QWILFISH", 39, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
      { "VAPOREON", 39, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    ERNEST_1 = { partner = "R125_BEN", party = {
      { "CONKELDURR", 39, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "MILOTIC", 39, ability = "MARVEL_SCALE", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "BUBBLE_BEAM", "SCALD", "AQUA_TAIL" } },
      { "BOUFFALANT", 39, ability = "SAP_SIPPER", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "HEAD_CHARGE", "HORN_ATTACK", "RAGE" } },
    } },
    STAN = { partner = "R125_MAC", party = {
      { "KINGDRA", 39, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "SURF", "DIVE", "FOCUS_ENERGY", "PROTECT" } },
      { "FURRET", 39, ability = "RUN_AWAY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "CURSE", "ROLLOUT", "SLAM", "SCRATCH" } },
    } },
    PRESLEY = { partner = "R125_SKY", party = {
      { "TALONFLAME", 39, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "QUICK_ATTACK", "TAILWIND", "FLARE_BLITZ" } },
      { "GLIGAR", 39, ability = "IMMUNITY", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "ACROBATICS", "EARTHQUAKE", "KNOCK_OFF", "PROTECT" } },
    } },
    SHARON = { partner = "R125_ELA", party = {
      { "SEAKING", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", ev = 128, moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
      { "BARRASKEWDA", 39, ability = "PROPELLER_TAIL", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SURF", "DIVE", "CRUNCH", "AGILITY" } },
    } },
    KIM_AND_IRIS = { party = {
      { "ALTARIA", 39, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", ev = 128, moves = { "DRAGON_CLAW", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "RHYDON", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_SLIDE", "DRILL_RUN", "MEGAHORN", "PROTECT" } },
      { "EISCUE", 39, ability = "ICE_FACE", nature = "JOLLY", spread = "atk", item = "NEVER_MELT_ICE", ev = 128, moves = { "ICE_BEAM", "ICICLE_CRASH", "REFLECT", "HEADBUTT" } },
      { "ROTOM", 39, ability = "LEVITATE", nature = "TIMID", spread = "spa", ev = 128, moves = { "THUNDERBOLT", "HEX", "WILL_O_WISP", "THUNDER_WAVE" } },
    } },
    AURON = { partner = "R125_KEN", party = {
      { "MANECTRIC", 39, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "DISCHARGE", "FLAMETHROWER", "THUNDER_WAVE", "SNARL" } },
      { "CRABOMINABLE", 39, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", ev = 128, moves = { "CLOSE_COMBAT", "ICE_HAMMER", "ICE_PUNCH", "LEER" } },
    } },
    -- Trick Houses 5 and 6: tag battles at 39-40
    BENNY = { partner = "TH6_SKY", party = {
      { "SWELLOW", 39, ability = "GUTS", nature = "JOLLY", item = "FLAME_ORB", ev = 128, moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "XATU", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "AIR_SLASH", "TAILWIND", "CONFUSE_RAY" } },
      { "CHATOT", 39, ability = "KEEN_EYE", nature = "TIMID", ev = 128, moves = { "CHATTER", "ECHOED_VOICE", "PLUCK", "PECK" } },
    } },
    SEBASTIAN = { partner = "TH6_RAN", party = {
      { "CRUSTLE", 39, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "X_SCISSOR", "PROTECT", "ROCK_SLIDE", "STEALTH_ROCK" } },
      { "DONPHAN", 39, ability = "STURDY", nature = "ADAMANT", ev = 128, moves = { "EARTHQUAKE", "ICE_SHARD", "KNOCK_OFF", "RAPID_SPIN" } },
      { "FURFROU", 39, ability = "FUR_COAT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "BODY_SLAM", "TAKE_DOWN", "RETALIATE", "ODOR_SLEUTH" } },
    } },
    SOPHIA = { partner = "TH6_WEN", party = {
      { "FLAPPLE", 39, ability = "HUSTLE", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "DEFOG", "GRAV_APPLE", "DRAGON_PULSE", "DRAGON_BREATH" } },
      { "ORICORIO_POM_POM", 39, ability = "DANCER", nature = "TIMID", spread = "spa", ev = 128, moves = { "REVELATION_DANCE", "AIR_SLASH", "FEATHER_DANCE", "TEETER_DANCE" } },
      { "HIPPOWDON", 39, ability = "SAND_STREAM", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "HIGH_HORSEPOWER", "ROCK_SLIDE", "PROTECT", "DIG" } },
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
      { "DOUBLADE", 44, ability = "NO_GUARD", nature = "ADAMANT", moves = { "AUTOTOMIZE", "IRON_HEAD", "RETALIATE", "NIGHT_SLASH" } },
      { "GRENINJA", 44, ability = "PROTEAN", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DARK_PULSE", "ICE_BEAM", "PROTECT" } },
      { "CRAMORANT", 44, ability = "GULP_MISSILE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "FLY", "DRILL_PECK", "DIVE", "STOCKPILE" } },
    } },
    PABLO_1 = { partner = "R126_ACE", party = {
      { "KABUTOPS", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "ROCK_SLIDE", "AQUA_TAIL", "PROTECT" } },
      { "GOLDUCK", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "PSYCHIC", "DISABLE", "ICY_WIND" } },
      { "ALOMOMOLA", 44, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "WAKE_UP_SLAP", "AQUA_JET", "HEAL_PULSE" } },
    } },
    BRENDA = { partner = "R126_LIA", party = {
      { "FLOATZEL", 44, ability = "WATER_VEIL", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "AGILITY", "AQUA_TAIL", "CRUNCH" } },
      { "RAICHU", 44, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "WILD_CHARGE", "FEINT", "NASTY_PLOT" } },
    } },
    BARRY = { partner = "R126_GIL", party = {
      { "SWAMPERT", 44, ability = "TORRENT", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
      { "SIMISAGE", 44, ability = "GLUTTONY", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "LEECH_SEED", "SEED_BOMB", "LEAF_BLADE", "CRUNCH" } },
    } },
    DEAN = { partner = "R126_JON", party = {
      { "FRAXURE", 44, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "DRAGON_CLAW", "CRUNCH", "DRAGON_DANCE", "TAUNT" } },
      { "VICTREEBEL", 44, ability = "CHLOROPHYLL", nature = "ADAMANT", spread = "atk", moves = { "GIGA_DRAIN", "POISON_JAB", "LEAF_BLADE", "SWALLOW" } },
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
    } },
    ISAIAH_1 = { partner = "R126_SKY", party = {
      { "DODRIO", 44, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", moves = { "DRILL_PECK", "TRI_ATTACK", "FLY", "AGILITY" } },
      { "JOLTEON", 44, ability = "VOLT_ABSORB", nature = "TIMID", spread = "spa", item = "MAGNET", moves = { "THUNDERBOLT", "SHADOW_BALL", "PIN_MISSILE", "THUNDER_WAVE" } },
    } },
    ISOBEL = { partner = "R126_MIA", party = {
      { "AVALUGG", 44, ability = "STURDY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICE_FANG", "AVALANCHE", "ICICLE_CRASH", "ICY_WIND" } },
      { "BARBARACLE", 44, ability = "PICKPOCKET", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "SURF", "SKULL_BASH", "LIQUIDATION", "HONE_CLAWS" } },
    } },
    DONNY = { partner = "R126_DUN", party = {
      { "LARVESTA", 44, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "DOUBLE_EDGE", "LEECH_LIFE", "AMNESIA" } },
      { "BLASTOISE", 44, ability = "RAIN_DISH", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "ICE_BEAM", "FAKE_OUT", "PROTECT" } },
    } },
    KATELYN_1 = { partner = "R126_ELA", party = {
      { "PERSIAN", 44, ability = "UNNERVE", nature = "MODEST", item = "SCOPE_LENS", moves = { "BODY_SLAM", "FOCUS_ENERGY", "SWIFT", "SLASH" } },
      { "BOLTUND", 44, ability = "STRONG_JAW", nature = "JOLLY", item = "MAGNET", moves = { "WILD_CHARGE", "FLAME_CHARGE", "SPARK", "CHARGE" } },
    } },
    NIKKI = { partner = "R126_AMY", party = {
      { "CRYOGONAL", 44, ability = "LEVITATE", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
      { "AUDINO", 44, ability = "HEALER", nature = "BOLD", spread = "bulk", moves = { "EXTRASENSORY", "HELPING_HAND", "TAKE_DOWN", "DISARMING_VOICE" } },
    } },
    SIENNA = { partner = "R126_KIM", party = {
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "ADAMANT", moves = { "PROTECT", "ICICLE_CRASH", "RAZOR_SHELL", "ICE_SHARD" } },
      { "WHISCASH", 44, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "AMNESIA", "PROTECT" } },
      { "POLITOED", 44, ability = "DRIZZLE", nature = "MODEST", spread = "stank", item = "DAMP_ROCK", moves = { "SURF", "ICE_BEAM", "HYPNOSIS", "HELPING_HAND" } },
    } },
    CARLEE = { partner = "R126_PIA", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", moves = { "WATERFALL", "MEGAHORN", "AQUA_TAIL", "AGILITY" } },
      { "ORANGURU", 44, ability = "INNER_FOCUS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "PSYCHIC", "ZEN_HEADBUTT", "QUASH" } },
    } },
    LEONARDO = { partner = "R126_LEO", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_TAIL", "WATERFALL", "PROTECT", "BRINE" } },
      { "JELLICENT", 44, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", moves = { "PROTECT", "HYDRO_PUMP", "WATER_PULSE", "SHADOW_BALL" } },
    } },
    ATHENA = { partner = "R126_MAX", party = {
      { "INFERNAPE", 44, ability = "IRON_FIST", nature = "JOLLY", item = "CHARCOAL", moves = { "BLAZE_KICK", "FLAME_WHEEL", "MACH_PUNCH", "U_TURN" } },
      { "ESCAVALIER", 44, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", moves = { "BUG_BUZZ", "ACID_SPRAY", "ENCORE", "X_SCISSOR" } },
    } },
    HARRISON = { partner = "R126_BEN", party = {
      { "SNORLAX", 44, ability = "IMMUNITY", nature = "ADAMANT", spread = "tank", moves = { "BODY_SLAM", "ROLLOUT", "DEFENSE_CURL", "LAST_RESORT" } },
      { "OMASTAR", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ANCIENT_POWER", "SURF", "BITE", "PROTECT" } },
    } },
    JONAH = { partner = "R126_HAL", party = {
      { "CORSOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
      { "SALAZZLE", 44, ability = "OBLIVIOUS", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", moves = { "VENOSHOCK", "FLAMETHROWER", "SLUDGE_BOMB", "TORMENT" } },
    } },
    HENRY = { partner = "R126_NED", party = {
      { "TENTACRUEL", 44, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "ACID_SPRAY" } },
      { "MANTYKE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", moves = { "WATER_PULSE", "SURF", "AQUA_RING", "WIDE_GUARD" } },
    } },
    ROGER = { partner = "R126_MAC", party = {
      { "CRAWDAUNT", 44, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "RAZOR_SHELL", "KNOCK_OFF", "LIQUIDATION", "PROTECT" } },
      { "LUVDISC", 44, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "bulk", moves = { "MUD_SPORT", "BUBBLE_BEAM", "SURF", "DRAINING_KISS" } },
    } },
    KOJI_1 = { partner = "R126_KEN", party = {
      { "HARIYAMA", 44, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "MAGNETON", 44, ability = "MAGNET_PULL", nature = "IMPISH", spread = "stank", moves = { "PROTECT", "FLASH_CANNON", "DISCHARGE", "THUNDERBOLT" } },
    } },
    WAYNE = { partner = "R126_WES", party = {
      { "WAILORD", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "SPIRITOMB", 44, ability = "PRESSURE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "PROTECT", "SUCKER_PUNCH", "FEINT_ATTACK", "PHANTOM_FORCE" } },
    } },
    AIDAN = { partner = "R126_SKY2", party = {
      { "STARAPTOR", 44, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "PIDGEOT", 44, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
    } },
    ALEXA = { partner = "R126_ANN", party = {
      { "FERALIGATR", 44, ability = "SHEER_FORCE", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "AQUA_TAIL", "CRUNCH", "PROTECT" } },
      { "CRUSTLE", 44, ability = "SHELL_ARMOR", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "X_SCISSOR", "PROTECT", "ROCK_SLIDE", "STEALTH_ROCK" } },
      { "AMPHAROS", 44, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", moves = { "DISCHARGE", "DRAGON_PULSE", "POWER_GEM", "THUNDER_WAVE" } },
    } },
    RUBEN = { partner = "R126_RAN", party = {
      { "MEGANIUM", 44, ability = "OVERGROW", nature = "BOLD", spread = "bulk", moves = { "ENERGY_BALL", "LIGHT_SCREEN", "REFLECT", "SYNTHESIS" } },
      { "SLIGGOO", 44, ability = "SAP_SIPPER", nature = "MODEST", moves = { "DRAGON_PULSE", "DRAGON_BREATH", "PROTECT", "RAIN_DANCE" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
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
      { "SHELLDER", 44, ability = "SHELL_ARMOR", nature = "TIMID", moves = { "TACKLE", "RAZOR_SHELL", "LIQUIDATION", "WATER_GUN" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", moves = { "WATERFALL", "AQUA_TAIL", "DRAGON_DANCE", "PROTECT" } },
      { "GYARADOS", 44, ability = "INTIMIDATE", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "AQUA_TAIL", "DRAGON_DANCE", "PROTECT" } },
    } },
    FRANKLIN = { partner = "R130_LEO", party = {
      { "SEISMITOAD", 44, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "stank", moves = { "SURF", "MUDDY_WATER", "LIQUIDATION", "SUPERSONIC" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    JACK = { partner = "R130_BO", party = {
      { "LINOONE", 44, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", moves = { "EXTREME_SPEED", "SLASH", "ROCK_CLIMB", "PROTECT" } },
      { "FLOATZEL", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SCALD", "CRUNCH", "TAUNT", "AQUA_TAIL" } },
    } },
    HITOSHI = { partner = "R130_KEN", party = {
      { "PRIMEAPE", 44, ability = "ANGER_POINT", nature = "ADAMANT", item = "BLACK_BELT", moves = { "ICE_PUNCH", "CLOSE_COMBAT", "CROSS_CHOP", "KARATE_CHOP" } },
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "LUCARIO", 44, ability = "INNER_FOCUS", nature = "MODEST", moves = { "PAYBACK", "PROTECT", "AURA_SPHERE", "FORCE_PALM" } },
    } },
    KIYO = { partner = "R130_GOR", party = {
      { "PASSIMIAN", 44, ability = "RECEIVER", nature = "JOLLY", item = "SITRUS_BERRY", moves = { "ACROBATICS", "DRAIN_PUNCH", "CLOSE_COMBAT", "THRASH" } },
      { "GRAPPLOCT", 44, ability = "TECHNICIAN", nature = "JOLLY", moves = { "CLOSE_COMBAT", "SUBMISSION", "BRICK_BREAK", "BULK_UP" } },
      { "SAWK", 44, ability = "STURDY", nature = "ADAMANT", moves = { "ROCK_SLIDE", "BULK_UP", "FACADE", "CLOSE_COMBAT" } },
    } },
    ALEX = { partner = "R130_SKY", party = {
      { "FEAROW", 44, ability = "KEEN_EYE", nature = "JOLLY", moves = { "FACADE", "BRAVE_BIRD", "QUICK_ATTACK", "PROTECT" } },
      { "TOGEKISS", 44, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
    } },
    BECK = { partner = "R130_ACE", party = {
      { "WEAVILE", 44, ability = "PRESSURE", nature = "ADAMANT", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "ICICLE_CRASH", "NASTY_PLOT", "HONE_CLAWS" } },
      { "ALTARIA", 44, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", moves = { "FLY", "ICE_BEAM", "TAILWIND", "ROOST" } },
      { "NOCTOWL", 44, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "HYPER_VOICE", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    DEBRA = { partner = "R130_AMY", party = {
      { "ALOMOMOLA", 44, ability = "REGENERATOR", nature = "ADAMANT", item = "MYSTIC_WATER", moves = { "WATERFALL", "WAKE_UP_SLAP", "AQUA_JET", "HEAL_PULSE" } },
      { "POLITOED", 44, ability = "WATER_ABSORB", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "PROTECT", "HYDRO_PUMP", "WATER_PULSE" } },
    } },
    LINDA = { partner = "R130_LIA", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "ICE_BEAM", "PROTECT" } },
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    LAUREL = { partner = "R130_ELA", party = {
      { "LUVDISC", 44, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", moves = { "WATER_PULSE", "SURF", "CHARM", "AGILITY" } },
      { "QWILFISH", 44, ability = "INTIMIDATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SCALD", "PROTECT", "AQUA_TAIL", "POISON_JAB" } },
    } },
    KELVIN = { partner = "R130_WES", party = {
      { "MACHAMP", 44, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "SPIRITOMB", 44, ability = "PRESSURE", nature = "ADAMANT", moves = { "PROTECT", "SUCKER_PUNCH", "FEINT_ATTACK", "PHANTOM_FORCE" } },
    } },
    REYNA = { partner = "R130_ROX", party = {
      { "LOPUNNY", 44, ability = "CUTE_CHARM", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PROTECT", "JUMP_KICK", "DIZZY_PUNCH", "CIRCLE_THROW" } },
      { "HAWLUCHA", 44, ability = "LIMBER", nature = "ADAMANT", moves = { "ROCK_SMASH", "FLY", "QUICK_GUARD", "BRICK_BREAK" } },
    } },
    HUDSON = { partner = "R130_BEN", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "BIBAREL", 44, ability = "UNAWARE", nature = "JOLLY", moves = { "FACADE", "CRUNCH", "AQUA_TAIL", "TAKE_DOWN" } },
    } },
    RODNEY = { partner = "R131_GIL", party = {
      { "OCTILLERY", 44, ability = "SUCTION_CUPS", nature = "MODEST", moves = { "WATERFALL", "PROTECT", "HYDRO_PUMP", "OCTAZOOKA" } },
      { "WISHIWASHI", 44, ability = "SCHOOLING", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "MUDDY_WATER", "ICE_BEAM", "HELPING_HAND", "TEARFUL_LOOK" } },
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
      { "CRUSTLE", 44, ability = "SHELL_ARMOR", nature = "JOLLY", moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "ROCK_WRECKER" } },
      { "STUNFISK", 44, ability = "SAND_VEIL", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "THUNDERBOLT", "MUD_BOMB", "MUDDY_WATER", "MUD_SPORT" } },
    } },
    ALLISON = { partner = "R131_TOD", party = {
      { "STOUTLAND", 44, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", moves = { "GIGA_IMPACT", "LAST_RESORT", "TAKE_DOWN", "RETALIATE" } },
      { "VENOMOTH", 44, ability = "SHIELD_DUST", nature = "TIMID", spread = "spa", item = "SILVER_POWDER", moves = { "BUG_BUZZ", "SIGNAL_BEAM", "SILVER_WIND", "SLEEP_POWDER" } },
    } },
    KATIE = { partner = "R132_KIM", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "AQUA_TAIL", "AGILITY" } },
      { "AVALUGG", 44, ability = "STURDY", nature = "ADAMANT", item = "NEVER_MELT_ICE", moves = { "ICICLE_CRASH", "SKULL_BASH", "ICE_FANG", "IRON_DEFENSE" } },
    } },
    KARA = { partner = "R132_ZOE", party = {
      { "STANTLER", 44, ability = "INTIMIDATE", nature = "IMPISH", spread = "bulk", moves = { "TAKE_DOWN", "STOMP", "TACKLE", "JUMP_KICK" } },
      { "AZUMARILL", 44, ability = "HUGE_POWER", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "MUDDY_WATER", "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND" } },
    } },
    DANA = { partner = "R132_MIA", party = {
      { "SCOLIPEDE", 44, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "SLUDGE_BOMB", "CROSS_POISON", "DOUBLE_EDGE", "IRON_DEFENSE" } },
      { "PRIMARINA", 44, ability = "LIQUID_VOICE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "HYPER_VOICE", "MOONBLAST", "ICY_WIND", "PROTECT" } },
    } },
    CLARENCE = { partner = "R132_LEO", party = {
      { "RATICATE", 44, ability = "HUSTLE", nature = "ADAMANT", item = "SILK_SCARF", moves = { "QUICK_ATTACK", "PROTECT", "DOUBLE_EDGE", "HYPER_FANG" } },
      { "EMPOLEON", 44, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "FLASH_CANNON", "ICE_BEAM", "PROTECT" } },
    } },
    REED = { partner = "R132_BO", party = {
      { "SEISMITOAD", 44, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "stank", moves = { "SURF", "MUDDY_WATER", "LIQUIDATION", "RAIN_DANCE" } },
      { "SHARPEDO", 44, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    TISHA = { partner = "R132_ELA", party = {
      { "LANTURN", 44, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "AROMATISSE", 44, ability = "AROMA_VEIL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "DAZZLING_GLEAM", "CALM_MIND", "DRAINING_KISS", "MOONBLAST" } },
    } },
    RELI_AND_IAN = { party = {
      { "SWELLOW", 44, ability = "GUTS", nature = "ADAMANT", spread = "atk", item = "DAMP_ROCK", moves = { "HURRICANE", "TAILWIND", "PROTECT", "BRAVE_BIRD" } },
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
    } },
    MOLLIE = { partner = "R133_ZEN", party = {
      { "VICTREEBEL", 44, ability = "CHLOROPHYLL", nature = "JOLLY", spread = "atk", item = "MIRACLE_SEED", moves = { "SLUDGE_BOMB", "PROTECT", "LEAF_BLADE", "POISON_JAB" } },
      { "CARRACOSTA", 44, ability = "SOLID_ROCK", nature = "ADAMANT", moves = { "ROCK_SLIDE", "WATERFALL", "AQUA_TAIL", "PROTECT" } },
      { "SLURPUFF", 44, ability = "UNBURDEN", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "PROTECT", "DRAINING_KISS", "FAIRY_WIND", "ENERGY_BALL" } },
    } },
    AARON = { partner = "R133_DRA", party = {
      { "TURTONATOR", 44, ability = "SHELL_ARMOR", nature = "MODEST", moves = { "DRAGON_CLAW", "SHELL_TRAP", "FLAMETHROWER", "IRON_DEFENSE" } },
      { "TYRANTRUM", 44, ability = "STRONG_JAW", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "DRAGON_CLAW", "CRUNCH", "EARTHQUAKE" } },
      { "VESPIQUEN", 44, ability = "PRESSURE", nature = "JOLLY", spread = "atk", moves = { "AIR_SLASH", "TAILWIND", "ATTACK_ORDER", "BUG_BITE" } },
    } },
    CONOR = { partner = "R133_KEN", party = {
      { "HARIYAMA", 44, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "AMOONGUSS", 44, ability = "EFFECT_SPORE", nature = "RELAXED", spread = "tank", moves = { "PROTECT", "SOLAR_BEAM", "GIGA_DRAIN", "SEED_BOMB" } },
      { "REUNICLUS", 44, ability = "MAGIC_GUARD", nature = "CALM", spread = "spdef", moves = { "PSYCHIC", "TRICK_ROOM", "FUTURE_SIGHT", "SNATCH" } },
    } },
    PAXTON = { partner = "R133_GOR", party = {
      { "BRELOOM", 44, ability = "TECHNICIAN", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "MACH_PUNCH", "SKY_UPPERCUT", "SPORE", "ROCK_TOMB" } },
      { "URSARING", 44, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "TAKE_DOWN", "CLOSE_COMBAT", "CRUNCH", "PROTECT" } },
      { "ELECTIVIRE", 44, ability = "MOTOR_DRIVE", nature = "ADAMANT", item = "MAGNET", moves = { "WILD_CHARGE", "SWAGGER", "CROSS_CHOP", "THUNDER_PUNCH" } },
    } },
    MAKAYLA = { partner = "R133_WEN", party = {
      { "ELDEGOSS", 44, ability = "EFFECT_SPORE", nature = "BOLD", spread = "bulk", moves = { "GIGA_DRAIN", "LEAF_STORM", "LEAF_TORNADO", "SYNTHESIS" } },
      { "MEDICHAM", 44, ability = "PURE_POWER", nature = "JOLLY", item = "ORAN_BERRY", moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "FLAREON", 44, ability = "FLASH_FIRE", nature = "ADAMANT", item = "CHARCOAL", moves = { "FLARE_BLITZ", "QUICK_ATTACK", "SUPERPOWER", "HELPING_HAND" } },
    } },
    WARREN = { partner = "R133_ACE", party = {
      { "GOLEM_ALOLAN", 44, ability = "GALVANIZE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WILD_CHARGE", "BODY_SLAM", "EARTHQUAKE", "EXPLOSION" } },
      { "TORTERRA", 44, ability = "OVERGROW", nature = "ADAMANT", item = "MIRACLE_SEED", moves = { "SEED_BOMB", "EARTHQUAKE", "CRUNCH", "PROTECT" } },
      { "POLTEAGEIST", 44, ability = "WEAK_ARMOR", nature = "RELAXED", spread = "bulk", moves = { "SHADOW_BALL", "WILL_O_WISP", "PROTECT", "GIGA_DRAIN" } },
    } },
    HERMAN = { partner = "R134_GIL", party = {
      { "HERACROSS", 44, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", moves = { "MEGAHORN", "CLOSE_COMBAT", "KNOCK_OFF", "PROTECT" } },
      { "TOGEKISS", 44, ability = "HUSTLE", nature = "CALM", spread = "spdef", moves = { "PSYCHIC", "WISH", "PROTECT", "AIR_SLASH" } },
      { "COPPERAJAH", 44, ability = "SHEER_FORCE", nature = "RELAXED", spread = "bulk", item = "SITRUS_BERRY", moves = { "IRON_HEAD", "STRENGTH", "GROWL", "IRON_DEFENSE" } },
    } },
    SUSIE = { partner = "R134_ELA", party = {
      { "STARAPTOR", 44, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
      { "SCEPTILE", 44, ability = "OVERGROW", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "LEAF_BLADE", "DRAGON_CLAW", "ENERGY_BALL", "DETECT" } },
      { "FROSLASS", 44, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "NEVER_MELT_ICE", moves = { "ICE_BEAM", "ICE_PUNCH", "WILL_O_WISP", "PROTECT" } },
    } },
    MARLEY = { partner = "R134_MAX", party = {
      { "VENUSAUR", 44, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "ACCELGOR", 44, ability = "STICKY_HOLD", nature = "MODEST", moves = { "KNOCK_OFF", "PROTECT", "BUG_BUZZ", "STRUGGLE_BUG" } },
      { "PYROAR", 44, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", moves = { "FLARE_BLITZ", "CRUNCH", "PROTECT", "HYPER_BEAM" } },
    } },
    JONATHAN = { partner = "R134_DUN", party = {
      { "RAMPARDOS", 44, ability = "SHEER_FORCE", nature = "ADAMANT", item = "HARD_STONE", moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "CRUNCH", "PROTECT" } },
      { "CHARIZARD", 44, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
      { "ABOMASNOW", 44, ability = "SNOW_WARNING", nature = "JOLLY", item = "MIRACLE_SEED", moves = { "PROTECT", "WOOD_HAMMER", "ICE_PUNCH", "RAZOR_LEAF" } },
    } },
    DARCY = { partner = "R134_ANN", party = {
      { "CHARIZARD", 44, ability = "SOLAR_POWER", nature = "TIMID", spread = "spa", item = "CHARCOAL", moves = { "FLAMETHROWER", "AIR_SLASH", "DRAGON_PULSE", "PROTECT" } },
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
      { "BANETTE", 47, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "SHADOW_CLAW", "PHANTOM_FORCE", "KNOCK_OFF", "WILL_O_WISP" } },
      { "GOURGEIST", 47, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", ev = 128, moves = { "SHADOW_BALL", "MYSTICAL_FIRE", "CONFUSE_RAY", "PHANTOM_FORCE" } },
      { "REUNICLUS", 47, ability = "MAGIC_GUARD", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", ev = 128, moves = { "PSYCHIC", "TRICK_ROOM", "FUTURE_SIGHT", "HEAL_BLOCK" } },
    } },
    JOSHUA = { partner = "VR_P2", party = {
      { "ALAKAZAM", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "PROTECT" } },
      { "WHIMSICOTT", 47, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DAZZLING_GLEAM", "SOLAR_BEAM", "ENERGY_BALL", "TAILWIND" } },
      { "SIMISEAR", 47, ability = "GLUTTONY", nature = "ADAMANT", item = "CHARCOAL", ev = 128, moves = { "FLARE_BLITZ", "ROCK_SLIDE", "SUPERPOWER", "CRUNCH" } },
    } },
    ALEXIS = { partner = "VR_P3", party = {
      { "GARDEVOIR", 47, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "HYPNOSIS" } },
      { "AUDINO", 47, ability = "HEALER", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", ev = 128, moves = { "PSYCHIC", "HYPER_VOICE", "DOUBLE_EDGE", "TAKE_DOWN" } },
    } },
    MARIELA = { partner = "VR_P4", party = {
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "MUSHARNA", 47, ability = "FOREWARN", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "YAWN", "HEALING_WISH", "SYNCHRONOISE", "DREAM_EATER" } },
    } },
    ALVARO = { partner = "VR_P5", party = {
      { "GALLADE", 47, ability = "STEADFAST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SACRED_SWORD", "LEAF_BLADE", "DRAIN_PUNCH", "PROTECT" } },
      { "ORANGURU", 47, ability = "SYMBIOSIS", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "FUTURE_SIGHT", "QUASH", "INSTRUCT" } },
    } },
    EVERETT = { partner = "VR_P6", party = {
      { "WOBBUFFET", 47, ability = "SHADOW_TAG", nature = "BOLD", spread = "bulk", ev = 128, moves = { "COUNTER", "MIRROR_COAT", "SAFEGUARD", "DESTINY_BOND" } },
      { "SLOWBRO", 47, ability = "OWN_TEMPO", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "SHADOW_BALL", "TRICK_ROOM", "BUBBLE_BEAM" } },
    } },
    NICOLAS_1 = { partner = "VR_P7", party = {
      { "XATU", 47, ability = "SYNCHRONIZE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", ev = 128, moves = { "TAILWIND", "ROOST", "FUTURE_SIGHT", "PSYCHIC" } },
      { "FLYGON", 47, ability = "LEVITATE", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
    } },
    JOHN_AND_JAY_1 = { party = {
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
      { "MEDICHAM", 47, ability = "PURE_POWER", nature = "JOLLY", ev = 128, moves = { "FAKE_OUT", "ZEN_HEADBUTT", "DRAIN_PUNCH", "BULLET_PUNCH" } },
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "CRABOMINABLE", 47, ability = "IRON_FIST", nature = "MODEST", item = "BLACK_BELT", ev = 128, moves = { "CLOSE_COMBAT", "DYNAMIC_PUNCH", "HAMMER_ARM", "LEER" } },
    } },
    -- Victory Road: tag battles at 46-48
    ALBERT = { partner = "VR_A1", party = {
      { "MAGNEZONE", 47, ability = "STURDY", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "THUNDERBOLT", "FLASH_CANNON", "THUNDER_WAVE", "PROTECT" } },
      { "MUK", 47, ability = "POISON_TOUCH", nature = "ADAMANT", spread = "tank", item = "BLACK_SLUDGE", ev = 128, moves = { "GUNK_SHOT", "SHADOW_SNEAK", "ICE_PUNCH", "MINIMIZE" } },
      { "SANDACONDA", 47, ability = "SAND_SPIT", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "IRON_HEAD", "EARTHQUAKE", "ROCK_SLIDE", "PROTECT" } },
    } },
    HOPE = { partner = "VR_A2", party = {
      { "ROSERADE", 47, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
      { "TOGEKISS", 47, ability = "SERENE_GRACE", nature = "TIMID", spread = "spa", item = "SITRUS_BERRY", ev = 128, moves = { "AIR_SLASH", "DAZZLING_GLEAM", "FOLLOW_ME", "TAILWIND" } },
      { "PYROAR", 47, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", ev = 128, moves = { "FLARE_BLITZ", "CRUNCH", "PROTECT", "HYPER_BEAM" } },
    } },
    SHANNON = { partner = "VR_A3", party = {
      { "CLAYDOL", 47, ability = "LEVITATE", nature = "CALM", spread = "spdef", ev = 128, moves = { "DRILL_RUN", "PSYCHIC", "TRICK_ROOM", "REFLECT" } },
      { "CONKELDURR", 47, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "MACH_PUNCH", "HAMMER_ARM", "ROCK_SLIDE", "KNOCK_OFF" } },
      { "CLOYSTER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", ev = 128, moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
    } },
    SAMUEL = { partner = "VR_A4", party = {
      { "DODRIO", 47, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "DRILL_PECK", "TRI_ATTACK", "FLY", "AGILITY" } },
      { "CRUSTLE", 47, ability = "SHELL_ARMOR", nature = "ADAMANT", ev = 128, moves = { "X_SCISSOR", "PROTECT", "ROCK_WRECKER", "STEALTH_ROCK" } },
      { "GOLEM", 47, ability = "STURDY", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "ROCK_SLIDE", "EARTHQUAKE", "EXPLOSION", "PROTECT" } },
    } },
    JULIE = { partner = "VR_A5", party = {
      { "SANDACONDA", 47, ability = "SAND_VEIL", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "EARTHQUAKE", "ROCK_SLIDE", "SKULL_BASH", "DIG" } },
      { "NINETALES", 47, ability = "DROUGHT", nature = "TIMID", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAMETHROWER", "EXTRASENSORY", "CONFUSE_RAY", "WILL_O_WISP" } },
      { "VENUSAUR", 47, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", ev = 128, moves = { "GIGA_DRAIN", "SLUDGE_BOMB", "SLEEP_POWDER", "PROTECT" } },
    } },
    OWEN = { partner = "VR_A6", party = {
      { "BOUFFALANT", 47, ability = "SAP_SIPPER", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "HEAD_CHARGE", "HORN_ATTACK", "RAGE" } },
      { "GYARADOS", 47, ability = "MOXIE", nature = "ADAMANT", ev = 128, moves = { "WATERFALL", "AQUA_TAIL", "DRAGON_DANCE", "PROTECT" } },
      { "KOMALA", 47, ability = "COMATOSE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "THRASH", "SLAM" } },
    } },
    DIANNE = { partner = "VR_A7", party = {
      { "GRIMMSNARL", 47, ability = "FRISK", nature = "BOLD", spread = "bulk", ev = 128, moves = { "DAZZLING_GLEAM", "PROTECT", "FOUL_PLAY", "PLAY_ROUGH" } },
      { "LANTURN", 47, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", ev = 128, moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "EXPLOUD", 47, ability = "SCRAPPY", nature = "MODEST", spread = "spa", item = "SITRUS_BERRY", ev = 128, moves = { "TAKE_DOWN", "FLAMETHROWER", "ICE_BEAM", "PROTECT" } },
    } },
    FELIX = { partner = "VR_A8", party = {
      { "SWOOBAT", 47, ability = "UNAWARE", nature = "TIMID", ev = 128, moves = { "ZEN_HEADBUTT", "PSYCHIC", "PSYSHOCK", "ODOR_SLEUTH" } },
      { "CROBAT", 47, ability = "INNER_FOCUS", nature = "JOLLY", ev = 128, moves = { "FLY", "AIR_SLASH", "TAILWIND", "PROTECT" } },
      { "SHIFTRY", 47, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    CAROLINE = { partner = "VR_A9", party = {
      { "TOGEDEMARU", 47, ability = "LIGHTNING_ROD", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "VOLT_TACKLE", "WILD_CHARGE", "ZING_ZAP", "SPARK" } },
      { "SABLEYE", 47, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "FOUL_PLAY", "WILL_O_WISP", "KNOCK_OFF", "RECOVER" } },
      { "SALAMENCE", 47, ability = "INTIMIDATE", nature = "JOLLY", item = "SITRUS_BERRY", ev = 128, moves = { "DRAGON_CLAW", "ROCK_SLIDE", "FLY", "PROTECT" } },
    } },
    VITO = { partner = "VR_A10", party = {
      { "SAWSBUCK", 47, ability = "SAP_SIPPER", nature = "JOLLY", item = "MIRACLE_SEED", ev = 128, moves = { "AGILITY", "DOUBLE_EDGE", "TAKE_DOWN", "HORN_LEECH" } },
      { "KADABRA", 47, ability = "MAGIC_GUARD", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "SHADOW_BALL", "DAZZLING_GLEAM", "REFLECT" } },
      { "ELECTRODE", 47, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "THUNDERBOLT", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    MICHELLE = { partner = "VR_A11", party = {
      { "ORICORIO", 47, ability = "DANCER", nature = "ADAMANT", spread = "tank", item = "HEAT_ROCK", ev = 128, moves = { "PROTECT", "AIR_SLASH", "AIR_CUTTER", "HEAT_WAVE" } },
      { "STARMIE", 47, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
      { "LUDICOLO", 47, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "GIGA_DRAIN", "SURF", "ICE_BEAM" } },
    } },
    MITCHELL = { partner = "VR_A12", party = {
      { "SHUCKLE", 47, ability = "STURDY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "POWER_GEM", "ROCK_SLIDE", "BUG_BITE", "SHELL_SMASH" } },
      { "SOLROCK", 47, ability = "LEVITATE", nature = "BRAVE", item = "SITRUS_BERRY", ev = 128, moves = { "ROCK_SLIDE", "ZEN_HEADBUTT", "FLARE_BLITZ", "EXPLOSION" } },
    } },
    HALLE = { partner = "VR_A13", party = {
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", ev = 128, moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
      { "HARIYAMA", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", ev = 128, moves = { "FAKE_OUT", "CLOSE_COMBAT", "KNOCK_OFF", "WIDE_GUARD" } },
    } },
    EDGAR = { partner = "VR_A14", party = {
      { "FERROTHORN", 47, ability = "IRON_BARBS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "POWER_WHIP", "IRON_HEAD", "METAL_CLAW", "FLASH_CANNON" } },
      { "PELIPPER", 47, ability = "DRIZZLE", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", ev = 128, moves = { "HURRICANE", "SURF", "TAILWIND", "PROTECT" } },
    } },
    QUINCY = { partner = "VR_A15", party = {
      { "LAMPENT", 47, ability = "INFILTRATOR", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "WILL_O_WISP", "TRICK_ROOM", "PAIN_SPLIT", "INFERNO" } },
      { "SLAKING", 47, ability = "TRUANT", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "BODY_SLAM", "EARTHQUAKE", "SHADOW_CLAW", "SLACK_OFF" } },
    } },
    KATELYNN = { partner = "VR_A16", party = {
      { "HATTERENE", 47, ability = "ANTICIPATION", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYCHIC", "DRAINING_KISS", "DAZZLING_GLEAM", "PLAY_NICE" } },
      { "FLYGON", 47, ability = "LEVITATE", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "EARTHQUAKE", "DRAGON_CLAW", "ROCK_SLIDE", "U_TURN" } },
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
      { "BISHARP", 49, ability = "DEFIANT", nature = "ADAMANT", item = "WIDE_DARK_GEM", moves = { "IRON_HEAD", "KNOCK_OFF", "SUCKER_PUNCH", "PROTECT" } },
      { "CRAWDAUNT", 49, ability = "ADAPTABILITY", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "CRABHAMMER", "KNOCK_OFF", "AQUA_JET", "SWORDS_DANCE" } },
      { "MANDIBUZZ", 49, ability = "OVERCOAT", nature = "IMPISH", spread = "bulk", item = "SITRUS_BERRY", moves = { "TAILWIND", "FOUL_PLAY", "ROOST", "KNOCK_OFF" } },
      { "ABSOL", 50, ability = "SUPER_LUCK", nature = "JOLLY", item = "SCOPE_LENS", moves = { "NIGHT_SLASH", "SUPERPOWER", "PLAY_ROUGH", "SUCKER_PUNCH" } },
    } },
    PHOEBE = { tier = "leader", party = {
      { "SPIRITOMB", 51, ability = "INFILTRATOR", nature = "CAREFUL", spread = "spdef", item = "SITRUS_BERRY", moves = { "WILL_O_WISP", "PAIN_SPLIT", "SUCKER_PUNCH", "SHADOW_SNEAK" } },
      { "GENGAR", 51, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "WIDE_GHOST_GEM", moves = { "SHADOW_BALL", "SLUDGE_BOMB", "DESTINY_BOND", "PROTECT" } },
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
    -- Steven in Meteor Falls (post-game; vanilla species and levels, 2026-11-01):
    -- Tailwind and screens up front, Earthquake beside Flying, Levitate and a Balloon
    STEVEN = { tier = "leader", party = {
      { "SKARMORY", 77, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "LEFTOVERS", moves = { "TAILWIND", "BRAVE_BIRD", "IRON_HEAD", "ROOST" } },
      { "CLAYDOL", 75, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "LIGHT_CLAY", moves = { "REFLECT", "LIGHT_SCREEN", "EARTH_POWER", "PSYCHIC" } },
      { "AGGRON", 76, ability = "ROCK_HEAD", nature = "ADAMANT", spread = "tank", item = "AIR_BALLOON", moves = { "IRON_HEAD", "ROCK_SLIDE", "SUPERPOWER", "PROTECT" } },
      { "CRADILY", 76, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "GIGA_DRAIN", "POWER_GEM", "RECOVER", "PROTECT" } },
      { "ARMALDO", 76, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "FOCUS_SASH", moves = { "SWORDS_DANCE", "X_SCISSOR", "ROCK_SLIDE", "AQUA_JET" } },
      { "METAGROSS", 78, ability = "CLEAR_BODY", nature = "ADAMANT", item = "LIFE_ORB", moves = { "METEOR_MASH", "EARTHQUAKE", "BULLET_PUNCH", "PROTECT" } },
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
      { "LAPRAS", 60, ability = "HYDRATION", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "WATERFALL", "DRAGON_DANCE", "PROTECT", "HYDRO_PUMP" } },
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

  -- Steven beside the player at the Space Center (the ROM's stevenMons, so this
  -- is not TRAINER_STEVEN, his Meteor Falls team): vanilla's three and levels
  steven = { tier = "leader", party = {
    { "METANG", 42, ability = "CLEAR_BODY", nature = "ADAMANT", spread = "tank", item = "EVIOLITE", moves = { "METEOR_MASH", "ZEN_HEADBUTT", "BULLET_PUNCH", "PROTECT" } },
    { "SKARMORY", 43, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ROCKY_HELMET", moves = { "TAILWIND", "DRILL_PECK", "IRON_HEAD", "PROTECT" } },
    { "AGGRON", 44, ability = "ROCK_HEAD", nature = "ADAMANT", spread = "tank", item = "AIR_BALLOON", moves = { "IRON_HEAD", "ROCK_SLIDE", "SUPERPOWER", "PROTECT" } },
  } },

  partners = {
    R102_DALE = { like = "CALVIN_1", name = "DALE", defeat = "Aw, we were a good team, too!", party = {
      { "POLIWAG", 12, ability = "DAMP", nature = "MODEST", spread = "spa", moves = { "BUBBLE", "WATER_SPORT" } },
      { "SOLOSIS", 12, ability = "OVERCOAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "CONFUSION", "ROLLOUT", "RECOVER", "PROTECT" } },
    } },
    R102_OWEN = { like = "RICK", name = "OWEN", defeat = "My bugs got squished...", party = {
      { "DEWPIDER", 12, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "BUBBLE", "WATER_SPORT", "FURY_CUTTER", "SPIDER_WEB" } },
      { "VENIPEDE", 12, ability = "SPEED_BOOST", nature = "ADAMANT", moves = { "BUG_BITE", "ROLLOUT", "POISON_STING", "DEFENSE_CURL" } },
    } },
    R102_BEN = { like = "ALLEN", name = "BEN", defeat = "Rolling didn't work out...", party = {
      { "SENTRET", 12, ability = "RUN_AWAY", nature = "IMPISH", spread = "tank", moves = { "DEFENSE_CURL", "ROLLOUT", "SCRATCH", "QUICK_ATTACK" } },
      { "SEEDOT", 12, ability = "EARLY_BIRD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", moves = { "ABSORB", "BULLET_SEED", "HARDEN", "TACKLE" } },
    } },
    R102_DANA = { like = "TIANA", name = "DANA", defeat = "You two are too strong!", party = {
      { "HATENNA", 12, ability = "MAGIC_BOUNCE", nature = "MODEST", spread = "spa", moves = { "CONFUSION", "DISARMING_VOICE", "DOUBLE_TEAM", "PLAY_NICE" } },
      { "LOTAD", 12, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", moves = { "ABSORB", "BUBBLE", "ASTONISH", "GROWL" } },
    } },
    R104_SAM = { like = "BILLY", name = "SAM", defeat = "Next time we'll win!", party = {
      { "RATTATA", 12, ability = "GUTS", nature = "JOLLY", item = "ORAN_BERRY", moves = { "QUICK_ATTACK", "MUD_SLAP", "TACKLE", "TAIL_WHIP" } },
      { "LILLIPUP", 12, ability = "PICKUP", nature = "JOLLY", item = "SILK_SCARF", moves = { "LEER", "TACKLE", "BITE", "ODOR_SLEUTH" } },
    } },
    R104_NEIL = { like = "DARIAN", name = "NEIL", defeat = "The big one got away...", party = {
      { "PYUKUMUKU", 12, ability = "UNAWARE", nature = "JOLLY", spread = "atk", moves = { "BLOCK", "WATER_SPORT" } },
      { "MAGIKARP", 12, ability = "SWIFT_SWIM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SPLASH", "TACKLE" } },
    } },
    R104_PERCY = { like = "WINSTON_1", name = "PERCY", defeat = "Hmph. Money can't buy everything.", party = {
      { "LEDYBA", 12, ability = "SWARM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "STRUGGLE_BUG", "SWIFT", "SUPERSONIC", "REFLECT" } },
      { "STARLY", 12, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", moves = { "QUICK_ATTACK", "SAND_ATTACK", "TACKLE", "AERIAL_ACE" } },
    } },
    PW_WADE = { like = "LYLE", name = "WADE", defeat = "The woods are full of tough bugs... and you.", party = {
      { "COMBEE", 12, ability = "HONEY_GATHER", nature = "ADAMANT", item = "SILVER_POWDER", moves = { "GUST", "SWEET_SCENT", "DUAL_WINGBEAT" } },
      { "GRUBBIN", 12, ability = "SWARM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "BUG_BITE", "BITE", "VISE_GRIP", "STRING_SHOT" } },
    } },
    PW_COLE = { like = "JAMES_1", name = "COLE", defeat = "Our spores weren't enough!", party = {
      { "PARAS", 12, ability = "DRY_SKIN", nature = "JOLLY", spread = "atk", moves = { "STUN_SPORE", "STRUGGLE_BUG", "FELL_STINGER", "SCRATCH" } },
      { "LEDYBA", 12, ability = "SWARM", nature = "JOLLY", item = "ORAN_BERRY", moves = { "SWIFT", "STRUGGLE_BUG", "LIGHT_SCREEN", "REFLECT" } },
    } },
    R104_ROSA = { like = "CINDY_1", name = "ROSA", defeat = "My, how unladylike of me to lose.", party = {
      { "FERROSEED", 12, ability = "IRON_BARBS", nature = "ADAMANT", spread = "atk", moves = { "LEECH_SEED", "METAL_CLAW", "TACKLE", "HARDEN" } },
      { "MORELULL", 12, ability = "ILLUMINATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "LEECH_SEED", "ABSORB", "ASTONISH", "FLASH" } },
    } },
    R104_TARA = { like = "HALEY_1", name = "TARA", defeat = "Haley, they're too good!", party = {
      { "BOUNSWEET", 12, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", moves = { "RAPID_SPIN", "PLAY_NICE", "BULLET_SEED" } },
      { "RALTS", 12, ability = "TELEPATHY", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", moves = { "CONFUSION", "DISARMING_VOICE", "HYPNOSIS", "DOUBLE_TEAM" } },
    } },
    R104_HUGO = { like = "IVAN", name = "HUGO", defeat = "Reeled in by you two...", party = {
      { "POLIWAG", 12, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", moves = { "MUD_SHOT", "BUBBLE", "BUBBLE_BEAM", "HYPNOSIS" } },
      { "GOLDEEN", 12, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "HORN_ATTACK", "FLAIL", "SUPERSONIC", "PECK" } },
    } },
    -- Chapter 2 partners -----------------------------------------------------------------
    R116_TIM = { like = "JOEY", name = "TIM", defeat = "Joey, they're way better than us!", party = {
      { "FLETCHINDER", 16, ability = "GALE_WINGS", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "GROWL" } },
      { "ELEKID", 16, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "SHOCK_WAVE", "LEER", "THUNDER_SHOCK", "SWIFT" } },
    } },
    R116_GUS = { like = "JOSE", name = "GUS", defeat = "My bugs need more training...", party = {
      { "APPLIN", 16, ability = "RIPEN", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "ASTONISH", "WITHDRAW", "GRASSY_GLIDE" } },
      { "NINCADA", 16, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "MUD_SLAP", "BUG_BITE", "ABSORB", "SAND_ATTACK" } },
    } },
    R116_EMMA = { like = "KAREN_1", name = "EMMA", defeat = "We studied so hard for this!", party = {
      { "ELEKID", 16, ability = "STATIC", nature = "MODEST", spread = "spa", ev = 128, moves = { "SHOCK_WAVE", "THUNDER_WAVE", "SWIFT", "LEER" } },
      { "CHINGLING", 16, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "HELPING_HAND", "YAWN", "ASTONISH" } },
    } },
    R116_HANK = { like = "CLARK", name = "HANK", defeat = "Hard as rock, and still we lost!", party = {
      { "SILICOBRA", 16, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "MUD_SLAP", "BRUTAL_SWING", "BULLDOZE", "SAND_ATTACK" } },
      { "LARVITAR", 16, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "BITE", "PAYBACK", "SCARY_FACE" } },
    } },
    R116_OLAF = { like = "DEVAN", name = "OLAF", defeat = "Back to the tunnel for us...", party = {
      { "WHISMUR", 16, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", ev = 128, moves = { "ECHOED_VOICE", "DISARMING_VOICE", "POUND", "HOWL" } },
      { "COMBEE", 16, ability = "HONEY_GATHER", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "GUST", "TAILWIND", "BUG_BITE", "SWEET_SCENT" } },
    } },
    R116_RAY = { like = "JOHNSON", name = "RAY", defeat = "Aw, I wanted to win that one.", party = {
      { "CRABRAWLER", 16, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "COUNTER", "ROCK_SMASH", "PURSUIT", "LEER" } },
      { "POOCHYENA", 16, ability = "QUICK_FEET", nature = "JOLLY", item = "BLACK_GLASSES", ev = 128, moves = { "BITE", "THIEF", "HOWL", "SAND_ATTACK" } },
    } },
    R116_ELLA = { like = "SARAH", name = "ELLA", defeat = "How terribly rude of you to win.", party = {
      { "SIZZLIPEDE", 16, ability = "FLASH_FIRE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "FLAME_WHEEL", "EMBER", "BITE", "SMOKESCREEN" } },
      { "LOMBRE", 16, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", ev = 128, moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R116_REX = { like = "DAWSON", name = "REX", defeat = "Daddy will hear about this!", party = {
      { "STARYU", 16, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "RAPID_SPIN", "RECOVER", "CONFUSE_RAY" } },
      { "MAGNEMITE", 16, ability = "MAGNET_PULL", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "SHOCK_WAVE", "THUNDER_WAVE", "MAGNET_BOMB", "LIGHT_SCREEN" } },
    } },
    R116_LIAM = { like = "JERRY_1", name = "LIAM", defeat = "That wasn't in the textbook!", party = {
      { "TRUMBEAK", 16, ability = "KEEN_EYE", nature = "JOLLY", ev = 128, moves = { "AIR_CUTTER", "ROCK_SMASH", "PLUCK", "GROWL" } },
      { "EXEGGCUTE", 16, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BULLET_SEED", "LEECH_SEED", "HYPNOSIS", "REFLECT" } },
    } },
    R116_JUNE = { like = "JANICE", name = "JUNE", defeat = "Janice, they beat us both!", party = {
      { "WINGULL", 16, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "AERIAL_ACE", "SUPERSONIC", "MIST" } },
      { "DODUO", 16, ability = "RUN_AWAY", nature = "ADAMANT", ev = 128, moves = { "FEINT_ATTACK", "QUICK_ATTACK", "PECK", "PLUCK" } },
    } },
    R106_KAI = { like = "NED", name = "KAI", defeat = "Even the sea's on your side.", party = {
      { "SEEL", 16, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", ev = 128, moves = { "HEADBUTT", "FLIP_TURN", "ENCORE", "WATER_SPORT" } },
      { "PANPOUR", 16, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FLIP_TURN", "BITE", "SCRATCH", "WATER_SPORT" } },
    } },
    R106_ROY = { like = "ELLIOT_1", name = "ROY", defeat = "Nothing's biting today, huh.", party = {
      { "DUNSPARCE", 16, ability = "RATTLED", nature = "JOLLY", spread = "atk", ev = 128, moves = { "RAGE", "PURSUIT", "SPITE", "YAWN" } },
      { "PURRLOIN", 16, ability = "LIMBER", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FOUL_PLAY", "ASSURANCE", "PURSUIT", "GROWL" } },
    } },
    -- Chapter 3 partners -------------------------------------------------------------------
    R109_WES = { like = "HUEY", name = "WES", defeat = "Shiver me timbers!", party = {
      { "CLAUNCHER", 21, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ICY_WIND", "WATER_PULSE", "WATER_GUN", "WATER_SPORT" } },
      { "CORPHISH", 21, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "KNOCK_OFF", "AQUA_JET", "TAUNT" } },
    } },
    R109_PIP = { like = "EDMOND", name = "PIP", defeat = "Swabbed the deck with us, you did.", party = {
      { "BERGMITE", 21, ability = "ICE_BODY", nature = "ADAMANT", item = "NEVER_MELT_ICE", ev = 128, moves = { "AVALANCHE", "TAKE_DOWN", "BITE", "HARDEN" } },
      { "BUIZEL", 21, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "WATER_SPORT", "AQUA_JET", "PURSUIT" } },
    } },
    R109_DOT = { like = "HAILEY", name = "DOT", defeat = "My floatie popped...", party = {
      { "AZUMARILL", 21, ability = "HUGE_POWER", nature = "ADAMANT", ev = 128, moves = { "AQUA_JET", "WATER_PULSE", "DEFENSE_CURL", "HELPING_HAND" } },
      { "SEEL", 21, ability = "THICK_FAT", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "HEADBUTT", "FLIP_TURN", "ENCORE", "WATER_SPORT" } },
    } },
    R109_BO = { like = "RICKY_1", name = "BO", defeat = "Aww, sand in my shoes AND I lost.", party = {
      { "POLIWAG", 21, ability = "DAMP", nature = "MODEST", spread = "spa", ev = 128, moves = { "BUBBLE", "MUD_SHOT", "DOUBLE_SLAP", "BUBBLE_BEAM" } },
      { "GOLDEEN", 21, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FLIP_TURN", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R109_KIM = { like = "LOLA_1", name = "KIM", defeat = "Let's go build sandcastles instead.", party = {
      { "SPHEAL", 21, ability = "THICK_FAT", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_PULSE", "POWDER_SNOW", "DEFENSE_CURL", "ENCORE" } },
      { "JIGGLYPUFF", 21, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "DISARMING_VOICE", "SING", "COVET", "DEFENSE_CURL" } },
    } },
    R109_ZED = { like = "CHANDLER", name = "ZED", defeat = "The tide went out on us.", party = {
      { "TENTACOOL", 21, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SALANDIT", 21, ability = "OBLIVIOUS", nature = "CAREFUL", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "EMBER", "VENOSHOCK", "POISON_GAS", "SWEET_SCENT" } },
    } },
    R110_ANN = { like = "ISABEL_1", name = "ANN", defeat = "Our babies did their best!", party = {
      { "IMPIDIMP", 21, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", ev = 128, moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
      { "WOOLOO", 21, ability = "RUN_AWAY", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "TACKLE", "COVET", "COPYCAT", "GUARD_SPLIT" } },
    } },
    R110_GIL = { like = "KALEB", name = "GIL", defeat = "Zapped right back at us!", party = {
      { "PIKACHU", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
      { "TRANQUILL", 21, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "AIR_CUTTER", "GUST", "LEER" } },
    } },
    R110_OTTO = { like = "TIMMY", name = "OTTO", defeat = "I'll bike faster next time!", party = {
      { "DEERLING", 21, ability = "SAP_SIPPER", nature = "JOLLY", item = "MIRACLE_SEED", ev = 128, moves = { "AGILITY", "GRASSY_GLIDE", "FEINT_ATTACK", "LEECH_SEED" } },
      { "ZUBAT", 21, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R110_MOE = { like = "EDWIN_1", name = "MOE", defeat = "A rare loss for my collection.", party = {
      { "HONEDGE", 21, ability = "NO_GUARD", nature = "ADAMANT", ev = 128, moves = { "METAL_SOUND", "AUTOTOMIZE", "SHADOW_SNEAK", "PURSUIT" } },
      { "GLOOM", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R110_BRAD = { like = "JOSEPH", name = "BRAD", defeat = "Feedback! Total feedback!", party = {
      { "LOUDRED", 21, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "STOMP", "DISARMING_VOICE", "HOWL", "SCREECH" } },
      { "CLEFFA", 21, ability = "FRIEND_GUARD", nature = "MODEST", spread = "stank", ev = 128, moves = { "DISARMING_VOICE", "SING", "ROLLOUT", "DEFENSE_CURL" } },
    } },
    R110_VIC = { like = "EDWARD", name = "VIC", defeat = "I foresaw this. Sort of.", party = {
      { "ESPURR", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", ev = 128, moves = { "FAKE_OUT", "PSYBEAM", "CONFUSION", "LIGHT_SCREEN" } },
      { "MIME_JR", 21, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    R110_LIZ = { like = "ALYSSA", name = "LIZ", defeat = "You out-paced us both!", party = {
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "BITE", "HELPING_HAND" } },
      { "EELEKTRIK", 21, ability = "LEVITATE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "THUNDER_WAVE", "SPARK", "CHARGE_BEAM", "TACKLE" } },
    } },
    R110_HAL = { like = "DALE", name = "HAL", defeat = "Reeled in by kids again.", party = {
      { "TENTACOOL", 21, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "FRILLISH", 21, ability = "WATER_ABSORB", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BUBBLE_BEAM", "BUBBLE", "RAIN_DANCE", "WATER_SPORT" } },
    } },
    TH1_MIA = { like = "SALLY", name = "MIA", defeat = "This house is too tricky!", party = {
      { "MORELULL", 21, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "SKITTY", 21, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "COVET", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    TH1_ZOE = { like = "ROBIN", name = "ZOE", defeat = "Tricked us right back!", party = {
      { "WOOLOO", 21, ability = "RUN_AWAY", nature = "JOLLY", ev = 128, moves = { "TACKLE", "COVET", "COPYCAT", "GUARD_SPLIT" } },
      { "WINGULL", 21, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    TH1_KIP = { like = "EDDIE", name = "KIP", defeat = "Which way is the exit?", party = {
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "SAND_ATTACK" } },
      { "ELEKID", 21, ability = "STATIC", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
    } },
    R103_FAY = { like = "DAISY", name = "FAY", defeat = "What a lovely, lovely loss.", party = {
      { "GLOOM", 21, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "ACID", "SLEEP_POWDER", "STUN_SPORE" } },
      { "SKIPLOOM", 21, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "SEED_BOMB", "BULLET_SEED", "ABSORB", "TACKLE" } },
    } },
    R103_GUY = { like = "MIGUEL_1", name = "GUY", defeat = "My precious Pokémon!", party = {
      { "TRANQUILL", 21, ability = "BIG_PECKS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "AIR_CUTTER", "GUST", "GROWL" } },
      { "PIKACHU", 21, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    R103_FINN = { like = "ANDREW", name = "FINN", defeat = "That one got away from me.", party = {
      { "SEEL", 21, ability = "THICK_FAT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "HEADBUTT", "FLIP_TURN", "ENCORE", "WATER_SPORT" } },
      { "GOLDEEN", 21, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FLIP_TURN", "BUBBLE_BEAM", "SUPERSONIC", "AGILITY" } },
    } },
    R103_JAX = { like = "MARCOS", name = "JAX", defeat = "Our set got cut short!", party = {
      { "STARAVIA", 21, ability = "INTIMIDATE", nature = "MODEST", spread = "stank", ev = 128, moves = { "AERIAL_ACE", "TACKLE", "QUICK_ATTACK", "GROWL" } },
      { "VOLTORB", 21, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "EERIE_IMPULSE", "SCREECH" } },
    } },
    R103_DUKE = { like = "RHETT", name = "DUKE", defeat = "Hrrah! I yield!", party = {
      { "MACHOP", 21, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "MACHOP", 21, ability = "GUTS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "KARATE_CHOP" } },
    } },
    CR_NOVA = { like = "JACLYN", name = "NOVA", defeat = "I didn't see that coming...", party = {
      { "ESPURR", 21, ability = "INFILTRATOR", nature = "TIMID", spread = "spa", ev = 128, moves = { "FAKE_OUT", "PSYBEAM", "DISARMING_VOICE", "LIGHT_SCREEN" } },
      { "MIME_JR", 21, ability = "TECHNICIAN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "HYPNOSIS", "CONFUSION", "POUND", "TICKLE" } },
    } },
    CR_TOD = { like = "JACOB", name = "TOD", defeat = "Out-pedaled AND out-battled.", party = {
      { "DODUO", 21, ability = "EARLY_BIRD", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "PLUCK", "DOUBLE_HIT", "QUICK_ATTACK", "AGILITY" } },
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "BITE" } },
    } },
    CR_WIN = { like = "ANTHONY", name = "WIN", defeat = "We blew a fuse!", party = {
      { "BLITZLE", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", ev = 128, moves = { "QUICK_ATTACK", "SPARK", "CHARGE", "SHOCK_WAVE" } },
      { "PINCURCHIN", 21, ability = "ELECTRIC_SURGE", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "ENDURE", "PECK", "CHARGE" } },
    } },
    CR_ACE = { like = "BENJAMIN_1", name = "ACE", defeat = "Can't win 'em all on the road.", party = {
      { "FLAAFFY", 21, ability = "STATIC", nature = "MODEST", spread = "spa", item = "MAGNET", ev = 128, moves = { "SHOCK_WAVE", "COTTON_SPORE", "THUNDER_WAVE", "TAKE_DOWN" } },
      { "HERDIER", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
    } },
    CR_ADA = { like = "ABIGAIL_1", name = "ADA", defeat = "That was electrifying. For you.", party = {
      { "MORPEKO", 21, ability = "HUNGER_SWITCH", nature = "JOLLY", spread = "atk", ev = 128, moves = { "THUNDER_WAVE", "THUNDER_FANG", "THUNDER_SHOCK", "QUICK_ATTACK" } },
      { "PLUSLE", 21, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "SHOCK_WAVE", "HELPING_HAND", "ENCORE" } },
    } },
    CR_SKY = { like = "JASMINE", name = "SKY", defeat = "Wind's against us today.", party = {
      { "BLITZLE", 21, ability = "LIGHTNING_ROD", nature = "JOLLY", spread = "atk", ev = 128, moves = { "QUICK_ATTACK", "SPARK", "CHARGE", "SHOCK_WAVE" } },
      { "BINACLE", 21, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "CLAMP", "ANCIENT_POWER", "WATER_GUN", "SCRATCH" } },
    } },
    R117_KAI = { like = "DEREK", name = "TOBY", defeat = "My bugs... squashed.", party = {
      { "DWEBBLE", 21, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SMACK_DOWN", "FURY_CUTTER", "BUG_BITE", "WITHDRAW" } },
      { "KRICKETUNE", 21, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "MEGA_DRAIN", "SING", "TAUNT" } },
    } },
    R117_LEE = { like = "DYLAN_1", name = "LEE", defeat = "Lap time: too slow.", party = {
      { "HERDIER", 21, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "TACKLE", "WORK_UP", "BABY_DOLL_EYES" } },
      { "GROWLITHE", 21, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
    } },
    R117_MAE = { like = "MARIA_1", name = "MAE", defeat = "We'll train harder for the next race.", party = {
      { "LARVESTA", 21, ability = "FLAME_BODY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "BUG_BITE", "FLAME_CHARGE", "EMBER", "TAKE_DOWN" } },
      { "WOOBAT", 21, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    R117_ROX = { like = "MELINA", name = "ROX", defeat = "Hit the wall at the last mile.", party = {
      { "ELEKID", 21, ability = "STATIC", nature = "MODEST", item = "MAGNET", ev = 128, moves = { "LEER", "SHOCK_WAVE", "THUNDER_SHOCK", "SWIFT" } },
      { "FLETCHINDER", 21, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "FLAME_CHARGE" } },
    } },
    R117_IVY = { like = "BRANDI", name = "IVY", defeat = "The future was cloudy today.", party = {
      { "KADABRA", 21, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SHOCK_WAVE", "DISABLE", "REFLECT" } },
      { "GOTHITA", 21, ability = "COMPETITIVE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "PROTECT", "CONFUSION", "EMBARGO" } },
    } },
    R117_JO = { like = "AISHA", name = "JO", defeat = "You hit harder than we do!", party = {
      { "TIMBURR", 21, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "ROCK_THROW", "MACH_PUNCH", "LOW_SWEEP", "BULK_UP" } },
      { "CRABRAWLER", 21, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SMASH", "PURSUIT", "LEER", "BUBBLE_BEAM" } },
    } },
    R111_ABE = { like = "TYRON", name = "ABE", defeat = "Our campfire's out.", party = {
      { "LITLEO", 21, ability = "RIVALRY", nature = "MODEST", item = "CHARCOAL", ev = 128, moves = { "HELPING_HAND", "ROAR", "INCINERATE", "EMBER" } },
      { "NINCADA", 21, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "MUD_SLAP", "FURY_SWIPES", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R111_NIA = { like = "CELINA", name = "NIA", defeat = "Such a sweet scent of defeat.", party = {
      { "MORELULL", 21, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "FLASH" } },
      { "SKIPLOOM", 21, ability = "INFILTRATOR", nature = "ADAMANT", item = "MIRACLE_SEED", ev = 128, moves = { "SEED_BOMB", "BULLET_SEED", "ABSORB", "TACKLE" } },
    } },
    R111_PIA = { like = "BIANCA", name = "PIA", defeat = "Picnic's ruined!", party = {
      { "SKWOVET", 21, ability = "GLUTTONY", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "BODY_SLAM", "TACKLE", "SWALLOW", "STUFF_CHEEKS" } },
      { "TEDDIURSA", 21, ability = "QUICK_FEET", nature = "ADAMANT", item = "SILK_SCARF", ev = 128, moves = { "COVET", "FEINT_ATTACK", "FURY_SWIPES", "FAKE_TEARS" } },
    } },
    R111_CY = { like = "HAYDEN", name = "CY", defeat = "Burnt out, just like that.", party = {
      { "ARBOK", 21, ability = "INTIMIDATE", nature = "JOLLY", spread = "atk", item = "POISON_BARB", ev = 128, moves = { "POISON_FANG", "POISON_STING", "BITE", "SCREECH" } },
      { "HOUNDOUR", 21, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "EMBER", "BITE", "INCINERATE", "HOWL" } },
    } },
    -- Chapter 4 partners -----------------------------------------------------------------------
    R112_BUD = { like = "LARRY", name = "BUD", defeat = "Back to camp for us.", party = {
      { "RUFFLET", 26, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "AERIAL_ACE", "TAILWIND", "HONE_CLAWS" } },
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    R112_SUE = { like = "CAROL", name = "SUE", defeat = "Our picnic basket's empty...", party = {
      { "JIGGLYPUFF", 26, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "SECRET_POWER", "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE" } },
      { "SKITTY", 26, ability = "WONDER_SKIN", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "DISARMING_VOICE", "SING", "HELPING_HAND" } },
    } },
    R112_GUS = { like = "BRICE", name = "GUS", defeat = "Rock solid, and still cracked.", party = {
      { "MACHOP", 26, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
      { "ONIX", 26, ability = "ROCK_HEAD", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "BLOCK", "HARDEN", "ROCK_SLIDE" } },
    } },
    R112_ROB = { like = "TRENT_1", name = "ROB", defeat = "Rockslide... on us.", party = {
      { "GRAVELER", 26, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "CARKOL", 26, ability = "STEAM_ENGINE", nature = "ADAMANT", spread = "atk", item = "HARD_STONE", ev = 128, moves = { "ROCK_BLAST", "SMACK_DOWN", "STEALTH_ROCK", "RAPID_SPIN" } },
    } },
    R112_ASH = { like = "BRYANT", name = "ASH", defeat = "Snuffed out!", party = {
      { "HOUNDOOM", 26, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "EMBER", "BITE", "INCINERATE", "HOWL" } },
      { "PANSEAR", 26, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "FLAME_BURST", "INCINERATE", "FLAME_CHARGE" } },
    } },
    R112_LIL = { like = "SHAYLA", name = "LIL", defeat = "The flowers wilted on us.", party = {
      { "STEENEE", 26, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "MAGICAL_LEAF", "RAZOR_LEAF", "RAPID_SPIN", "SWEET_SCENT" } },
      { "SPOINK", 26, ability = "THICK_FAT", nature = "MODEST", spread = "spa", ev = 128, moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R113_PIP = { like = "JAYLEN", name = "PIP", defeat = "Ash in my eyes!", party = {
      { "DRILBUR", 26, ability = "MOLD_BREAKER", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "RAPID_SPIN", "FURY_CUTTER", "BULLDOZE", "METAL_CLAW" } },
      { "SPINDA", 26, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    R113_TAD = { like = "DILLON", name = "TAD", defeat = "We're covered in soot and loss.", party = {
      { "EMOLGA", 26, ability = "STATIC", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "SHOCK_WAVE", "SPARK", "TAIL_WHIP" } },
      { "NINCADA", 26, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "MUD_SLAP", "SKITTER_SMACK", "BUG_BITE", "SAND_ATTACK" } },
    } },
    R113_ZEN = { like = "LAO_1", name = "ZEN", defeat = "Our stealth was not enough.", party = {
      { "SHUPPET", 26, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "SECRET_POWER", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "PARASECT", 26, ability = "EFFECT_SPORE", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SKITTER_SMACK", "AERIAL_ACE", "PROTECT", "SLASH" } },
    } },
    R113_KO = { like = "LUNG", name = "KO", defeat = "Smoked out ourselves.", party = {
      { "ESCAVALIER", 26, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BUZZ", "DOUBLE_TEAM", "DOUBLE_EDGE", "BUG_BITE" } },
      { "GRIMER", 26, ability = "STICKY_HOLD", nature = "ADAMANT", ev = 128, moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R113_UMA = { like = "MADELINE_1", name = "UMA", defeat = "My parasol's full of ash.", party = {
      { "DODUO", 26, ability = "RUN_AWAY", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "PLUCK", "QUICK_ATTACK", "GROWL" } },
    } },
    R113_BEA = { like = "SOPHIE", name = "BEA", defeat = "Dessert is cancelled!", party = {
      { "SANDSLASH_ALOLAN", 26, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "NEVER_MELT_ICE", ev = 128, moves = { "AVALANCHE", "METAL_CLAW", "RAPID_SPIN", "DEFENSE_CURL" } },
      { "DUNSPARCE", 26, ability = "RATTLED", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "BODY_SLAM", "RAGE", "PURSUIT", "SPITE" } },
    } },
    R113_TAO = { like = "COBY", name = "TAO", defeat = "Grounded, both of us.", party = {
      { "SWABLU", 26, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "AERIAL_ACE", "SING", "MIST" } },
      { "SWELLOW", 26, ability = "SCRAPPY", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "AIR_CUTTER", "WING_ATTACK", "EXTREME_SPEED", "GROWL" } },
    } },
    R113_RIO = { like = "LAWRENCE", name = "RIO", defeat = "The desert wind beat us.", party = {
      { "RHYHORN", 26, ability = "ROCK_HEAD", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "SMACK_DOWN", "TAIL_WHIP", "SCARY_FACE" } },
      { "CACNEA", 26, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    R113_MAX = { like = "WYATT", name = "MAX", defeat = "My rare ones weren't rare enough.", party = {
      { "NIDORINA", 26, ability = "POISON_POINT", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "POISON_FANG", "DOUBLE_KICK", "BITE", "HELPING_HAND" } },
      { "SALANDIT", 26, ability = "CORROSION", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "EMBER", "VENOSHOCK", "POISON_GAS", "SWEET_SCENT" } },
    } },
    R114_HAL = { like = "STEVE_1", name = "HAL", defeat = "Fossil-fueled and still lost.", party = {
      { "YANMA", 26, ability = "SPEED_BOOST", nature = "MODEST", item = "SILVER_POWDER", ev = 128, moves = { "PROTECT", "AIR_CUTTER", "AERIAL_ACE", "FORESIGHT" } },
      { "LILEEP", 26, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "ANCIENT_POWER", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    R114_ED = { like = "BERNIE_1", name = "ED", defeat = "Burned out by the river.", party = {
      { "DARUMAKA", 26, ability = "HUSTLE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "INCINERATE", "FIRE_FANG", "FACADE", "TAUNT" } },
      { "LOMBRE", 26, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_IKE = { like = "SHANE", name = "IKE", defeat = "Sore losers, the pair of us.", party = {
      { "SEVIPER", 26, ability = "SHED_SKIN", nature = "MODEST", spread = "spa", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "POISON_FANG", "BITE", "SCREECH" } },
      { "ACCELGOR", 26, ability = "STICKY_HOLD", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "PURSUIT", "STRUGGLE_BUG", "SWIFT", "YAWN" } },
    } },
    R114_JEB = { like = "CLAUDE", name = "JEB", defeat = "The big one bit back.", party = {
      { "GOOMY", 26, ability = "SAP_SIPPER", nature = "MODEST", ev = 128, moves = { "DRAGON_BREATH", "BUBBLE", "PROTECT", "ABSORB" } },
      { "LOMBRE", 26, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "BUBBLE", "ASTONISH", "MIST" } },
    } },
    R114_GUY = { like = "NOLAN", name = "GUY", defeat = "Only minnows today.", party = {
      { "CLAUNCHER", 26, ability = "MEGA_LAUNCHER", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "BUBBLE_BEAM", "BUBBLE", "WATER_SPORT", "WATER_GUN" } },
      { "LAPRAS", 26, ability = "WATER_ABSORB", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ICE_SHARD", "AVALANCHE" } },
    } },
    R114_FLO = { like = "NANCY", name = "FLO", defeat = "Oh dear, oh dear.", party = {
      { "RUFFLET", 26, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", ev = 128, moves = { "SECRET_POWER", "AERIAL_ACE", "TAILWIND", "HONE_CLAWS" } },
      { "NUZLEAF", 26, ability = "CHLOROPHYLL", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "FEINT_ATTACK", "GROWTH", "HARDEN" } },
    } },
    R114_OZ = { like = "LENNY", name = "OZ", defeat = "Avalanche of defeat.", party = {
      { "SWINUB", 26, ability = "SNOW_CLOAK", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "ROCK_TOMB", "BULLDOZE", "DEFENSE_CURL", "ICE_SHARD" } },
      { "MACHOP", 26, ability = "NO_GUARD", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    R114_BOB = { like = "LUCAS_1", name = "BOB", defeat = "Meteor shower of losses.", party = {
      { "NOSEPASS", 26, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "THUNDER_WAVE", "BLOCK", "HARDEN" } },
      { "LUNATONE", 26, ability = "LEVITATE", nature = "MODEST", ev = 128, moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "PSYSHOCK" } },
    } },
    R114_MEL = { like = "ANGELINA", name = "MEL", defeat = "No fair, you two!", party = {
      { "ARAQUANID", 26, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "BUBBLE_BEAM", "SKITTER_SMACK", "BITE", "SPIDER_WEB" } },
      { "CORVISQUIRE", 26, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    R114_NED = { like = "KAI", name = "NED", defeat = "Let's call it a day.", party = {
      { "BARBOACH", 26, ability = "HYDRATION", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BULLDOZE", "MUD_BOMB", "MUD_SPORT", "WATER_SPORT" } },
      { "TENTACOOL", 26, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R114_ROE = { like = "CHARLOTTE", name = "ROE", defeat = "My garden's been trampled.", party = {
      { "SHIFTRY", 26, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", ev = 128, moves = { "MEGA_DRAIN", "EXPLOSION", "KNOCK_OFF", "NATURE_POWER" } },
      { "SPOINK", 26, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115_KEN = { like = "NOB_1", name = "KEN", defeat = "Osu! A fine defeat.", party = {
      { "MACHOP", 26, ability = "GUTS", nature = "ADAMANT", ev = 128, moves = { "LOW_KICK", "BULK_UP", "LOW_SWEEP", "REVENGE" } },
      { "SWELLOW", 26, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "SECRET_POWER", "PURSUIT", "TAILWIND" } },
    } },
    R115_DON = { like = "HECTOR", name = "DON", defeat = "A gap in my collection.", party = {
      { "SWELLOW", 26, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "SECRET_POWER", "ROOST", "TAILWIND" } },
      { "PIDGEOTTO", 26, ability = "BIG_PECKS", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "AERIAL_ACE", "SECRET_POWER", "QUICK_ATTACK" } },
    } },
    R115_EVE = { like = "MARLENE", name = "EVE", defeat = "I sensed this would happen.", party = {
      { "CLEFFA", 26, ability = "MAGIC_GUARD", nature = "MODEST", spread = "spa", item = "PIXIE_PLATE", ev = 128, moves = { "DISARMING_VOICE", "MAGICAL_LEAF", "ENCORE", "COPYCAT" } },
      { "CHIMECHO", 26, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R115_JAN = { like = "CYNDY_1", name = "JAN", defeat = "Hyah! We'll train harder!", party = {
      { "CRABRAWLER", 26, ability = "IRON_FIST", nature = "ADAMANT", ev = 128, moves = { "ROCK_SMASH", "POWER_UP_PUNCH", "LEER", "PURSUIT" } },
      { "JANGMO_O", 26, ability = "BULLETPROOF", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_TAIL", "HEADBUTT", "SCARY_FACE", "PROTECT" } },
    } },
    MC_BRAM = { like = "SAWYER_1", name = "BRAM", defeat = "Like a boulder down the mountain.", party = {
      { "GRAVELER", 26, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "ORICORIO", 26, ability = "DANCER", nature = "RELAXED", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "CURSE", "PROTECT", "AIR_CUTTER", "PECK" } },
    } },
    MC_LIV = { like = "MELISSA", name = "LIV", defeat = "Not a hair out of place, and still lost.", party = {
      { "CASTFORM", 26, ability = "FORECAST", nature = "TIMID", item = "SILK_SCARF", ev = 128, moves = { "HEADBUTT", "EMBER", "POWDER_SNOW", "SUNNY_DAY" } },
      { "IMPIDIMP", 26, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "ASSURANCE", "FLATTER", "FAKE_TEARS" } },
    } },
    MC_FAE = { like = "SHEILA", name = "FAE", defeat = "How very unglamorous.", party = {
      { "WATCHOG", 26, ability = "ANALYTIC", nature = "JOLLY", ev = 128, moves = { "HELPING_HAND", "SECRET_POWER", "CRUNCH", "DETECT" } },
      { "TOGETIC", 26, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    MC_DEE = { like = "SHIRLEY", name = "DEE", defeat = "Our dance fell flat.", party = {
      { "SIGILYPH", 26, ability = "WONDER_SKIN", nature = "TIMID", spread = "spa", ev = 128, moves = { "AIR_CUTTER", "PSYBEAM", "GRAVITY", "MIRACLE_EYE" } },
      { "DEERLING", 26, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "LEECH_SEED" } },
    } },
    MC_RUE = { like = "SHELBY_1", name = "RUE", defeat = "Well fought. Truly.", party = {
      { "SWOOBAT", 26, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
      { "CHIMECHO", 26, ability = "LEVITATE", nature = "MODEST", spread = "spa", ev = 128, moves = { "CONFUSION", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    JP_COL = { like = "ERIC", name = "COL", defeat = "Down the pass we go.", party = {
      { "DWEBBLE", 26, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_TOMB", "BLOCK", "BUG_BITE", "SKITTER_SMACK" } },
      { "MACHOKE", 26, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "WAKE_UP_SLAP", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
    } },
    JP_IDA = { like = "AUTUMN", name = "IDA", defeat = "The leaves are falling. So are we.", party = {
      { "XATU", 26, ability = "SYNCHRONIZE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "PECK", "OMINOUS_WIND", "AIR_CUTTER", "CONFUSE_RAY" } },
      { "NUMEL", 26, ability = "SIMPLE", nature = "MODEST", spread = "spa", item = "CHARCOAL", ev = 128, moves = { "FLAME_BURST", "EMBER", "AMNESIA", "MAGNITUDE" } },
    } },
    JP_ROD = { like = "JULIO", name = "ROD", defeat = "Out of breath and out of Pokémon.", party = {
      { "SPOINK", 26, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
      { "FLETCHINDER", 26, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    JP_BEL = { like = "DIANA_1", name = "BEL", defeat = "The view was nice, at least.", party = {
      { "CORVISQUIRE", 26, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
      { "MANKEY", 26, ability = "ANGER_POINT", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "KARATE_CHOP", "LOW_SWEEP", "REVENGE", "ROCK_TOMB" } },
    } },
    JP_GUS = { like = "ETHAN_1", name = "WALT", defeat = "Cold camp tonight.", party = {
      { "ORICORIO", 26, ability = "DANCER", nature = "RELAXED", spread = "stank", ev = 128, moves = { "CURSE", "PROTECT", "AIR_CUTTER", "PECK" } },
      { "SPINDA", 26, ability = "OWN_TEMPO", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "DIZZY_PUNCH", "PSYBEAM", "HYPNOSIS" } },
    } },
    -- Chapter 5: Lavaridge to Norman (draft 1, 2026-10-27; cap 31): partners ----------------------------------------
    R111N_ROY = { like = "TRAVIS", name = "ROY", defeat = "Dusty boots, dusty loss.", party = {
      { "HIPPOPOTAS", 26, ability = "SAND_FORCE", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "SAND_TOMB", "DIG", "CRUNCH", "SAND_ATTACK" } },
      { "SWABLU", 26, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "AERIAL_ACE", "SING", "MIST" } },
    } },
    R111N_ADA = { like = "IRENE", name = "ADA", defeat = "Oh, my picnic!", party = {
      { "SHIINOTIC", 26, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "LEECH_SEED", "MEGA_DRAIN", "ABSORB", "MOONLIGHT" } },
      { "PICHU", 26, ability = "STATIC", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "NUZZLE", "THUNDER_SHOCK", "SWEET_KISS", "CHARM" } },
    } },
    R111N_ZED = { like = "WILTON_1", name = "ZED", defeat = "Cool under pressure, still lost.", party = {
      { "HONEDGE", 26, ability = "NO_GUARD", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SHADOW_CLAW", "AERIAL_ACE", "METAL_SOUND", "AUTOTOMIZE" } },
      { "AXEW", 26, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DUAL_CHOP", "BITE", "ASSURANCE", "TAUNT" } },
    } },
    R111N_MAY = { like = "BROOKE_1", name = "MAYA", defeat = "We were so in sync, too.", party = {
      { "STARYU", 26, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
      { "CORVISQUIRE", 26, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
    } },
    R111N_KEN = { like = "DAISUKE", name = "KENJI", defeat = "Osu! Respect.", party = {
      { "CLOBBOPUS", 26, ability = "LIMBER", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "REVENGE", "ROCK_SMASH", "FEINT", "BIND" } },
      { "WOOBAT", 26, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "AIR_CUTTER", "IMPRISON", "ODOR_SLEUTH" } },
    } },
    TH2_OLI = { like = "PAUL", name = "OLI", defeat = "Lost in here AND lost the battle.", party = {
      { "POLIWHIRL", 26, ability = "DAMP", nature = "ADAMANT", spread = "atk", item = "SCOPE_LENS", ev = 128, moves = { "BUBBLE_BEAM", "BODY_SLAM", "DOUBLE_SLAP", "RAIN_DANCE" } },
      { "PIKACHU", 26, ability = "STATIC", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "NUZZLE", "FEINT", "QUICK_ATTACK" } },
    } },
    TH2_ABI = { like = "TED", name = "ABI", defeat = "The Trick Master would laugh at us.", party = {
      { "CHINGLING", 26, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "MAGIC_COAT", "CONFUSION", "LAST_RESORT", "YAWN" } },
      { "LEDIAN", 26, ability = "EARLY_BIRD", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "MACH_PUNCH", "SILVER_WIND", "REFLECT", "LIGHT_SCREEN" } },
    } },
    TH2_ZAC = { like = "GEORGIA", name = "ZAC", defeat = "We got tricked by you!", party = {
      { "STUNFISK", 26, ability = "SAND_VEIL", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "MUD_BOMB", "MUD_SHOT", "THUNDER_SHOCK", "MUD_SLAP" } },
      { "ILLUMISE", 26, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SILVER_WIND", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    DES_RAE = { like = "DUSTY_1", name = "RAE", defeat = "The ruins keep their secrets.", party = {
      { "BALTOY", 28, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "BULLDOZE", "ROCK_TOMB", "REFLECT" } },
      { "DRILBUR", 28, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_HAL = { like = "DREW", name = "HAL", defeat = "Buried in sand!", party = {
      { "TRAPINCH", 28, ability = "ARENA_TRAP", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "BITE", "SAND_TOMB", "FEINT_ATTACK" } },
      { "DRILBUR", 28, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_IKE = { like = "BEAU", name = "IKE", defeat = "Sandblasted.", party = {
      { "SILICOBRA", 28, ability = "SAND_SPIT", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "HEADBUTT", "MINIMIZE", "GLARE" } },
      { "KINGLER", 28, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "HIDDEN_POWER", "RAZOR_SHELL", "STOMP" } },
    } },
    DES_FLO = { like = "HEIDI", name = "FLO", defeat = "Goggles fogged up, sorry!", party = {
      { "CARNIVINE", 28, ability = "LEVITATE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "SYNTHESIS", "SWEET_SCENT", "RAZOR_LEAF" } },
      { "KROKOROK", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
    } },
    DES_LEA = { like = "BECKY", name = "LEA", defeat = "Too hot, too cold, too strong.", party = {
      { "CORVISQUIRE", 28, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "PECK", "TAUNT", "HONE_CLAWS" } },
      { "CACNEA", 28, ability = "SAND_VEIL", nature = "MODEST", spread = "spa", item = "MIRACLE_SEED", ev = 128, moves = { "NEEDLE_ARM", "PIN_MISSILE", "LEECH_SEED", "SAND_ATTACK" } },
    } },
    DES_NIA = { like = "CELIA", name = "NIA", defeat = "The desert dried out our hopes.", party = {
      { "SANDSLASH", 28, ability = "SAND_RUSH", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "RAPID_SPIN", "FURY_CUTTER", "BULLDOZE", "DEFENSE_CURL" } },
      { "DRILBUR", 28, ability = "SAND_RUSH", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
    } },
    DES_OTT = { like = "BRYAN", name = "OTTO", defeat = "Unearthed and defeated.", party = {
      { "ANORITH", 28, ability = "BATTLE_ARMOR", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ANCIENT_POWER", "BUG_BITE", "METAL_CLAW", "PROTECT" } },
      { "SNOVER", 28, ability = "SOUNDPROOF", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "RAZOR_LEAF", "ICE_SHARD", "LEAFAGE", "ICY_WIND" } },
    } },
    DES_GIL = { like = "BRANDEN", name = "GILL", defeat = "Lost in the dunes.", party = {
      { "KROKOROK", 28, ability = "INTIMIDATE", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "BITE", "SAND_TOMB", "TORMENT" } },
      { "MUDBRAY", 28, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BULLDOZE", "HIGH_HORSEPOWER", "MUD_SPORT", "ROTOTILLER" } },
    } },
    TH3_MO = { like = "JUSTIN", name = "MO", defeat = "I can see the exit from here!", party = {
      { "DRILBUR", 28, ability = "SAND_FORCE", nature = "ADAMANT", spread = "atk", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "CRUSH_CLAW", "SLASH", "MUD_SPORT" } },
      { "SWABLU", 28, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "DISARMING_VOICE", "SECRET_POWER", "SING", "MIST" } },
    } },
    TH3_BO = { like = "MARTHA", name = "BOE", defeat = "Third time is not a charm.", party = {
      { "DEERLING", 28, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "JUMP_KICK" } },
      { "SPOINK", 28, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    TH3_AL = { like = "ALAN", name = "AL", defeat = "Hard as rock, soft as sand.", party = {
      { "GRAVELER", 28, ability = "STURDY", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ROCK_TOMB", "BULLDOZE", "ROLLOUT", "DEFENSE_CURL" } },
      { "GURDURR", 28, ability = "GUTS", nature = "ADAMANT", ev = 128, moves = { "REVENGE", "ROCK_TOMB", "BULK_UP", "WAKE_UP_SLAP" } },
    } },
    -- Chapter 6a: sea routes, ship, Route 115 north, Route 118, Trick House 4 (draft 1, 2026-10-27): partners ----------------------------------------
    R118_IKE = { like = "WADE", name = "IKE", defeat = "Big one got away.", party = {
      { "KRABBY", 21, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "VISE_GRIP" } },
      { "WINGULL", 21, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    R118_POE = { like = "DEANDRE", name = "POE", defeat = "Dug ourselves a hole there.", party = {
      { "SILICOBRA", 21, ability = "SAND_VEIL", nature = "JOLLY", item = "SOFT_SAND", ev = 128, moves = { "BULLDOZE", "HEADBUTT", "SAND_ATTACK", "MINIMIZE" } },
      { "LINOONE", 21, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R118_IVY = { like = "ROSE_1", name = "IVY", defeat = "The petals scattered.", party = {
      { "BURMY", 21, ability = "SHED_SKIN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "BUG_BUZZ", "TACKLE", "PROTECT" } },
      { "STEENEE", 21, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "MAGICAL_LEAF", "RAZOR_LEAF", "RAPID_SPIN", "SWEET_SCENT" } },
    } },
    R118_REX = { like = "DALTON_1", name = "REX", defeat = "Encore? No thanks.", party = {
      { "KRICKETUNE", 21, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", ev = 128, moves = { "BUG_BITE", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "JOLTIK", 21, ability = "UNNERVE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "ELECTROWEB", "BUG_BITE", "FURY_CUTTER", "ABSORB" } },
    } },
    SEA_ORR = { like = "LUIS", name = "ORR", defeat = "Glub glub, we lost.", party = {
      { "BARRASKEWDA", 32, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_PULSE", "PROTECT", "DIVE", "AQUA_JET" } },
      { "AZUMARILL", 32, ability = "HUGE_POWER", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
    } },
    SEA_GIL = { like = "DOMINIK", name = "GIL", defeat = "Sank like a stone.", party = {
      { "TENTACRUEL", 32, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
      { "SEEL", 32, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", ev = 128, moves = { "FLIP_TURN", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
    } },
    SEA_JON = { like = "DOUGLAS", name = "JON", defeat = "Cramp! I lost!", party = {
      { "WAILMER", 32, ability = "OBLIVIOUS", nature = "MODEST", spread = "stank", ev = 128, moves = { "WATER_PULSE", "WHIRLPOOL", "ROLLOUT", "ASTONISH" } },
      { "CLAUNCHER", 32, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
    } },
    SEA_AMY = { like = "BEVERLY", name = "AMY", defeat = "Washed ashore again.", party = {
      { "CLAUNCHER", 32, ability = "MEGA_LAUNCHER", nature = "TIMID", spread = "spa", ev = 128, moves = { "BUBBLE_BEAM", "BUBBLE", "SWORDS_DANCE", "WATER_SPORT" } },
      { "SEALEO", 32, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BRINE", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SEA_ZOE = { like = "IMANI", name = "ZOE", defeat = "Too tired to swim back.", party = {
      { "FLOATZEL", 32, ability = "WATER_VEIL", nature = "ADAMANT", ev = 128, moves = { "WATERFALL", "AGILITY", "AQUA_JET", "QUICK_ATTACK" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SEA_FAY = { like = "KYLA", name = "FAY", defeat = "The current took us.", party = {
      { "PYUKUMUKU", 32, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_SPORT", "PURIFY" } },
      { "CORSOLA", 32, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "ROCK_BLAST", "AQUA_RING" } },
    } },
    SEA_RAE = { like = "FOSTER", name = "RAE", defeat = "History repeats: we lost.", party = {
      { "BRONZOR", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "ROCK_TOMB", "REFLECT", "EXTRASENSORY", "CONFUSION" } },
      { "KABUTO", 32, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "ANCIENT_POWER", "MUD_SHOT", "PROTECT" } },
    } },
    SEA_OTT = { like = "ANDRES_1", name = "OTTO", defeat = "Fossilized in defeat.", party = {
      { "BINACLE", 32, ability = "TOUGH_CLAWS", nature = "ADAMANT", item = "HARD_STONE", ev = 128, moves = { "ANCIENT_POWER", "RAZOR_SHELL", "PROTECT", "SLASH" } },
      { "LILEEP", 32, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "GIGA_DRAIN", "MEGA_DRAIN", "CONFUSE_RAY", "INGRAIN" } },
    } },
    SEA_SKY = { like = "JOSUE", name = "SKY", defeat = "Clipped our wings.", party = {
      { "BARRASKEWDA", 32, ability = "SWIFT_SWIM", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_PULSE", "PROTECT", "DIVE", "AQUA_JET" } },
      { "SWABLU", 32, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "DISARMING_VOICE", "SECRET_POWER", "SING", "MIST" } },
    } },
    SEA_KIM = { like = "TARA", name = "KIM", defeat = "I need a lifeguard.", party = {
      { "JIGGLYPUFF", 32, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "SECRET_POWER" } },
      { "STARYU", 32, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_LEO = { like = "DARRIN", name = "LEO", defeat = "Gulls and jellies, all beaten.", party = {
      { "KINGLER", 32, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "STOMP" } },
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
    } },
    SEA_MAC = { like = "TONY_1", name = "MAC", defeat = "Out-swum!", party = {
      { "BRUXISH", 32, ability = "STRONG_JAW", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "BITE", "CRUNCH", "DISABLE" } },
      { "CRAWDAUNT", 32, ability = "ADAPTABILITY", nature = "ADAMANT", item = "MYSTIC_WATER", ev = 128, moves = { "BUBBLE_BEAM", "KNOCK_OFF", "RAZOR_SHELL", "TAUNT" } },
    } },
    SEA_HAL = { like = "JEROME", name = "HAL", defeat = "Brr, and beaten.", party = {
      { "LOMBRE", 32, ability = "SWIFT_SWIM", nature = "IMPISH", spread = "tank", ev = 128, moves = { "WATER_GUN", "GIGA_DRAIN", "BUBBLE_BEAM", "MIST" } },
      { "TENTACRUEL", 32, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    SEA_DUN = { like = "MATTHEW", name = "DUNN", defeat = "Riding the wave out.", party = {
      { "CRAWDAUNT", 32, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_PULSE", "PROTECT", "NIGHT_SLASH", "KNOCK_OFF" } },
      { "LANTURN", 32, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "RISING_VOLTAGE", "SPARK", "THUNDER_WAVE", "CONFUSE_RAY" } },
    } },
    SEA_ELA = { like = "DENISE", name = "ELA", defeat = "My goggles are full of water.", party = {
      { "AZUMARILL", 32, ability = "HUGE_POWER", nature = "ADAMANT", ev = 128, moves = { "DRAINING_KISS", "AQUA_TAIL", "DEFENSE_CURL", "HELPING_HAND" } },
      { "GASTRODON", 32, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "ICY_WIND", "PROTECT", "BUBBLE_BEAM" } },
    } },
    SEA_BEN = { like = "CORY_1", name = "BEN", defeat = "Aye, we sank.", party = {
      { "STARYU", 32, ability = "NATURAL_CURE", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "WATER_PULSE", "ROLLOUT", "BRINE", "BUBBLE_BEAM" } },
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "TAILWIND", "PROTECT" } },
    } },
    SEA_LIA = { like = "MISSY", name = "LIA", defeat = "Pearls before swine...", party = {
      { "PYUKUMUKU", 32, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_SPORT", "PURIFY" } },
      { "STARYU", 32, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    SEA_PIA = { like = "CAROLINA", name = "PIA", defeat = "Cool heads, hot loss.", party = {
      { "GOLDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
      { "ELECTABUZZ", 32, ability = "STATIC", nature = "MODEST", item = "MAGNET", ev = 128, moves = { "LEER", "SHOCK_WAVE", "RISING_VOLTAGE", "SWIFT" } },
    } },
    SEA_UMA = { like = "BETH", name = "UMA", defeat = "Swam into a wall.", party = {
      { "CLAUNCHER", 32, ability = "MEGA_LAUNCHER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "ICY_WIND", "BUBBLE_BEAM", "BUBBLE", "WATER_GUN" } },
      { "SEADRA", 32, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "SCOPE_LENS", ev = 128, moves = { "BUBBLE_BEAM", "TWISTER", "SMOKESCREEN", "FOCUS_ENERGY" } },
    } },
    SEA_TOD = { like = "CAMRON", name = "TOD", defeat = "Last leg, lost leg.", party = {
      { "SEEL", 32, ability = "THICK_FAT", nature = "JOLLY", item = "MYSTIC_WATER", ev = 128, moves = { "FLIP_TURN", "HEADBUTT", "ICE_SHARD", "WATER_SPORT" } },
      { "PIKACHU", 32, ability = "LIGHTNING_ROD", nature = "JOLLY", item = "LIGHT_BALL", ev = 128, moves = { "SPARK", "THUNDER_PUNCH", "FEINT", "QUICK_ATTACK" } },
    } },
    SHIP_BO = { like = "JANI", name = "BO", defeat = "This ship is spooky AND I lost!", party = {
      { "JIGGLYPUFF", 32, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "SECRET_POWER" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    SHIP_WES = { like = "DUNCAN", name = "WES", defeat = "Abandon ship!", party = {
      { "PELIPPER", 32, ability = "KEEN_EYE", nature = "TIMID", spread = "spa", ev = 128, moves = { "AIR_SLASH", "AIR_CUTTER", "SUPERSONIC", "PROTECT" } },
      { "LUMINEON", 32, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "BUBBLE_BEAM", "FLIP_TURN", "POUND" } },
    } },
    SHIP_RIO = { like = "GARRISON", name = "RIO", defeat = "Sunk treasure, sunk hopes.", party = {
      { "MANTYKE", 32, ability = "SWIFT_SWIM", nature = "MODEST", ev = 128, moves = { "PROTECT", "WATER_PULSE", "BUBBLE_BEAM", "AIR_SLASH" } },
      { "BALTOY", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "BULLDOZE", "ROCK_TOMB", "REFLECT" } },
    } },
    SHIP_DOT = { like = "CHARLIE", name = "DOT", defeat = "Waaah, my floatie!", party = {
      { "JIGGLYPUFF", 32, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "SECRET_POWER" } },
      { "SEALEO", 32, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BRINE", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    SHIP_LIV = { like = "THALIA_1", name = "LIV", defeat = "How dreadfully unfashionable.", party = {
      { "SPRITZEE", 32, ability = "HEALER", nature = "BOLD", spread = "bulk", ev = 128, moves = { "FAIRY_WIND", "DRAINING_KISS", "ODOR_SLEUTH", "CALM_MIND" } },
      { "DEERLING", 32, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "JUMP_KICK" } },
    } },
    SHIP_KIP = { like = "DEMETRIUS", name = "KIP", defeat = "Ghosts AND you? No fair.", party = {
      { "SANDYGAST", 32, ability = "SAND_VEIL", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "BULLDOZE", "SAND_TOMB", "SCORCHING_SANDS", "MEGA_DRAIN" } },
      { "DUSKULL", 32, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    R109S_ANN = { like = "GWEN", name = "ANNE", defeat = "I want my mommy!", party = {
      { "JIGGLYPUFF", 32, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "DEFENSE_CURL", "HELPING_HAND", "DISARMING_VOICE", "SECRET_POWER" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R109S_EVE = { like = "ALICE", name = "EVE", defeat = "Sea salt and sore losses.", party = {
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "WATER_PULSE", "BUBBLE_BEAM", "WATER_GUN", "SCREECH" } },
      { "STARYU", 32, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "SWIFT", "RECOVER", "THUNDER_WAVE" } },
    } },
    R109S_KIT = { like = "AUSTINA", name = "KIT", defeat = "Splash! I lost.", party = {
      { "IGGLYBUFF", 32, ability = "COMPETITIVE", nature = "MODEST", ev = 128, moves = { "CHARM", "HELPING_HAND", "DRAINING_KISS", "COPYCAT" } },
      { "SEALEO", 32, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "BRINE", "DEFENSE_CURL", "WATER_GUN", "ENCORE" } },
    } },
    R109S_GUS = { like = "DAVID", name = "GUS", defeat = "Swept away!", party = {
      { "KINGLER", 32, ability = "HYPER_CUTTER", nature = "JOLLY", spread = "atk", ev = 128, moves = { "RAZOR_SHELL", "BUBBLE", "WATER_GUN", "STOMP" } },
      { "SHARPEDO", 32, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "BITE", "NIGHT_SLASH", "ICE_FANG", "PROTECT" } },
    } },
    R109S_NED = { like = "CARTER", name = "NED", defeat = "Line snapped.", party = {
      { "CLAUNCHER", 32, ability = "MEGA_LAUNCHER", nature = "MODEST", ev = 128, moves = { "WATERFALL", "BUBBLE_BEAM", "BUBBLE", "SWORDS_DANCE" } },
      { "WHISCASH", 32, ability = "OBLIVIOUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "MUD_BOMB", "AQUA_TAIL", "AMNESIA", "PROTECT" } },
    } },
    R109S_ACE = { like = "ELIJAH", name = "ACE", defeat = "Grounded!", party = {
      { "SWELLOW", 32, ability = "GUTS", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "SECRET_POWER", "TAILWIND", "PROTECT", "WING_ATTACK" } },
      { "SWELLOW", 32, ability = "SCRAPPY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "SECRET_POWER", "ROOST", "TAILWIND" } },
    } },
    R103S_MEG = { like = "ISABELLE", name = "MEG", defeat = "Out of breath!", party = {
      { "PYUKUMUKU", 32, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "WATER_SPORT", "PURIFY" } },
      { "CLAMPERL", 32, ability = "SHELL_ARMOR", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_GUN", "CLAMP", "WHIRLPOOL", "BRINE" } },
    } },
    R103S_SAM = { like = "PETE", name = "SAMI", defeat = "Gulp. Lost.", party = {
      { "SEALEO", 32, ability = "OBLIVIOUS", nature = "MODEST", spread = "spa", ev = 128, moves = { "WATER_PULSE", "PROTECT", "BRINE", "AURORA_BEAM" } },
      { "TENTACRUEL", 32, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ACID", "TOXIC_SPIKES", "SUPERSONIC" } },
    } },
    R115N_DAN = { like = "KOICHI", name = "DAN", defeat = "Our fists were not enough.", party = {
      { "MACHOKE", 32, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "BRICK_BREAK", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "WOOBAT", 32, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSION", "PSYSHOCK", "AIR_CUTTER", "IMPRISON" } },
    } },
    R115N_JO = { like = "KYRA", name = "JO", defeat = "Finish line? What finish line?", party = {
      { "GROWLITHE", 32, ability = "FLASH_FIRE", nature = "JOLLY", item = "CHARCOAL", ev = 128, moves = { "FLAME_WHEEL", "FLAME_CHARGE", "DOUBLE_KICK", "FIRE_FANG" } },
      { "FLETCHINDER", 32, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    R115N_KO = { like = "JAIDEN", name = "KOTA", defeat = "Vanished... in defeat.", party = {
      { "STUNKY", 32, ability = "AFTERMATH", nature = "ADAMANT", ev = 128, moves = { "MUD_SLAP", "BITE", "VENOSHOCK", "ACID_SPRAY" } },
      { "GOLBAT", 32, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R115N_VIC = { like = "ALIX", name = "VIC", defeat = "My dreams said we would win.", party = {
      { "DODRIO", 32, ability = "TANGLED_FEET", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "PLUCK", "QUICK_ATTACK", "SECRET_POWER", "DOUBLE_HIT" } },
      { "GRUMPIG", 32, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R115N_ROX = { like = "HELENE", name = "ROX", defeat = "Hyah... we lost.", party = {
      { "PANCHAM", 32, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "LOW_SWEEP", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
      { "SKORUPI", 32, ability = "SNIPER", nature = "ADAMANT", item = "POISON_BARB", ev = 128, moves = { "VENOSHOCK", "TAUNT", "BUG_BITE", "SKITTER_SMACK" } },
    } },
    R115N_KEN = { like = "TIMOTHY_1", name = "KENT", defeat = "Expertly beaten.", party = {
      { "GURDURR", 32, ability = "GUTS", nature = "ADAMANT", ev = 128, moves = { "REVENGE", "ROCK_TOMB", "BULK_UP", "WAKE_UP_SLAP" } },
      { "GARDEVOIR", 32, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
    } },
    R118E_HAL = { like = "BARNY", name = "HALE", defeat = "Caught nothing but defeat.", party = {
      { "SLOWPOKE", 32, ability = "OBLIVIOUS", nature = "ADAMANT", ev = 128, moves = { "AQUA_TAIL", "PROTECT", "HEADBUTT", "TACKLE" } },
      { "SKRELP", 32, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "BUBBLE_BEAM", "POISON_TAIL", "BUBBLE" } },
    } },
    R118E_JAY = { like = "PERRY", name = "JAY", defeat = "Ruffled feathers all around.", party = {
      { "DUCKLETT", 32, ability = "KEEN_EYE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WING_ATTACK", "AERIAL_ACE", "WATER_PULSE", "AIR_SLASH" } },
      { "SWELLOW", 32, ability = "GUTS", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "SECRET_POWER", "PURSUIT", "TAILWIND" } },
    } },
    R118E_KAY = { like = "CHESTER", name = "KAY", defeat = "Shot down!", party = {
      { "CRAMORANT", 32, ability = "GULP_MISSILE", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "AIR_CUTTER", "TAILWIND", "DIVE", "PLUCK" } },
      { "NOCTOWL", 32, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "AIR_SLASH", "HYPNOSIS", "REFLECT" } },
    } },
    TH4_ZIA = { like = "CORA", name = "ZIA", defeat = "Tricked AND punched.", party = {
      { "HARIYAMA", 32, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "FAKE_OUT", "FORCE_PALM", "KNOCK_OFF", "BRICK_BREAK" } },
      { "CRABRAWLER", 32, ability = "IRON_FIST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SMASH", "DRAIN_PUNCH", "MACH_PUNCH", "DIZZY_PUNCH" } },
    } },
    TH4_MAE = { like = "PAULA", name = "MAE", defeat = "Strength wasn't the answer.", party = {
      { "MACHOKE", 32, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "BRICK_BREAK", "REVENGE", "ROCK_TOMB", "BULK_UP" } },
      { "PANCHAM", 32, ability = "MOLD_BREAKER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "LOW_SWEEP", "VITAL_THROW", "CIRCLE_THROW", "LEER" } },
    } },
    TH4_GOR = { like = "YUJI", name = "GORO", defeat = "Oss! Defeated!", party = {
      { "THROH", 32, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
      { "SAWK", 32, ability = "STURDY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SEISMIC_TOSS", "BULK_UP", "ROCK_TOMB", "BRICK_BREAK" } },
    } },
    -- Chapter 6b: Route 119 to Winona (draft 1, 2026-10-27; caps 32, 33, 34): partners ----------------------------------------
    R119_BO = { like = "CHRIS", name = "BO", defeat = "Rain or shine, we lose.", party = {
      { "PHIONE", 32, ability = "HYDRATION", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "DIVE", "BUBBLE" } },
      { "LOMBRE", 32, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "BUBBLE", "GIGA_DRAIN", "MIST" } },
    } },
    R119_GUS = { like = "DONALD", name = "GUS", defeat = "My net has a hole in it.", party = {
      { "NINCADA", 32, ability = "COMPOUND_EYES", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "MUD_SLAP", "SKITTER_SMACK", "BUG_BITE", "SAND_ATTACK" } },
      { "ARAQUANID", 32, ability = "WATER_BUBBLE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "LEECH_LIFE", "BUG_BITE", "WATER_SPORT" } },
    } },
    R119_TED = { like = "TAYLOR", name = "TED", defeat = "Squashed in the grass.", party = {
      { "KRICKETUNE", 32, ability = "TECHNICIAN", nature = "ADAMANT", item = "SILVER_POWDER", ev = 128, moves = { "SECRET_POWER", "MEGA_DRAIN", "SING", "TAUNT" } },
      { "DWEBBLE", 32, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
    } },
    R119_CY = { like = "HUGH", name = "CY", defeat = "Feathers everywhere.", party = {
      { "STARAVIA", 32, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AIR_CUTTER", "SECRET_POWER", "FEATHER_DANCE", "ROOST" } },
      { "MINIOR", 32, ability = "SHIELDS_DOWN", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "SECRET_POWER", "ROCK_SLIDE", "ANCIENT_POWER", "ROLLOUT" } },
    } },
    R119_KO = { like = "YASU", name = "KOTA", defeat = "We vanish... in shame.", party = {
      { "PARASECT", 32, ability = "EFFECT_SPORE", nature = "JOLLY", ev = 128, moves = { "FURY_CUTTER", "AERIAL_ACE", "PROTECT", "X_SCISSOR" } },
      { "GRIMER", 32, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SLUDGE", "MUD_SLAP", "DISABLE", "MINIMIZE" } },
    } },
    R119_LIL = { like = "DOUG", name = "LIL", defeat = "Bugged out!", party = {
      { "VENOMOTH", 32, ability = "SHIELD_DUST", nature = "JOLLY", spread = "atk", ev = 128, moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
      { "DUSTOX", 32, ability = "SHIELD_DUST", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SILVER_WIND", "SKITTER_SMACK", "MOONLIGHT", "PROTECT" } },
    } },
    R119_PIP = { like = "GREG", name = "PIP", defeat = "My bugs got stomped.", party = {
      { "BUTTERFREE", 32, ability = "COMPOUND_EYES", nature = "MODEST", spread = "spa", item = "SILVER_POWDER", ev = 128, moves = { "SILVER_WIND", "STUN_SPORE", "ATTRACT", "AIR_SLASH" } },
      { "ARIADOS", 32, ability = "SNIPER", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "POISON_FANG", "SHADOW_SNEAK", "SKITTER_SMACK", "STRING_SHOT" } },
    } },
    R119_SKY = { like = "PHIL", name = "SKYE", defeat = "Grounded by the rain.", party = {
      { "LINOONE", 32, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "TAKE_DOWN", "EXTREME_SPEED", "HEADBUTT", "SLASH" } },
      { "SWABLU", 32, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "DISARMING_VOICE", "SECRET_POWER", "SING", "MIST" } },
    } },
    R119_ZEN = { like = "TAKASHI", name = "ZEN", defeat = "Defeated in silence.", party = {
      { "PUMPKABOO", 32, ability = "INSOMNIA", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "GRASSY_GLIDE", "WILL_O_WISP", "MEGA_DRAIN", "EMBER" } },
      { "NINJASK", 32, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "SKITTER_SMACK", "AERIAL_ACE", "SAND_ATTACK", "PROTECT" } },
    } },
    R119_RAN = { like = "JACKSON_1", name = "RANDY", defeat = "Protect the wild... from you.", party = {
      { "ORICORIO", 32, ability = "DANCER", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "AIR_SLASH", "TEETER_DANCE", "ROOST" } },
      { "LINOONE", 32, ability = "QUICK_FEET", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "HEADBUTT", "COVET", "PIN_MISSILE", "HONE_CLAWS" } },
    } },
    R119_WEN = { like = "CATHERINE_1", name = "WEN", defeat = "Nature wins. Wait, no, you do.", party = {
      { "MILTANK", 32, ability = "SAP_SIPPER", nature = "ADAMANT", ev = 128, moves = { "BODY_SLAM", "STOMP", "TACKLE", "DEFENSE_CURL" } },
      { "GLOOM", 32, ability = "CHLOROPHYLL", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "MEGA_DRAIN", "GIGA_DRAIN", "SLEEP_POWDER", "STUN_SPORE" } },
    } },
    R119_ABE = { like = "KENT", name = "ABE", defeat = "We bugged out.", party = {
      { "ILLUMISE", 32, ability = "PRANKSTER", nature = "IMPISH", spread = "bulk", ev = 128, moves = { "STRUGGLE_BUG", "CONFUSE_RAY", "MOONLIGHT", "DRAINING_KISS" } },
      { "ILLUMISE", 32, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
    } },
    R119_JIN = { like = "HIDEO", name = "JIN", defeat = "Our shuriken missed.", party = {
      { "CROAGUNK", 32, ability = "ANTICIPATION", nature = "BOLD", spread = "bulk", ev = 128, moves = { "REVENGE", "DRAIN_PUNCH", "VENOSHOCK", "SUCKER_PUNCH" } },
      { "GOLBAT", 32, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AERIAL_ACE", "BITE", "CONFUSE_RAY", "SUPERSONIC" } },
    } },
    R119_JAX = { like = "FABIAN", name = "JAX", defeat = "Unplugged.", party = {
      { "TRANQUILL", 32, ability = "RIVALRY", nature = "MODEST", spread = "spa", ev = 128, moves = { "SECRET_POWER", "AIR_SLASH", "AIR_CUTTER", "GUST" } },
      { "MANECTRIC", 32, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "THUNDER_FANG", "RISING_VOLTAGE", "HOWL" } },
    } },
    R119_ASH = { like = "DAYTON", name = "ASH", defeat = "The rain put out our fire.", party = {
      { "CENTISKORCH", 32, ability = "WHITE_SMOKE", nature = "ADAMANT", spread = "atk", item = "CHARCOAL", ev = 128, moves = { "SKITTER_SMACK", "BUG_BITE", "FLAME_WHEEL", "SMOKESCREEN" } },
      { "HOUNDOOM", 32, ability = "FLASH_FIRE", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "INCINERATE", "FEINT_ATTACK", "SMOG", "HOWL" } },
    } },
    R119_UMA = { like = "RACHEL", name = "UMA", defeat = "My parasol couldn't stop that.", party = {
      { "STEENEE", 32, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "RAZOR_LEAF", "STOMP" } },
      { "PSYDUCK", 32, ability = "CLOUD_NINE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "CONFUSION", "DISABLE", "FURY_SWIPES" } },
    } },
    R119_DON = { like = "BRENT", name = "DONN", defeat = "Cocooned in defeat.", party = {
      { "ILLUMISE", 32, ability = "PRANKSTER", nature = "BOLD", spread = "bulk", ev = 128, moves = { "DRAINING_KISS", "CHARM", "MOONLIGHT", "PLAY_NICE" } },
      { "VENOMOTH", 32, ability = "SHIELD_DUST", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    R120_RAE = { like = "CHIP", name = "RAE", defeat = "The ruins weren't on our side.", party = {
      { "BRUXISH", 32, ability = "STRONG_JAW", nature = "ADAMANT", ev = 128, moves = { "WATERFALL", "CRUNCH", "AQUA_JET", "DISABLE" } },
      { "SOLROCK", 32, ability = "LEVITATE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "CONFUSION", "ROCK_POLISH", "MORNING_SUN" } },
    } },
    R120_GUS = { like = "JEFFREY_1", name = "GUSS", defeat = "Swatted!", party = {
      { "DWEBBLE", 32, ability = "SHELL_ARMOR", nature = "JOLLY", ev = 128, moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
      { "VENOMOTH", 32, ability = "SHIELD_DUST", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "BUG_BITE", "TACKLE", "SIGNAL_BEAM", "SLEEP_POWDER" } },
    } },
    R120_SKY = { like = "COLIN", name = "SKY", defeat = "Flew straight into defeat.", party = {
      { "NOCTOWL", 32, ability = "TINTED_LENS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "ROOST", "TAILWIND", "AIR_SLASH" } },
      { "SWABLU", 32, ability = "NATURAL_CURE", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "DISARMING_VOICE", "SECRET_POWER", "SING", "MIST" } },
    } },
    R120_KO = { like = "KEIGO", name = "KO", defeat = "Our smoke bomb fizzled.", party = {
      { "MASQUERAIN", 32, ability = "INTIMIDATE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "PROTECT", "AIR_CUTTER", "BUBBLE_BEAM" } },
      { "SHUPPET", 32, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "SECRET_POWER", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R120_ACE = { like = "ROBERT_1", name = "ACE", defeat = "Clipped!", party = {
      { "STOUTLAND", 32, ability = "SAND_RUSH", nature = "JOLLY", item = "SCOPE_LENS", ev = 128, moves = { "TAKE_DOWN", "RETALIATE", "TACKLE", "WORK_UP" } },
      { "NOCTOWL", 32, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R120_NIA = { like = "CLARISSA", name = "NIA", defeat = "Our garden party is ruined.", party = {
      { "BELLOSSOM", 32, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", ev = 128, moves = { "GIGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "CORVISQUIRE", 32, ability = "BIG_PECKS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DRILL_PECK", "PLUCK", "PECK", "TAUNT" } },
    } },
    R120_PIA = { like = "ANGELICA", name = "PIA", defeat = "Under the weather today.", party = {
      { "XATU", 32, ability = "SYNCHRONIZE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "CONFUSE_RAY", "MAGIC_COAT", "AIR_SLASH", "PECK" } },
      { "CHIMECHO", 32, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    R120_RAN = { like = "LORENZO", name = "RANN", defeat = "The wild ones won today.", party = {
      { "CASTFORM", 32, ability = "FORECAST", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "WEATHER_BALL", "HEADBUTT", "TACKLE", "EMBER" } },
      { "STARMIE", 32, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "WATER_PULSE", "PSYBEAM", "RECOVER", "THUNDER_WAVE" } },
    } },
    R120_WEN = { like = "JENNA", name = "WENDA", defeat = "Rangers retreat!", party = {
      { "ABSOL", 32, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "SIMIPOUR", 32, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "SCALD", "BRINE", "FLIP_TURN" } },
    } },
    R120_JIN = { like = "RILEY", name = "JINN", defeat = "Outwitted...", party = {
      { "ESCAVALIER", 32, ability = "OVERCOAT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "BUG_BUZZ", "BUG_BITE", "DOUBLE_TEAM", "DOUBLE_EDGE" } },
      { "GOLBAT", 32, ability = "INNER_FOCUS", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "AIR_CUTTER", "BITE", "CONFUSE_RAY", "AERIAL_ACE" } },
    } },
    R120_ROX = { like = "CALLIE", name = "ROXY", defeat = "Hyaah! We'll be back!", party = {
      { "HARIYAMA", 32, ability = "THICK_FAT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "BRICK_BREAK", "FORCE_PALM", "KNOCK_OFF", "WHIRLWIND" } },
      { "PASSIMIAN", 32, ability = "RECEIVER", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "DRAIN_PUNCH", "LOW_SWEEP", "THRASH", "TAKE_DOWN" } },
    } },
    R120_MAX = { like = "JENNIFER", name = "MAXI", defeat = "Cool trainers, cold loss.", party = {
      { "ABSOL", 32, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "NIGHT_SLASH", "SLASH", "FUTURE_SIGHT", "DETECT" } },
      { "ZANGOOSE", 32, ability = "IMMUNITY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "REVENGE", "PURSUIT", "FOCUS_ENERGY", "CRUSH_CLAW" } },
    } },
    R120_LEO = { like = "LEONEL", name = "LEON", defeat = "A shocking result.", party = {
      { "CHARJABUG", 32, ability = "BATTERY", nature = "RELAXED", spread = "tank", ev = 128, moves = { "SPARK", "BUG_BITE", "BITE", "STRING_SHOT" } },
      { "KECLEON", 32, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "SECRET_POWER" } },
    } },
    -- Chapter 7a: Routes 121-123, Mt. Pyre, Lilycove rival (draft 1, 2026-10-27; cap 35): partners ----------------------------------------
    R121_ANN = { like = "JESSICA_1", name = "ANNA", defeat = "How utterly unbeautiful.", party = {
      { "SAWSBUCK", 39, ability = "CHLOROPHYLL", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "FEINT_ATTACK", "TAKE_DOWN", "TACKLE", "ENERGY_BALL" } },
      { "STEENEE", 39, ability = "LEAF_GUARD", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "MAGICAL_LEAF", "SEED_BOMB", "STOMP" } },
    } },
    R121_GUS = { like = "CALE", name = "GUSS", defeat = "Our cocoons cracked.", party = {
      { "BEEDRILL", 39, ability = "SWARM", nature = "BOLD", spread = "bulk", ev = 128, moves = { "PROTECT", "BUG_BITE", "X_SCISSOR", "PIN_MISSILE" } },
      { "NINJASK", 39, ability = "SPEED_BOOST", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
    } },
    R121_WEN = { like = "TAMMY", name = "WEN", defeat = "The spirits abandoned us.", party = {
      { "DUSCLOPS", 39, ability = "PRESSURE", nature = "BOLD", spread = "bulk", ev = 128, moves = { "SHADOW_PUNCH", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
      { "BRAVIARY", 39, ability = "SHEER_FORCE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "STRENGTH", "TAILWIND", "SLASH", "AERIAL_ACE" } },
    } },
    R121_MAX = { like = "WALTER_1", name = "MAX", defeat = "A gentleman loses graciously.", party = {
      { "DUBWOOL", 39, ability = "STEADFAST", nature = "TIMID", ev = 128, moves = { "TAKE_DOWN", "HEADBUTT", "TACKLE", "GUARD_SWAP" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "STRENGTH" } },
    } },
    R121_PIA = { like = "VANESSA", name = "PIA", defeat = "My darlings, are you all right?", party = {
      { "MORGREM", 39, ability = "PICKPOCKET", nature = "BOLD", spread = "bulk", ev = 128, moves = { "FALSE_SURRENDER", "SUCKER_PUNCH", "DAZZLING_GLEAM", "ASSURANCE" } },
      { "PLUSLE", 39, ability = "PLUS", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SPARK", "DISCHARGE", "HELPING_HAND", "ENCORE" } },
    } },
    R121_TOD = { like = "MARCEL", name = "TODD", defeat = "Cool as ever. Beaten as ever.", party = {
      { "ABSOL", 39, ability = "SUPER_LUCK", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "THROAT_CHOP", "SLASH", "SUCKER_PUNCH", "DETECT" } },
      { "MANDIBUZZ", 39, ability = "BIG_PECKS", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "TAILWIND", "KNOCK_OFF", "PUNISHMENT" } },
    } },
    R121_ROX = { like = "CRISTIN_1", name = "ROXA", defeat = "Oof, too cool for us.", party = {
      { "XATU", 39, ability = "SYNCHRONIZE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "CONFUSE_RAY", "MAGIC_COAT", "EXPANDING_FORCE", "PECK" } },
      { "MIGHTYENA", 39, ability = "INTIMIDATE", nature = "ADAMANT", item = "BLACK_GLASSES", ev = 128, moves = { "CRUNCH", "ICE_FANG", "THUNDER_FANG", "ROAR" } },
    } },
    PYRE_DAN = { like = "ZANDER", name = "DANE", defeat = "The mountain humbles us.", party = {
      { "FALINKS", 39, ability = "BATTLE_ARMOR", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "BRICK_BREAK", "ROCK_SMASH", "REVERSAL", "HEADBUTT" } },
      { "WOOBAT", 39, ability = "UNAWARE", nature = "TIMID", item = "ORAN_BERRY", ev = 128, moves = { "ZEN_HEADBUTT", "PSYSHOCK", "AIR_CUTTER", "IMPRISON" } },
    } },
    PYRE_ELI = { like = "LEAH", name = "ELI", defeat = "The graves are restless...", party = {
      { "PUMPKABOO", 39, ability = "INSOMNIA", nature = "MODEST", item = "SPELL_TAG", ev = 128, moves = { "SEED_BOMB", "WILL_O_WISP", "MEGA_DRAIN", "EMBER" } },
      { "DUSCLOPS", 39, ability = "PRESSURE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_PUNCH", "WILL_O_WISP", "CONFUSE_RAY", "DISABLE" } },
    } },
    PYRE_NIA = { like = "VALERIE_1", name = "NIA", defeat = "Rest in peace... us.", party = {
      { "PUMPKABOO", 39, ability = "PICKUP", nature = "TIMID", spread = "spa", item = "SPELL_TAG", ev = 128, moves = { "HEX", "CONFUSE_RAY", "PAIN_SPLIT", "SEED_BOMB" } },
      { "HAUNTER", 39, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "SPELL_TAG", ev = 128, moves = { "SHADOW_BALL", "WILL_O_WISP", "SUCKER_PUNCH", "SPITE" } },
    } },
    PYRE_ZIA = { like = "TASHA", name = "ZIA", defeat = "Hee hee... we lost.", party = {
      { "BANETTE", 39, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "BODY_SLAM", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
      { "COFAGRIGUS", 39, ability = "MUMMY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_BALL", "HEX", "OMINOUS_WIND", "GRUDGE" } },
    } },
    PYRE_OTT = { like = "MARK", name = "OTTO", defeat = "Rare finds, common loss.", party = {
      { "LICKILICKY", 39, ability = "OBLIVIOUS", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "BODY_SLAM", "AMNESIA", "REST", "SLAM" } },
      { "GOOMY", 39, ability = "SAP_SIPPER", nature = "MODEST", item = "ORAN_BERRY", ev = 128, moves = { "DRAGON_PULSE", "WATER_PULSE", "PROTECT", "RAIN_DANCE" } },
    } },
    PYRE_GOR = { like = "ATSUSHI", name = "GORO", defeat = "Hrr! Bested!", party = {
      { "CHESNAUGHT", 39, ability = "OVERGROW", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "GRASS_PLEDGE", "BULK_UP", "ROCK_TOMB", "BRICK_BREAK" } },
      { "THROH", 39, ability = "GUTS", nature = "ADAMANT", item = "BLACK_BELT", ev = 128, moves = { "LOW_SWEEP", "ROCK_TOMB", "COUNTER", "VITAL_THROW" } },
    } },
    PYRE_VIC = { like = "WILLIAM", name = "VICK", defeat = "I sensed a different outcome.", party = {
      { "HATTREM", 39, ability = "ANTICIPATION", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "EXPANDING_FORCE", "DAZZLING_GLEAM", "PLAY_NICE" } },
      { "CHIMECHO", 39, ability = "LEVITATE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "EXTRASENSORY", "ASTONISH", "YAWN", "HEALING_WISH" } },
    } },
    PYRE_IVY = { like = "KAYLA", name = "IVY", defeat = "The future was foggy.", party = {
      { "MIME_JR", 39, ability = "TECHNICIAN", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "CONFUSE_RAY", "PSYBEAM", "PSYSHOCK", "TICKLE" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "EXPANDING_FORCE", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    PYRE_LEO = { like = "CEDRIC", name = "LEO", defeat = "Not even my mind could save us.", party = {
      { "MORGREM", 39, ability = "FRISK", nature = "MODEST", spread = "spa", item = "BLACK_GLASSES", ev = 128, moves = { "DRAINING_KISS", "DARK_PULSE", "FALSE_SURRENDER", "FLATTER" } },
      { "CLAYDOL", 39, ability = "LEVITATE", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "PSYBEAM", "DRILL_RUN", "ROCK_TOMB", "REFLECT" } },
    } },
    R123_FAY = { like = "VIOLET", name = "FAYE", defeat = "The berries were sweeter than this.", party = {
      { "BELLOSSOM", 39, ability = "CHLOROPHYLL", nature = "CALM", spread = "spdef", ev = 128, moves = { "GIGA_DRAIN", "STUN_SPORE", "SLEEP_POWDER", "SWEET_SCENT" } },
      { "SHIINOTIC", 39, ability = "ILLUMINATE", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "LEECH_SEED", "GIGA_DRAIN", "MEGA_DRAIN", "ABSORB" } },
    } },
    R123_GUS = { like = "DAVIS", name = "GUSTAV", defeat = "Squashed!", party = {
      { "HERACROSS", 39, ability = "GUTS", nature = "ADAMANT", item = "FLAME_ORB", ev = 128, moves = { "HORN_ATTACK", "ARM_THRUST", "NIGHT_SLASH", "BRICK_BREAK" } },
      { "BUTTERFREE", 39, ability = "COMPOUND_EYES", nature = "TIMID", item = "SILVER_POWDER", ev = 128, moves = { "PROTECT", "BUG_BUZZ", "AIR_SLASH", "SILVER_WIND" } },
    } },
    R123_MAX = { like = "JAZMYN", name = "MAXINE", defeat = "Cooled off for good.", party = {
      { "CRUSTLE", 39, ability = "SHELL_ARMOR", nature = "JOLLY", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "BUG_BITE", "SMACK_DOWN", "FURY_CUTTER" } },
      { "ESPEON", 39, ability = "MAGIC_BOUNCE", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "SWIFT", "EXPANDING_FORCE", "MORNING_SUN" } },
    } },
    R123_SKY = { like = "ALBERTO", name = "SKYLER", defeat = "Feathers fly, we fall.", party = {
      { "GREEDENT", 39, ability = "GLUTTONY", nature = "JOLLY", item = "SILK_SCARF", ev = 128, moves = { "BODY_SLAM", "COVET", "TACKLE", "SWALLOW" } },
      { "NOCTOWL", 39, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    R123_DON = { like = "ED", name = "DONNY", defeat = "Another hole in the collection.", party = {
      { "MUNCHLAX", 39, ability = "PICKUP", nature = "MODEST", spread = "stank", ev = 128, moves = { "ROLLOUT", "DEFENSE_CURL", "BODY_SLAM", "CHIP_AWAY" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "FEINT_ATTACK", "ANCIENT_POWER", "STRENGTH" } },
    } },
    R123_ZEN = { like = "KINDRA", name = "ZENNA", defeat = "Curses...", party = {
      { "BRAVIARY", 39, ability = "SHEER_FORCE", nature = "JOLLY", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "STRENGTH", "TAILWIND", "SLASH", "AERIAL_ACE" } },
      { "BANETTE", 39, ability = "CURSED_BODY", nature = "ADAMANT", item = "SPELL_TAG", ev = 128, moves = { "BODY_SLAM", "KNOCK_OFF", "WILL_O_WISP", "SCREECH" } },
    } },
    R123_JAX = { like = "FERNANDO_1", name = "JAXON", defeat = "The crowd went home.", party = {
      { "TOUCANNON", 39, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "HYPER_VOICE", "SUPERSONIC", "DRILL_PECK", "PLUCK" } },
      { "MANECTRIC", 39, ability = "LIGHTNING_ROD", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "DISCHARGE", "FLAME_BURST", "THUNDER_WAVE", "ROAR" } },
    } },
    R123_VIC = { like = "CAMERON_1", name = "VICKI", defeat = "My visions were wrong.", party = {
      { "CARBINK", 39, ability = "CLEAR_BODY", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "PSYCHIC", "ROCK_SLIDE", "SMACK_DOWN", "ROCK_THROW" } },
      { "KADABRA", 39, ability = "INNER_FOCUS", nature = "TIMID", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "PSYBEAM", "EXPANDING_FORCE", "DISABLE", "REFLECT" } },
    } },
    R123_IVY = { like = "JACKI_1", name = "IVA", defeat = "Dreams don't always come true.", party = {
      { "FLORGES", 39, ability = "SYMBIOSIS", nature = "MODEST", spread = "spa", item = "PIXIE_PLATE", ev = 128, moves = { "PSYCHIC", "DRAINING_KISS", "DISARMING_VOICE", "GRASSY_TERRAIN" } },
      { "GRUMPIG", 39, ability = "THICK_FAT", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "EXPANDING_FORCE", "CONFUSE_RAY", "MAGIC_COAT", "POWER_GEM" } },
    } },
    R123_KEN = { like = "FREDRICK", name = "KENNY", defeat = "An expert knows when he's beaten.", party = {
      { "HITMONCHAN", 39, ability = "KEEN_EYE", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "SKY_UPPERCUT", "DRAIN_PUNCH", "REVENGE", "MACH_PUNCH" } },
      { "SKARMORY", 39, ability = "STURDY", nature = "IMPISH", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "STEEL_WING", "IRON_HEAD", "SPIKES", "TAILWIND" } },
    } },
    R123_ACE = { like = "BRAXTON", name = "ACE", defeat = "Cool down, cool out.", party = {
      { "LANTURN", 39, ability = "ILLUMINATE", nature = "TIMID", spread = "spa", item = "MAGNET", ev = 128, moves = { "SPARK", "THUNDER_WAVE", "SCALD", "BUBBLE_BEAM" } },
      { "VIBRAVA", 39, ability = "LEVITATE", nature = "ADAMANT", item = "SOFT_SAND", ev = 128, moves = { "DIG", "CRUNCH", "ROCK_SLIDE", "FEINT_ATTACK" } },
    } },
    R123_ELA = { like = "WENDY", name = "ELLA", defeat = "Out-cooled.", party = {
      { "GARDEVOIR", 39, ability = "TRACE", nature = "MODEST", spread = "spa", item = "TWISTED_SPOON", ev = 128, moves = { "DRAINING_KISS", "PSYBEAM", "DISARMING_VOICE", "HYPNOSIS" } },
      { "KANGASKHAN", 39, ability = "INNER_FOCUS", nature = "JOLLY", ev = 128, moves = { "FACADE", "CRUSH_CLAW", "MEGA_PUNCH", "CHIP_AWAY" } },
    } },
    R123_KO = { like = "JONAS", name = "KOJI", defeat = "Into the shadows we go.", party = {
      { "PARASECT", 39, ability = "EFFECT_SPORE", nature = "JOLLY", ev = 128, moves = { "X_SCISSOR", "AERIAL_ACE", "SWORDS_DANCE", "PROTECT" } },
      { "MUK", 39, ability = "STICKY_HOLD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SLUDGE", "POISON_JAB", "DISABLE", "MINIMIZE" } },
    } },
    R123_UMA = { like = "KAYLEY", name = "UMI", defeat = "What a dreary day for it.", party = {
      { "BRELOOM", 39, ability = "EFFECT_SPORE", nature = "ADAMANT", spread = "atk", item = "MIRACLE_SEED", ev = 128, moves = { "GIGA_DRAIN", "GROWTH", "HELPING_HAND", "SEED_BOMB" } },
      { "TOGETIC", 39, ability = "SERENE_GRACE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DRAINING_KISS", "FAIRY_WIND", "FOLLOW_ME", "YAWN" } },
    } },
    -- Chapter 7b: Magma and Aqua Hideouts (draft 1, 2026-10-27; caps 36, 37, 38): partners ----------------------------------------
    -- Chapter 7c: Routes 124-125, Mossdeep, Space Center (draft 1, 2026-10-27; cap 42): partners ----------------------------------------
    R124_LEO = { like = "CHAD", name = "LEO", defeat = "Washed up on Mossdeep.", party = {
      { "GOLDUCK", 39, ability = "CLOUD_NINE", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "WATER_PULSE", "BUBBLE_BEAM", "SCALD", "WATER_SPORT" } },
      { "SEALEO", 39, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "BRINE", "DEFENSE_CURL", "ENCORE" } },
    } },
    R124_MIA = { like = "JENNY_1", name = "MIA", defeat = "Out of air!", party = {
      { "PYUKUMUKU", 39, ability = "INNARDS_OUT", nature = "JOLLY", spread = "atk", ev = 128, moves = { "GASTRO_ACID", "PURIFY" } },
      { "SEADRA", 39, ability = "POISON_POINT", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "PROTECT", "BRINE", "BUBBLE_BEAM" } },
    } },
    R124_GIL = { like = "DECLAN", name = "GILL", defeat = "Dragged under.", party = {
      { "SHARPEDO", 39, ability = "SPEED_BOOST", nature = "ADAMANT", ev = 128, moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
      { "SIMIPOUR", 39, ability = "GLUTTONY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "SCALD", "BRINE", "DIVE" } },
    } },
    R124_HAL = { like = "SPENCER", name = "HALL", defeat = "Drifted off course.", party = {
      { "ARAQUANID", 39, ability = "WATER_ABSORB", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "PROTECT", "LUNGE", "LEECH_LIFE" } },
      { "STARMIE", 39, ability = "NATURAL_CURE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "PSYCHIC", "RECOVER", "THUNDER_WAVE" } },
    } },
    R124_DUN = { like = "ROLAND", name = "DUNN", defeat = "Sunk by the sea itself.", party = {
      { "LUMINEON", 39, ability = "SWIFT_SWIM", nature = "MODEST", ev = 128, moves = { "PROTECT", "BUBBLE_BEAM", "WATER_GUN", "DIVE" } },
      { "TENTACRUEL", 39, ability = "CLEAR_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "SURF", "SLUDGE_BOMB", "TOXIC_SPIKES", "WRAP" } },
    } },
    R124_LIA = { like = "GRACE", name = "LIA", defeat = "The current won.", party = {
      { "STARMIE", 39, ability = "ILLUMINATE", nature = "MODEST", ev = 128, moves = { "WATERFALL", "PROTECT", "EXPANDING_FORCE", "PSYBEAM" } },
      { "SEAKING", 39, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "MEGAHORN", "KNOCK_OFF", "AGILITY" } },
    } },
    R124_TOD = { like = "ISABELLA", name = "TODD", defeat = "Last lap, last place.", party = {
      { "DEWGONG", 39, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", ev = 128, moves = { "LIQUIDATION", "BRINE", "AURORA_BEAM", "WATER_SPORT" } },
      { "TALONFLAME", 39, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "AERIAL_ACE", "QUICK_ATTACK", "TAILWIND", "ACROBATICS" } },
    } },
    R125_JON = { like = "NOLEN", name = "JONAH", defeat = "Tide's against me.", party = {
      { "DEWGONG", 39, ability = "ICE_BODY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "DISABLE", "LIQUIDATION", "BRINE" } },
      { "SHARPEDO", 39, ability = "SPEED_BOOST", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "AQUA_JET", "CRUNCH", "ICE_FANG", "PROTECT" } },
    } },
    R125_AMY = { like = "TANYA", name = "AMIE", defeat = "Too tired to keep kicking.", party = {
      { "CLAWITZER", 39, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", ev = 128, moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "CORSOLA", 39, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "BUBBLE_BEAM", "ANCIENT_POWER", "SCALD", "AQUA_RING" } },
    } },
    R125_BEN = { like = "ERNEST_1", name = "BENN", defeat = "Aye, ye beat us fair.", party = {
      { "SAMUROTT", 39, ability = "TORRENT", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", ev = 128, moves = { "ICE_BEAM", "WATER_PLEDGE", "RAZOR_SHELL", "BUBBLE_BEAM" } },
      { "INTELEON", 39, ability = "TORRENT", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", ev = 128, moves = { "WATER_PULSE", "PROTECT", "LIQUIDATION", "WATER_GUN" } },
    } },
    R125_MAC = { like = "STAN", name = "MACK", defeat = "Kelp in my hair, loss on my record.", party = {
      { "LANTURN", 39, ability = "VOLT_ABSORB", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "DISCHARGE", "SURF", "CONFUSE_RAY", "THUNDER_WAVE" } },
      { "SWANNA", 39, ability = "KEEN_EYE", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "LIQUIDATION", "PROTECT", "AIR_SLASH", "AQUA_RING" } },
    } },
    R125_SKY = { like = "PRESLEY", name = "SKYE", defeat = "Grounded at sea.", party = {
      { "TOXAPEX", 39, ability = "MERCILESS", nature = "ADAMANT", spread = "atk", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "PROTECT", "POISON_JAB", "VENOSHOCK" } },
      { "PURUGLY", 39, ability = "DEFIANT", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "BODY_SLAM", "SLASH", "SCRATCH", "FAKE_OUT" } },
    } },
    R125_ELA = { like = "SHARON", name = "ELA", defeat = "Glub.", party = {
      { "GOREBYSS", 39, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SCALD", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "GASTRODON", 39, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
    } },
    R125_KEN = { like = "AURON", name = "KENJI", defeat = "Expertly sunk.", party = {
      { "LUCARIO", 39, ability = "STEADFAST", nature = "MODEST", spread = "stank", ev = 128, moves = { "CLOSE_COMBAT", "FORCE_PALM", "FLASH_CANNON", "WORK_UP" } },
      { "ELECTRODE", 39, ability = "AFTERMATH", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "DISCHARGE", "FOUL_PLAY", "TAUNT", "EXPLOSION" } },
    } },
    TH6_SKY = { like = "BENNY", name = "SKAI", defeat = "The Trick Master tricked us both.", party = {
      { "NOCTOWL", 39, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
      { "TALONFLAME", 39, ability = "FLAME_BODY", nature = "JOLLY", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "QUICK_ATTACK", "TAILWIND", "FLARE_BLITZ" } },
    } },
    TH6_RAN = { like = "SEBASTIAN", name = "RANDALL", defeat = "Lost in the maze AND the battle.", party = {
      { "MORPEKO", 39, ability = "HUNGER_SWITCH", nature = "ADAMANT", item = "SCOPE_LENS", ev = 128, moves = { "SPARK", "BITE", "CRUNCH", "THUNDER_SHOCK" } },
      { "KECLEON", 39, ability = "PROTEAN", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "SHADOW_SNEAK", "KNOCK_OFF", "ANCIENT_POWER", "BODY_SLAM" } },
    } },
    TH6_WEN = { like = "SOPHIA", name = "WENDA", defeat = "Even the walls laughed.", party = {
      { "HAWLUCHA", 39, ability = "LIMBER", nature = "MODEST", spread = "spa", ev = 128, moves = { "SUBMISSION", "BOUNCE", "WING_ATTACK", "AERIAL_ACE" } },
      { "SHIFTRY", 39, ability = "CHLOROPHYLL", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "FAKE_OUT", "LEAF_BLADE", "SUCKER_PUNCH", "FEINT_ATTACK" } },
    } },
    -- Chapter 8: Mossdeep to Juan (draft 1, 2026-10-27; caps 43, 44, 46): partners ----------------------------------------
    R126_TOD = { like = "CAMDEN", name = "CORA", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "AQUA_TAIL", "AGILITY" } },
      { "SIMIPOUR", 44, ability = "TORRENT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "AQUA_TAIL", "CRUNCH", "BITE" } },
    } },
    R126_ACE = { like = "PABLO_1", name = "GILL", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 44, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R126_LIA = { like = "BRENDA", name = "LIA", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "AQUA_TAIL", "PROTECT" } },
      { "ARCTOVISH", 44, ability = "WATER_ABSORB", nature = "ADAMANT", moves = { "AQUA_TAIL", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    R126_GIL = { like = "BARRY", name = "GIL", defeat = "The sea floor's colder than this loss.", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_TAIL", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_JON = { like = "DEAN", name = "JON", defeat = "The sea floor's colder than this loss.", party = {
      { "TOXTRICITY", 44, ability = "PUNK_ROCK", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SLUDGE_BOMB", "ACID_SPRAY", "POISON_JAB", "DISCHARGE" } },
      { "LIEPARD", 44, ability = "PRANKSTER", nature = "ADAMANT", moves = { "PROTECT", "DARK_PULSE", "THROAT_CHOP", "NIGHT_SLASH" } },
    } },
    R126_SKY = { like = "ISAIAH_1", name = "SKY", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILORD", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "GALVANTULA", 44, ability = "SWARM", nature = "MODEST", moves = { "PROTECT", "DISCHARGE", "SIGNAL_BEAM", "BUG_BUZZ" } },
    } },
    R126_MIA = { like = "ISOBEL", name = "MIA", defeat = "The sea floor's colder than this loss.", party = {
      { "WALREIN", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "WATER_PULSE", "BUBBLE_BEAM", "WATER_SPORT" } },
    } },
    R126_DUN = { like = "DONNY", name = "DUN", defeat = "The sea floor's colder than this loss.", party = {
      { "DEDENNE", 44, ability = "PICKUP", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "PLAY_ROUGH", "HELPING_HAND", "PARABOLIC_CHARGE", "VOLT_SWITCH" } },
      { "GASTRODON", 44, ability = "STICKY_HOLD", nature = "MODEST", spread = "stank", moves = { "SURF", "MUDDY_WATER", "EARTH_POWER", "RAIN_DANCE" } },
    } },
    R126_ELA = { like = "KATELYN_1", name = "ELA", defeat = "The sea floor's colder than this loss.", party = {
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "POIPOLE", 44, ability = "BEAST_BOOST", nature = "BOLD", spread = "bulk", moves = { "PROTECT", "POISON_JAB", "VENOSHOCK", "ACID" } },
    } },
    R126_AMY = { like = "NIKKI", name = "AMY", defeat = "The sea floor's colder than this loss.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 44, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "RAZOR_SHELL", "AQUA_TAIL", "PROTECT" } },
    } },
    R126_KIM = { like = "SIENNA", name = "KIM", defeat = "The sea floor's colder than this loss.", party = {
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 44, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "AQUA_TAIL" } },
    } },
    R126_PIA = { like = "CARLEE", name = "PIA", defeat = "The sea floor's colder than this loss.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R126_LEO = { like = "LEONARDO", name = "LEO", defeat = "The sea floor's colder than this loss.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R126_MAX = { like = "ATHENA", name = "MAX", defeat = "The sea floor's colder than this loss.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R126_BEN = { like = "HARRISON", name = "BEN", defeat = "The sea floor's colder than this loss.", party = {
      { "DRACOVISH", 44, ability = "SAND_RUSH", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "DIVE", "CRUNCH", "AQUA_TAIL" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R126_HAL = { like = "JONAH", name = "HAL", defeat = "The sea floor's colder than this loss.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "AQUA_TAIL", "AGILITY" } },
      { "DEWGONG", 44, ability = "ICE_BODY", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DISABLE", "AQUA_TAIL", "BRINE" } },
    } },
    R126_NED = { like = "HENRY", name = "NED", defeat = "The sea floor's colder than this loss.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 44, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R126_MAC = { like = "ROGER", name = "MAC", defeat = "The sea floor's colder than this loss.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "AQUA_TAIL", "PROTECT" } },
      { "OCTILLERY", 44, ability = "SUCTION_CUPS", nature = "MODEST", moves = { "WATERFALL", "PROTECT", "OCTAZOOKA", "WATER_PULSE" } },
    } },
    R126_KEN = { like = "KOJI_1", name = "KEN", defeat = "The sea floor's colder than this loss.", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_TAIL", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R126_WES = { like = "WAYNE", name = "WES", defeat = "The sea floor's colder than this loss.", party = {
      { "GENGAR", 44, ability = "CURSED_BODY", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SLUDGE_BOMB", "SHADOW_PUNCH", "SHADOW_BALL", "HEX" } },
      { "CARRACOSTA", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", moves = { "AQUA_TAIL", "PROTECT", "DIVE", "CRUNCH" } },
    } },
    R126_SKY2 = { like = "AIDAN", name = "SKAI", defeat = "The sea floor's colder than this loss.", party = {
      { "WAILORD", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "SWANNA", 44, ability = "HYDRATION", nature = "MODEST", moves = { "FLY", "PROTECT", "WATER_PULSE", "AIR_SLASH" } },
    } },
    R126_ANN = { like = "ALEXA", name = "ANN", defeat = "The sea floor's colder than this loss.", party = {
      { "WALREIN", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "SEAKING", 44, ability = "WATER_VEIL", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "AQUA_TAIL", "POISON_JAB", "AQUA_RING" } },
    } },
    R126_RAN = { like = "RUBEN", name = "RAN", defeat = "The sea floor's colder than this loss.", party = {
      { "MISDREAVUS", 44, ability = "LEVITATE", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "SHADOW_BALL", "HEX", "DISARMING_VOICE", "ASTONISH" } },
      { "CACTURNE", 44, ability = "SAND_VEIL", nature = "ADAMANT", spread = "tank", moves = { "SUCKER_PUNCH", "FEINT_ATTACK", "PAYBACK", "NEEDLE_ARM" } },
    } },
    R130_LEO = { like = "FRANKLIN", name = "LEO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "GASTRODON", 44, ability = "STORM_DRAIN", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "WATER_PULSE", "PROTECT", "MUDDY_WATER", "EARTH_POWER" } },
      { "POIPOLE", 44, ability = "BEAST_BOOST", nature = "BOLD", spread = "bulk", moves = { "PROTECT", "POISON_JAB", "VENOSHOCK", "ACID" } },
    } },
    R130_BO = { like = "JACK", name = "BO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 44, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R130_KEN = { like = "HITOSHI", name = "KEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "SIMIPOUR", 44, ability = "GLUTTONY", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "AQUA_TAIL" } },
    } },
    R130_GOR = { like = "KIYO", name = "GORO", defeat = "Pacifidlog is a long swim from here.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R130_SKY = { like = "ALEX", name = "SKY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R130_ACE = { like = "BECK", name = "ACE", defeat = "Pacifidlog is a long swim from here.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "KINGLER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "SCALD", "ICY_WIND", "CRABHAMMER", "RAZOR_SHELL" } },
    } },
    R130_AMY = { like = "DEBRA", name = "AMY", defeat = "Pacifidlog is a long swim from here.", party = {
      { "KABUTOPS", 44, ability = "WEAK_ARMOR", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "BRINE" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R130_LIA = { like = "LINDA", name = "LIA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "SEAKING", 44, ability = "LIGHTNING_ROD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "MEGAHORN", "AQUA_TAIL", "AGILITY" } },
      { "SIMIPOUR", 44, ability = "TORRENT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "AQUA_TAIL", "CRUNCH", "BITE" } },
    } },
    R130_ELA = { like = "LAUREL", name = "ELA", defeat = "Pacifidlog is a long swim from here.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 44, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R130_WES = { like = "KELVIN", name = "WES", defeat = "Pacifidlog is a long swim from here.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "AQUA_TAIL", "PROTECT" } },
      { "TOXAPEX", 44, ability = "MERCILESS", nature = "ADAMANT", moves = { "PROTECT", "LIQUIDATION", "POISON_JAB", "VENOSHOCK" } },
    } },
    R130_ROX = { like = "REYNA", name = "ROX", defeat = "Pacifidlog is a long swim from here.", party = {
      { "DEWGONG", 44, ability = "THICK_FAT", nature = "TIMID", item = "MYSTIC_WATER", moves = { "AQUA_TAIL", "WATERFALL", "PROTECT", "BRINE" } },
      { "CORSOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R130_BEN = { like = "HUDSON", name = "BEN", defeat = "Pacifidlog is a long swim from here.", party = {
      { "INTELEON", 44, ability = "TORRENT", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "WATER_PULSE", "SNIPE_SHOT" } },
      { "KINGLER", 44, ability = "SHEER_FORCE", nature = "ADAMANT", moves = { "RAZOR_SHELL", "KNOCK_OFF", "PROTECT", "CRABHAMMER" } },
    } },
    R131_GIL = { like = "RODNEY", name = "GIL", defeat = "Caught in the currents.", party = {
      { "WAILORD", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "SLOWBRO", 44, ability = "REGENERATOR", nature = "MODEST", moves = { "PROTECT", "BUBBLE_BEAM", "CONFUSION", "PSYCHIC" } },
    } },
    R131_JON = { like = "RICHARD", name = "JON", defeat = "Caught in the currents.", party = {
      { "WALREIN", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "DEWGONG", 44, ability = "HYDRATION", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "AQUA_TAIL", "AURORA_BEAM", "WATER_SPORT" } },
    } },
    R131_HAL = { like = "SANTIAGO", name = "HAL", defeat = "Caught in the currents.", party = {
      { "PRIMARINA", 44, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "SPARKLING_ARIA", "PLAY_ROUGH", "HELPING_HAND", "WATER_PULSE" } },
      { "PALOSSAND", 44, ability = "WATER_COMPACTION", nature = "MODEST", spread = "stank", moves = { "EARTH_POWER", "SHADOW_BALL", "BULLDOZE", "SAND_TOMB" } },
    } },
    R131_MAC = { like = "GILBERT", name = "MAC", defeat = "Caught in the currents.", party = {
      { "CAMERUPT", 44, ability = "SOLID_ROCK", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PROTECT", "EARTH_POWER", "FLAMETHROWER", "LAVA_PLUME" } },
      { "AMOONGUSS", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", moves = { "PROTECT", "GIGA_DRAIN", "MEGA_DRAIN", "SEED_BOMB" } },
    } },
    R131_DUN = { like = "KEVIN", name = "DUN", defeat = "Caught in the currents.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 44, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R131_SKY = { like = "CHASE", name = "SKY", defeat = "Caught in the currents.", party = {
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "BARBARACLE", 44, ability = "TOUGH_CLAWS", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "LIQUIDATION" } },
    } },
    R131_PIA = { like = "TALIA", name = "PIA", defeat = "Caught in the currents.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R131_TOD = { like = "ALLISON", name = "TOD", defeat = "Caught in the currents.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "IRON_DEFENSE" } },
    } },
    R132_KIM = { like = "KATIE", name = "KIM", defeat = "Even the fish feel sorry for us.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "PHIONE", 44, ability = "HYDRATION", nature = "BOLD", spread = "bulk", moves = { "SCALD", "LIQUIDATION", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    R132_ZOE = { like = "KARA", name = "ZOE", defeat = "Even the fish feel sorry for us.", party = {
      { "WAILORD", 44, ability = "PRESSURE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "BRINE" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    R132_MIA = { like = "DANA", name = "MIA", defeat = "Even the fish feel sorry for us.", party = {
      { "BASCULIN", 44, ability = "MOLD_BREAKER", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "AGILITY", "AQUA_TAIL", "AQUA_JET" } },
      { "CLAWITZER", 44, ability = "MEGA_LAUNCHER", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "ICY_WIND", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    R132_LEO = { like = "CLARENCE", name = "LEO", defeat = "Even the fish feel sorry for us.", party = {
      { "QUAGSIRE", 44, ability = "UNAWARE", nature = "RELAXED", spread = "bulk", item = "ORAN_BERRY", moves = { "EARTHQUAKE", "WATERFALL", "YAWN", "PROTECT" } },
      { "CRYOGONAL", 44, ability = "LEVITATE", nature = "MODEST", spread = "stank", moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    R132_BO = { like = "REED", name = "BO", defeat = "Even the fish feel sorry for us.", party = {
      { "HUNTAIL", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CRUNCH", "AQUA_TAIL", "PROTECT" } },
      { "SLOWBRO", 44, ability = "OBLIVIOUS", nature = "MODEST", moves = { "EARTHQUAKE", "AMNESIA", "PROTECT", "PSYCHIC" } },
    } },
    R132_ELA = { like = "TISHA", name = "ELA", defeat = "Even the fish feel sorry for us.", party = {
      { "GLALIE", 44, ability = "INNER_FOCUS", nature = "TIMID", item = "MYSTIC_WATER", moves = { "PROTECT", "ROCK_SLIDE", "ICE_FANG", "FROST_BREATH" } },
      { "CORSOLA", 44, ability = "REGENERATOR", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", moves = { "SURF", "POWER_GEM", "ROCK_BLAST", "AQUA_RING" } },
    } },
    R133_ZEN = { like = "MOLLIE", name = "ZEN", defeat = "An expert loss, at least.", party = {
      { "OMASTAR", 44, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "TOXIC_SPIKES", "BRINE", "ANCIENT_POWER" } },
      { "SLOWKING", 44, ability = "REGENERATOR", nature = "MODEST", moves = { "PROTECT", "PSYCHIC", "ZEN_HEADBUTT", "BUBBLE_BEAM" } },
    } },
    R133_DRA = { like = "AARON", name = "DRA", defeat = "An expert loss, at least.", party = {
      { "WAILORD", 44, ability = "WATER_VEIL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "WATER_SPOUT", "ICE_BEAM", "LIQUIDATION", "AMNESIA" } },
      { "JELLICENT", 44, ability = "DAMP", nature = "MODEST", moves = { "PROTECT", "WATER_PULSE", "SHADOW_BALL", "SURF" } },
    } },
    R133_KEN = { like = "CONOR", name = "KEN", defeat = "An expert loss, at least.", party = {
      { "WALREIN", 44, ability = "THICK_FAT", nature = "IMPISH", spread = "tank", item = "ORAN_BERRY", moves = { "ICE_BALL", "SURF", "DEFENSE_CURL", "ENCORE" } },
      { "ARCTOVISH", 44, ability = "WATER_ABSORB", nature = "JOLLY", spread = "atk", item = "MYSTIC_WATER", moves = { "SURF", "CRUNCH", "BITE", "AQUA_TAIL" } },
    } },
    R133_GOR = { like = "PAXTON", name = "GORO", defeat = "An expert loss, at least.", party = {
      { "INTELEON", 44, ability = "TORRENT", nature = "ADAMANT", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "WATER_PULSE", "WATER_GUN" } },
      { "JELLICENT", 44, ability = "WATER_ABSORB", nature = "MODEST", spread = "stank", moves = { "SURF", "CONFUSE_RAY", "HYDRO_PUMP", "WATER_PULSE" } },
    } },
    R133_WEN = { like = "MAKAYLA", name = "WEN", defeat = "An expert loss, at least.", party = {
      { "PALOSSAND", 44, ability = "WATER_COMPACTION", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "PROTECT", "EARTH_POWER", "SHADOW_BALL", "BULLDOZE" } },
      { "SEVIPER", 44, ability = "INFILTRATOR", nature = "BOLD", spread = "bulk", moves = { "PROTECT", "AQUA_TAIL", "POISON_JAB", "VENOSHOCK" } },
    } },
    R133_ACE = { like = "WARREN", name = "ACE", defeat = "An expert loss, at least.", party = {
      { "KINGDRA", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DIVE", "ICE_BEAM", "PROTECT" } },
      { "DREDNAW", 44, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    R134_GIL = { like = "HERMAN", name = "GIL", defeat = "The open sea humbled us.", party = {
      { "OMASTAR", 44, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "DRACOVISH", 44, ability = "WATER_ABSORB", nature = "ADAMANT", moves = { "PROTECT", "SCALD", "BRINE", "AQUA_TAIL" } },
    } },
    R134_ELA = { like = "SUSIE", name = "ELA", defeat = "The open sea humbled us.", party = {
      { "GOREBYSS", 44, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "MUDDY_WATER", "PSYCHIC", "AMNESIA", "AQUA_RING" } },
      { "MANTINE", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    R134_MAX = { like = "MARLEY", name = "MAX", defeat = "The open sea humbled us.", party = {
      { "RELICANTH", 44, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
      { "CLOYSTER", 44, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
    } },
    R134_DUN = { like = "JONATHAN", name = "DUN", defeat = "The open sea humbled us.", party = {
      { "POLIWRATH", 44, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "PHIONE", 44, ability = "HYDRATION", nature = "BOLD", spread = "bulk", moves = { "SCALD", "LIQUIDATION", "WATER_PULSE", "BUBBLE_BEAM" } },
    } },
    R134_ANN = { like = "DARCY", name = "ANN", defeat = "The open sea humbled us.", party = {
      { "SEISMITOAD", 44, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "MUDDY_WATER", "BUBBLE_BEAM" } },
      { "VAPOREON", 44, ability = "WATER_ABSORB", nature = "BOLD", spread = "bulk", moves = { "SURF", "ICE_BEAM", "AURORA_BEAM", "HELPING_HAND" } },
    } },
    -- Chapter 9: Victory Road and the League (draft 1, 2026-10-27; caps 48, 50, 52, 54, 56, 58): partners ----------------------------------------
    VR_P1 = { like = "PATRICIA", name = "ROSA", defeat = "The road to the League ends here for us.", party = {
      { "EXEGGUTOR", 47, ability = "CHLOROPHYLL", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "PSYCHIC", "SEED_BOMB", "EXTRASENSORY", "PSYSHOCK" } },
      { "WIGGLYTUFF", 47, ability = "COMPETITIVE", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND", "HYPER_VOICE" } },
    } },
    VR_P2 = { like = "JOSHUA", name = "KAI", defeat = "The road to the League ends here for us.", party = {
      { "HELIOLISK", 47, ability = "DRY_SKIN", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "SURF", "THUNDER_WAVE", "THUNDERBOLT", "PARABOLIC_CHARGE" } },
      { "WALREIN", 47, ability = "THICK_FAT", nature = "ADAMANT", spread = "atk", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "ICE_BEAM", "PROTECT", "BLIZZARD" } },
    } },
    VR_P3 = { like = "ALEXIS", name = "MONA", defeat = "The road to the League ends here for us.", party = {
      { "CLOYSTER", 47, ability = "SHELL_ARMOR", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", ev = 128, moves = { "ICE_BEAM", "ICICLE_CRASH", "RAZOR_SHELL", "TOXIC_SPIKES" } },
      { "CARRACOSTA", 47, ability = "SWIFT_SWIM", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "LIQUIDATION", "DIVE", "AQUA_TAIL" } },
    } },
    VR_P4 = { like = "MARIELA", name = "OTTO", defeat = "The road to the League ends here for us.", party = {
      { "LUMINEON", 47, ability = "STORM_DRAIN", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "ICY_WIND", "BUBBLE_BEAM", "AQUA_TAIL" } },
      { "BARBARACLE", 47, ability = "TOUGH_CLAWS", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "SCALD", "LIQUIDATION", "RAZOR_SHELL" } },
    } },
    VR_P5 = { like = "ALVARO", name = "ZEKE", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "PRIMEAPE", 47, ability = "VITAL_SPIRIT", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "CLOSE_COMBAT", "CROSS_CHOP", "SCREECH", "FOCUS_ENERGY" } },
    } },
    VR_P6 = { like = "EVERETT", name = "LUNA", defeat = "The road to the League ends here for us.", party = {
      { "BANETTE", 47, ability = "INSOMNIA", nature = "JOLLY", ev = 128, moves = { "PHANTOM_FORCE", "PROTECT", "SHADOW_BALL", "CRUSH_CLAW" } },
      { "STARAPTOR", 47, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_P7 = { like = "NICOLAS_1", name = "IRIS", defeat = "The road to the League ends here for us.", party = {
      { "PIDGEOT", 47, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
      { "GOLISOPOD", 47, ability = "EMERGENCY_EXIT", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "PROTECT", "FIRST_IMPRESSION", "LIQUIDATION" } },
    } },
    VR_A1 = { like = "ALBERT", name = "DREW", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "HIGH_HORSEPOWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "VILEPLUME", 47, ability = "EFFECT_SPORE", nature = "ADAMANT", spread = "atk", ev = 128, moves = { "EARTH_POWER", "SLUDGE_BOMB", "SOLAR_BEAM", "PETAL_DANCE" } },
    } },
    VR_A2 = { like = "HOPE", name = "NORA", defeat = "The road to the League ends here for us.", party = {
      { "POLIWRATH", 47, ability = "SWIFT_SWIM", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "WATERFALL", "CLOSE_COMBAT", "ICE_PUNCH", "HYPNOSIS" } },
      { "MANTINE", 47, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    VR_A3 = { like = "SHANNON", name = "TESS", defeat = "The road to the League ends here for us.", party = {
      { "SLOWKING", 47, ability = "OBLIVIOUS", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "CRYOGONAL", 47, ability = "LEVITATE", nature = "MODEST", spread = "stank", ev = 128, moves = { "ICE_BEAM", "CONFUSE_RAY", "AURORA_BEAM", "ACID_ARMOR" } },
    } },
    VR_A4 = { like = "SAMUEL", name = "VERA", defeat = "The road to the League ends here for us.", party = {
      { "RELICANTH", 47, ability = "ROCK_HEAD", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "ROCK_SLIDE", "WATERFALL", "TAKE_DOWN", "AQUA_TAIL" } },
      { "DREDNAW", 47, ability = "SHELL_ARMOR", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "LIQUIDATION", "RAZOR_SHELL", "PROTECT" } },
    } },
    VR_A5 = { like = "JULIE", name = "MILO", defeat = "The road to the League ends here for us.", party = {
      { "SALAZZLE", 47, ability = "OBLIVIOUS", nature = "BOLD", spread = "bulk", item = "BLACK_SLUDGE", ev = 128, moves = { "VENOSHOCK", "FLAMETHROWER", "SLUDGE_BOMB", "NASTY_PLOT" } },
      { "CRAWDAUNT", 47, ability = "ADAPTABILITY", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "RAZOR_SHELL", "KNOCK_OFF", "LIQUIDATION", "PROTECT" } },
    } },
    VR_A6 = { like = "OWEN", name = "JUNE", defeat = "The road to the League ends here for us.", party = {
      { "SKUNTANK", 47, ability = "KEEN_EYE", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "CRUNCH", "PROTECT", "FOUL_PLAY", "NIGHT_SLASH" } },
      { "WHISCASH", 47, ability = "HYDRATION", nature = "RELAXED", spread = "bulk", ev = 128, moves = { "EARTHQUAKE", "WATERFALL", "PROTECT", "AQUA_TAIL" } },
    } },
    VR_A7 = { like = "DIANNE", name = "RUSS", defeat = "The road to the League ends here for us.", party = {
      { "DELPHOX", 47, ability = "BLAZE", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "PSYCHIC", "FLAMETHROWER", "MYSTICAL_FIRE", "PSYSHOCK" } },
      { "WIGGLYTUFF", 47, ability = "COMPETITIVE", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "PLAY_ROUGH", "KNOCK_OFF", "HELPING_HAND", "HYPER_VOICE" } },
    } },
    VR_A8 = { like = "FELIX", name = "FAYE", defeat = "The road to the League ends here for us.", party = {
      { "MAGNETON", 47, ability = "MAGNET_PULL", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", ev = 128, moves = { "DISCHARGE", "THUNDER_WAVE", "FLASH_CANNON", "THUNDERBOLT" } },
      { "SEISMITOAD", 47, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", ev = 128, moves = { "SURF", "PROTECT", "LIQUIDATION", "DRAIN_PUNCH" } },
    } },
    VR_A9 = { like = "CAROLINE", name = "COLE", defeat = "The road to the League ends here for us.", party = {
      { "MAMOSWINE", 47, ability = "OBLIVIOUS", nature = "BOLD", spread = "bulk", item = "SITRUS_BERRY", ev = 128, moves = { "ICE_BEAM", "ICICLE_CRASH", "HIGH_HORSEPOWER", "MUD_BOMB" } },
      { "KABUTOPS", 47, ability = "WEAK_ARMOR", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "LIQUIDATION", "DIVE", "BRINE" } },
    } },
    VR_A10 = { like = "VITO", name = "GWEN", defeat = "The road to the League ends here for us.", party = {
      { "TOXAPEX", 47, ability = "LIMBER", nature = "BOLD", spread = "bulk", item = "ORAN_BERRY", ev = 128, moves = { "SCALD", "ICY_WIND", "LIQUIDATION", "POISON_JAB" } },
      { "WAILORD", 47, ability = "WATER_VEIL", nature = "ADAMANT", ev = 128, moves = { "PROTECT", "SCALD", "BRINE", "DIVE" } },
    } },
    VR_A11 = { like = "MICHELLE", name = "HUGO", defeat = "The road to the League ends here for us.", party = {
      { "MACHAMP", 47, ability = "NO_GUARD", nature = "ADAMANT", item = "SITRUS_BERRY", ev = 128, moves = { "DYNAMIC_PUNCH", "KNOCK_OFF", "ROCK_SLIDE", "WIDE_GUARD" } },
      { "CRABOMINABLE", 47, ability = "HYPER_CUTTER", nature = "ADAMANT", spread = "tank", ev = 128, moves = { "CLOSE_COMBAT", "WIDE_GUARD", "DYNAMIC_PUNCH", "HAMMER_ARM" } },
    } },
    VR_A12 = { like = "MITCHELL", name = "NELL", defeat = "The road to the League ends here for us.", party = {
      { "PURUGLY", 47, ability = "THICK_FAT", nature = "JOLLY", ev = 128, moves = { "FACADE", "QUICK_ATTACK", "PROTECT", "BODY_SLAM" } },
      { "STARAPTOR", 47, ability = "RECKLESS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "QUICK_ATTACK", "FEATHER_DANCE", "ROOST" } },
    } },
    VR_A13 = { like = "HALLE", name = "PERCY", defeat = "The road to the League ends here for us.", party = {
      { "PIDGEOT", 47, ability = "BIG_PECKS", nature = "TIMID", item = "SHARP_BEAK", ev = 128, moves = { "BRAVE_BIRD", "TAILWIND", "QUICK_ATTACK", "AIR_SLASH" } },
      { "CROBAT", 47, ability = "INNER_FOCUS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "PROTECT", "CROSS_POISON", "WING_ATTACK", "AIR_SLASH" } },
    } },
    VR_A14 = { like = "EDGAR", name = "RHEA", defeat = "The road to the League ends here for us.", party = {
      { "NIDOKING", 47, ability = "SHEER_FORCE", nature = "MODEST", spread = "spa", item = "ORAN_BERRY", ev = 128, moves = { "HIGH_HORSEPOWER", "SLUDGE_BOMB", "THUNDERBOLT", "FLAMETHROWER" } },
      { "SCOLIPEDE", 47, ability = "SPEED_BOOST", nature = "MODEST", spread = "spa", ev = 128, moves = { "SLUDGE_BOMB", "CROSS_POISON", "DOUBLE_EDGE", "IRON_DEFENSE" } },
    } },
    VR_A15 = { like = "QUINCY", name = "SETH", defeat = "The road to the League ends here for us.", party = {
      { "MIENSHAO", 47, ability = "RECKLESS", nature = "ADAMANT", item = "ORAN_BERRY", ev = 128, moves = { "CLOSE_COMBAT", "DRAIN_PUNCH", "FORCE_PALM", "BOUNCE" } },
      { "MANTINE", 47, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", ev = 128, moves = { "SURF", "WATER_PULSE", "AIR_SLASH", "AQUA_RING" } },
    } },
    VR_A16 = { like = "KATELYNN", name = "ADA", defeat = "The road to the League ends here for us.", party = {
      { "POLITOED", 47, ability = "WATER_ABSORB", nature = "CALM", spread = "spdef", item = "ORAN_BERRY", ev = 128, moves = { "ICE_BEAM", "SURF", "WATER_PULSE", "BUBBLE_BEAM" } },
      { "AURORUS", 47, ability = "REFRIGERATE", nature = "MODEST", spread = "stank", ev = 128, moves = { "ICE_BEAM", "AURORA_BEAM", "FREEZE_DRY", "POWER_GEM" } },
    } },
    -- Post-game and stragglers: Rusturf Mike, Jagged Pass grunt, S.S. Tidal, Trick House 8 (draft 1, 2026-10-27): partners ----------------------------------------
    RT_GUS = { like = "MIKE_2", name = "GUSTAV", defeat = "The tunnel is ours no more.", party = {
      { "BINACLE", 21, ability = "TOUGH_CLAWS", nature = "IMPISH", spread = "bulk", moves = { "ROCK_TOMB", "CLAMP", "SCRATCH", "SAND_ATTACK" } },
      { "WHISMUR", 21, ability = "SOUNDPROOF", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ECHOED_VOICE", "DISARMING_VOICE", "HOWL", "SCREECH" } },
    } },
    SS_ELA = { like = "NAOMI", name = "ELAINE", defeat = "How rude, on a cruise no less.", party = {
      { "TOGEKISS", 59, ability = "HUSTLE", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "MOONBLAST", "PSYCHIC", "WISH", "PROTECT" } },
      { "ARCTOZOLT", 58, ability = "VOLT_ABSORB", nature = "BOLD", spread = "bulk", moves = { "ICE_BEAM", "FREEZE_DRY", "DISCHARGE", "AVALANCHE" } },
    } },
    SS_REX = { like = "GARRET", name = "REX", defeat = "Daddy owns this ship, you know.", party = {
      { "VANILLUXE", 59, ability = "ICE_BODY", nature = "MODEST", spread = "stank", item = "ORAN_BERRY", moves = { "ICE_BEAM", "FREEZE_DRY", "ACID_ARMOR", "BLIZZARD" } },
      { "NINETALES", 58, ability = "DROUGHT", nature = "TIMID", spread = "spa", moves = { "FLAMETHROWER", "EXTRASENSORY", "WILL_O_WISP", "PROTECT" } },
    } },
    SS_MAX = { like = "MICAH", name = "MAXWELL", defeat = "A gentleman accepts defeat.", party = {
      { "ARCTOVISH", 59, ability = "SLUSH_RUSH", nature = "CALM", spread = "spdef", item = "SITRUS_BERRY", moves = { "SURF", "LIQUIDATION", "DIVE", "FREEZE_DRY" } },
      { "NOCTOWL", 58, ability = "TINTED_LENS", nature = "MODEST", spread = "spa", moves = { "AIR_SLASH", "EXTRASENSORY", "HYPNOSIS", "REFLECT" } },
    } },
    SS_HAL = { like = "THOMAS", name = "HALE", defeat = "Most unexpected.", party = {
      { "ORBEETLE", 59, ability = "FRISK", nature = "TIMID", spread = "spa", item = "MYSTIC_WATER", moves = { "PSYCHIC", "RECOVER", "BUG_BUZZ", "PSYBEAM" } },
      { "LICKILICKY", 58, ability = "OBLIVIOUS", nature = "ADAMANT", spread = "tank", item = "SITRUS_BERRY", moves = { "BODY_SLAM", "PROTECT", "SLAM", "POWER_WHIP" } },
    } },
    SS_BEN = { like = "PHILLIP", name = "BENN", defeat = "Shipshape, but beaten.", party = {
      { "SEADRA", 59, ability = "SNIPER", nature = "MODEST", spread = "spa", item = "DAMP_ROCK", moves = { "SURF", "PROTECT", "HYDRO_PUMP", "BRINE" } },
      { "CAMERUPT", 58, ability = "ANGER_POINT", nature = "MODEST", item = "ORAN_BERRY", moves = { "PROTECT", "EARTH_POWER", "MUD_BOMB", "EARTHQUAKE" } },
    } },
    SS_WES = { like = "LEONARD", name = "WESLEY", defeat = "Back to swabbing the deck.", party = {
      { "KINGDRA", 59, ability = "SWIFT_SWIM", nature = "MODEST", spread = "spa", item = "MYSTIC_WATER", moves = { "SURF", "DRAGON_PULSE", "ICE_BEAM", "PROTECT" } },
      { "LUMINEON", 58, ability = "SWIFT_SWIM", nature = "TIMID", spread = "spa", item = "ORAN_BERRY", moves = { "SURF", "HYDRO_PUMP", "BUBBLE_BEAM", "QUIVER_DANCE" } },
    } },
  },
}
