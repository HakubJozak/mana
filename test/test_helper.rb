ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test/backend_test_base'
require 'test/browser'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def setup
    Game.delete_all
    User.delete_all
    Card.delete_all
    CardStamp.delete_all
  end

end
