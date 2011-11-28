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

    if player = @players[player_id]
      player.ws.close_websocket
    else
      player = @game.players.find(player_id)
      @players[player_id] = player
    end

    raise "Player not found in the game" unless player

    # CONNECT
    #
    player.ws = ws

    ws.onclose do
      p = @players.delete(player_id)
      unsubscribe(p.sid) if p
      puts "Player #{p.name}(#{p.id}) disconnected"
    end

    ws.onmessage do |msg|
      ws.table.push(raw: msg)
    end

    player.sid = subscribe do |event|
      # TODO: subclass EM::Channel to do this
      player.send_event_to_client(event)
    end

    # TODO: DEFER these jobs!?
    player.replay_history

    # TODO: this should happen atomically!
    # add player that just sit down
    unless player.has_started
      push(model: player)
      player.cards(true).each { |c| push(model: c) }
      player.update_attribute( :has_started, true)
    end

  end

  # Required one of:
  #
  # :raw - JSON representation of the message
  # :model - deserialized model (Card, User, ...)
  #
  def push(params = {})
    raise 'Missing :model or :raw' unless params.key?(:raw) || params.key?(:model)

    model = params[:model] || ActiveSupport::JSON.decode(params[:raw])
    raw = params[:raw] || ActiveSupport::JSON.encode(params[:model])

    # ----------- ISOLATE to method ----------
    if model['clazz'] == 'Action' && model['type'] == 'create_token'
      stamp = CardStamp.find(model['card_stamp_id'])
      player = @game.players.find(model['player_id'])

      card = stamp.imprint do |c|
        c.player = player
        c.game = @game
        c.collection_id = "battlefield"
        c.position = "grid-0-0-#{player.id}"
        c.order = 0

        c.covered = false
        c.save!
      end

      model = card
      raw = ActiveSupport::JSON.encode(model)
    end
    # ------------------------------------------

    puts "!!!- #{raw.encoding}"

    # TODO: DEFER that or is it done automatically by synchrony?
    event = @game.game_events.create! do |e|
      e.mid = (@mid += 1)
      e.raw =  raw
      e.model = model
    end

    puts "???- #{event.id}"
    puts "???- #{event.raw.encoding}"

    super(event)
  end
end
