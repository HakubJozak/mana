require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'new' do
    game = Game.create(name: 'my new game')
    get :new, game_id: 1
    assert_response :success
  end

end
