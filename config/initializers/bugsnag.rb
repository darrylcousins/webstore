# frozen_string_literal: true

if defined?(Bugsnag) && Figaro.env.bugsnag_api_key.present?
  # :nocov:
  Bugsnag.configure do |config|
    config.api_key = Figaro.env.bugsnag_api_key
    config.notify_release_stages = %w[production staging]
  end
  # :nocov:
end
