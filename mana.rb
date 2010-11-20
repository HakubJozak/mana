#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require

require 'cramp/controller'
require 'erb'
require 'sinatra/base'
require 'app/controllers/commands_controller'
# require './config/routes'

Cramp::Controller::Websocket.backend = :thin

# Thin::Logging.trace = true
Thin::Logging.debug = true

class Mana < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/public'

  get '/:name.css' do
    scss "#{params[:name]}".to_sym
  end
  
  get '/' do
    haml :index
  end
end


routes =  Rack::Builder.new do
  use Rack::Session::Cookie
  
  # routes = Usher::Interface.for(:rack) do
  #   get('/connect').to(CommandsController)
  # end

  run Rack::Cascade.new( [ Mana ] )
end


Rack::Handler::Thin.run(routes, :Port => 3000)
