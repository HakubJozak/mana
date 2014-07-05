ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
# Minitest::Reporters::ProgressReporter.new
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


class ActiveSupport::TestCase
  def john
    @john ||= User.create!(email: 'me@there.net', name: 'John', password: 'test1234')
  end
end
