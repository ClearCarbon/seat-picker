class AddUserToSeats < ActiveRecord::Migration
  def change
    add_reference :seats, :user, index: true
  end
end
