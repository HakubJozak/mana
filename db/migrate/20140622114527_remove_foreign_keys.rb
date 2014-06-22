class RemoveForeignKeys < ActiveRecord::Migration
  def change
    # causing troubles when initializing tests - put it back when there is time
    remove_foreign_key :players, :games
  end
end
