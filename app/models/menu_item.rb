class MenuItem < ActiveRecord::Base
  has_one :fooditem
  belongs_to :mealtime
end
