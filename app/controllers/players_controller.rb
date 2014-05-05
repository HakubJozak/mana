class PlayersController < ApplicationController

  before_action :find_game
  before_action :redirect_if_player_exists

  def new
    @player = @game.players.new(user: current_user)
    # @player.build_deck(mainboard: "1\tForest\n")
    # @player.spectator = false
  end

  def create
    attrs = params[:player]
    attrs.merge!(:user => current_user) if current_user


    if attrs[:spectator] == 'true'
      attrs.delete :deck
      @player = @game.players.build(attrs)
    else
      @player = @game.players.build(attrs)
      @player.build_deck(attrs[:deck].merge(name: "#{@player.name}'s deck for #{@game.name}"))
    end

    if @player.save!
      set_player_for( @game, @player)
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
    redirect_to @game if is_playing?(@game)
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end
