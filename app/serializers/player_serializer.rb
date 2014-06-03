class PlayerSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  attributes :id, :name
  has_many :deck, :hand, :graveyard, :battlefield
end
