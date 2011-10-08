class Player
  include Mongoid::Document

  field :name, type: String
  field :deck, type: String
  field :color,type: String, default: '#FF0000'
  field :clazz, type: String, :default => 'Player'

  validates_presence_of :name

  belongs_to :user
  embedded_in :game
  has_many :cards

  after_create do
    crd = Card.create!(
      name: 'Forest',
      url: 'http://magiccards.info/isd/en/262.html',
      image_url: 'http://magiccards.info/scans/en/isd/262.jpg',
      collection_id: "library-#{self.id}",
      game: game,
      player: self)
  end

  after_initialize do
    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from cookie
      self.name ||= "Guest"
    end

    # TODO: remove
    if defined?(Rails)
      self.deck = File.open("#{Rails.root}/db/decks/eldrazi").read
    end
  end

end

