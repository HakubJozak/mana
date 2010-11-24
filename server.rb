#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

$:.unshift(File.expand_path('.'))

require 'app/commander'
require 'app/models/user'
require 'app/models/game'

# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game
  attr_accessor :user
end



EventMachine.run do
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    include Mana::Commander

    ws.onerror do |error|
      puts error.backtrace
    end
    
    ws.onopen do
      ws.send(message('Connected to Websocket'))
    end
    
    ws.onmessage do |msg|
      command = decode(msg)

      if command['action'].downcase.to_sym == :connect
        id = command['game']
        ws.game = Mana::Game.find_or_create(id)
        ws.user = Mana::User.new('X', ws)
        ws.game.connect(ws.user)
      else
        # adds author to the command
        ws.game.received(command.merge(:sid => ws.user.sid, :remote => true))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end

  puts "Server started"
end
