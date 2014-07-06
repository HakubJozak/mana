class Slot < ActiveRecord::Base
  belongs_to :player
  has_many :cards

  # proxy_association.owner
  # proxy_association.reflection
  # proxy_association.target
  # module Extension
  #   def size
  #     proxy_association.owner.cards.size
  #   end
  # end

  delegate :size, to: :cards

  def add_cards(card_list)
    card_list.each_line.with_index do |line,i|
      count, name = line.split(';')
      next if name.blank?

      if stamp = Stamp.find_by_name(name.strip)
        count.to_i.times do
          cards.create! stamp: stamp,
                        slot: self, position: i, covered: true,
                        game: player.game, player: player
        end
      else
        Rails.logger.warn("#{name} not found")
        # TODO: add errors to the slot model
      end
    end
  end
end
