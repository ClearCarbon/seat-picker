class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  private

  def require_seat_admin
    unless admin?
      flash[:error] = "You do not have permission to do that."
      redirect_to root_path
    end
  end

  include ApplicationHelper

end

