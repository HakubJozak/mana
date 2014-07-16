class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :mainboard
      t.text :sideboard
      t.integer :user_id

      t.timestamps
    end
  end
end
