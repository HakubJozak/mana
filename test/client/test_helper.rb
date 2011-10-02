require 'rubygems'
require 'bundler'

Bundler.require(:default, :test, :development)

require_all 'app'


class ActiveSupport::TestCase

  def setup
    @conn = Mongo::Connection.new
    @conn.drop_database('mana-test')
    @db = @conn["mana-test"]
  end

  def teardown
    @conn.drop_database('mana-test')
  end
end


