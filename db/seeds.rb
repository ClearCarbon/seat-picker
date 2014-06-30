require 'machinist/active_record'
require_relative '../spec/blueprints'

for i in 1..20
  User.make!
end

User.make!(:admin)
