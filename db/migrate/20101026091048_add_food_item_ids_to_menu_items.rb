class AddFoodItemIdsToMenuItems < ActiveRecord::Migration
  def self.up
    remove_column :menu_items, :food_id
    add_column :menu_items, :food_item_id, :integer
  end

  def self.down
    add_column :menu_items, :food_id, :integer
    remove_column :menu_items, :food_item_id
  end
end
