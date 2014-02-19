class AddMessageToSeatRequests < ActiveRecord::Migration
  def change
    add_column :seat_requests, :message, :string
  end
end
