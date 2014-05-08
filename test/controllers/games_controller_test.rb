require 'test_helper'

class GamesControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
    assert_select 'input#game_name[value="Casual game"]'
  end

  test 'create' do
    # post :create
  end
end
