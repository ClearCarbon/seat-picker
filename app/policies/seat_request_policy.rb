class SeatRequestPolicy < Struct.new(:user, :seat_request)

  def destroy?
    (user.id == seat_request.user_id) || (seat_request.seat.user_id == user.id)
  end

  def donate?
    seat_request.seat.user_id == user.id
  end

  def create?
    true
  end

end
