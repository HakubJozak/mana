class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :stamp
  belongs_to :player
  belongs_to :slot

  default_scope { order 'position,created_at' }

  validates_presence_of :game, :stamp, :player, :slot

  delegate :name, :manaCost, :text, :frontside, :backside, to: :stamp
end
