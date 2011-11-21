$:.unshift '.'

require 'test/test_helper'
require 'capybara/rails'


class WebsocketEncodingTest < ActionDispatch::IntegrationTest

  include Capybara::DSL

  def setup
    Capybara.default_driver = :webkit
    Capybara.default_wait_time = 2

    fork do
      exec 'bash ./backend-test.sh'
    end
  end

  test 'all is fine' do
    visit '/games'
    click_link 'Create'
    fill_in 'Name', with: 'Igra'
    click_button 'Create Game'

    fill_in 'Cards', with: '15,Forest'
    click_button "Join 'Igra'"

#    assert page.has_css? "#left-panel .users"
    assert page.has_css? "#left-panel .users .user"

    # page.execute_script("console.info('something');")
    # assert_equal 8, page.evaluate_script('4 + 4');
  end
end
