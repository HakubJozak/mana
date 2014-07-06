require 'test_helper'
require 'minitest/mock'

class SlotTest < ActiveSupport::TestCase
  test "name is always set" do
    # g = Game.create
    # p = Player.create

    # Slot.create(name: 'hand',game: g, player: p)
  end

  fixtures :stamps

  # TODO: the slot should be more independent
  test "add_cards" do
    slot = Slot.create(name: 'hand',player: player_john)

    Stamp.stub :find_by_name, stamps(:forest) do
      list = File.read(Rails.root.join 'test/fixtures/highlander_deck.txt')
      slot.add_cards list
    end

    assert_equal 44, slot.cards.count
  end
end
