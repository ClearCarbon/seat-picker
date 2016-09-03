class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :seats
  has_many :seat_requests
  validates :username, presence: true

  def requested?(seat)
    SeatRequest.where(user: self, seat: seat).any?
  end

  def request(seat)
    SeatRequest.where(user: self, seat: seat).first
  end
  
  def seat(event)
    seats.where(event: event).first
  end

  def admin?
    admin
  end

  def promote_to_admin!
    self.admin = true
    save
  end

  def demote_from_admin!
    self.admin = false
    save
  end
end
