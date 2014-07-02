class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_one :player
  belongs_to :game, through: :player
end
