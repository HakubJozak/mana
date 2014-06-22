class RemoveLocationFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :location
    remove_column :cards, :order
  end
end
