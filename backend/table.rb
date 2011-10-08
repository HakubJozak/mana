class Table < EM::Channel

  @@tables = {}

  def self.find_or_create(game)
    @@tables[game.id] ||= Table.new(game)
  end

  def initialize(game)
    super()
    @mid = 0
    @game = game
    @players = {}
  end

  def sitdown(player_id, ws)
    # Reloading players.
    #
    # TODO: what if the game changed in backend and the load will
    # override it?
    @game.players(true)
    @game.reload

    # TODO: this should be somehow checked against Rails session -
    # security issue
    #
    # the player is reconnecting || fresh connect
    player = @players[player_id] ||= @game.players(true).find(player_id)

    raise "Player not found in the game" unless player
    player.ws = ws

    player.sid = subscribe do |model|
      # TODO: subclass EM::Channel to do this
      player.message_received(model)
    end

    push(player)
  end

  def push(model)
    super( :mid => @mid, :data => model )
  end

  def disconnect(player)
    @players.delete(player)
    @channel.unsubscribe(player.sid)
  end

end
