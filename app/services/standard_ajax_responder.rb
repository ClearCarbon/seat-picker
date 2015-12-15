class StandardAjaxResponder
  def initialize(controller)
    @controller = controller
  end

  def success(resource)
    render_success(resource)
  end

  def failure(resource)
    render_failure(resource)
  end

  private

  def render_success(resource)
    @controller.respond_with(resource) do |format|
      format.js   { @controller.render "#{@controller.action_name}_success" }
    end
  end

  def render_failure(resource)
    @controller.respond_with(resource) do |format|
      format.js   { @controller.render "#{@controller.action_name}_failure" }
    end
  end
end
