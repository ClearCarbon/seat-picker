class RegistrationsController < Devise::RegistrationsController
  before_filter :registration_allowed!, except: [:edit, :update]

  def ensure_registration_key!
    key = ENV["restricted_registration_key"]
    given_key = params[:key]

    if key != given_key
      redirect_to :root
    end
  end

  def registration_allowed!
    restricted = ENV["restricted_registration"]
    if restricted == true
      return ensure_registration_key!
    end
  end
end 
