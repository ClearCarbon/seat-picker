require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = false
    config.restricted_registration_key = 
      'LqZVYMe6PsfFBLvxcB92bm7hk5eCRZgPJPaZMnFAPgLvwWKH'
    
    config.action_mailer.default_url_options = { host: '10.0.33.33:3000' }
  end
end
