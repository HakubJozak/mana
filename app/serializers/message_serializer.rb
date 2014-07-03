class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_one :player, embed: :ids
  has_one :game, embed: :ids
end
