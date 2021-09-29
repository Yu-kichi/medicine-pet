# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "active_storage_validations", "~> 0.8.8"
gem "bootsnap", ">= 1.4.2", require: false
gem "bulma-rails", "~> 0.9.1"
gem "devise"
gem "devise-i18n"
gem "devise-i18n-views"
gem "image_processing", "~> 1.2"
gem "jbuilder", "~> 2.7"
gem "meta-tags"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.7"
gem "rails_autolink"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "slim"
gem "webpacker", "~> 4.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry-byebug"
  gem "rspec-rails", "~> 5.0.0"
  gem "spring-commands-rspec"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "~> 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  # not default
  gem "bullet"
  gem "rails-erd"
  gem "rubocop", "~> 1.12", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "slim_lint"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
