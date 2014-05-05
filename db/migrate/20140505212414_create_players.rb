class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :type, default: 'Player'

      t.integer :game_id
      t.integer :user_id
      t.foreign_key :games
      t.foreign_key :users

      t.string :name
      t.integer :lives, default: 20
      t.integer :poison_counters, default: 0
      t.string :settings

      t.timestamps
    end
  end
end
