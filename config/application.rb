require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlsUnibo
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = "Rome"
    config.i18n.default_locale = :it

    config.hosts << "www.dm.unibo.it"
    config.action_mailer.default_url_options = { protocol: 'https' }
  end
end
