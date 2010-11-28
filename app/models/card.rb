require 'ostruct'

class Card < OpenStruct

  def initialize(params)
    raise ArgumentError unless params
    super(params)
  end

  def to_hash
    { :name => name, :image_url => image_url, :url => url }
  end

end
