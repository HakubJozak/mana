class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    session[:player_ids] ||= {}
  end

  protected

  helper_method :is_playing?, :player_for

  def after_sign_in_path_for(user)
    games_path
  end

  def set_player_for(game, player)
    session[:player_ids][game.id.to_s] = player.id
  end

  def player_for(game)
    game.players.find_by(id: session[:player_ids][game.id.to_s])
  end


end
