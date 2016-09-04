class Seat < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  has_many :seat_requests, dependent: :destroy
  validates :user_id, uniqueness: { scope: :event_id, allow_blank: true }
  
  validates :event, presence: true

  scope :ordered_seats, -> { Seat.order(row: :asc, number: :asc) }

  def self.rows
    Seat.order(row: :asc).pluck(:row).uniq
  end
end
