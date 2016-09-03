class Admin::EventsController < Admin::AdminController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  respond_to :html

  def index
    @events = Event.order(:name).all
    authorize @events, :create?
    authorize @events, :update?
    authorize @events, :destroy?
  end

  def edit
    @users = User.all
    authorize @event, :update?
  end

  def create
    @event = Event.new
    authorize @event
    EventCreator.new(StandardResponder.new(self, action: :index)).update(@event, NewEventForm.new(params[:event]))
  end

  def update
    authorize @event, :update?
    StandardUpdater.new(StandardResponder.new(self)).update(@event, event_params)
  end

  def destroy
    authorize @event, :destroy?
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@event)
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end
    
    def event_params
      params.require(:event).permit(:name, :total_seats, :rows)
    end
end
