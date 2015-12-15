class SeatRequest < ActiveRecord::Base
  belongs_to :seat
  belongs_to :user
  validates :user, :seat, presence: true
  validate :not_already_requested

  private

  def not_already_requested
    if user.requested?(seat)
      errors.add(:user_id, "You can't request a seat you've already requested.")
    end
  end
end
