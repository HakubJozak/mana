# A sample Gemfile
source :rubygems

gem 'rack', '~> 1.2.1'
gem 'thin'
gem 'haml'
# gem 'haml-more', '~> 0.5.1.beta' # Coffee script on-fly translator
# gem 'escape_utils' # HAML speed-up
gem 'compass'
#gem 'sass' # required by compass
gem 'sinatra'
# gem 'sinatra_more'
gem 'activesupport', :require => 'active_support'

gem 'bson_ext', '~> 1.3.1'
gem 'em-websocket'
# gem 'em-mongo'
gem 'mongo', '~> 1.3.1'
gem 'sinatra-mongo'
gem 'require_all'
gem 'coffee-script'

group :development do
  gem 'railsless-deploy', :require => false
  gem 'sinatra-reloader'
  gem 'awesome_print'
  gem 'ruby-debug-base19'
  gem 'ruby-debug19'
end

group :tools do
  gem 'capistrano'
  gem 'capistrano_colors'
end


group :test do
  gem 'shotgun'
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'test-unit-capybara'

  gem 'autotest'
  gem 'autotest-growl'
#  gem 'autotest-fsevent'
  gem 'cucumber'
  gem 'launchy'
  gem 'bermuda', :require => false #'bermuda/cucumber' # jQuery UI helpers for capybara/cucumber

  gem 'shoulda'
  gem 'mocha'
end
