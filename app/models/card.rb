class Card

  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :image_url, type: String
  field :clazz, type: String, :default => 'Card'

  # Graveyard, Library etc; cannot be 'collection' as this field is
  # reserved by Mongoid
  field :collection_name, type: String

  belongs_to :player
  belongs_to :game

  def self.copy(original, user)
    card = original.clone
    card.id = Card.new_id
    card.user = user

    puts 'Created card'
    puts card.inspect

    card
  end

end
