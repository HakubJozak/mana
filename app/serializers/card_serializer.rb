class CardSerializer < ActiveModel::Serializer
  attributes :id, :position, :location,
             :counters, :power, :toughness, :covered,
             :flipped, :tapped,
             :frontside, :backside,
             :name, :manaCost, :text

end
