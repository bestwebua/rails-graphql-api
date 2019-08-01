# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'graphql', '~> 1.9'
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'rails', '~> 6.0.0.rc2'
gem 'sass-rails'
gem 'webpacker'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
  gem 'factory_bot_rails'
  gem 'fasterer', require: false
  gem 'ffaker'
  gem 'overcommit', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails_best_practices', require: false
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'graphiql-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'dry-schema', '~> 1.3', '>= 1.3.1'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end
