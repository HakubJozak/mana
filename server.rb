#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default) #, :development)

require_all 'app'
Debugger.start rescue nil

# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end



EventMachine.run do
end
