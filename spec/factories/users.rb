FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "someone#{i}@example.co.uk" }
    sequence(:username) { |i| "someone#{i}" }
    password 'password'
    password_confirmation 'password'
  end
end
