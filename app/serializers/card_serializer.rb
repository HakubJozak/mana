class CardSerializer < ActiveModel::Serializer
  attributes :id, :counters, :power, :toughness, :covered,
             :flipped, :tapped,
             :frontside, :backside,
             :name, :manaCost, :text

end
