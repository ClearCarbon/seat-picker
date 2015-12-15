class SeatRequestPolicy < Struct.new(:user, :seat_request)
  def destroy?
    user.id == seat_request.user_id
  end

  def deny?
    seat_request.seat.user_id == user.id
  end

  def accept?
    seat_request.seat.user_id == user.id
  end

  def create?
    true
  end
end
