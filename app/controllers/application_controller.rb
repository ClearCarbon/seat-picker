class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_seat_admin
    unless current_user.email == 'admin@example.com'
      flash[:error] = "You do not have permission to do that."
      redirect_to root_path
    end
  end

end
