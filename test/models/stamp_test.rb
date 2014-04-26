require 'test_helper'
require 'mtg_json_loader'

class StampTest < ActiveSupport::TestCase
  def setup
    MtgJsonLoader.load_set(Rails.root + 'db/ISD-x.json')
    @cloistered_youth = Stamp['Cloistered Youth']
    @forest = Stamp['Forest']
  end

  test "double_faced?" do
    assert @cloistered_youth.double_faced?
    refute @forest.double_faced?
  end

  test "frontside_url" do
    assert_equal 'http://mtgimage.com/multiverseid/245247.jpg', @forest.frontside_url
    assert_equal 'http://mtgimage.com/multiverseid/221212.jpg', @cloistered_youth.frontside_url
  end

  test "backside_url" do
    assert_equal 'http://mtgimage.com/multiverseid/221222.jpg', @cloistered_youth.backside_url
  end

end
