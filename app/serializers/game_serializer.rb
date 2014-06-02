class GameSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :battlefield, serializer: CardSerializer

  def battlefield
    object.cards.where(location: 'battlefield')
  end

end
