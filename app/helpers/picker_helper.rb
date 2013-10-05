module PickerHelper
  def selected_class(seat)

    if(seat.user_id.nil?)
      return ''
    else
      return ' selected'
    end

  end

  def seat_row(seats, row)
    row_seats = Array.new

    seats.each do |seat|
      if(seat.row == row)
        row_seats.push(seat)
      end
    end

    row_seats
  end
end
