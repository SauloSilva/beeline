Map.create([
  { name: 'SP' },
  { name: 'RJ' },
  { name: 'RS' }
])

City.create([
  { name: 'A', map_id: 1 },
  { name: 'B', map_id: 1 },
  { name: 'C', map_id: 1 },
  { name: 'D', map_id: 2 },
  { name: 'E', map_id: 3 }
])

Route.create([
  { from_id: 1, to_id: 2, distance: 10 },
  { from_id: 2, to_id: 4, distance: 15 },
  { from_id: 1, to_id: 3, distance: 20 },
  { from_id: 3, to_id: 4, distance: 30 },
  { from_id: 2, to_id: 5, distance: 50 },
  { from_id: 4, to_id: 5, distance: 30 }
])