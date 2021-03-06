# frozen_string_literal: true

require File.expand_path("boot", __dir__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BuckyBox
  module Webstore
    class Application < Rails::Application
      # Settings in config/environments/* take precedence over those specified here.
      # Application configuration should go into files in config/initializers
      # -- all .rb files in that directory are automatically loaded.

      # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
      # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
      # config.time_zone = 'Central Time (US & Canada)'

      # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
      config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]

      # https://github.com/svenfuchs/rails-i18n
      config.i18n.available_locales = Dir[Rails.root.join("config", "locales", "*")]
                                      .select { |path| File.directory?(path) && !File.symlink?(path) }
                                      .map { |directory| File.basename directory }

      config.i18n.default_locale = :en

      # fall back to config.i18n.default_locale translation if key is missing
      config.i18n.fallbacks = true

      # http://stackoverflow.com/questions/20361428/rails-i18n-validation-deprecation-warning
      config.i18n.enforce_available_locales = true

      # For not swallow errors in after_commit/after_rollback callbacks.
      # config.active_record.raise_in_transactional_callbacks = true

      # Custom directories with classes and modules you want to be autoloadable.
      config.autoload_paths += Dir["#{config.root}/app/models/checkout"]
      config.autoload_paths += Dir["#{config.root}/lib"]

      # Use memory store since we only need to cache a few megabytes
      config.cache_store = :memory_store, { compress: false }
    end
  end
end
