class AddDiningHallIdToMealTimes < ActiveRecord::Migration
  def self.up
    add_column :meal_times, :dining_hall_id, :integer
  end

  def self.down
    remove_column :meal_times, :dining_hall_id
  end
end
