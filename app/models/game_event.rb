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

  def apply
    if model.is_a?(Hash)
      case model['clazz']
      when 'Card'
        card = game.cards.find(model['_id'])
        card.update_attributes(model)
      when 'Player'
        # player = game.players.find(model['_id'])
        # player.update_attributes(model)
      when 'Message'
      else
        puts '!!!!!!', model
        puts model.class
        puts model['clazz']
        raise "Unknown event received #{}"
      end
    else
      model.save!
    end
  end

end
