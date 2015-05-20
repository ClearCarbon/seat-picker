class SeatRequestDecorator < Draper::Decorator
  delegate_all
  decorates_association :seat
  decorates_association :user

  def seat_name
    seat.name
  end
  
end
