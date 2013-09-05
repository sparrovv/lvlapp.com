RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'foo' && password == 'bar'
    end
  end
end
