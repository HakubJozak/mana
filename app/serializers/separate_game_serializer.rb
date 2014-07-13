class SeparateGameSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :players, embed: :ids, include: true, each_serializer: SeparatePlayerSerializer
  has_many :slots, embed: :ids, include: true

  def name
    'updated_game'
  end
end
