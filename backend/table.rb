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
      # TODO: player#disconnect method
      if player = @players.delete(player_id)
        unsubscribe(player.sid)
        player.update_attribute( :connected, false)
        push(model: player)
        puts "Player #{player.name}(#{player.id}) disconnected"
      end
    end

    ws.onmessage do |msg|
      ws.table.push(raw: msg)
    end

    player.sid = subscribe do |event|
      # TODO: subclass EM::Channel to do this
      player.send_event_to_client(event)
    end

    # TODO: DEFER these jobs!?
    @players.each_value { |p| puts p; push(model: p); }
    @game.cards(true).each { |c| push(model: c); puts c }

    player.update_attribute( :connected, true)
    push(model: player)
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
    tuples = if model['clazz'] == 'Action'
      if model['type'] == 'create_token'
        params = model

        stamp = CardStamp.find(params['card_stamp_id'])
        player = @game.players.find(params['player_id'])

        card = stamp.imprint do |c|
          c.player = player
          c.game = @game
          c.collection_id = "battlefield"
          c.position = params['position']
          c.order = params['order']
          c.covered = false
          c.save!
        end

        [[ ActiveSupport::JSON.encode(card), card ]]
      elsif model['type'] == 'shuffle'
        cards = @game.shuffle_collection(model['collection_id'])
        cards.map { |c| [ ActiveSupport::JSON.encode(c), c ] }
      end
    else
      [[ raw, model]]
    end
    # ------------------------------------------

    # Save & apply event ------------------------------
    # TODO: DEFER that or is it done automatically by synchrony?
    tuples.each do |raw, model|
      event = @game.game_events.create! do |e|
        e.mid = (@mid += 1)
        e.raw =  raw
        e.model = model
      end

      event.apply

      super(event)
    end
    # ------------------------------------------
  end
end
