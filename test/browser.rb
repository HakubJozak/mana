require 'timeout'

# Very thin layer simulating web browser/client of the backend.
#
class Browser

  include Timeout

  attr_accessor :cards, :players

  def initialize(game_id, player_id, opts = {})
    # connect as @player
    @cards = {}
    @players = {}
    @local_player_id = player_id

    @port = opts[:port] || 9999
    @host = opts[:host] || 'localhost'

    @ws = WebSocket.new("ws://#{@host}:#{@port}/games/#{game_id}/players/#{player_id}")
  end

  def receive(expected_class)
    timeout(3) do
      data = @ws.receive
      raise 'Failed to receive data from backend' unless data

      attrs = ActiveSupport::JSON.decode(data)
      clazz = attrs['clazz']
      id = attrs['_id']

      if expected_class != :any && clazz != expected_class
        raise "Exptected #{expected_class} but received #{clazz}"
      end

      if clazz == 'Card'
        @cards[id] = attrs
      elsif clazz == 'Player'
        @players[id] = attrs
      end

      attrs
    end
  end

  def send(hash)
    @ws.send ActiveSupport::JSON.encode(hash)
  end

  def wait_until_connected
    timeout 5 do
      while obj = self.receive(:any)
        if obj['clazz'] == 'Player' &&
           obj == self.player &&
           obj['connected'] == true
          break
        end
      end
    end

    self
  end

  def player
    @players[@local_player_id.to_s]
  end

  def close
    @ws.close
  end
end


