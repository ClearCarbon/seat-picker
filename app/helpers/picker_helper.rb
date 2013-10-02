module PickerHelper
  def selected_class(row, number, selected_seats)

    selected_seats.each do |selected_seat|
      if(selected_seat.row == row && selected_seat.number == number)
        return ' selected'
      end
    end

    return ''
  end
end
