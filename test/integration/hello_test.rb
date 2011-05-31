require File.expand_path File.join('test/integration/test_helper')

require_all 'app'

class HelloTest < Test::Unit::TestCase
  include Capybara

  def setup
  end

  def test_lobby
    visit '/games/some'
    assert page.has_xpath?( Bermuda::XPath.dialog('Lobby'), :visible => true)
    # within :xpath, Bermuda::XPath.dialog('Lobby') do |dialog|
    # end
  end
end
