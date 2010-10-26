class MenuItem < ActiveRecord::Base
  belongs_to :food_item
  belongs_to :meal_time
end
