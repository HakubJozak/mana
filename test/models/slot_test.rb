require 'test_helper'
require 'minitest/mock'

class SlotTest < ActiveSupport::TestCase
  fixtures :stamps


  # TODO: the slot should be more independent
  test "add_cards" do
    slot = Slot.create(name: 'hand', player: player_john)

    Stamp.stub :find_by_name, stamps(:forest) do
      list = File.read(Rails.root.join 'test/fixtures/highlander_deck.txt')
      slot.add_cards list
    end

    assert_equal 44, slot.cards.count
  end

  test 'size' do
    slot = Slot.create(name: 'hand', player: player_john)
    slot.add_cards '10;Forest'
    assert_equal 10,slot.size
  end

  test 'shuffle' do
    slot = Slot.create(name: 'hand', player: player_john)
    slot.add_cards "10;Forest\n12Cloistered Youth"
    slot.shuffle
    # TODO: invent some assertion
  end
end
