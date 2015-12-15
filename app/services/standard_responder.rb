class StandardResponder
  attr_writer :action_name, :redirect_path, :success_text, :failure_text

  def initialize(controller, params = {})
    @controller = controller
    @success_text = params[:success_text] if params[:success_text]
    @failure_text = params[:failure_text] if params[:failure_text]
    @redirect_path = params[:redirect_path] if params[:redirect_path]
    @action_name = params[:action_name] if params[:action_name]
  end

  def success(resource)
    set_success_message
    success_response(resource)
  end

  def failure(resource)
    set_failure_message
    failure_response(resource)
  end

  private

  def success_message
    @success_text || 'Successfully saved record'
  end

  def failure_message
    @failure_text || 'Failed to save record, please check the form for errors.'
  end

  def success_response(resource)
    @controller.respond_with(resource, location: redirect_path)
  end

  def failure_response(resource)
    @controller.respond_with(resource, action: action_name)
  end

  def redirect_path
    @redirect_path || @controller.url_for(action: :index)
  end

  attr_reader :action_name

  def set_success_message
    @controller.flash[:notice] = success_message
  end

  def set_failure_message
    @controller.flash.now[:alert] = failure_message
  end
end
