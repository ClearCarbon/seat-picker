class ApplicationController < ActionController::Base
  layout :layout_by_resource
  include Pundit
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :registration_allowed?

  protected

  def layout_by_resource
    if devise_controller? && !user_signed_in?
      'registrations'
    else
      'application'
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def registration_allowed?
    Rails.configuration.restricted_registration == false || Rails.configuration.restricted_registration_key == params[:key]
  end

end
