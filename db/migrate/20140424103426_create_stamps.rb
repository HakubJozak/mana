class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :name
      t.string :url
      t.string :frontside
      t.string :backside

      t.timestamps
    end
  end
end
