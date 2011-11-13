class PlayersController < ApplicationController

  before_filter :find_game
  before_filter :redirect_if_player_exists

  def new
    @player = @game.players.new(user: current_user)
    @player.build_deck
  end

  def create
    attrs = params[:player]
    attrs.merge!(:user => current_user) if current_user

    @player = @game.players.build(attrs)
    @player.build_deck(attrs[:deck].merge(name: "#{current_user.name}'s deck for #{@game.name}"))

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

  def deck_hint
    unless current_user
      raw "<b>TIP</b>: #{link_to('Login', new_user_registration_path)} to enable deck management and be able to reconnect to a previous game!"
    end
  end

  helper_method :deck_hint

  def redirect_if_player_exists
    redirect_to @game if is_playing?(@game)
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end
