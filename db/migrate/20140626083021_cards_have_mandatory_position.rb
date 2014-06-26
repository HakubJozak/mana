class CardsHaveMandatoryPosition < ActiveRecord::Migration
  def change
    change_column :cards, :position, :integer, null: false
  end
end
