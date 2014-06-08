class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :current

  has_many :deck, embed: :ids
  has_many :hand, embed: :ids
  has_many :battlefield, embed: :ids
  has_many :graveyard, embed: :ids

  def current
    object == current_player
  end
  # def deck_ids
  #   object.deck.map &:id
  # end
end
