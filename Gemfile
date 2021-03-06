source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'nokogiri', '~> 1.6'
gem 'rails_admin'
gem 'bootstrap-sass', '~> 2.3.2.1'
gem 'puma'

gem 'wordnik'
gem 'bing_translator', '~> 4.0'
gem 'language_list', '~> 1.0.0'
gem 'simple_form'
gem 'friendly_id', git: 'https://github.com/norman/friendly_id.git', branch: '5.0-stable'
gem 'sitemap_generator'
gem 'whenever', :require => false
gem 'social-share-button'
gem 'devise'
gem 'kaminari'
gem 'gravtastic'
gem 'mobile-fu'
# errors reporting
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"

# parse srt input files
gem 'srt'
gem 'google-api-client', require: false

group :development do
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
end

group :test, :development do
  gem 'pry-rails'
  gem 'pry-plus'
  gem 'debugger'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :test do
  gem 'bogus'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
group :assets do
  gem 'execjs'
  gem 'therubyracer'
end
# Use unicorn as the app server
# gem 'unicorn'

