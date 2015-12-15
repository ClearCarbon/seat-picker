module PickerHelper
  def selected_class(seat)
    if seat.user_id.nil?
      return ''
    else
      if seat.user_id == current_user.id
        return ' highlight'
      else
        return ' selected'
      end
    end
  end

  def seat_row(seats, row)
    seats.select { |s| s.row == row }
  end
end
