class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name #, :deck_ids
  has_many :deck, embed: :ids
  has_many :hand, embed: :ids
  has_many :battlefield, embed: :ids
  has_many :graveyard, embed: :ids

  # def deck_ids
  #   object.deck.map &:id
  # end
end
