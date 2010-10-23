require 'rubygems'
require 'bundler'

Bundler.require

require 'cramp/controller'

require 'app/controllers/commands_controller'
require './config/routes'

Cramp::Controller::Websocket.backend = :thin
Thin::Logging.trace = true
Rack::Handler::Thin.run(app_routes, :Port => 3333)
