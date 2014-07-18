class AddDeckIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :deck_id, :integer, null: false
  end
end
