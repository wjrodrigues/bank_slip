# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# https://github.com/rails/tailwindcss-rails
gem 'tailwindcss-rails', '~> 2.3'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# https://github.com/RubyMoney/money
gem 'money', '~> 6.16'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # https://github.com/rubocop/rubocop
  gem 'rubocop', '~> 1.60', '>= 1.60.2'

  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1'

  # https://github.com/rails/rails-controller-testing
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'

  # https://github.com/vcr/vcr
  gem 'vcr', '~> 6.2'

  # https://github.com/bblimke/webmock
  gem 'webmock', '~> 3.22'

  # https://github.com/simplecov-ruby/simplecov
  gem 'simplecov', '~> 0.22.0'

  # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '~> 6.1'

  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'

  # https://github.com/faker-ruby/faker
  gem 'faker', '~> 3.2', '>= 3.2.3'

  # https://github.com/travisjeffery/timecop
  gem 'timecop', '~> 0.9.8'

  # https://github.com/bkeepers/dotenv
  gem 'dotenv', '~> 3.0', '>= 3.0.2'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
