require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Lvlapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = false

    # CUSTOM CONFIG

    # Wordnik
    config.wordnik_api = ENV['WORDNIK_API']
    config.google_api_key = ENV['GOOGLE_API_KEY']

    # Microsoft
    config.azure_primary_account_key = ENV['AZURE_PRIMARY_ACCOUNT_KEY']
    config.azure_customer_id = ENV['AZURE_CUSTOMER_ID']
    config.azure_secret = ENV['AZURE_SECRET']

    # Sentry error logging
    config.raven_dsn = ENV['RAVEN_DSN']

    # rails secret
    config.secret_key_base = ENV['RAILS_SECRET_KEY_BASE']

    # google analytics
    config.google_analytics = ENV['GOOGLE_ANALYTICS']
  end
end
