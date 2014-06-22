class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  has_many :players, embed: :ids, include: true
  has_many :cards, embed: :ids, include: true
  has_many :slots, embed: :ids, include: true
end
