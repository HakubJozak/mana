class AddPlayerToCard < ActiveRecord::Migration
  def change
    add_column :cards, :player_id, :integer
    add_foreign_key :cards, :players
  end
end
