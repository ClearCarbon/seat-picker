class RegistrationsController < Devise::RegistrationsController
  before_filter :registration_allowed!, except: [:edit, :update]

  def ensure_registration_key!
    key = ENV['restricted_registration_key']
    given_key = params[:key]

    redirect_to :root if key != given_key
  end

  def registration_allowed!
    restricted = ENV['restricted_registration']
    return ensure_registration_key! if restricted == true
  end
end
