require './test/test_helper'


# ONLINE
#
class CardStampTest < ActiveSupport::TestCase

  test 'fetch a normal card' do
    stamp = CardStamp.fetch('Forest')
    assert_equal 'http://magiccards.info/isd/en/262.html', stamp.url
    assert_nil stamp.backside
  end


  test '#fetch transformable card' do
    stamp = CardStamp.fetch('Cloistered Youth')
    assert_equal 'http://magiccards.info/isd/en/8a.html', stamp.url
    assert_equal 'http://magiccards.info/isd/en/8b.html', stamp.backside.url

    assert_match  /backside/, stamp.imprint.to_json
  end


end
