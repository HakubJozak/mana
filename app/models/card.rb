class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :stamp
  belongs_to :player
end
