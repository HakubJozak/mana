class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_one :player
  has_one :game
end
