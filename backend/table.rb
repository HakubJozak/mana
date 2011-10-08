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

    # TODO: DEFER these jobs!?
    player.replay_history

    # add player that just sit down
    push(model: player)
    player.cards(true).each { |c| push(model: c) }
  end

  # Required one of:
  #
  # :raw - JSON representation of the message
  # :model - deserialized model (Card, User, ...)
  #
  def push(params = {})
    raise 'Missing :model or :raw' unless params.key?(:raw) || params.key?(:model)

    # TODO: DEFER that or is it done automatically by synchrony?
    event = @game.game_events.create! do |e|
      e.mid = (@mid += 1)
      e.raw =  params[:raw] || ActiveSupport::JSON.encode(params[:model])
      e.model = params[:model] || ActiveSupport::JSON.decode(params[:raw])
    end

    super(event)
  end


  def disconnect(player)
    @players.delete(player.id)
    @channel.unsubscribe(player.sid)
  end

end
