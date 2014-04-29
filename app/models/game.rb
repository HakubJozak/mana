class Game < ActiveRecord::Base
  has_many :players
  has_many :cards, through: :players
  has_many :messages
end
