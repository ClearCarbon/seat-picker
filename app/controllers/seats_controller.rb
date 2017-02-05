class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_seat, except: [:index]
  before_action :set_seats
  respond_to :html, only: [:index]
  respond_to :js, only: [:pick, :give_up]

  def index
  end

  def pick
    authorize @seat, :pick?
    params = { user_id: current_user.id }
    @seat = @seat.decorate
    UserSeatPicker.new(StandardAjaxResponder.new(self)).pick(@seat, current_user)
  end

  def give_up
    authorize @seat, :give_up?
    params = { user_id: nil }
    @seat = @seat.decorate
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@seat, params)
  end

  private

  def set_seat
    @seat = @event.seats.includes(:event).find(params[:id]).decorate
  end

  def set_seats
    @rows = @event.seats.rows
    @seats = @event.seats.ordered_seats.includes(:event).decorate
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

end
