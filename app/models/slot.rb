class Slot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
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

end
