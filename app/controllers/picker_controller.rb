class PickerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @selected_seats = Seat.where.not(user_id:nil)
  end
end
