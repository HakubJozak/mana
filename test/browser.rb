# Very thin layer simulating web browser/client of the backend.
#
class Browser

  attr_accessor :cards, :players

  def initialize(game_id, player_id)
    # connect as @player
    @cards = {}
    @players = {}
    @local_player_id = player_id
    @ws = WebSocket.new("ws://localhost:9999/games/#{game_id}/players/#{player_id}")
  end

  def receive(expected_class)
    attrs = ActiveSupport::JSON.decode(@ws.receive)
    clazz = attrs['clazz']
    id = attrs['_id']

    raise "Exptected #{expected_class} but received #{clazz}" unless clazz == expected_class

    if clazz == 'Card'
      @cards[id] = attrs
    elsif clazz == 'Player'
      @players[id] = attrs
    end

    attrs
  end

  def player
    @players[@local_player_id.to_s]
  end

  def close
    @ws.close
  end
end


