class DiningHall < ActiveRecord::Base
  has_many :meal_times
  
  def to_xml(options = {})
    super(options.merge(:except => [:id, :updated_at, :created_at]))
  end
  
  def to_json(options = {})
    super(options.merge(:except => [:id, :updated_at, :created_at]))
  end
  
  def update_status
    is_open_result = is_open
    self[:open] = is_open_result ? true : false
    self[:meal] = is_open_result ? is_open_result.titleize : "Closed"
    puts "updating "+name.to_s+" with: " + self[:meal] + " | "+is_open_result.to_s
    save
  end

  def is_open
    meal_times = MealTime.todays.where(:dining_hall_id => id)
    meal_times.each do |mt|
      if is_between(mt.start, mt.end)
        return mt.meal
      end
    end
    false
  end
  
  def is_between(start_time, end_time)
    #puts "Start: " + start_time
    #puts "End: " + end_time
    #puts "Now: " + (@now-21600)
    @now ||= Time.now.gmtime - 14400
    if (@now) > start_time && (@now) < end_time
      true 
    else
      false
    end
  end
end
