ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test/backend_test_base'
require 'test/browser'


VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "#{Rails.root}/test/vcr"
  c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true

  c.ignore_request do |request|
    URI(request.uri).port == 9999
  end
end


class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def setup
    Game.delete_all
    User.delete_all
    Card.delete_all
    CardStamp.delete_all
  end

end
