class AddPositionToCard < ActiveRecord::Migration
  def change
    add_column :cards, :location, :string
    add_column :cards, :position, :integer
    add_column :cards, :order, :integer, null: false, default: 0
  end
end
