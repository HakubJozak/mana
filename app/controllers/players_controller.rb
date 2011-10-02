class PlayersController < ApplicationController

  before_filter :find_game

  def new
    @player = @game.players.build
  end

  def create
    attrs = params[:player]
    attrs.merge(:user => current_user) if current_user

    if player = @game.players.create(attrs)

      session[:players] = {}
      session[:players][@game.id] = player

      redirect_to @game
    else
      render :new
    end
  end

  def destroy
    # TODO
  end

  protected

  def find_game
    @game = Game.find(params[:game_id])
  end

end
