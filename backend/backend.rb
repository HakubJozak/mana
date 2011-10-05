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


# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :game, :user
end

# MEGA-HACK just for now
class Object
  include Mana::Commander
end

class Table

  def initialize(game)
    @game = game
    @users = []
    @queue = []
    @channel = EM::Channel.new
  end

  def connect(user)
    user.sid = @channel.subscribe do |pack|
      # TODO: subclass EM::Channel to do this
      user.message_to_client(pack[:scope], pack[:command])
    end

    # add all others to new user
    @users.each do |remote_user|
      args = { :user => remote_user.to_hash(:include_library => true) }
      user.message_to_client(:all, args)
    end

    # add new user to new user
    # TODO: replace :local with requestID
    args = { :user => user.to_hash(:include_library => true).merge(:local => true)  };
    user.message_to_client(:me, args)

    # add new user to all others
    @users.each do |remote_user|
      args = { :user => user.to_hash(:include_library => true) };
      remote_user.message_to_client(:opponents, args)
    end

    @users << user
  end

  def send_to_opponents(command)
    broadcast_to :opponents, command
  end

  def disconnect(user)
    @users.delete(user)
    @channel.unsubscribe(user.sid)
    # TODO - send just ID and type
    # broadcast_to :opponents, user.to_hash
  end

  private

  # TODO: subclass EM::Channel to do this
  def broadcast_to(scope, command)
    @channel.push(:scope => scope, :command => command)
  end

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
        ws.game = Table.new(game)
        ws.user = Mana::User.new(ws, game.players.find(command['player_id']))
        ws.game.connect(ws.user)
      else
        # adds author to the command
        ws.game.send_to_opponents(command.merge(:sid => ws.user.sid))
      end

      ws.onclose { ws.game.disconnect(ws.user) }
    end
  end

  puts "Mana backend started!"
end
