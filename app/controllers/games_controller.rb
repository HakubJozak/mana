class GamesController < ApplicationController

  # GET /games
  # GET /games.json
  def index
    @games = Game.desc(:created_at)

    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @websocket_host = request.host
    @websocket_port = '9090'

    @game = Game.find(params[:id])

    if is_playing?(@game)
      @player = player_for(@game)
      render layout: false
    else
      redirect_to new_game_player_path(@game)
    end

  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
    @game.name = "#{current_user.name}'s game" if current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

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

end
