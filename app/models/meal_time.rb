class MealTime < ActiveRecord::Base
  has_one :dininghall
  has_many :menuitems
end
