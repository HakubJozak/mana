require 'test_helper'

class StampTest < ActiveSupport::TestCase
  test "has_backside?" do
    youth = Stamp.new(name: 'Cloistered Youth',
                      url: 'http://magiccards.info/isd/en/8a.html')
    assert youth.has_backside?

    forest = Stamp.new(name: 'Forest',
                       url: 'http://magiccards.info/ths/en/246.html')
    refute forest.has_backside?
  end

  test 'fetch!' do
    assert_not_nil card = Stamp.fetch!('Forest')
    assert_match %r{http://magiccards.info.*\.html}, card.url
    assert_match %r{http://magiccards.info.*\.jpg}, card.frontside
    assert_nil card.backside

    assert_not_nil card = Stamp.fetch!('Cloistered Youth')
    assert_match %r{http://magiccards.info.*\.html}, card.url
    assert_match %r{http://magiccards.info.*a\.jpg}, card.frontside
    assert_match %r{http://magiccards.info.*b\.jpg}, card.backside

    assert_raise(Stamp::UnknownCard) {
      Stamp.fetch!('this-card-does-NOT-exist')
    }
  end
end
