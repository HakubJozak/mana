$:.unshift '.'

require 'test/test_helper'
require 'capybara/rails'


class BasicTest < ActionDispatch::IntegrationTest

  include Capybara::DSL
  include BackendTestRunner

  def setup
    super
    Capybara.default_driver = :webkit
    start_backend
  end

  test 'register, login and create deck' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Name', with: 'Garruk'
    fill_in 'Email', with: 'garruk@alara.gov'
    fill_in 'Password', with: 'lillianaissexy'
    fill_in 'Password confirmation', with: 'lillianaissexy'
    click_button "Sign up"
    assert_match /Logout/, page.body

    click_link 'My Decks'
    click_link 'Create one?'
    click_button 'Create Deck'
    assert_match /Deck was successfully created/, page.body
    assert_match /1x Black Lotus/, page.body
  end

  test 'login, pick deck and create game' do
  end
end
