class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :messages, dependent: :destroy
end
