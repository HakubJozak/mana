class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :lives, :poison_counters

  has_one :library, :hand, :exile, :graveyard, embed: :ids
  has_many :battlefield_slots, embed: :ids
  has_many :messages, embed: :ids
end
