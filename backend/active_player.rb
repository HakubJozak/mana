class Player

  after_initialize do
    @last_mid = -1
  end

  def replay_history
    game.game_events(true).where('mid' => { '$gt' => @last_mid }).each do |event|
      puts "replaying event #{event.id}"
      @queue.push(event)
    end
  end

  # Websocket connection with the browser controlling this player.
  #
  def ws=(ws)
    @ws = ws
    @queue = EM::Queue.new

    consumer = Proc.new do |event|
      @ws.send(event.raw)
      @queue.pop(&consumer)
    end

    @queue.pop(&consumer)
  end

  # SID is a 'subscription ID' by which
  # this player is known "at the" Table.
  #
  def sid=(sid)
    @sid = sid
  end

  def message_received(event)
    @last_mid = event.mid
    @queue.push(event)
  end

end
