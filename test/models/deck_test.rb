require 'test_helper'

class DeckTest < ActiveSupport::TestCase

  fixtures :stamps

  test 'validates mainboard format' do
    valid = Deck.create(mainboard: "2;Forest\n39;Cloistered Youth\n")
    assert valid.errors[:mainboard].empty?, valid.errors.inspect

    # skip blank lines
    valid = Deck.create(mainboard: "2;Forest\n\n\n3;Cloistered Youth\n\n")
    assert valid.errors[:mainboard].empty?, valid.errors.inspect

    bad = Deck.create(mainboard: "bad_format2;Forest\n39;Cloistered Youth")
    assert_equal bad.errors[:mainboard].first, "wrong line: 'bad_format2;Forest'"

    unknown = Deck.create(mainboard: "1;MY_AWESOME_CARD\n;13;Forest")
    assert_equal unknown.errors[:mainboard].first, "card 'MY_AWESOME_CARD' is unknown"
  end

  test 'stamps' do
    valid = Deck.create(mainboard: "2;Forest\n39;Cloistered Youth\n")
    assert valid.errors[:mainboard].empty?, valid.errors.inspect
  end

end
