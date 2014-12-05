require 'machinist/active_record'

rows = {'A' => 6,
        'B' => 6,
        'C' => 6,
        'D' => 6}

rows.each do |row, seats|
  for seat in 1..seats
    Seat.create({:row => row, :number => seat})
  end
end


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

for i in 1..20
  User.make!
end

User.make!(:admin)
User.make!(:admin2)
User.make!(:default)
