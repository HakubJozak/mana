$:.unshift '.'

require 'test/test_helper'
require 'capybara/rails'


class BasicTest < ActionDispatch::IntegrationTest

  include Capybara::DSL

  def setup
    super
    Capybara.default_driver = :webkit
    # Capybara.default_wait_time = 2

    env = { 'BUNDLE_GEMFILE' => './Gemfile', 'RACK_ENV' => 'test' }
    cmd = 'bundle exec ruby ./backend.rb localhost 9999'

    @backend = Process.spawn(env, cmd, chdir: './backend', close_others: false)
    puts "Backend PID: #{@backend}"
  end

  def teardown
    puts 'teardown called'
    super
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

    assert page.has_css? ".users .user"
    # page.execute_script("console.info('something');")
    # assert_equal 8, page.evaluate_script('4 + 4');
  end

  test 'register, login and create deck' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Name', with: 'Garruk'
    fill_in 'Email', with: 'garruk@alara.gov'
    fill_in 'Password', with: 'lillianaissexy'
    fill_in 'Password confirmation', with: 'lillianaissexy'
    click_button "Sign up"
    # save_and_open_page
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
