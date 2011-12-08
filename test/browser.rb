require 'timeout'

# Very thin layer simulating web browser/client of the backend.
#
class Browser

  include Timeout

  attr_accessor :cards, :players

  def initialize(game_id, player_id)
    # connect as @player
    @cards = {}
    @players = {}
    @local_player_id = player_id
    @ws = WebSocket.new("ws://localhost:9999/games/#{game_id}/players/#{player_id}")
  end

  def receive(expected_class)
    timeout(3) do
      attrs = ActiveSupport::JSON.decode(@ws.receive)
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


