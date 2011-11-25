$:.unshift '.'

require 'test/test_helper'
require 'capybara/rails'


class BasicTest < ActionDispatch::IntegrationTest

  include Capybara::DSL

  def setup
    Capybara.default_driver = :webkit
    # Capybara.default_wait_time = 2

    env = { 'BUNDLE_GEMFILE' => './Gemfile', 'RACK_ENV' => 'test' }
    cmd = 'bundle exec ruby ./backend.rb localhost 9999'

    @backend = Process.spawn(env, cmd, :chdir => './backend')
    puts "Backend PID: #{@backend}"
  end

  def teardown
    puts 'teardown called'
    Process.kill("INT", @backend)
    Process.wait(@backend)
  end

  test 'create and enter game' do
    visit '/games'
    click_link 'Create'
    fill_in 'Name', with: 'Igra'
    click_button 'Create Game'

    fill_in 'Cards', with: '15,Forest'
    click_button "Join 'Igra'"

    assert page.has_css? "#left-panel .users .user"
    # page.execute_script("console.info('something');")
    # assert_equal 8, page.evaluate_script('4 + 4');
  end
end
