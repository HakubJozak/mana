class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :name
      # double-faced cards have multiple names: i.e. ["Cloistered Youth", "Unholy Fiend"]
      t.text :names
      t.text :foreignNames
      t.text :text
      t.text :originalText
      t.text :rulings
      t.text :printings

      t.text :flavor
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

      t.string :loyalty
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

      t.text :legalities
      t.string :variations

      t.timestamps
    end
  end
end
