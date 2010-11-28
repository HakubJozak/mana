class Library

  attr_reader :cards
  
  # TODO: handle bad lines
  # TODO: handle wrong names
  def initialize(card_list = '')
    @cards = card_list.lines.map do |line|
      count, name = line.strip.split("\t")
      card = MagicCardsInfo.instance.find_or_create(name)

      (1..count.to_i).to_a.fill(card)
    end

    @cards.flatten!
  end

  def draw_a_card
    @cards.shift
  end


end
