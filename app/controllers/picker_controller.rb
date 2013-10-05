class PickerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @seats = Seat.order('row asc', 'number asc')
  end
end
