class SeatMailer < ActionMailer::Base
  default from: "seat_picker@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.seat_mailer.new_request.subject
  #
  def new_request(seat)
    @seat = seat
    mail to: seat.user.email, subject: 'Someone has requested your seat.'
  end
end
