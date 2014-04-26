class HomeController < ApplicationController
  layout false

  def index
    @stamps = Stamp.draw_hand
  end
end
