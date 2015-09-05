class Mana::Backend::PlayerConnection < Faye::WebSocket
  attr_reader :current_player

  def initialize(env, protocols = nil, options = {})
    @current_player = find_player(env)
    super(env,protocols,options)
  end

  private

  def find_player(env)
    request = Rack::Request.new(env)
    game_id = request.path.match(%r{/games/([0-9]+)}).try(:[],1)
    player_id = request.session[:player_ids][game_id]

    Rails.logger.debug "Trying to find player '#{player_id}' for game '#{game_id}'"

    if player = Player.find_by_id(player_id)
      Rails.logger.debug "Connected as #{player.name}"
      player
    else
      raise "Failed to connect - no player found: #{game_id},#{player_id}."
    end
  end

end
