class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_seat, only: [:pick]
  respond_to :html, only: [:index]
  respond_to :js, only: [:pick]

  def index
    set_seats
  end

  def pick
    authorize @seat, :pick?
    params = { user_id: current_user.id }

    set_seats
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@seat, params)
  end

  def find_seat
    @seat = Seat.find(params[:id])
  end

  def set_seats
    @rows = Seat.order(row: :asc).pluck(:row).uniq
    @seats = Seat.order(row: :asc, number: :desc).decorate
  end

end
