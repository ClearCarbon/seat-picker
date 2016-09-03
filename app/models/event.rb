class Event < ActiveRecord::Base
  has_many :seats
  has_many :seat_requests, through: :seats
end
