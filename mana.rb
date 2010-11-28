#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development)


$:.unshift(File.expand_path('.'))

require_all 'app'

Thin::Logging.debug = true


rack_app =  Rack::Builder.new do
  use Rack::Session::Cookie
  run Rack::Cascade.new( [ Mana::StaticServer ] )
end

Rack::Handler::Thin.run(rack_app, :Port => 3000)
