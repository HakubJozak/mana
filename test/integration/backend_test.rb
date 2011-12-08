$:.unshift '.'

require 'test/test_helper'
require 'web_socket'

class BackendTest < BackendTestBase

  def setup
    super
#    start_backend
  end

  def test_connect
    VCR.use_cassette('normal_deck') do
      game = Fabricate(:game_with_players)
      player = game.players.first

      @browser = Browser.new(game.id, player.id)

      @browser.receive('Player')
      assert_equal nil, @browser.player['connected']
      assert_equal player.name, @browser.player['name']

      5.times { @browser.receive('Card') }
      @browser.receive('Player')
      assert_equal true, @browser.player['connected']
    end
  end

  def test_reconnect
    VCR.use_cassette('normal_deck') do
      game = Fabricate(:game_with_players)
      player = game.players.first

      2.times do
        browser = Browser.new(game.id, player.id)
        browser.wait_until_connected
        browser.close
      end
    end
  end

  def test_shuffle
  end

end
