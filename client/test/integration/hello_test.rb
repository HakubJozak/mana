require File.expand_path File.join('client/test/test_helper')

class HelloTest < Test::Unit::TestCase
  include Capybara
  Capybara.default_driver = :webkit

  def setup
    Capybara.app = Sinatra::Application.new
  end

  def test_hello
    visit '/'
    assert_equal "hello world", page.body
  end

end
