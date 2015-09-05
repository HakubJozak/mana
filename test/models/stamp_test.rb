require 'test_helper'
require 'mtg_json_loader'

class StampTest < ActiveSupport::TestCase
  fixtures :stamps

  def setup
    @cloistered_youth = Stamp['Cloistered Youth']
    @forest = Stamp['Forest']
  end

  test "double_faced?" do
    assert @cloistered_youth.double_faced?
    refute @forest.double_faced?
  end

  test "frontside" do
    assert_equal 'http://mtgimage.com/multiverseid/289.jpg', @forest.frontside
    assert_equal 'http://mtgimage.com/multiverseid/221212.jpg', @cloistered_youth.frontside
  end

  test "backside" do
    assert_equal 'http://mtgimage.com/multiverseid/221222.jpg', @cloistered_youth.backside
  end

end
