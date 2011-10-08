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
    # TODO: compute order automatically or too much pain?
    order = 0

    parse_deck do |card|
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

    # TODO: remove
    if defined?(Rails)
      self.deck = File.open("#{Rails.root}/db/decks/eldrazi").read
    end
  end

  private

    # TODO: handle bad lines
  # TODO: handle wrong names
  def parse_deck(&block)
    raise unless block
    return [] unless deck.present?

    deck.lines.each do |line|
      count, name = line.strip.split(/\t|\;/)
      count = count.to_i rescue 1

      # TODO: inform about bad card
      if name.present?
        count.times { CardStamp.print_by_name(name, &block) }
      end
    end
  end


end

