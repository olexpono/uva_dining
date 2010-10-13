class CreateFoodItems < ActiveRecord::Migration
  def self.up
    create_table :food_items do |t|
      t.string :nutrition_url
      t.string :name
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :food_items
  end
end
