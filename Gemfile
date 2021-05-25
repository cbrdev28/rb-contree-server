# frozen_string_literal: true

# rubocop:disable Style/SymbolArray

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4.2'
# Use Puma as the app server
gem 'puma', '~> 5.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4.8', require: false

gem 'graphql', '~> 1.11.4'

gem 'bcrypt', '~> 3.1.16'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
# gem 'rack-cors'

gem 'redis', '~> 3.3.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', '~> 11.1.3', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'graphiql-rails', '~> 1.7.0'
  gem 'listen', '~> 3.2.1'
  gem 'rubocop', '~> 0.92.0', require: false
  gem 'rubocop-rails', '~> 2.8.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data',
    '~> 1.2020.1',
    platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# rubocop:enable Style/SymbolArray
