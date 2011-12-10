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

    browser = Browser.new(game.id, player.id)

    # Player 1
    browser.receive('Player')
    assert_equal nil, browser.player['connected']
    assert_equal player.name, browser.player['name']

    # Player 2
    p2 = browser.receive('Player')
    assert_equal 'Player2', p2['name']

    # All cards
    10.times { browser.receive('Card') }

    # Player 1 state changes to 'connected'
    p1 = browser.receive('Player')
    assert_equal true, p1['connected']
  end

  def test_reconnect
    game = Fabricate(:game_with_players)
    player = game.players.first

    2.times do
      browser = Browser.new(game.id, player.id)
      browser.wait_until_connected
      browser.close
    end
  end

  def test_replay
    game = Fabricate(:game_with_players)
    p1 = game.players.first
    p2 = game.players.last

    b1 = Browser.new(game.id, p1.id).wait_until_connected
    card = b1.cards.values.first
    b1.send(clazz: 'Card', _id: card['_id'], tapped: true)
    b1.send(clazz: 'Player', _id: p1.id, lives: 25)

    b2 = Browser.new(game.id, p2.id).wait_until_connected
    assert_equal true, b2.cards[card['_id']]['tapped']
    assert_equal 25, b2.players[p1.id.to_s]['lives']
  end

  def test_shuffle
    game = Fabricate(:game_with_players)
    player = game.players.first
    browser = Browser.new(game.id, player.id).wait_until_connected

    browser.send( clazz: 'Action',
                  type: 'shuffle',
                  collection_id: "library-#{player.id}")

    # In backend, randomizer is seeded as Random.srand(42)
    # while in test environment, therefor the outcome
    # should be invariant
    lands = %w{Forest Plains Island Swamp Mountain}

    lands.each do |land|
      c = browser.receive('Card')
      assert_equal land, c['name']
    end
  end

end
