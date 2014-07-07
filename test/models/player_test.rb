require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  fixtures :stamps

  setup do
    @game = Game.create(name: 'Awesome game')
  end

  # test 'has all the slots' do
  #   p = @game.players.create!
  #   assert_not_nil p.hand
  #   assert_not_nil p.deck
  #   assert_not_nil p.graveyard
  #   assert_not_nil p.exile
  # end

  test 'has a library on create' do
    txt = """
    3;Forest
    5;Cloistered Youth
    """

    p = @game.players.create!(mainboard: txt)
    assert_equal 0, p.hand.size
    assert_equal 8, p.library.size
  end
end
