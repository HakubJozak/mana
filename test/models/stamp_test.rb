require 'test_helper'
require 'mtg_json_loader'

class StampTest < ActiveSupport::TestCase
  def setup
    ::MtgJsonLoader.load(File.new(Rails.root + 'db/ISD-x.json'))
    @cloistered_youth = Stamp.where(name: 'Cloistered Youth').first
  end


  test "double_faced?" do
    assert @cloistered_youth.double_faced?
  end

end
