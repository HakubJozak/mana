class Player

  attr_reader :ws, :sid

  after_initialize do
    @last_mid = -1
  end

  # TODO: squeeze into batch
  def replay_history
    game.players(true).each { |p| @queue.push(p) }
    game.cards(true).each   { |c| @queue.push(c) }
    # game.game_events(true).where('mid' => { '$gt' => @last_mid }).each do |event|
    #   @queue.push(event)
    # end
  end

  # Websocket connection with a browser controlling this player.
  #
  def ws=(ws)
    @ws = ws
    @queue = EM::Queue.new

    consumer = Proc.new do |data|
      txt = if data.respond_to?(:raw)
              data.raw
            else
              data.to_json
            end

      # HACK: the force encoding should not be necessary
      # yet sometimes the data arrive ecoded in ASCII-8BIT.
      @ws.send(txt.force_encoding('utf-8'))
      # process the next event by this block
      @queue.pop(&consumer)
    end

    # process the first event (non-blocking call)
    @queue.pop(&consumer)
  end

  # SID is a 'subscription ID' by which
  # this player is known "at the" Table.
  #
  def sid=(sid)
    @sid = sid
  end

  def send_event_to_client(event)
    @last_mid = event.mid
    @queue.push(event)
  end

end
