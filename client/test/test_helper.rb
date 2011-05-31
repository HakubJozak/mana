require 'bundler/setup'
Bundler.require :default, :test

require 'test/unit/capybara'
require 'capybara-webkit'

Capybara.run_server = false
Capybara.default_driver = :webkit
Capybara.app_host = 'http://localhost:3000'

# require File.join File.dirname(__FILE__), 'server'
