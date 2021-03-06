class SeatDecorator < Draper::Decorator
  delegate_all

  def name
    row + number.to_s
  end

  def popover_title
    "#{h.avatar_for(source.user, size: :micro, width: '25px', height: '25px')} #{seat.user.try(:username) || 'Empty seat'}"
  end

  def user_username
    user.username
  end
end
