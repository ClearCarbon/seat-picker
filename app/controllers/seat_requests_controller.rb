class SeatRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_seat, only: [:create]
  before_action :find_seat_request, except: [:create]
  before_action :set_seats
  respond_to :js

  def create
    @seat_request = SeatRequest.new(seat: @seat, user: current_user)
    authorize @seat_request, :create?

    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@seat_request, {})
  end

  def destroy
    authorize @seat_request, :destroy?

    StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@seat_request)
  end
  
  def deny
    authorize @seat_request, :destroy?

    StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@seat_request)
  end

  private

    def find_seat
      @seat = Seat.find(params[:seat_id])
    end

    def find_seat_request
      @seat_request = SeatRequest.find(params[:id])
    end

    def set_seats
      @rows = Seat.order(row: :asc).pluck(:row).uniq
      @seats = Seat.order(row: :asc, number: :desc).decorate
    end

end
