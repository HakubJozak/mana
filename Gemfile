source 'http://rubygems.org'
gem 'rails', '3.1.0'
gem "haml", ">= 3.0.25"

gem "bson_ext", ">= 1.3.0"
gem "mongoid", ">= 2.0.1", :git => 'https://github.com/mongoid/mongoid.git'
gem "devise", ">= 1.3.3"
gem 'jquery-rails'
gem 'formtastic'
gem 'thin'
gem 'god', '~> 0.11.0'


#group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem "compass"
#end

group :test do
  gem "cucumber-rails", ">= 0.4.1", :group => :test
  gem "capybara", ">= 0.4.1.2", :group => :test
  gem "database_cleaner", ">= 0.6.7", :group => :test
  gem "launchy", ">= 0.4.0", :group => :test
  gem 'turn', :require => false
end

group :production do
  gem 'therubyracer'
end

group :development do
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
