class Admin::SeatsController < Admin::AdminController
  before_filter :authenticate_user!
  before_action :set_event
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index
  respond_to :html

  def index
    @seats = policy_scope(Seat).order(:row, :number).where(event: @event)
    authorize @seats, :create?
    authorize @seats, :update?
    authorize @seats, :destroy?
    @seats = @seats.decorate
  end

  def new
    @users = User.all.decorate
    @seat = Seat.new(event: @event)
    authorize @seat, :create?
  end

  def edit
    @users = User.all.decorate
    authorize @seat, :update?
  end

  def create
    @seat = Seat.new(seat_params.merge(event: @event))
    authorize @seat
    StandardUpdater.new(StandardResponder.new(self)).update(@seat, seat_params)
  end

  def update
    authorize @seat, :update?
    StandardUpdater.new(StandardResponder.new(self)).update(@seat, seat_params)
  end

  def destroy
    authorize @seat, :destroy?
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@seat)
  end

  private

  def set_seat
    @seat = @event.seats.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def seat_params
    params.require(:seat).permit(:row, :number, :reserved, :user_id)
  end

end
