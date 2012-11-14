source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'
gem "haml", ">= 3.0.25"

gem 'bson_ext', '~> 1.4.0'
gem "mongoid", ">= 2.0.1"
gem "devise", ">= 1.3.3"
gem 'jquery-rails'
gem 'formtastic'
gem 'unicorn'

gem 'god', '~> 0.11.0', :require => false
gem 'mechanize', :require => false
gem 'em-websocket'
gem 'em-synchrony'


#group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'coffee-filter'
  gem 'uglifier'
  gem "compass"
#end

gem "fabrication"


group :test do
#  gem "minitest"
  gem "ruby-prof"
  gem "capybara", ">= 0.4.1.2"
  gem "capybara-webkit"
  gem "database_cleaner", ">= 0.6.7"
  gem "launchy", ">= 0.4.0"
  gem 'web-socket-ruby', :require => 'web_socket'
  gem 'webmock'
  gem 'vcr', :git => 'https://github.com/myronmarston/vcr.git'
end

group :development do
  gem 'newrelic_rpm'
  gem 'capistrano', '~> 2.9.0'
  gem 'capistrano_colors'
  gem "haml-rails", ">= 0.3.4"
  gem 'ruby-debug-base19'
  gem 'ruby-debug19'
  gem 'pry'
  gem 'pry-doc'
  gem 'guard-livereload'
  gem 'rb-inotify', '>= 0.5.1', :require => false # for Guard
end

group :backend do
  gem 'activesupport', :require => 'active_support'
  gem "mongoid", ">= 2.0.1"
end

group :performance do
  gem 'mechanize'
end
