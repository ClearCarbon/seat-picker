class SeatRequest < ActiveRecord::Base
  belongs_to :seat
  belongs_to :user

  validates :user, :seat, presence: true

  after_save :send_mail

  def send_mail
    SeatMailer.new_request(user, seat).deliver
  end
end
