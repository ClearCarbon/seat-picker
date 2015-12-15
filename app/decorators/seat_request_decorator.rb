class SeatRequestDecorator < Draper::Decorator
  delegate_all
  decorates_association :seat
  decorates_association :user

  def seat_name
    seat.name
  end

  def user_username
    user.username
  end

  def seat_user_username
    seat.user_username
  end
end
