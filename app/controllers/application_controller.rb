class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_seat_admin
    unless admin?
      flash[:error] = "You do not have permission to do that."
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  include ApplicationHelper

end

