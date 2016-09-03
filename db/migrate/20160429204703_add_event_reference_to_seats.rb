class AddEventReferenceToSeats < ActiveRecord::Migration
  def change
    add_reference :seats, :event, index: true
    add_foreign_key :seats, :events
  end
end
