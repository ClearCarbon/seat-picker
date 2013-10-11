class SeatDecorator < Draper::Decorator
  delegate_all

  def name
    row + number.to_s
  end
end
