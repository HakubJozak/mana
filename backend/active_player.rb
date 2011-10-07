class ActivePlayer

  extend Forwardable

  def_delegators :@player, :name, :deck, :color, :to_hash, :game, :user

  def initialize(player)
    @player = player
  end

  def to_hash(opts = {})
    @library = Library.new(self, deck)

    result = { :name => name, :id => id, :color => color }
    opts[:include_library] ? result.merge({ :cards => @library.cards }) : result
  end

  def ws=(ws)
    @ws = ws
  end

  def sid=(sid)
    @sid = sid
  end

  def message_to_client(scope, command)
    @connection.send(encode(command))
  end
end
