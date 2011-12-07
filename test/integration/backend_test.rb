$:.unshift '.'

require 'test/test_helper'
require 'web_socket'

class BackendTest < BackendTestBase

  def setup
    super
    start_backend
  end

  def test_connect
    game = Fabricate(:game_with_players)
    player = game.players.first

    @browser = Browser.new(game.id, player.id)

    @browser.receive('Player')
    assert_equal nil, @browser.player['connected']

    10.times { @browser.receive('Card') }
    @browser.receive('Player')

    assert_equal player.name, @browser.player['name']
    assert_equal true, @browser.player['connected']
  end

  def test_shuffle
  end

end
