class SeatRequestAcceptor < Struct.new(:listener)
  def accept(seat_request)
    seat = seat_request.seat
    seat.user = seat_request.user

    if seat.save
      seat_request.destroy
      listener.success(seat_request)
    else
      listener.failure(seat_request)
    end
  end
end
