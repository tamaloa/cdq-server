Airbrake.configure do |config|
  config.api_key = 'secret-key'
  config.host    = 'my-own-airbrake-host.example.com'
  config.port    = 80
  config.secure  = config.port == 443
end
