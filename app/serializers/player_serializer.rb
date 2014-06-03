class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :hand, serializer: CardSerializer
  has_many :battlefield, serializer: CardSerializer
  has_many :deck, serializer: CardSerializer
  has_many :graveyard, serializer: CardSerializer


  def hand
    object.cards.where(location: "hand")
  end

  def battlefield
    object.cards.where(location: 'battlefield')
  end

  def graveyard
    object.cards.where(location: "graveyard")
  end
end
