class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :name
      t.text :names # double-faced cards have multiple names: i.e. ["Cloistered Youth", "Unholy Fiend"]
      t.text :text
      t.text :originalText
      t.text :rulings, limit: 2048
      t.text :printings, limit: 2048
      t.text :legalities, limit: 2048
      t.text :flavor

      t.string :manaCost
      t.string :cmc # converted mana cost
      t.string :colors
      t.string :card_type # 'type' in JSON - renamed because of Rails STI
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

      t.string :variations

      t.timestamps
    end
  end
end
