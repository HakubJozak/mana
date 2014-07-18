class Player < ActiveRecord::Base

  belongs_to :user
  belongs_to :game
  belongs_to :deck

  has_many :cards, dependent: :destroy
  has_many :slots, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one :hand, ->(p) { where(name: "hand") }, class_name: 'Slot'
  has_one :library, ->(p) { where(name: 'library') }, class_name: 'Slot'
  has_one :graveyard, ->(p) { where(name: "graveyard") }, class_name: 'Slot'
  has_one :exile, ->(p) { where(name: "exile") }, class_name: 'Slot'
  has_many :battlefield_slots, ->(p) { where(name: "battlefield").order(:position) }, class_name: 'Slot'


  validates_presence_of :game, :deck

  attr_accessor :prepared_deck
  accepts_nested_attributes_for :deck

  after_create do
    %w( hand library graveyard exile ).each do |name|
      slots.create(name: name)
    end

    (0..15).each do |i|
      slots.create(name: 'battlefield', position: i)
    end

    self.library.add_deck(self.deck)
    self.library.shuffle
  end

  after_initialize do
    self.deck ||= Deck.new(mainboard: "10;Forest")

    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from a cookie
      self.name ||= "Guest"
    end
  end

end
