class PlayersController < ApplicationController

  before_action :find_game, except: :show
  before_action :redirect_if_player_exists, except: :show

  helper_method :available_decks

  def new
    @player = @game.players.new(user: current_user)
  end

  def create
    @player = @game.players.new(player_params)

    if (id = params[:player][:deck_id]) =~ /\d+/
      @player.deck = Deck.find(id)
    end

    if @player.save
      set_player_for(@game, @player)
      redirect_to @game
    else
      render :new
    end
  end

  def show
    respond_to do |f|
      f.json { render json: Player.find(params[:id]) }
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

  def available_decks
    decks = { 'All the cards below:' => 'ADHOC', 'None. I will just watch the game.' => 'WATCH' }

    if current_user
      current_user.decks.each do |d|
	decks[d.name] = d.id
      end
    end

    decks
  end

  def player_params
    params.require(:player).permit(:name, :prepared_deck, :mainboard, :deck_attributes)
#    result.merge!(user: current_user) if current_user
  end

end
