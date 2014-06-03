class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name #, :deck_ids
  has_many :deck, embed: :ids
#  has_many :battlefield

  # def deck_ids
  #   object.deck.map &:id
  # end
end
