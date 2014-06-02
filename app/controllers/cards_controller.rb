class CardsController < ApplicationController
  def index
    render :json => Card.all
  end

  def show
    render :json => Card.first
  end
end
