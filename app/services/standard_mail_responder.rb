class StandardMailResponder
  attr_writer :mail

  def initialize(listener, params = {})
    @listener = listener
    @mail = params[:mail] if params[:mail]
  end

  def success(resource)
    @mail.deliver_later
    @listener.success(resource)
  end

  def failure(resource)
    @listener.failure(resource)
  end
end
