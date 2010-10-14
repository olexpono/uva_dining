class DiningHall < ActiveRecord::Base
  has_many :mealtimes
  
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
    est_offset = -14400
    @now = Time.now.gmtime + est_offset
    # @now is the current EST time (hour, min, sec), signed as UTC
    
    @year   = @now.year
    @month  = @now.month
    @day    = @now.day
    
    #Times that are valid accross all dining halls
    dinner_start      = Time.gm(@year,@month,@day,17,00,0)
    dinner_end        = Time.gm(@year,@month,@day,20,00,0)
    brunch_start      = Time.gm(@year,@month,@day,10,00,0)
    brunch_end        = Time.gm(@year,@month,@day,14,00,0)
    afterhrs_start    = Time.gm(@year,@month,@day,20,30,0)
    afterhrs_end      = Time.gm(@year,@month,@day,22,00,0)
    
    if name == 'Newcomb'
      breakfast_start   = Time.gm(@year,@month,@day,7,00,0)
      breakfast_end     = Time.gm(@year,@month,@day,10,15,0)
      lunch_start       = Time.gm(@year,@month,@day,10,45,0)
      lunch_end         = Time.gm(@year,@month,@day,14,15,0)
      ssd_start         = Time.gm(@year,@month,@day,14,15,0)
      ssd_end           = Time.gm(@year,@month,@day,16,00,0)
      #Monday - Thursday
      if @now.wday >=1 && @now.wday <=4
        #Check breakfast, lunch, ssd, dinner
        if is_between( breakfast_start, breakfast_end)
          "breakfast"
        elsif is_between( lunch_start, lunch_end)
          "lunch"
        elsif is_between( ssd_start, ssd_end)
          "soup_and_salad"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        else
          false
        end
      #Friday
      elsif @now.wday ==5
        #Check breakfast, lunch
        if is_between( breakfast_start, breakfast_end)
          "breakfast"
        elsif is_between( lunch_start, lunch_end)
          "lunch"
        else
          false
        end
      #Saturday
      elsif @now.wday ==6
        #Check brunch
        if is_between( brunch_start, brunch_end)
          "brunch"
        else
          false
        end
      #Sunday
      elsif @now.wday ==0
        #Check brunch, dinner
        if is_between( brunch_start, brunch_end)
          "brunch"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        else
          false
        end
      end   
    elsif name == 'Ohill'
      breakfast_start   = Time.gm(@year,@month,@day,7,00,0)
      breakfast_end     = Time.gm(@year,@month,@day,10,15,0)
      salad_start       = Time.gm(@year,@month,@day,10,15,0)
      salad_end         = Time.gm(@year,@month,@day,10,40,0)
      lunch_start       = Time.gm(@year,@month,@day,10,45,0)
      lunch_end         = Time.gm(@year,@month,@day,14,15,0)
      ssd_start         = Time.gm(@year,@month,@day,14,15,0)
      ssd_end           = Time.gm(@year,@month,@day,16,00,0)
      #Monday - Friday
      if @now.wday >=1 && @now.wday <=5
        #Check breakfast, salad bar, lunch, ssd, dinner
        if is_between( breakfast_start, breakfast_end)
          "breakfast"
        elsif is_between( lunch_start, lunch_end)
          "lunch"
        elsif is_between( ssd_start, ssd_end)
          "soup_and_salad"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        elsif is_between( salad_start, salad_end)
          "salad_bar"
        else
          false
        end
      #Saturday - Sunday
      elsif @now.wday ==0 || @now.wday ==6
        #Check  brunch, ssd, dinner
        if is_between( brunch_start, brunch_end)
          "brunch"
        elsif is_between( ssd_start, ssd_end)
          "soup_and_salad"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        else
          false
        end        
      end
    elsif name == 'Runk'
      breakfast_start   = Time.gm(@year,@month,@day,7,00,0)
      breakfast_end     = Time.gm(@year,@month,@day,10,30,0)
      lunch_start       = Time.gm(@year,@month,@day,11,00,0)
      lunch_end         = Time.gm(@year,@month,@day,14,00,0)
      ssd_start         = Time.gm(@year,@month,@day,14,00,0)
      ssd_end           = Time.gm(@year,@month,@day,16,00,0)
      #Monday - Thursday
      if @now.wday >=1 && @now.wday <=4
        #Check breakfast, lunch, ssd, dinner, afterhours
        if is_between breakfast_start, breakfast_end
          "breakfast"
        elsif is_between lunch_start, lunch_end
          "lunch"
        elsif is_between( ssd_start, ssd_end)
          "soup_and_salad"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        elsif is_between( afterhrs_start, afterhrs_end)
          "after_hours"
        else
          false
        end
      #Friday
      elsif @now.wday ==5
        #Check breakfast, lunch, ssd, dinner
        if is_between( breakfast_start, breakfast_end)
          "breakfast"
        elsif is_between( lunch_start, lunch_end)
          "lunch"
        elsif is_between( ssd_start, ssd_end)
          "soup_and_salad"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        else
          false
        end
      #Saturday - Sunday
      elsif @now.wday ==0 || @now.wday ==6
        #Check brunch, dinner
        if is_between( brunch_start, brunch_end)
          "brunch"
        elsif is_between( dinner_start, dinner_end)
          "dinner"
        else
          false
        end
      end
    end
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
