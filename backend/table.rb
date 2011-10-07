class Table

  include Mana::Commander

  @@tables = {}

  def self.find_or_create(game)
    @@tables[game.id] ||= Table.new(game)
  end

  def initialize(game)
    @game = game
    @players = {}
    @channel = EM::Channel.new
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
    player = @players[player_id] ||= ActivePlayer.new(@game.players(true).find(player_id))

    raise "Player not found in the game" unless player
    player.ws = ws

    # TODO: check and close any active connection on player
    player.sid = @channel.subscribe do |object|
      # TODO: subclass EM::Channel to do this
      player.message_to_client(pack[:scope], pack[:command])
    end
  end

  def send_to_opponents(command)
    broadcast_to :opponents, command
  end

  def disconnect(player)
    @players.delete(player)
    @channel.unsubscribe(player.connection)
  end

  private

  # TODO: subclass EM::Channel to do this
  def broadcast_to(scope, command)
    @channel.push(:scope => scope, :command => command)
  end

end
