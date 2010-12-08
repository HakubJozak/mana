#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
require 'thin'

# Config


if ENV['RACK_ENV'] == 'development'
  Bundler.require(:default, :development)
  Debugger.start
  ADDRESS = "0.0.0.0"
  STATIC_PORT = 3000
  PORT = 8080
else
  Bundler.require(:default)
  ADDRESS = "83.167.232.160"
  STATIC_PORT = 80
  PORT = 90
end


$:.unshift(File.expand_path('.'))

require_all 'app'

Thin::Logging.debug = true



# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end

class Rack::Builder
  include Mana::Commander
end



EM.run do

  @mongo = Mongo::Connection.new.db('mana')
  MagicCardsInfo.instance = MagicCardsInfo.new(@mongo)
  
  EventMachine::WebSocket.start(:host => ADDRESS, :port => PORT, :debug => true) do |ws|

    ws.onerror do |error|
      puts error.backtrace
    end
    
    ws.onopen do
      ws.send(encode(message('Connected to server')))
    end
    
    ws.onmessage do |msg|
      command = decode(msg)
      action = command['action'].downcase.to_sym

      case action
      when :connect
        ws.game = Mana::Game.find_or_create(command['game_id'])
        ws.user = Mana::User.new(command['username'], ws)
        ws.user.update_library(command['cards'])
        ws.game.connect(ws.user)

      when :server
        operation = command['operation'].downcase.to_sym

        case operation
        when :draw_a_card
          ws.user.draw_a_card
        end          
      else
        # adds author to the command
        ws.game.send_to_opponents(command.merge(:sid => ws.user.sid))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end
  

  Thin::Server.start Mana::Server, ADDRESS, STATIC_PORT

  puts "Mana server started"  
end
