class SeatRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_seat, only: [:new, :create]
  before_action :set_seat_request, except: [:create]
  before_action :set_seats
  respond_to :js

  def new
    authorize SeatRequest, :create?
    @seat_request = SeatRequest.new(seat: @seat, user: current_user)
    @seat_request = @seat_request.decorate
    render layout: false
  end

  def create
    @seat_request = SeatRequest.new(seat: @seat, user: current_user)
    authorize @seat_request, :create?
    @seat_request = @seat_request.decorate
    mail_responder = StandardMailResponder.new(StandardAjaxResponder.new(self),
                                               mail: SeatMailer.new_request(@seat_request.source))
    StandardUpdater.new(mail_responder).update(@seat_request, seat_request_params)
  end

  def destroy
    authorize @seat_request, :destroy?
    @seat_request = @seat_request.decorate
    mail_responder = StandardMailResponder.new(StandardAjaxResponder.new(self),
                                               mail: SeatMailer.request_cancelled(current_user, @seat_request.seat.user))

    StandardDestroyer.new(mail_responder).destroy(@seat_request)
  end

  def show
    @seat_request = @seat_request.decorate
    render layout: false
  end

  def deny
    authorize @seat_request, :deny?
    @seat_request = @seat_request.decorate
    mail_responder = StandardMailResponder.new(StandardAjaxResponder.new(self),
                                               mail: SeatMailer.request_denied(@seat_request.source.user, current_user))

    StandardDestroyer.new(mail_responder).destroy(@seat_request)
  end

  def accept
    authorize @seat_request, :accept?
    @seat_request = @seat_request.decorate
    mail_responder = StandardMailResponder.new(StandardAjaxResponder.new(self),
                                               mail: SeatMailer.request_accepted(@seat_request.source.user, current_user))
    SeatRequestAcceptor.new(mail_responder).accept(@seat_request)
  end

  private

  def seat_request_params
    params.require(:seat_request).permit(:reason)
  end

  def set_seat
    @seat = @event.seats.includes(:event).find(params[:seat_id]).decorate if params[:seat_id]
  end

  def set_seat_request
    @seat_request = @event.seat_requests.find(params[:id]) if params[:id]
  end

  def set_seats
    @rows = @event.seats.rows
    @seats = @event.seats.ordered_seats.includes(:event).decorate
  end
  
  def set_event
    @event = Event.find(params[:event_id])
  end
  
end
