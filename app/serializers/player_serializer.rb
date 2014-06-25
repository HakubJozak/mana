class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :current, :lives, :poison_counters

  has_one :deck, :hand, :exile, :graveyard, embed: :ids
  has_many :battlefield_slots, embed: :ids

  def current
    object == current_player
  end
  # def deck_ids
  #   object.deck.map &:id
  # end
end
