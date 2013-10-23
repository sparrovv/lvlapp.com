require 'raven'

Raven.configure do |config|
  config.dsn = '***REMOVED***'
  config.environments = %w[ production ]
end
