City.create([
  { name: 'A' },
  { name: 'B' },
  { name: 'C' },
  { name: 'D' },
  { name: 'E' }
])

Route.create([
  { from_id: 1, to_id: 2, distance: 10 },
  { from_id: 2, to_id: 4, distance: 15 },
  { from_id: 1, to_id: 3, distance: 20 },
  { from_id: 3, to_id: 4, distance: 30 },
  { from_id: 2, to_id: 5, distance: 50 },
  { from_id: 4, to_id: 5, distance: 30 }
])