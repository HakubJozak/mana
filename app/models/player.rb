class Player
  include Mongoid::Document

  field :name, :type => :string
  field :color, :type => :string, :default => '#FF0000'

  validates_presence_of :name

  embedded_in :game
  belongs_to :user
end

