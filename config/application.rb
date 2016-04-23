require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SeatPicker
  class Application < Rails::Application
    config.restricted_registration = ENV['RESTRICTED_REGISTRATION'].downcase == 'true' ? true : false
    config.restricted_registration_key = ENV['RESTRICTED_REGISTRATION_KEY']
    
    #letter_opener or smtp
    ActionMailer::Base.delivery_method = ENV['MAIL_DELIVERY_METHOD'].to_sym
    
    if ActionMailer::Base.delivery_method == :smtp
      ActionMailer::Base.smtp_settings = {
        port: ENV['SMTP_PORT'].to_i,
        address: ENV['SMTP_SERVER'],
        user_name: ENV['SMTP_USERNAME'],
        password: ENV['SMTP_PASSWORD'],
        domain: ENV['SMTP_DOMAIN'],
        authentication: ENV['SMTP_AUTHENTICATION'].to_sym,
        enable_starttls_auto: ENV['SMTP_STARTTLS_AUTO'].downcase == 'true' ? true : false
      }
    end

    config.action_mailer.default_url_options = {
      host: ENV['MAIL_DEFAULT_URL_DOMAIN']
    }
    
    config.autoload_paths += %W( #{config.root}/app/services #{config.root}/app/forms )
  end
end
