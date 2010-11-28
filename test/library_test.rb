require './test/test_helper'

class LibraryTest < ActiveSupport::TestCase
  context "LibraryTest" do
    setup do
      card = stub(:name => 'Fake', :to_ary => nil)
      @mci = stub(:find_or_create_card => card)
      MagicCardsInfo.stubs(:instance).returns(@mci)
    end

    should "handle tabs and ; as separators" do
      lib = Library.new("1\tMountain\n 2;Forest")
      assert_equal 3, lib.cards.count
    end

    should "handle bad lines" do
      lib = Library.new("1\tMountain\naslkdasForest\n111111")
      assert_equal 1, lib.cards.size
    end
    
    should "handle unknown cards" do
      @mci.stubs(:find_or_create_card => nil)
      lib = Library.new("1\tMountainnnn")
      assert_equal 0, lib.cards.size
    end
  end
end
