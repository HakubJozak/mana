ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def john
    @john ||= User.create!(email: 'me@there.net', name: 'John', password: 'test1234')
  end
end
