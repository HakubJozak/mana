require 'ostruct'

class Card < OpenStruct

  include MongoMapper::Document

  attr_accessor :user

  @@counter = 0

  # TODO: is the ID unique this way?
  def initialize(params)
    raise ArgumentError unless params
    super(params.merge(:id => Card.new_id))
  end

  def self.copy(original, user)
    card = original.clone
    card.user = user
    card
  end

  def to_hash
    { :id => id,
      :name => name,
      :user_id => user.id,
      :image_url => image_url,
      :picture => image_url,
      :url => url }
  end

end
