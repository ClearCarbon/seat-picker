module PickerHelper
  def selected_class(seat)

    if(seat.user_id.nil?)
      return ''
    else
      return ' selected'
    end

  end

  def seat_row(seats, row)
    seats.select{|s| s.row == row }
  end
end
