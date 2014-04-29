class GamesController < ApplicationController

  def index
    @games = Game.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end


  def show
    @websocket_host = request.host

    # TODO: this has to go to app config!
    if Rails.env.test?
      @websocket_port = '9999'
    else
      @websocket_port = '9090'
    end

    @game = Game.find(params[:id])
    @debug = true if params[:debug].present?

    if is_playing?(@game)
      @player = player_for(@game)
      render layout: false
    else
      redirect_to new_game_player_path(@game)
    end
  end


  def new
    @game = Game.new
    @game.name = if current_user
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

  def game_params
    params[:game].permit(:name)
  end

end
