#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require

require 'cramp/controller'
require 'erb'
require 'sinatra/base'
require 'app/controllers/commands_controller'
require 'app/controllers/static_controller'
# require './config/routes'

Cramp::Controller::Websocket.backend = :thin

# Thin::Logging.trace = true
Thin::Logging.debug = true


rack_app =  Rack::Builder.new do
  use Rack::Session::Cookie
  
  command_routes = Usher::Interface.for(:rack) do
    get('/connect').to(Mana::CommandsController)
  end

  run Rack::Cascade.new( [ Mana::StaticController ] )
end


Rack::Handler::Thin.run(rack_app, :Port => 3000)
