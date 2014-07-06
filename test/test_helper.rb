ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
# Minitest::Reporters::ProgressReporter.new
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


class ActiveSupport::TestCase
  def john
    @john ||= User.create!(email: 'me@there.net', name: 'John', password: 'test1234')
  end

  def player_john
    @player_john ||= Player.create!(name: 'John', user: john, game: johns_game)
  end

  def johns_game
    @johns_game ||= Game.create! name: "John's game"
  end
end
