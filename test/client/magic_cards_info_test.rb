require './test/test_helper'

class MagicCardsInfoTest < ActiveSupport::TestCase
  context "MagicCardsInfo" do

    # TODO: FakeWeb
    setup do
      @mci = MagicCardsInfo.new(@db)
    end


    # TODO: FakeWeb
    should "create card if none can be found" do
      card = @mci.find_or_create_card('Forest')
      assert_equal 'Forest', card.name
      assert_equal "http://magiccards.info/query?q=!Forest&v=card&s=cname", card.url
      assert_equal "http://magiccards.info/scans/en/som/246.jpg", card.image_url
    end

    context 'with existing card' do
      setup do
        @db.collection('cards').insert( :name => 'Forest',
                                        :image_url => 'image',
                                        :url => 'url')
      end
      
      should "finds existing" do
        @mci.expects(:create_card).never
        card = @mci.find_or_create_card('Forest')
        assert_equal card.url, 'url'
        assert_equal card.image_url, 'image'
      end

      should "fail gratiously if no card found" do
        card = @mci.find_or_create_card('NO_SUCH_CARD_EXISTS')
	assert_nil card
      end
    end



  end
end
