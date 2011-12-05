$:.unshift '.'

require 'test/test_helper'

class BackendTest < BackendTestBase

  class Client < EM::WebSocket::Connection
  end

  def setup
    super
  end

  def test_prdel
    EM.run do
      EM::connect('localhost','9090',  EventMachine::WebSocket::Connection, {}) do |c|
        c.onopen do
          puts 'prdel'
          close_connection
          EM.stop
        end
      end
    end
  end


end
