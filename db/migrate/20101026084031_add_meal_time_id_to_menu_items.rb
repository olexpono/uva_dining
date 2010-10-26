class AddMealTimeIdToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :meal_time_id, :integer
  end

  def self.down
    remove_column :menu_items, :meal_time_id
  end
end
