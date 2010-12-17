require 'ostruct'

class Card < OpenStruct

  @@counter = 0

  # TODO: is the ID unique this way?
  def initialize(params)
    raise ArgumentError unless params
    super(params.merge(:id => Card.new_id))
  end

  def self.copy(original)
    card = original.clone
    card.id = Card.new_id
    card
  end

  def self.new_id
    @@counter += 1
  end
  
  def to_hash
    { :id => id,
      :name => name, 
      :image_url => image_url,
      :picture => image_url, 
      :url => url }
  end

end
