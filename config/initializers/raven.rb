require 'raven'

Raven.configure do |config|
  config.dsn = Rails.configuration.raven_dsn || ''
  config.environments = %w[ production ]
end
