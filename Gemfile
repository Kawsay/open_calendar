# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8.0'
gem 'doorkeeper', '~> 5.5', '>= 5.5.4'
gem 'image_processing', '>= 1.12.2'
gem 'jbuilder', '~> 2.7'
gem 'jwt', '~> 1.5'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.6.2'
gem 'pundit', '~> 2.2'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'simple_calendar', '~> 2.4'
gem 'turbo-rails', '~> 1.0.1'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'bullet', '~> 7.0', '>= 7.0.1'
  gem 'fabrication', '~> 2.27'
  gem 'faker', '~> 2.19.0'
  gem 'pry'
  gem 'rspec-rails', '~> 5.0.3'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman'
  gem 'letter_opener', '~> 1.8'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'reek'
  gem 'rubocop-rails', '~> 2.14', '>= 2.14.1'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'pundit-matchers', '~> 1.7.0'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
