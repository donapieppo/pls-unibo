require "omniauth-entra-id"

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :developer, {
      fields: [:upn, :name, :surname],
      uid_field: :upn
    }
  end
end
