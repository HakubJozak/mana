#!/usr/bin/env ruby

$:.unshift(File.expand_path('.'))

require 'rubygems'
require 'bundler'


if ENV['RACK_ENV'] == 'production'
  require 'config/production.rb'

  Bundler.require(:default)
  ADDRESS = "83.167.232.160"
  WEBSOCKET_PORT = 80
else
  Bundler.require(:default, :development)
  ADDRESS = "0.0.0.0"
  WEBSOCKET_PORT = 8080
end


require '../lib/library'
require '../lib/magic_cards_info'
require '../lib/commander'

require '../app/models/game'
require '../app/models/player'
require '../app/models/card'
require '../app/models/client/user'

require 'table'



# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end

# MEGA-HACK just for now
class Object
  include Mana::Commander
end


# Mongoid config - hack cause it recognizes only this env value to
# determine environment
ENV["RACK_ENV"] = 'development' # 'production'
Mongoid.load!("./mongoid.yml")


EM.synchrony do

  @mongo = Mongo::Connection.new.db('mana')
  MagicCardsInfo.instance = MagicCardsInfo.new(@mongo)

  EventMachine::WebSocket.start(:host => ADDRESS, :port => WEBSOCKET_PORT, :debug => true) do |ws|

    ws.onerror do |error|
      puts error.backtrace
    end

    ws.onopen do
      puts "Client connected"
    end

    ws.onmessage do |msg|
      command = decode(msg)

      puts msg.to_json

      # LEGACY logic (Backbone does not save 'action')
      if command['action']
        game = Game.find(command['game_id'])
        ws.game = Table.find(game)
        ws.game.sitdown(command['player_id'], ws)
      else
        # adds author to the command
        ws.game.send_to_opponents(command.merge(:sid => ws.user.sid))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end

  puts "Mana backend started!"
end
