class CreateSeatRequests < ActiveRecord::Migration
  def change
    create_table :seat_requests do |t|
      t.integer :seat_id
      t.integer :user_id

      t.timestamps
    end
  end
end
