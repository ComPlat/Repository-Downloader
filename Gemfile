source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "3.4.2"

# Use postgresql as the database for Active Record
gem "pg", "1.4.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "5.6.5"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", "1.0.3"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails", "1.1.1"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "1.2022.7", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "1.15.0", require: false

# Use Grape to create a REST API and generate a Swagger UI to interact with the endpoints [https://www.ruby-grape.org/]
gem "grape", "1.6.2"
gem "grape-swagger", "1.5.0" # [https://github.com/ruby-grape/grape-swagger]

# Use Sass to process CSS
# gem "sassc-rails"

# Ruby Object mapper and serialization library for JSON, YAML, TOML, CSV and XML [https://www.shalerb.org/]
gem "shale", "0.9.0"

# Autoload dotenv in Rails [https://github.com/bkeepers/dotenv]
gem "dotenv-rails", "2.8.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "1.6.2", platforms: %i[mri mingw x64_mingw]

  # Ruby Style Guide, with linter & automatic code fixer [https://github.com/testdouble/standard]
  gem "standard", "1.19.1", require: false #
  gem "rubocop-rails", "2.17.3", require: false # [https://docs.rubocop.org/rubocop-rails/]
  gem "rubocop-rspec", "2.15.0", require: false # [https://docs.rubocop.org/rubocop-rspec/]
  gem "rubocop-thread_safety", "0.4.4", require: false # [https://github.com/rubocop/rubocop-thread_safety]

  # Behaviour-Driven Development tool for the TDD part focusing on the documentation and design aspects of TDD [https://relishapp.com/rspec/]
  gem "rspec-rails", "6.0.1" # RSpec for Rails 5+ [https://relishapp.com/rspec/rspec-rails/docs]
  gem "rails-controller-testing", "1.0.5" # Needed for Controller tests [https://github.com/rails/rails-controller-testing]
  gem "shoulda-matchers", "5.2.0" # Simple One-Liner Tests for Rails [https://matchers.shoulda.io/]
  gem "factory_bot_rails", "6.2.0" # fixtures replacement with a straightforward definition syntax, support for multiple build strategies and support for multiple factories for the same class [https://github.com/thoughtbot/factory_bot_rails]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "4.2.0"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # A Ruby code quality reporter [https://github.com/whitesmith/rubycritic]
  gem "rubycritic", "4.7.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", "3.37.1"
  gem "selenium-webdriver", "4.5.0"
  gem "webdrivers", "5.2.0"
end
