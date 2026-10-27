"""Route guide: vanilla Emerald's story in order, one chapter per cap, each step
a stop with its maps. Trainers come from where the ROM places them; a route
visited twice names the first visit's trainers in `only` and the later visit
takes the rest. Wild tables and items are matched by map: a name ending in `*`
is a prefix (interiors), and each map belongs to the first step naming it
exactly, else the first prefix that matches. Rematches (_2.._5) are left out."""
import re

# (title, boss symbols whose ace is the chapter's cap, intro, steps)
# step: (title, maps, note[, only])
CHAPTERS = [
  ('Littleroot to Roxanne', ['ROXANNE_1'],
   'Your starter is Littleroot’s encounter. Route trainers fight as tag teams; the rival fights alone.', [
    ('Littleroot Town', ['LITTLEROOT_TOWN*'], 'Pick your starter at Birch’s bag. It counts as Littleroot’s encounter. After Birch’s rescue each player gets 2 Oran Berries and a Potion.'),
    ('Route 101', ['ROUTE101'], 'Birch’s rescue battle is excluded from Soul Link. Your first real encounter is here.'),
    ('Oldale Town', ['OLDALE_TOWN*'], 'The mart opens after you get the Pokédex. Every town mart sells Oran, Cheri, Pecha, Rawst, Aspear and Chesto Berries.'),
    ('Route 103', ['ROUTE103'], 'Rival battle: your rival brings the starter strong against yours, holding an Oran Berry.',
     ['BRENDAN_ROUTE_103_MUDKIP', 'BRENDAN_ROUTE_103_TREECKO', 'BRENDAN_ROUTE_103_TORCHIC',
      'MAY_ROUTE_103_MUDKIP', 'MAY_ROUTE_103_TREECKO', 'MAY_ROUTE_103_TORCHIC']),
    ('Route 102', ['ROUTE102'], 'Four tag battles. Grab Oran Berries from the trees.'),
    ('Petalburg City', ['PETALBURG_CITY', 'PETALBURG_CITY_MART', 'PETALBURG_CITY_WALLYS_HOUSE'],
     'Wally’s catching tutorial uses a borrowed Zigzagoon and is excluded from tracking.'),
    ('Route 104 (south)', ['ROUTE104', 'ROUTE104_*'], 'Beach and boardwalk side, before the woods.',
     ['BILLY', 'DARIAN', 'CINDY_1']),
    ('Petalburg Woods', ['PETALBURG_WOODS'], 'The Aqua grunt fights alone (a story battle).'),
    ('Route 104 (north)', ['ROUTE104'], 'North of the woods: the twins are a double on their own.'),
    ('Rustboro City', ['RUSTBORO_CITY', 'RUSTBORO_CITY_MART', 'RUSTBORO_CITY_POKEMON_SCHOOL', 'RUSTBORO_CITY_FLAT*',
                       'RUSTBORO_CITY_CUTTERS_HOUSE', 'RUSTBORO_CITY_DEVON*', 'RUSTBORO_CITY_HOUSE*'], ''),
    ('Rustboro Gym', ['RUSTBORO_CITY_GYM'], 'Gym trainers fight alone with three. Roxanne brings six, 2-vs-1.'),
  ]),
  ('Rustboro to Brawly', ['BRAWLY_1'],
   'Chase the Devon Goods, then sail to Dewford with Mr. Briney.', [
    ('Route 116', ['ROUTE116'], 'The east half needs Cut (Cutter’s house in Rustboro).'),
    ('Rusturf Tunnel', ['RUSTURF_TUNNEL'], 'The grunt with the Devon Goods fights alone.'),
    ('Rustboro rival', ['RUSTBORO_CITY'], 'After returning the goods, your rival stops you on the way out. Alone, four Pokémon, starter at 17.',
     ['BRENDAN_RUSTBORO_MUDKIP', 'BRENDAN_RUSTBORO_TREECKO', 'BRENDAN_RUSTBORO_TORCHIC',
      'MAY_RUSTBORO_MUDKIP', 'MAY_RUSTBORO_TREECKO', 'MAY_RUSTBORO_TORCHIC']),
    ('Dewford Town', ['DEWFORD_TOWN*', 'ROUTE106'], 'Route 106’s beach is walkable now; its water side needs Surf.',
     ['NED', 'ELLIOT_1']),
    ('Granite Cave', ['GRANITE_CAVE*'], 'Deliver the letter to Steven. Flash helps on B1F.'),
    ('Dewford Gym', ['DEWFORD_TOWN_GYM'], 'A dark gym: trainers fight alone with three.'),
  ]),
  ('Dewford to Wattson', ['RIVAL_ROUTE_110', 'WALLY_MAUVILLE', 'WATTSON_1'],
   'Slateport, the Museum, and Mauville. The rival (20) and Wally (21) come before Wattson.', [
    ('Route 109 (beach)', ['ROUTE109', 'ROUTE109_*'], 'Beach trainers and the Seashore House (three in a row).',
     ['HUEY', 'EDMOND', 'HAILEY', 'RICKY_1', 'LOLA_1', 'CHANDLER', 'SIMON', 'JOHANNA', 'DWAYNE']),
    ('Slateport City', ['SLATEPORT_CITY*'], 'The market and harbor.'),
    ('Oceanic Museum', ['SLATEPORT_CITY_OCEANIC_MUSEUM*'], 'Two Aqua grunts in a row, fought alone.'),
    ('Route 110', ['ROUTE110'], 'Your rival waits at the north end (alone).',
     ['ISABEL_1', 'KALEB', 'TIMMY', 'EDWIN_1', 'JOSEPH', 'EDWARD', 'ALYSSA', 'DALE',
      'BRENDAN_ROUTE_110_MUDKIP', 'BRENDAN_ROUTE_110_TREECKO', 'BRENDAN_ROUTE_110_TORCHIC',
      'MAY_ROUTE_110_MUDKIP', 'MAY_ROUTE_110_TREECKO', 'MAY_ROUTE_110_TORCHIC']),
    ('Trick House 1', ['ROUTE110_TRICK_HOUSE_ENTRANCE', 'ROUTE110_TRICK_HOUSE_PUZZLE1', 'ROUTE110_TRICK_HOUSE_END'], 'Needs Cut.'),
    ('Route 103 (east)', ['ROUTE103'], 'Reached from Route 110’s south end. The water trainers need Surf; come back later.',
     ['DAISY', 'AMY_AND_LIV_1', 'MIGUEL_1', 'ANDREW', 'MARCOS', 'RHETT']),
    ('Mauville City', ['MAUVILLE_CITY*'], 'Wally challenges you at the gym door (alone, cap 21). Get a bike here.'),
    ('Cycling Road', ['ROUTE110'], 'The bike path over Route 110.'),
    ('Route 118 (west)', ['ROUTE118'], 'East of Mauville, no Surf needed. The east bank comes later.',
     ['WADE', 'DEANDRE', 'ROSE_1', 'DALTON_1']),
    ('Route 117', ['ROUTE117'], 'The Day Care is here.'),
    ('Verdanturf Town', ['VERDANTURF_TOWN*'], 'Rusturf Tunnel’s east side.'),
    ('Route 111 (south)', ['ROUTE111', 'ROUTE111_*'], 'South of the rocks, and the Winstrates’ four battles in a row.',
     ['TYRON', 'CELINA', 'BIANCA', 'HAYDEN', 'VICTOR', 'VICTORIA', 'VIVI', 'VICKY']),
    ('Mauville Gym', ['MAUVILLE_CITY_GYM'], 'Electric switches; trainers fight alone with three.'),
  ]),
  ('Mauville to Flannery', ['TABITHA_MT_CHIMNEY', 'MAXIE_MT_CHIMNEY', 'FLANNERY_1'],
   'North through Fallarbor, then up Mt. Chimney after Team Magma.', [
    ('Route 111 (north)', ['ROUTE111'], 'North of the desert, on the way to Route 113. The desert itself needs Go-Goggles (later).',
     ['GABBY_AND_TY_1', 'TRAVIS', 'IRENE', 'WILTON_1', 'BROOKE_1', 'DAISUKE']),
    ('Trick House 2', ['ROUTE110_TRICK_HOUSE_PUZZLE2'], 'Opens after the Dynamo Badge.'),
    ('Route 112', ['ROUTE112'], 'The cable car is blocked until after Route 114.', ['LARRY', 'CAROL', 'BRICE', 'TRENT_1', 'BRYANT', 'SHAYLA']),
    ('Fiery Path', ['FIERY_PATH'], ''),
    ('Route 113', ['ROUTE113', 'ROUTE113_*'], 'Ash grass: collect ash for the Glass Workshop.'),
    ('Fallarbor Town', ['FALLARBOR_TOWN*'], ''),
    ('Route 114', ['ROUTE114', 'ROUTE114_*'], ''),
    ('Meteor Falls', ['METEOR_FALLS*'], 'Team Magma takes the meteorite. The inner caves need Surf and Waterfall (their trainers are listed with Victory Road).'),
    ('Route 115', ['ROUTE115'], 'The south half; the north beach needs Surf.', ['NOB_1', 'HECTOR', 'MARLENE', 'CYNDY_1']),
    ('Mt. Chimney', ['MT_CHIMNEY'], 'Ride the cable car up. Magma grunts, Tabitha (25) and Maxie (26) fight alone.'),
    ('Jagged Pass', ['JAGGED_PASS'], 'Down to Lavaridge.', ['ERIC', 'AUTUMN', 'JULIO', 'DIANA_1', 'ETHAN_1']),
    ('Lavaridge Town', ['LAVARIDGE_TOWN', 'LAVARIDGE_TOWN_MART', 'LAVARIDGE_TOWN_HERB_SHOP', 'LAVARIDGE_TOWN_HOUSE'], 'The Herb Shop and hot springs.'),
    ('Lavaridge Gym', ['LAVARIDGE_TOWN_GYM*'], 'Steam vents hide trainers; each fights alone with three.'),
  ]),
  ('Lavaridge to Norman', ['NORMAN_1'],
   'Go-Goggles open the desert. Then home to face your father.', [
    ('Route 111 (desert)', ['ROUTE111', 'DESERT_UNDERPASS', 'MIRAGE_TOWER*'], 'Sandstorm all the way. Pick a fossil at Mirage Tower.'),
    ('Trick House 3', ['ROUTE110_TRICK_HOUSE_PUZZLE3'], 'Opens after the Heat Badge.'),
    ('New Mauville', ['NEW_MAUVILLE*'], 'Optional: the generator under Route 110 (Surf).'),
    ('Petalburg Gym', ['PETALBURG_CITY_GYM'], 'Rooms by stat theme; trainers fight alone with three.'),
  ]),
  ('Petalburg to Winona', ['SHELLY_WEATHER_INSTITUTE', 'RIVAL_ROUTE_119', 'WINONA_1'],
   'Surf opens the sea routes. Team Aqua takes over the Weather Institute.', [
    ('Routes 105 and 106 (sea)', ['ROUTE105', 'ROUTE106', 'ISLAND_CAVE'], 'Surf from Petalburg toward Dewford.'),
    ('Routes 107 and 108', ['ROUTE107', 'ROUTE108'], ''),
    ('Abandoned Ship', ['ABANDONED_SHIP*'], 'The flooded rooms need Dive (later).'),
    ('Route 109 (sea)', ['ROUTE109'], 'The water south of Slateport.'),
    ('Route 103 (sea)', ['ROUTE103'], ''),
    ('Route 115 (north)', ['ROUTE115'], ''),
    ('Route 118', ['ROUTE118'], 'West bank, then Surf to the east.'),
    ('Route 119', ['ROUTE119'], 'Long grass and rain. Your rival waits near the Institute’s north end (alone, 33).',
     None),
    ('Weather Institute', ['ROUTE119_WEATHER_INSTITUTE*'], 'Aqua grunts, then Shelly (alone, 32).'),
    ('Fortree City', ['FORTREE_CITY', 'FORTREE_CITY_MART', 'FORTREE_CITY_HOUSE*'], 'A Kecleon blocks the gym until you have the Devon Scope.'),
    ('Route 120', ['ROUTE120', 'SCORCHED_SLAB'], 'Steven gives you the Devon Scope at the bridge.'),
    ('Trick House 4', ['ROUTE110_TRICK_HOUSE_PUZZLE4'], ''),
    ('Fortree Gym', ['FORTREE_CITY_GYM'], 'Rotating gates; trainers fight alone with three.'),
  ]),
  ('Fortree to Tate & Liza', ['RIVAL_LILYCOVE', 'TABITHA_MAGMA_HIDEOUT', 'MAXIE_MAGMA_HIDEOUT', 'MATT', 'TATE_AND_LIZA_1'],
   'The orbs, two hideouts, and the open sea to Mossdeep.', [
    ('Route 121', ['ROUTE121', 'SAFARI_ZONE*'], 'The Safari Zone is here.'),
    ('Route 122 and Mt. Pyre', ['ROUTE122', 'MT_PYRE*'], 'Team Aqua takes the Blue Orb at the summit.'),
    ('Route 123', ['ROUTE123', 'ROUTE123_*'], ''),
    ('Lilycove City', ['LILYCOVE_CITY*'], 'Your rival waits by the Department Store (alone, 35).'),
    ('Magma Hideout', ['MAGMA_HIDEOUT*'], 'Back through Jagged Pass with the Magma Emblem. Tabitha (36), then Maxie (37).'),
    ('Aqua Hideout', ['AQUA_HIDEOUT*'], 'In Lilycove’s bay. Matt (38) guards the submarine dock.'),
    ('Route 124', ['ROUTE124', 'UNDERWATER_ROUTE124'], ''),
    ('Mossdeep City', ['MOSSDEEP_CITY', 'MOSSDEEP_CITY_MART', 'MOSSDEEP_CITY_HOUSE*', 'MOSSDEEP_CITY_STEVENS_HOUSE'], 'Steven gives you Dive after the gym.'),
    ('Routes 125 and Shoal Cave', ['ROUTE125', 'SHOAL_CAVE*'], 'Tides change Shoal Cave every six hours.'),
    ('Trick Houses 5 and 6', ['ROUTE110_TRICK_HOUSE_PUZZLE5', 'ROUTE110_TRICK_HOUSE_PUZZLE6'], ''),
    ('Mossdeep Gym', ['MOSSDEEP_CITY_GYM'], 'Psychic warp tiles. Tate & Liza fight as a double (42).'),
    ('Space Center', ['MOSSDEEP_CITY_SPACE_CENTER*'], 'Maxie and Tabitha attack. You and Steven (or your partner) fight them together.'),
  ]),
  ('Mossdeep to Juan', ['SHELLY_SEAFLOOR_CAVERN', 'ARCHIE', 'JUAN_1'],
   'Dive to Seafloor Cavern, wake Rayquaza, then Sootopolis.', [
    ('Routes 126 to 128', ['ROUTE126', 'ROUTE127', 'ROUTE128', 'UNDERWATER_ROUTE126', 'UNDERWATER_ROUTE127', 'UNDERWATER_ROUTE128'], 'Dive spots lead to the sea floor.'),
    ('Seafloor Cavern', ['SEAFLOOR_CAVERN*'], 'Shelly (43), then Archie (44), both alone.'),
    ('Sootopolis City', ['SOOTOPOLIS_CITY', 'SOOTOPOLIS_CITY_MART', 'SOOTOPOLIS_CITY_HOUSE*', 'SOOTOPOLIS_CITY_LOTAD*', 'CAVE_OF_ORIGIN*'], 'Find Wallace at the Cave of Origin.'),
    ('Sky Pillar', ['SKY_PILLAR*'], 'Wake Rayquaza to end the weather.'),
    ('Routes 129 to 134', ['ROUTE129', 'ROUTE130', 'ROUTE131', 'ROUTE132', 'ROUTE133', 'ROUTE134', 'PACIFIDLOG_TOWN*'], 'Optional sea routes past Pacifidlog.'),
    ('Sootopolis Gym', ['SOOTOPOLIS_CITY_GYM*'], 'Ice floor puzzles; trainers fight alone with three.'),
  ]),
  ('Victory Road and the League', ['WALLY_VR_1', 'SIDNEY', 'PHOEBE', 'GLACIA', 'DRAKE', 'WALLACE'],
   'Waterfall up to Ever Grande. Wally (48), then the Elite Four in a row.', [
    ('Trick House 7', ['ROUTE110_TRICK_HOUSE_PUZZLE7'], 'Opens after the Rain Badge.'),
    ('Ever Grande City', ['EVER_GRANDE_CITY', 'EVER_GRANDE_CITY_POKEMON*'], ''),
    ('Meteor Falls (inner)', ['METEOR_FALLS_1F_2R', 'METEOR_FALLS_B1F_2R'], 'Needs Waterfall: the trainers deep inside.',
     ['NICOLAS_1', 'JOHN_AND_JAY_1']),
    ('Victory Road', ['VICTORY_ROAD*'], 'Wally waits at the exit (alone, 48).'),
    ('Elite Four', ['EVER_GRANDE_CITY_SIDNEYS_ROOM', 'EVER_GRANDE_CITY_PHOEBES_ROOM', 'EVER_GRANDE_CITY_GLACIAS_ROOM', 'EVER_GRANDE_CITY_DRAKES_ROOM'],
     'Sidney 50, Phoebe 52, Glacia 54, Drake 56. No healing between rooms except your items.'),
    ('Champion Wallace', ['EVER_GRANDE_CITY_CHAMPIONS_ROOM'], 'Wallace’s ace is 58.'),
  ]),
]

SKIP = {'STEVEN'}  # Meteor Falls Steven is post-game
REMATCH = re.compile(r'_([2-9])$')


def build(data):
    """Return the routeGuide list; asserts every named map exists."""
    maps = {k[3:]: k for k in data['maps']}  # EM_ prefix
    by_symbol = {t['symbol'][8:]: t for t in data['trainers']}
    by_id = {t['id']: t for t in data['trainers']}
    first = lambda t: not t['phantom'] and t['party'] and not ('GRUNT_' not in t['symbol'] and REMATCH.search(t['symbol']) and
        by_symbol.get(REMATCH.sub('_1', t['symbol'][8:])))
    steps = [(c, s) for c in CHAPTERS for s in c[3]]

    # each map's owner step for wild/items: exact names first, then the
    # longest matching prefix (earliest step on ties)
    owner, prefixes = {}, []
    for n, (_, s) in enumerate(steps):
        for name in s[1]:
            if name.endswith('*'):
                prefixes.append((-len(name), n, name[:-1]))
            else:
                assert name in maps, f'route guide: unknown map {name}'
                owner.setdefault(name, n)
    for _, n, prefix in sorted(prefixes):
        for m in maps:
            if m.startswith(prefix):
                owner.setdefault(m, n)

    # trainers: explicit `only` lists, then everything left goes to the first
    # step without `only` that names the map exactly or by prefix
    taken, step_trainers = set(), [[] for _ in steps]
    for n, (_, s) in enumerate(steps):
        if len(s) > 3 and s[3]:
            for sym in s[3]:
                t = by_symbol[sym]
                taken.add(t['id'])
                step_trainers[n].append(t['id'])
    def names(s, m):
        return any(m == name or (name.endswith('*') and m.startswith(name[:-1])) for name in s[1])
    free = [n for n, (_, s) in enumerate(steps) if not (len(s) > 3 and s[3])]
    for t in data['trainers']:
        if t['id'] in taken or not first(t) or t['symbol'][8:] in SKIP:
            continue
        tmaps = [m['id'][3:] for m in t['maps']]
        cands = [n for n in free if any(names(steps[n][1], m) for m in tmaps)]
        own = [n for n in cands if any(owner.get(m) == n for m in tmaps)]
        pick = (own or cands or [None])[0]
        if pick is not None:
            step_trainers[pick].append(t['id'])

    out, n = [], 0
    for title, bosses, intro, chapter_steps in CHAPTERS:
        boss_ids = [by_symbol[b]['id'] for b in bosses if b in by_symbol]
        chapter = {'title': title, 'intro': intro, 'bosses': boss_ids,
                   'cap': max(m['level'] for b in boss_ids for m in by_id[b]['party']), 'steps': []}
        for s in chapter_steps:
            main = next((maps[m.rstrip('*')] for m in s[1] if m.rstrip('*') in maps), None)
            chapter['steps'].append({'title': s[0], 'note': s[2], 'primary': main,
                                     'maps': sorted({maps[m] for m, o in owner.items() if o == n} |
                                                     {maps[m] for m in s[1] if m in maps}),
                                     'trainers': sorted(step_trainers[n], key=lambda i: (max(m['level'] for m in by_id[i]['party']), i))})
            n += 1
        out.append(chapter)
    return out
