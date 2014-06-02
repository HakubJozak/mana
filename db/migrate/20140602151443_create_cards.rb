class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :counters
      t.integer :power
      t.integer :toughness

      t.boolean :covered, default: true, null: false
      t.boolean :tapped, default: false, null: false
      t.boolean :flipped, default: false, null: false

      t.integer :game_id, null: false
      t.foreign_key :games

      t.integer :stamp_id, null: false
      t.foreign_key :stamps

      t.timestamps
    end
  end
end
