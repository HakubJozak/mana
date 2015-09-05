class SlotSerializer < ActiveModel::Serializer
  attributes :id, :name, :position
  has_many :cards, embed: :ids
end
