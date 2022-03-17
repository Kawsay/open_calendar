source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.6.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbo-rails', '~> 1.0.1'
gem 'devise', '~> 4.8.0'
gem 'pundit', '~> 2.2'
gem 'jwt', '~> 1.5'
gem 'doorkeeper', '~> 5.5', '>= 5.5.4'
gem 'simple_calendar', '~> 2.4'
gem 'image_processing', '>= 1.12.2'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'rspec-rails', '~> 5.0.3'
  gem 'shoulda-matchers'
  gem 'fabrication', '~> 2.27'
  gem 'pry'
  gem 'faker', '~> 2.19.0'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'brakeman'
  gem 'reek'
  gem 'bullet'
  gem 'annotate', '~> 3.2'
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem 'binding_of_caller', '~> 1.0'
end

group :test do
  gem 'rails-controller-testing'
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'pundit-matchers', '~> 1.7.0'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
