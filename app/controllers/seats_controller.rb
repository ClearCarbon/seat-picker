class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_seat, except: [:index]
  before_action :set_seats
  respond_to :html, only: [:index]
  respond_to :js, only: [:pick, :give_up]

  def index
  end

  def pick
    authorize @seat, :pick?
    params = { user_id: current_user.id }
    @seat = @seat.decorate
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@seat, params)
  end

  def give_up
    authorize @seat, :give_up?
    params = { user_id: nil }
    @seat = @seat.decorate
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@seat, params)
  end

  private

    def find_seat
      @seat = Seat.find(params[:id])
    end

    def set_seats
      @rows = Seat.rows
      @seats = Seat.ordered_seats
    end

end
