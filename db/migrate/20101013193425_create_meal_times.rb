class CreateMealTimes < ActiveRecord::Migration
  def self.up
    create_table :meal_times do |t|
      t.datetime :start
      t.datetime :end
      t.string :meal

      t.timestamps
    end
  end

  def self.down
    drop_table :meal_times
  end
end
