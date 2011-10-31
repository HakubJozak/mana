class Card

  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :image_url, type: String
  field :collection_id, type: String
  field :order, type: Integer
  field :clazz, type: String, :default => 'Card'

  # Graveyard, Library etc; cannot be 'collection' as this field is
  # reserved by Mongoid
  field :collection_name, type: String

  belongs_to :player
  belongs_to :game
  embeds_one :backside, class_name: 'Card'

  def self.copy(original, user)
    card = original.clone
    card.id = Card.new_id
    card.user = user

    puts 'Created card'
    puts card.inspect

    card
  end

  def to_json
    super(:include => :backside)
  end

end
