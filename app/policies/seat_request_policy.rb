class SeatRequestPolicy < Struct.new(:user, :seat_request)

  def cancel_request?
    user.id == seat_request.user_id
  end

  def donate?
    user.seat.id == seat_request.seat_id
  end

end
