$:.unshift '.'

require 'test/test_helper'
require 'web_socket'

class BackendTest < BackendTestBase

  def setup
    super
  end

  def test_player_enters
    game = Fabricate(:game_with_players)
    player = game.players.first

    @browser = Browser.new(game.id, player.id)
    @browser.receive('Player')
    10.times { @browser.receive('Card') }
    @browser.close

    assert_equal player.name, @browser.player['name']
  end

  def test_shuffle
  end

end
