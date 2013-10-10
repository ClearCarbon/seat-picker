require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = true
    config.restricted_registration_key = 
      'LqZVYMe6PsfFBLvxcB92bm7hk5eCRZgPJPaZMnFAPgLvwWKH'
  end
end
