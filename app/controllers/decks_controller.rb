class DecksController < ApplicationController

  before_action :authenticate_user!

  def index
    @decks = current_user.decks
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def new
    @deck = current_user.decks.build
    @deck.name = "#{current_user.decks.count + 1}. #{current_user.name}'s deck"
    @deck.mainboard = '1;Black Lotus'
  end

  def edit
    @deck = current_user.decks.find(params[:id])
  end

  def create
    @deck = current_user.decks.build(deck_params)
    @deck.user = current_user

    if @deck.save
        redirect_to @deck
      else
        render action: "new"
      end
  end

  def update
    @deck = current_user.decks.find(params[:id])

    if @deck.update_attributes(deck_params)
      redirect_to @deck, notice: 'Deck was successfully updated.'
    else
      render action: "edit"
    end
  end


  def destroy
    @deck = current_user.decks.find(params[:id])
    @deck.destroy
    redirect_to decks_url
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :mainboard, :sideboard)
  end
end
