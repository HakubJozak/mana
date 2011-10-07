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
require 'active_player'





# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :table
end

# MEGA-HACK just for now
class Object
  include Mana::Commander
end


# Mongoid config - hack cause it recognizes only this env value to
# determine environment
ENV["RACK_ENV"] = 'development' # 'production'
Mongoid.load!("./mongoid.yml")

# TODO -
# require 'em-synchrony-mongodb'
# EM.synchrony do
EM.run do

  @mongo = Mongo::Connection.new.db('mana')
  MagicCardsInfo.instance = MagicCardsInfo.new(@mongo)

  EventMachine::WebSocket.start(:host => ADDRESS, :port => WEBSOCKET_PORT, :debug => true) do |ws|

    ws.onerror do |error|
      puts error.backtrace
    end

    ws.onopen do
      ws.request['path'] =~ %r{/games/(\S*)/players/(\S*)}
      game_id = $1
      player_id = $2

      game = Game.find(game_id)
      @table = Table.find_or_create(game)
      @table.sitdown(player_id, ws)

      puts "Player #{player_id} connected."
    end

    ws.onmessage do |msg|
      command = decode(msg)
      puts msg.to_json

      @table.send_to_opponents(command)

      ws.onclose { @table.disconnect(ws.user) }
    end
  end

  puts "Mana backend started!"
end
