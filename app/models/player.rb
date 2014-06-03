class Player < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  has_many :cards
  has_many :deck, ->(o) { where(location: 'deck') }, class_name: 'Card'
  has_many :graveyard, ->(o) { where(location: 'graveyard') }, class_name: 'Card'
  has_many :battlefield, ->(o) { where(location: 'battlefield') }, class_name: 'Card'
  has_many :hand, ->(o) { where(location: 'hand') }, class_name: 'Card'


  validates_presence_of :game

  attr_accessor :prepared_deck


  after_create do
    10.times do |i|
      cards.create! stamp: Stamp.random, location: 'deck', game: game
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
      # TODO: take it from cookie
      self.name ||= "Guest"
    end
  end

end
