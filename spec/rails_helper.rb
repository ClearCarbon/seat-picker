require 'simplecov'
SimpleCov.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/poltergeist'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.include Capybara::DSL              # Let's us use the capybara stuf in our specs
  config.include Warden::Test::Helpers      # Let's us do login_as(user)
  config.include Rails.application.routes.url_helpers
  config.include Devise::TestHelpers, :type => :controller
  config.after(:each) do
    Warden.test_reset!
  end

  config.mock_with :rspec

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each, js: true) do
    expect(current_path).to eq current_path
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  Capybara.asset_host = 'http://localhost:3000'


  class WarningSuppressor
    class << self
      def write(message)
        if message =~ /no title for patternMismatch provided. Always add a title attribute/ ||
           message =~ /QFont::setPixelSize: Pixel size <= 0/ ||
           message =~/CoreText performance note:/ ||
           message =~ /Method userSpaceScaleFactor in class NSView is deprecated on/ ||
           message =~ /loading all features without specifing might be bad for performance/ ||
           message =~ /detected use of select2 try to add support/
           0
        else
           puts(message)
           1
        end
      end
    end
  end

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, phantomjs_logger: WarningSuppressor, debug: false, window_size: [1280, 1024])
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.server do |app, port|
    require 'rack/handler/thin'
    Rack::Handler::Thin.run(app, :Port => port)
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        break if page.evaluate_script('jQuery.active') == 0
        sleep 0.5
      end
    end
  end
end
