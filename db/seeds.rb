# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
rows = {'A' => 4,
        'B' => 4,
        'C' => 4,
        'D' => 4,
        'E' => 2}

rows.each do |row, seats|
  for seat in 1..seats
    Seat.create({:row => row, :number => seat})
  end
end
