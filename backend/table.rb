class Table

  include Mana::Commander

  @@tables = {}

  def self.find(game)
    @@tables[game.id] ||= Table.new(game)
  end

  def initialize(game)
    @game = game
    @players = {}
    #    @queue = []
    @channel = EM::Channel.new
  end

  def sitdown(player_id, ws)
    # TODO: this should be somehow checked against Rails session -
    # security issue
    #
    # the player is reconnecting || fresh connect
    player = @players[player_id] || @game.players.find(player_id)

    raise "Player not found in the game" unless player

    player.connection = ws

    # TODO: check and close any active connection on player
    player.sid = @channel.subscribe do |pack|
      # TODO: subclass EM::Channel to do this
      player.message_to_client(pack[:scope], pack[:command])
    end

    # add all others to new player
    @players.each do |remote_player|
      args = { :user => remote_player.to_hash(:include_library => true) }
      player.message_to_client(:all, args)
    end

    # add new player to new player
    # TODO: replace :local with requestID
    args = { :user => player.to_hash(:include_library => true).merge(:local => true)  };
    player.message_to_client(:me, args)

    # add new user to all others
    @players.each do |remote_player|
      args = { :player => player.to_hash(:include_library => true) };
      remote_player.message_to_client(:opponents, args)
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
