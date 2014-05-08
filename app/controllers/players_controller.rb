class PlayersController < ApplicationController

  before_action :find_game
  before_action :redirect_if_player_exists

  def new
    @player = @game.players.new(user: current_user)
    # @player.build_deck(mainboard: "1\tForest\n")
    # @player.spectator = false
  end

  def create
    @player = @game.players.new(player_params)

    if @player.save
      set_player_for(@game, @player)
      redirect_to @game
    else
      render :new
    end
  end

  def destroy
    # TODO
  end

  protected

  def redirect_if_player_exists
    if player_for(@game)
      redirect_to @game
    end
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

  private

  def player_params
    params.require(:player).permit(:name)
#    result.merge!(user: current_user) if current_user
  end

end
