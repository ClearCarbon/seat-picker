SeatPicker::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.action_controller.action_on_unpermitted_parameters = :raise
  config.assets.debug = true

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = {
    host: 'localhost',
    port: 3000
  }
end
