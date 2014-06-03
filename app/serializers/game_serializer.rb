class GameSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  attributes :id, :name, :created_at
  has_many :players
end
