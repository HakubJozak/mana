class Game < ActiveRecord::Base
  has_many :players
  has_many :cards
  has_many :messages
end
