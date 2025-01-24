# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Sheet.create([
  { id: 1 , column: 1, row: 'a' },
  { id: 2 , column: 2, row: 'a' },
  { id: 3 , column: 3, row: 'a' },
  { id: 4 , column: 4, row: 'a' },
  { id: 5 , column: 5, row: 'a' },
  { id: 6 , column: 1, row: 'b' },
  { id: 7 , column: 2, row: 'b' },
  { id: 8 , column: 3, row: 'b' },
  { id: 9 , column: 4, row: 'b' },
  { id: 10 , column: 5, row: 'b' },
  { id: 11 , column: 1, row: 'c' },
  { id: 12 , column: 2, row: 'c' },
  { id: 13 , column: 3, row: 'c' },
  { id: 14 , column: 4, row: 'c' },
  { id: 15 , column: 5, row: 'c' },
])
