class NewEventForm < Form
  include Virtus.model

  attribute :name, String
  attribute :total_seats, Integer
  attribute :rows, Integer
end
