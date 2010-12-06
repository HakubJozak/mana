#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development)
Debugger.start rescue nil

$:.unshift(File.expand_path('.'))

require_all 'app'

Thin::Logging.debug = true


rack_app = Rack::Builder.new do
  use Rack::Session::Cookie
  run Rack::Cascade.new( [ Mana::StaticServer ] )
end

run rack_app

