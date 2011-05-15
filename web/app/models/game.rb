class Game
  include Mongoid::Document

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  field :name, type: String
  field :created_at, type: DateTime
  embeds_many :users
end
