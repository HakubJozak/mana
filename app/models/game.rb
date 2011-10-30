class Game
  include Mongoid::Document

  validates_presence_of :name

  field :name, type: String
  field :hidden, type: Boolean
  field :created_at, :type => DateTime, :default => lambda { Time.now }

  has_many :game_events
  has_many :cards
  embeds_many :players

end
