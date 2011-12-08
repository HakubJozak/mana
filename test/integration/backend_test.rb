$:.unshift '.'

require 'test/test_helper'
require 'web_socket'

class BackendTest < BackendTestBase

  def setup
    super
    start_backend
  end

  def test_connect
#    VCR.use_cassette('normal_deck') do
      game = Fabricate(:game_with_players)
      player = game.players.first

      @browser = Browser.new(game.id, player.id)

      @browser.receive('Player')
      assert_equal nil, @browser.player['connected']
      assert_equal player.name, @browser.player['name']

      5.times { @browser.receive('Card') }
      @browser.receive('Player')
      assert_equal true, @browser.player['connected']
#    end
  end

  def test_reconnect
#    VCR.use_cassette('normal_deck') do
      game = Fabricate(:game_with_players)
      player = game.players.first

      2.times do
        browser = Browser.new(game.id, player.id)
        browser.wait_until_connected
        browser.close
      end
#    end
  end

  def test_one_player_tapping
    game = Fabricate(:game_with_players)
    p1 = game.players.first
    p2 = game.players.last


    b1 = Browser.new(game.id, p1.id).wait_until_connected
    card = b1.cards.values.first
    b1.send(clazz: 'Card', _id: card['_id'], tapped: true)

    b2 = Browser.new(game.id, p2.id).wait_until_connected
    assert_equal true, b2.cards[card['_id']]['tapped']
  end

  def test_shuffle
#    VCR.use_cassette('normal_deck') do
      game = Fabricate(:game_with_players)
      player = game.players.first
      browser = Browser.new(game.id, player.id).wait_until_connected
      browser.send( clazz: 'Action',
                    type: 'shuffle',
                    collection_id: "library-#{player.id}")

      # randomizer is seeded as Random.srand(42) in test environment
      5.times { STDERR.puts browser.receive('Card') }
#    end
  end

end
