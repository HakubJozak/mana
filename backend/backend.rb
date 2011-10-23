#!/usr/bin/env ruby

$:.unshift(File.expand_path('.'))

require 'rubygems'
require 'bundler'


# Mongoid config - hack cause it recognizes only this env value to
# determine environment
ENV["RACK_ENV"] ||= 'production'


if ENV['RACK_ENV'] == 'development'
  Bundler.require(:default, :development)
else
  Bundler.require(:default)
end

if ARGV.length == 2
  ADDRESS = ARGV[0]
  WEBSOCKET_PORT = ARGV[1]
else
  puts "Run it as: bundle exec backend.rb HOST PORT"
  exit
end

require '../lib/card_collection'
require '../lib/commander'

require '../app/models/game_event'
require '../app/models/game'
require '../app/models/player'
require '../app/models/card'

require 'table'
require 'active_player'



# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :table
end


Mongoid.load!("../config/mongoid.yml")

# TODO -
# require 'em-synchrony-mongodb'
# EM.synchrony do
EM.run do

  # @mongo = Mongo::Connection.new.db('mana')

  EventMachine::WebSocket.start(:host => ADDRESS, :port => WEBSOCKET_PORT, :debug => true) do |ws|

    ws.onerror do |error|
      puts error.backtrace
    end

    ws.onopen do
      ws.request['path'] =~ %r{/games/(\S*)/players/(\S*)}
      game_id = $1
      player_id = $2

      game = Game.find(game_id)
      ws.table = Table.find_or_create(game)
      ws.table.sitdown(player_id, ws)

      puts "Player #{player_id} connected."
    end
  end

  puts "Mana backend started!"
end
