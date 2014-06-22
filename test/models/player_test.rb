require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  fixtures :stamps

  setup do
    @game = Game.create(name: 'Awesome game')
  end

  test 'has all the slots' do
    p = @game.players.create!
    assert_not_nil p.hand
    assert_not_nil p.deck
    assert_not_nil p.graveyard
    assert_not_nil p.exile
  end

  test 'has deck on create' do
    p = @game.players.create!
    assert_equal 10, p.hand.size
  end
end
