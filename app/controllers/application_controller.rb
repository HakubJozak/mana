class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    session[:player_ids] ||= {}
  end

  protected

  helper_method :is_playing?, :player_for

  # DRY with player_for
  def is_playing?(game)
    id = session[:player_ids][game.id]
    game.players.where(_id: id).first if id
  end

  def set_player_for(game, player)
    session[:player_ids][game.id] = player.id
  end

  def player_for(game)
    game.players.where(_id: session[:player_ids][game.id]).first
  end

end
