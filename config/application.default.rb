require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = false
    config.restricted_registration_key = 
      'm7x6StfpPRRd8Ln7CjnkLtHZ'
    config.admin_email = 'chris@clear-carbon.co.uk'
  end
end
