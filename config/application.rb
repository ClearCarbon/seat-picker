require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = ENV['RESTRICTED_REGISTRATION'].downcase == 'true' ? true : false
    config.restricted_registration_key = ENV['RESTRICTED_REGISTRATION_KEY']
    
    config.autoload_paths += %W( #{config.root}/app/services #{config.root}/app/forms )
  end
end
