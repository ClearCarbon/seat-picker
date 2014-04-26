require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = true
    config.restricted_registration_key = 
      'CHANGEME'
    config.admin_email = 'admin@example.com'
  end
end
