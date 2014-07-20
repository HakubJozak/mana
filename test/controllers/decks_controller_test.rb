require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :decks, :users

  setup do
    sign_in john
  end

  test "index" do
    get :index
    assert_response :success
    assert_match  /Highlander/, @response.body
  end

  test "update" do
    deck = decks(:highlander)
    put :update, { id: deck.id, deck: { mainboard: "3;Forest\n" }}
    assert_response :redirect
  end

end
