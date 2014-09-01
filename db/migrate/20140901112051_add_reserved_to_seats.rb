class AddReservedToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :reserved, :boolean
  end
end
