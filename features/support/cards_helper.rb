module CardsHelper
  #attr_accessor :current_card
  
  def current_card
    @card
  end
  
  def current_card= card
    @card = card
  end
  
  def my_hand
    find(selector_for('my hand'))
  end
end

World(CardsHelper)