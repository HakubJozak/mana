class Library

  attr_reader :cards
  
  # TODO: handle bad lines
  # TODO: handle wrong names
  def initialize(card_list = '')
    progress = 100 / card_list.lines.count

    @cards = card_list.lines.map do |line|
      count, name = line.strip.split(/\t|\;/)
      yield(name, progress) if block_given?
      mono_card_array(count, name)
    end
    
    @cards.flatten!
    @cards.compact!
    @cards.shuffle!
  end

  def draw_a_card
    @cards.shift
  end

  private

  def mono_card_array(count, name)
      if count && name
        card = MagicCardsInfo.instance.find_or_create_card(name)
        (1..count.to_i).to_a.fill { Card.copy(card) }
      else
        nil
      end
  end

end
