class GamesController < ApplicationController

  helper_method :is_playing?


  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @websocket_host = 'localhost'
    @websocket_port = '8080'

    @game = Game.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

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

  protected

  def is_playing?(game)
    !players[game.id].nil?
  end

end
