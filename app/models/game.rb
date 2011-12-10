class Game
  include Mongoid::Document

  validates_presence_of :name

  field :name, type: String
  field :hidden, type: Boolean
  field :created_at, :type => DateTime, :default => lambda { Time.now }

  has_many :game_events
  has_many :cards
  embeds_many :players

  def shuffle_collection(collection_id)
    cards.where( collection_id: collection_id).shuffle.map.with_index do |c,i|
      { '_id' => c.id, 'order' => i+1, 'clazz' => 'Card', 'name' => c.name }
    end
  end

end
