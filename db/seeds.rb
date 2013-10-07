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
  email { Faker::Internet.email }
  password { 'password42' }
  password_confirmation { 'password42' }
end

for i in 1..20
  User.make!
end

User.create( {
  :email => 'admin@example.com',
  :password => 'password',
  :password_confirmation => 'password' })
