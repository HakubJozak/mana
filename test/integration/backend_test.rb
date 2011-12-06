$:.unshift '.'

require 'test/test_helper'

class BackendTest < BackendTestBase

  class Client < EM::WebSocket::Connection

    def trigger_on_open
      card = "{\"_id\":\"4edd5b9d16f27e5098000008\",\"backside\":null,\"clazz\":\"Card\",\"collection_id\":\"library-4edd5b9d16f27e5098000005\",\"collection_name\":\"cards\",\"covered\":true,\"game_id\":\"4edd5b9716f27e5098000002\",\"image_url\":\"http://magiccards.info/scans/en/cmd/148.jpg\",\"name\":\"Cultivate\",\"order\":1,\"player_id\":\"4edd5b9d16f27e5098000005\",\"position\":null,\"tapped\":false,\"url\":\"http://magiccards.info/cmd/en/148.html\"}"

      send data
    end

    def trigger_on_message(msg)
      puts msg
      close_connection
      EM.stop
    end
  end

  def setup
    super
  end

  def test_prdel
    EM.run do
      EM::connect('localhost','9999',  Client, {}) do |c|
      end
    end
  end


end
