require File.expand_path File.join('client/test/test_helper')

require_all 'app'

class HelloTest < Test::Unit::TestCase
  include Capybara
  Capybara.default_driver = :selenium

  def setup
    Capybara.app = Mana::Server.new
  end

  def test_hello
    visit '/flow'
    assert_equal "hello world", page.body
  end

end
