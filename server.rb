#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)

require_all 'app'
Debugger.start

# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end



EventMachine.run do

  redis = EM::Protocols::Redis.connect
  redis.select(0)
  MagicCardsInfo.redis = redis
  
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    include Mana::Commander

    ws.onerror do |error|
      puts error.backtrace
    end
    
    ws.onopen do
      ws.send(encode(message('Connected to Websocket')))
    end
    
    ws.onmessage do |msg|
      command = decode(msg)
      action = command['action'].downcase.to_sym

      case action
      when :connect
        game_id = command['game']
        ws.game = Mana::Game.find_or_create(game_id)
        ws.user = Mana::User.new('X', ws)
        ws.game.connect(ws.user)
      when :server
        if command['operation'].downcase.to_sym == :update_library
          ws.user.update_library(command['operation']['args'])
        end
      else
        # adds author to the command
        ws.game.send_to_opponents(command.merge(:sid => ws.user.sid, :remote => true))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end

  puts "Mana server started"
end
