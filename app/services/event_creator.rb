class EventCreator < Struct.new(:listener)
  def update(event, new_event_form)
    @new_event_form = new_event_form
    
    total_seats = 0
    (1..max_columns).each do |column|
      row_letters.each do |row|
        event.seats.build(number: column, row: row)
        total_seats += 1
        break if total_seats == new_event_form.total_seats
      end
    end
    
    event.name = new_event_form.name
    
    if event.save
      listener.success(event)
    else
      listener.failure(event)
    end
  end
  
  def row_letters
    possible_letters = ('A'..'Z').to_a + ('AA'..'ZA').to_a
    possible_letters.first(@new_event_form.rows)
  end
  
  def max_columns
    (@new_event_form.total_seats.to_f / @new_event_form.rows.to_f).ceil
  end
    
end
