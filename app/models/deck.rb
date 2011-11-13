class Deck
  include Mongoid::Document

  validates_presence_of :name, :mainboard

  field :name, type: String
  field :mainboard, type: String
  field :sideboard, type: String
  field :created_at, :type => DateTime, :default => lambda { Time.now }

  belongs_to :user

  def card_stamps(type = :mainboard)
    Deck.fetch_stamps_with_counts(self.send(type))
  end


  def self.fetch_stamps_with_counts(text)
    counts_and_stamps = []

    parse(text) do |count,name|
      stamp = CardStamp.find_or_create_by_name(name)
      counts_and_stamps << [ count, stamp ] if stamp
    end

    counts_and_stamps
  end

  def self.build_cards(text, &on_create)
    parse(text) do |count,name|
      count.times do
        CardStamp.print_by_name(name, &on_create)
      end
    end
  end

  private

  def self.parse(text, &block)
    raise 'Block missing' unless block
    raise 'Text missing' unless text
    errors = []

    text.lines.each do |line|
      count, name = line.strip.split(/\t|\;/)
      count = count.to_i rescue 1

      if name.blank?
        errors << line
      else
        yield(count, name)
      end
    end

    errors
  end


end
