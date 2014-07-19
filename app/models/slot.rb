class Slot < ActiveRecord::Base
  belongs_to :player
  has_many :cards

  delegate :size, to: :cards

  def shuffle
    cards.shuffle.each_with_index do |card,i|
      card.update_attribute(:position, i)
    end
  end

  def add_deck(deck)
    position = 0
    deck.parse_mainboard do |stamp,count|
      count.to_i.times do
        cards.create! stamp: stamp,
                      slot: self, position: position, covered: true,
                      game: player.game, player: player
        position += 1
      end
    end
  end

end
