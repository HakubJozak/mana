class HomeController < ApplicationController

  layout false
  skip_before_action :authenticate_user!

  def index
    @stamps = Stamp.draw_hand
  end
end
