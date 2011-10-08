class CardCollection

  attr_reader :cards

  def initialize(container)
  end

  private

  def mono_card_array(count, name)
    card = MagicCardsInfo.instance.find_or_create_card(name) if name && count
    card ? (1..count.to_i).to_a.fill { Card.copy(card, @user) } : nil
  end

end
