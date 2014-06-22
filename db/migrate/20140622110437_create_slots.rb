class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :name, null: false
      # used for battlefield only
      t.integer :position

      t.integer :player_id, null: false
      t.foreign_key :players

      # t.integer :game_id, null: false
      # t.foreign_key :games

      t.timestamps
    end

    add_column :cards, :slot_id, :integer, null: false
  end
end
