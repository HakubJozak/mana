class Game
  include Mongoid::Document

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  field :name, :type => String
  field :created_at, :type => DateTime, :default => Time.now

  has_many :game_events
  has_many :cards
  embeds_many :players


end
