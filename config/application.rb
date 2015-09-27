require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    #if this is enabled users must go to http://yourdomain.com/users/sign_up?key=registration_key
    #to register for the seat picker, the registration link will not appear on the site
    config.restricted_registration = false
    config.restricted_registration_key = 'CHANGEME'
    config.autoload_paths += %W( #{config.root}/app/services #{config.root}/app/forms )
  end
end
