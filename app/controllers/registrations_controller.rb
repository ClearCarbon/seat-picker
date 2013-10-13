class RegistrationsController < Devise::RegistrationsController
  before_filter :registration_allowed!

  def ensure_registration_key!
    key = Rails.application.config.restricted_registration_key
    given_key = params[:key]

    if key != given_key
      redirect_to :root
    end
  end

  def registration_allowed!
    restricted = Rails.application.config.restricted_registration

    if restricted == true
      return ensure_registration_key!
    end
  end
end 
