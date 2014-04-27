require 'machinist/active_record'

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


User.blueprint do
  email { Faker::Internet.safe_email }
  username { Faker::Internet.user_name }
  password { 'password' }
  password_confirmation { 'password' }
  admin { false }
end

User.blueprint(:admin) do
  email { 'admin@example.com' }
  username { 'Admin' }
  admin { true }
end

for i in 1..20
  User.make!
end

User.make!(:admin)
