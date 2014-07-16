require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :games

  test 'new' do
    game = Game.create(name: 'my new game')
    get :new, game_id: games(:casual_game).id
    assert_response :success
  end

end
