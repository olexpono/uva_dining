class DiningHall < ActiveRecord::Base
  has_many :mealtimes
  
  def update
    open = "closed" unless false
    meal = "breakfast"
  end
  
  def is_open?
    
  end
end
