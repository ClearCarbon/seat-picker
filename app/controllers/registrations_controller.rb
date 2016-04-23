class RegistrationsController < Devise::RegistrationsController
  before_filter :ensure_registration_allowed!, except: [:edit, :update]
  helper_method :registration_allowed?

  def ensure_registration_allowed!
    redirect_to :root unless registration_allowed?
  end

  private
  
    def registration_allowed?
      Rails.configuration.restricted_registration == false || Rails.configuration.restricted_registration_key == params[:key]
    end
    
end
