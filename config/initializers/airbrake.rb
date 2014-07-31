Airbrake.configure do |config|
  config.api_key = 'secret-key'
  config.host    = 'my-own-airbrake-host.example.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.ignore_only = []

  ## Ignore Defaults were:
  # AbstractController::ActionNotFound
  # ActiveRecord::RecordNotFound
  # ActionController::RoutingError
  # ActionController::InvalidAuthenticityToken
  # ActionController::UnknownAction
  # ActionController::UnknownHttpMethod
  # CGI::Session::CookieStore::TamperedWithCookie
  # Mongoid::Errors::DocumentNotFound
  # ActionController::UnknownFormat
end
