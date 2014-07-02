class Message < ActiveRecord::Base
  belongs_to :player
  has_one :game, through: :player
end
