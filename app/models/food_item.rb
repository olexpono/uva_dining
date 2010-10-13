class FoodItem < ActiveRecord::Base
  has_many :menuitems
end
