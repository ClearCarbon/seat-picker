class AddReasonToSeatRequest < ActiveRecord::Migration
  def change
    add_column :seat_requests, :reason, :text
  end
end
