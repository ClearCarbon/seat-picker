class SeatMailer < ActionMailer::Base
  default from: "seat_picker@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.seat_mailer.new_request.subject
  #
  def new_request(seat_request)
    @seat_request = seat_request.decorate
    mail to: seat_request.seat.user.email, subject: "#{@seat_request.user_username} has requested your seat"
  end
  
  def request_accepted(seat_request_user, seat_user)
    @seat_request_user = seat_request_user.decorate
    @seat_user = seat_user.decorate
    mail to: seat_request_user.email, subject: "#{seat_user.username} accepted your request"
  end
  
  def request_denied(seat_request_user, seat_user)
    @seat_request_user = seat_request_user.decorate
    @seat_user = seat_user.decorate
    mail to: seat_request_user.email, subject: "#{seat_user.username} declined your request"
  end
end
