class PlayersController < ApplicationController

  before_filter :find_game
  before_filter :redirect_if_player_exists

  def new
    @player = @game.players.new(user: current_user)
    txt = File.open("#{Rails.root}/db/decks/eldrazi").read
    @player.build_deck(mainboard: txt)
  end

  def create
    attrs = params[:player]
    attrs.merge!(:user => current_user) if current_user

    @player = @game.players.build(attrs)
    @player.build_deck(attrs[:deck].merge(name: "#{@player.name}'s deck for #{@game.name}"))

    if @player.save
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
