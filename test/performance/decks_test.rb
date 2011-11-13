# MEGA-HACK
$:.unshift "./test"

require 'test_helper'
require 'rails/performance_test_help'

class DecksTest < ActionDispatch::PerformanceTest

  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }
  setup do
    cards = File.new("#{Rails.root}/test/fixtures/eldrazi")

    @user = Fabricate(:user)
    @deck = @user.decks.create(name: 'AAA', mainboard: cards)
  end

  def test_show
#    get "/decks/#{@deck.id}"
  end
end
