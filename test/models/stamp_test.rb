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

end
