source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.0.0"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"

gem "importmap-rails"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"

gem "jbuilder"

gem "simple_form"
gem "pundit"
gem "view_component"

gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-shibboleth"
gem "omniauth-rails_csrf_protection"
gem "pretender"

gem "recaptcha"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "rack-protection", "~> 2.2"

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "factory_bot_rails"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
end
