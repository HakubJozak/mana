#!/usr/bin/env ruby

$:.unshift(File.expand_path('.'))

require 'rubygems'
require 'bundler'


# Mongoid config - hack cause it recognizes only this env value to
# determine environment
ENV["RACK_ENV"] ||= 'production'


if ENV['RACK_ENV'] == 'development'
  Bundler.require(:default, :backend, :development)
else
# TODO: require the needed stuffmanually
  Bundler.require(:default, :backend)
end

if ENV['RACK_ENV'] == 'test'
  Random.srand(42)
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
require '../app/models/deck'

# TODO: do we really need Devise in the backend?
require '../config/initializers/devise.rb'
require '../app/models/user'

require '../app/models/player'
require '../app/models/card'
require '../app/models/card_stamp'

require 'table'
require 'player'
require 'websocket'
