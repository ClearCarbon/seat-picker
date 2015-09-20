class SeatRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_seat, only: [:new, :create]
  before_action :find_seat_request, except: [:create]
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
    StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@seat_request)
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

    def find_seat
      @seat = Seat.find(params[:seat_id]) if params[:seat_id]
    end

    def find_seat_request
      @seat_request = SeatRequest.find(params[:id]) if params[:id]
    end

    def set_seats
      @rows = Seat.rows
      @seats = Seat.ordered_seats
    end

end
