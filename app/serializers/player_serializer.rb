class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :deck_ids

  def deck_ids
    object.deck.map &:id
  end
end
