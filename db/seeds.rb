require 'machinist/active_record'

User.blueprint do
  email { Faker::Internet.safe_email }
  username { Faker::Internet.user_name }
  password { 'password' }
  password_confirmation { 'password' }
  admin { false }
end

User.blueprint(:default) do
  email { 'user@example.com' }
  username { 'User' }
end

User.blueprint(:admin) do
  email { 'admin@example.com' }
  username { 'Admin' }
  admin { true }
end

User.blueprint(:admin2) do
  email { 'admin2@example.com' }
  username { 'Admin2' }
  admin { true }
end

Event.blueprint(:event) do
  name { Faker::Lorem.words(1).first }
end

(1..10).each do |i|
  event = Event.make!(:event)
  
  rows = { 'A' => 6,
           'B' => 6,
           'C' => 6,
           'D' => 6 }

  rows.each do |row, seats|
    for seat in 1..seats
      created_seat = Seat.new(row: row, number: seat)
      created_seat.event = event
      if seat.even?
        created_seat.user = User.where(email: Faker::Internet.safe_email).first_or_create(
          username: Faker::Internet.user_name,
          password: 'password',
          password_confirmation: 'password',
          admin: false
        )
      end
      
      created_seat.save
    end
  end
end

for i in 1..10
  User.make!
end

User.make!(:admin)
User.make!(:admin2)
User.make!(:default)
