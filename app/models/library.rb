class Library

  attr_reader :cards

  # TODO: handle bad lines
  # TODO: handle wrong names
  def initialize(user, card_list = '')
    raise 'User not supplied' unless user

    @user = user

    @cards = card_list.lines.map do |line|
      count, name = line.strip.split(/\t|\;/)
      mono_card_array(count, name)
    end

    @cards.flatten!
    @cards.compact!
    @cards.shuffle!
    @cards.each_with_index { |c,i| c.order = i }
  end

  def to_hash
    { :cards => @cards }
  end

  private

  def mono_card_array(count, name)
    card = MagicCardsInfo.instance.find_or_create_card(name) if name && count
    card ? (1..count.to_i).to_a.fill { Card.copy(card, @user) } : nil
  end

end
