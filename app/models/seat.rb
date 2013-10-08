class Seat < ActiveRecord::Base
  belongs_to :user
  before_save :ensure_one_seat_for_user
  attr_accessor :skip_user_checking

  def ensure_one_seat_for_user
    return if skip_user_checking
    Seat.where(user_id: self.user_id).each do |seat|
      seat.skip_user_checking = true
      seat.update_attributes(user_id: nil)
    end
  end
end
