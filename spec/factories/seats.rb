FactoryGirl.define do
  factory :seat do
    row 'A'
    sequence('number')
  end
end
