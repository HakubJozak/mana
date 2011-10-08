class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    session[:player_ids] ||= {}
  end

  protected

  helper_method :is_playing?, :player_for

  def is_playing?(game)
    session[:player_ids][game.id]
  end

  def set_player_for(game, player)
    session[:player_ids][game.id] = player
  end

  def player_for(game)
    game.players.find(session[:player_ids][game.id])
  end

end
