class GamesController < ApplicationController

  # settings for Active Model Serializers
  serialization_scope :current_player


  def index
    @games = Game.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end


  def show
    @websocket_host = request.host
    @websocket_port = '9090'

    @game = Game.find(params[:id])

    if @player = player_for(@game)
      respond_to  { |f|
        f.json { render json: [ @game ] }
        f.html { render layout: false }
      }

    else
      redirect_to new_game_player_path(@game)
    end
  end


  def new
    @game = Game.new


    @game.name = if user_signed_in?
                   "#{current_user.name}'s game"
                 else
                   "Casual game"
                 end

    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end


  def edit
    @game = Game.find(params[:id])
  end


  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def current_player
    if @game
      player_for(@game)
    else
      raise 'No current game set but current_player demanded.'
    end
  end

  def game_params
    params[:game].permit(:name)
  end

end
