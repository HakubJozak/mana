require './test/test_helper'

class LibraryTest < ActiveSupport::TestCase
  context "LibraryTest" do
    setup do
      @list = "1\tMountain\n 2\tForest"
    end

    should "load all cards" do
      lib = Library.new(@list)
      assert_equal 3, lib.cards.size
    end

    should "handle bad lines"
    should "handle unknown cards"
  end
end
