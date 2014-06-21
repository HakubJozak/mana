class Player < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  has_many :cards, dependent: :destroy

  has_many :deck, ->(p) { where(location: "deck_#{p.id}") }, class_name: 'Card'
  has_many :graveyard, ->(p) { where(location: "graveyard_#{p.id}") }, class_name: 'Card'
  has_many :battlefield, ->(p) { where(location: "battlefield_#{p.id}") }, class_name: 'Card'
  has_many :hand, ->(p) { where(location: "hand_#{p.id}") }, class_name: 'Card'


  validates_presence_of :game

  attr_accessor :prepared_deck


  after_create do
    10.times do |i|
      cards.create! stamp: Stamp.random, location: "hand_#{id}", game: game
    end

    # TODO: compute order automatically or too much pain?
    # order = 0

    # Deck.build_cards(deck.mainboard) do |card|
    #   card.player = self
    #   card.game = game
    #   card.order = (order += 1)
    #   card.collection_id = "library-#{self.id}"
    #   card.save!
    # end
  end

  after_initialize do
    self.prepared_deck = 'ADHOC'
    self.mainboard = '10;Forest'

    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from a cookie
      self.name ||= "Guest"
    end
  end

end
