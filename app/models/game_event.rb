class GameEvent
  include Mongoid::Document

  field :mid, type: Integer
  field :raw, type: String
  belongs_to :game

  attr_accessor :model

  def self.history(opts = { before: 1 })
    raise ':before parameter missing' unless opts[:before].present?

    opts[:before]
  end

end
