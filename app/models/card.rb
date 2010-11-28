require 'ostruct'

class Card < OpenStruct

  @@counter = 0

  # TODO: is the ID unique this way?
  def initialize(params)
    raise ArgumentError unless params
    super(params.merge(:id => @@counter))
    @@counter += 1
  end

  def to_hash
    { :id => id,
      :name => name, 
      :image_url => image_url, 
      :url => url }
  end

end
