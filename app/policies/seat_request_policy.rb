class SeatRequestPolicy < Struct.new(:user, :seat_request)

  def destroy?
    user.id == seat_request.user_id
  end

  def donate?
    user.seat.id == seat_request.seat_id
  end

  def create?
    true
  end

end
