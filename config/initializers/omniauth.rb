OmniAuth.config.allowed_request_methods = [:post]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['PLS_GOOGLE_APP_ID'], ENV['PLS_GOOGLE_APP_SECRET'] #, {provider_ignores_state: true}
  provider :developer unless Rails.env.production?
end

