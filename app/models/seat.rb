class Seat < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  has_many :seat_requests, dependent: :destroy
  before_save :ensure_one_seat_for_user
  attr_accessor :skip_user_checking
  
  validates :event, presence: true

  scope :ordered_seats, -> { Seat.order(row: :asc, number: :asc) }

  def ensure_one_seat_for_user
    return if skip_user_checking
    Seat.where(user_id: user_id).each do |seat|
      seat.skip_user_checking = true
      seat.update_attributes(user_id: nil) if seat.id != self.id
    end
  end

  def self.rows
    Seat.order(row: :asc).pluck(:row).uniq
  end
end
