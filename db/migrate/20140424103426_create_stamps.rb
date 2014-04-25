class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :name
      # double-faced cards have multiple names: i.e. ["Cloistered Youth", "Unholy Fiend"]
      t.string :names
      t.string :text
      t.string :flavor
      t.string :manaCost
      # converted mana cost
      t.string :cmc
      t.string :colors
      # 'type' in JSON - renamed because of Rails STI
      t.string :card_type
      t.string :types
      t.string :supertypes
      t.string :subtypes
      t.string :rarity
      t.string :power
      t.string :toughness
      # 'normal' or 'double-faced'
      t.string :layout
      t.string :artist
      t.string :edition
      # has 'a/b' sufix for double-faced cards (i.e. 8a)
      t.string :number
      t.string :multiverseid
      t.string :imageName

      t.string :originalType
      t.string :originalText
      t.string :rulings
      t.string :foreignNames
      t.string :printings
      t.string :legalities

      t.timestamps
    end
  end
end
