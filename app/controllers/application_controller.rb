class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    session[:player_ids] ||= {}
  end

  protected

  helper_method :is_playing?, :player_for

  def is_playing?(game)
    if player_id = session[:player_ids][game.id]
      game.players.find_by(id: player_id)
    end
  end

  alias :current_player :is_playing?

  def set_player_for(game, player)
#    session[:player_ids][game.id] = player.id
  end

  def player_for(game)
    game.players.find_by(id: session[:player_ids][game.id])
  end


end
