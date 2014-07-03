class Game < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :slots, through: :players, dependent: :destroy
  has_many :messages, -> { order('created_at DESC') }, through: :players, dependent: :destroy
end
