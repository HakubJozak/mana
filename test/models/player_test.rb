require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  setup do
    @game = Game.create(name: 'Awesome game')
  end

  test 'has deck on create' do
    p = @game.players.create

    assert_equal 10, p.deck.size
  end
end
