require './test/test_helper'


# ONLINE
#
class CardStampTest < ActiveSupport::TestCase

  def setup
    CardStamp.delete_all
    Card.delete_all
  end

  test 'fetch a normal card' do
    stamp = CardStamp.fetch('Forest')
    assert_equal 'http://magiccards.info/isd/en/262.html', stamp.url
    assert_nil stamp.backside
  end

  test '#fetch transformable card' do
    stamp = CardStamp.fetch('Cloistered Youth')
    assert_equal 'http://magiccards.info/isd/en/8a.html', stamp.url
    assert_equal 'http://magiccards.info/isd/en/8b.html', stamp.backside[:url]
    stamp.save()

    assert_not_nil CardStamp.find(stamp.id).backside

    card = CardStamp.print_by_name('Cloistered Youth')
    assert_match  /backside/, card.to_json
  end


end
