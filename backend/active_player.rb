class Player

#  extend Forwardable
#  def_delegators :@player, :name, :deck, :color, :to_hash, :game,  :user

  after_initialize do
    @last_mid = -1
  end

  # def to_hash(opts = {})
  #   @library = Library.new(self, deck)

  #   result = { :name => name, :id => id, :color => color }
  #   opts[:include_library] ? result.merge({ :cards => @library.cards }) : result
  # end

  # Websocket connection with the browser controlling this player.
  #
  def ws=(ws)
    @ws = ws
  end

  # SID is a 'subscription ID' by which
  # this player is known "at the" Table.
  #
  def sid=(sid)
    @sid = sid
  end

  def message_received(message)
    @last_mid = message[:mid]
    @ws.send(encode(message[:data]))
  end

  private

  def encode(model)
    ActiveSupport::JSON.encode(model)
  end

end
