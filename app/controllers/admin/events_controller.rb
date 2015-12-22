class Admin::EventsController < Admin::AdminController
  before_action :set_event, only: [:edit, :update, :destroy]
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index
  respond_to :html

  def index
    @events = policy_scope(Event).order(:created_at)
  end

  def new
    @event = Event.new
    authorize @event, :create?
  end

  def edit
    authorize @event, :update?
  end

  def create
    @event = Event.new(event_params)
    authorize @event, :create?
    StandardUpdater.new(StandardResponder.new(self)).update(@event, event_params)
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
    def event_params
      params.require(:event).permit(:title)
    end
    
    def set_event
      @event = Event.find(params[:id])
    end
end
