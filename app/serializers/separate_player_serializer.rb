class SeparatePlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :game_id, :lives, :poison_counters

  has_one :library, embed: :ids, include: true, serializer: SlotSerializer, root: 'slots'
  has_one :hand, embed: :ids, include: true, serializer: SlotSerializer, root: 'slots'
  has_one :exile, embed: :ids, include: true, serializer: SlotSerializer, root: 'slots'
  has_one :graveyard, embed: :ids, include: true, serializer: SlotSerializer, root: 'slots'
  has_many :battlefield_slots, embed: :ids, include: true, each_serializer: SlotSerializer, root: 'slots'

  has_one :game, embed: :ids, include: true, serializer: SeparateGameSerializer, root: 'games'
end
