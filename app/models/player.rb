class Player < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  has_many :cards, dependent: :destroy
  has_many :slots, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one :hand, ->(p) { where(name: "hand") }, class_name: 'Slot'
  has_one :deck, ->(p) { where(name: 'deck') }, class_name: 'Slot'
  has_one :graveyard, ->(p) { where(name: "graveyard") }, class_name: 'Slot'
  has_one :exile, ->(p) { where(name: "exile") }, class_name: 'Slot'
  has_many :battlefield_slots, ->(p) { where(name: "battlefield").order(:position) }, class_name: 'Slot'


  validates_presence_of :game

  attr_accessor :prepared_deck

  after_create do
    %w( hand deck graveyard exile ).each do |name|
      slots.create(name: name)
    end

    (0..15).each do |i|
      slots.create(name: 'battlefield', position: i)
    end

    self.deck.add_cards(mainboard)
  end

  after_initialize do
    self.prepared_deck = 'ADHOC'
    self.mainboard ||= '10;Forest'

    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from a cookie
      self.name ||= "Guest"
    end
  end

end
