class GameSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name, :created_at
  has_many :players
  has_many :cards, embed: :ids, :include => true
end
