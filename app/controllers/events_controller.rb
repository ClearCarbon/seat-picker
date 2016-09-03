class EventsController < Admin::AdminController
  before_filter :authenticate_user!
  after_action :verify_authorized
  respond_to :html

  def index
    @events = Event.order(:name).all
    authorize @events, :pick?
  end

end
