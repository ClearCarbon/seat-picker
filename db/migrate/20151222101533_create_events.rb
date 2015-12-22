class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title

      t.timestamps null: false
    end
    
    add_reference :seats, :event, index: true
    
    if Seat.any?
      migrated_event = Event.create(title: 'Migrated')
      Seat.update_all(event_id: migrated_event.id)
    end
  end
end
