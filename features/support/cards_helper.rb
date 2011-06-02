module CardsHelper
  def my_hand
    find(selector_for('my hand'))
  end
end

World(CardsHelper)