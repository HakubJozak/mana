#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require

$:.unshift(File.expand_path('.'))

require 'app/controllers/static_controller'



Thin::Logging.debug = true


rack_app =  Rack::Builder.new do
  use Rack::Session::Cookie
  run Rack::Cascade.new( [ Mana::StaticController ] )
end


Rack::Handler::Thin.run(rack_app, :Port => 3000)
