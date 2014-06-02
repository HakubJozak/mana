class CardSerializer < ActiveModel::Serializer
  attributes :id, :counters, :power, :toughness, :covered,
             :flipped, :tapped,  :frontside, :backside

  def frontside
    object.stamp.frontside_url
  end

  def backside
    object.stamp.backside_url
  end

end
