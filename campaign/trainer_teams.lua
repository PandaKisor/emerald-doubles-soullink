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
  },
}
