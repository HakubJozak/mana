# Generated by cucumber-sinatra. (2011-05-30 13:32:01 +0200)

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

require File.join(File.dirname(__FILE__), '..', '..', 'app/server.rb')

#require 'capybara'
require 'capybara/cucumber'
require 'test/unit/capybara'
#require 'rspec'

Capybara.app = Mana::Server

Capybara.run_server = false
Capybara.default_driver = :webkit
Capybara.app_host = 'http://localhost:3000'

class Mana::ServerWorld
  include Capybara
  include MiniTest::Assertions
  #include RSpec::Expectations
  #include RSpec::Matchers
  def setup
    if fork
      sleep 5
    else
      exec "bundle exec rackup"
    end
  end
end

World do
  Mana::ServerWorld.new
end
