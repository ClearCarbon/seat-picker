class UserSeatPicker < Struct.new(:listener)
  def pick(seat, user)
    ActiveRecord::Base.transaction do
      if clear_old_seat(seat, user) && seat.update_attributes!(user: user)
        listener.success(seat)
      else
        listener.failure(seat)
      end
      
    end
  end
  
  private
  
  def clear_old_seat(seat, user)
    current_seat = user.seat(seat.event)
    if current_seat.present?
      current_seat.update_attributes!(user_id: nil)
    else
      true
    end
  end
  
end
