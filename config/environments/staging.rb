# Based on production defaults
require Rails.root.join("config/environments/production")

DataQualityCollector::Application.configure do
  # See everything in the log (default is :info)
  #config.log_level = :debug

  #Email-Setup
  config.action_mailer.delivery_method = :test

  #We are not using apache for staging thus we need to serve assets our self
  config.serve_static_assets = true

end