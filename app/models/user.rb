class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :seat
  has_many :seat_requests

  def requested?(seat)
    SeatRequest.where(user: self, seat: seat).any?
  end
end
