SeatPicker::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  
  #:cram_md5
  ActionMailer::Base.smtp_settings = {
    port: ENV['SMTP_PORT'].to_i,
    address: ENV['SMTP_SERVER'],
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    domain: ENV['SMTP_DOMAIN'],
    authentication: ENV['SMTP_AUTHENTICATION'].to_sym,
    enable_starttls_auto: ENV['SMTP_STARTTLS_AUTO'].downcase == 'true' ? true : false
  }
  ActionMailer::Base.delivery_method = :smtp

  config.action_mailer.default_url_options = {
    host: ENV['MAIL_DEFAULT_URL_DOMAIN']
  }
end
