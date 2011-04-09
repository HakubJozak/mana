require 'ostruct'

class Card < OpenStruct

  attr_accessor :user, :id, :order

  @@counter = 0

  # TODO: is the ID unique this way?
  def initialize(params)
    raise ArgumentError unless params
    super(params.merge(:id => Card.new_id))
  end

  def self.copy(original, user)
    card = original.clone
    card.id = Card.new_id
    card.user = user

    puts 'Created card'
    puts card.inspect

    card
  end

  def self.new_id
    @@counter += 1
  end

  def to_hash
    result = {
      :id => id,
      :order => order,
      :name => name,
      :image_url => image_url,
      :picture => image_url,
      :url => url }

    result[:user_id] = user.id if user
    result
  end

end
