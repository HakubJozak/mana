class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    session[:player_ids] ||= {}
  end

  protected

  def players
    session[:player_ids]
  end

  def player_for(game)
    players[game.id]
  end

end
