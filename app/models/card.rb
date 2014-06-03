class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :stamp
  belongs_to :player

  validates_presence_of :game, :stamp, :player

  delegate :name, :manaCost, :text, :frontside, :backside, to: :stamp
end
