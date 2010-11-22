#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

$:.unshift(File.expand_path('.'))

require 'app/commander'
require 'app/models/user'
require 'app/models/game'



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
        @game = Mana::Game.find_or_create(id)
        @user = Mana::User.new('X', ws)
        @game.connect(@user)
      else
        # adds autohor to the command
        @game.received(command.merge(:sid => @user.sid))
      end

      ws.onclose { @game.disconnect(@user) }
    end
  end

  puts "Server started"
end
