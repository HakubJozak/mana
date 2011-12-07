class Player
  include Mongoid::Document

  field :name, type: String
  field :color,type: String, default: '#FFD012'
  field :has_started, type: Boolean
  field :connected, type: Boolean
  field :spectator, type: Boolean
  field :clazz, type: String, :default => 'Player'

  validates_presence_of :name
  embedded_in :game
  has_many :cards
  embeds_one :deck

  # TODO: hackish - better way?
  belongs_to :user

  after_create do
    # TODO: compute order automatically or too much pain?
    order = 0

    Deck.build_cards(deck.mainboard) do |card|
      card.player = self
      card.game = game
      card.order = (order += 1)
      card.collection_id = "library-#{self.id}"
      card.save!
    end
  end

  after_initialize do
    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from cookie
      self.name ||= "Guest"
    end
  end

  def chosen_deck
    nil
#    current_user.decks.
  end

end

