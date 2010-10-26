module Constants
  EST_OFFSET = -14400
  def self.now
    Time.now.gmtime + EST_OFFSET
  end
  
  year = now.year
  month = now.month
  day = now.day
  
  DINNER_START          = Time.gm(year,month,day,17,00,0)
  DINNER_END            = Time.gm(year,month,day,20,00,0)
  BRUNCH_START          = Time.gm(year,month,day,10,00,0)
  BRUNCH_END            = Time.gm(year,month,day,14,00,0)
  AFTER_HOURS_START     = Time.gm(year,month,day,20,30,0)
  AFTER_HOURS_END       = Time.gm(year,month,day,22,00,0)
  BREAKFAST_START       = Time.gm(year,month,day,7,00,0)
  BREAKFAST_END         = Time.gm(year,month,day,10,15,0)
  SALAD_START           = Time.gm(year,month,day,10,15,0)
  SALAD_END             = Time.gm(year,month,day,10,40,0)
  LUNCH_START           = Time.gm(year,month,day,10,45,0)
  LUNCH_END             = Time.gm(year,month,day,14,15,0)      
  SOUP_SALAD_START      = Time.gm(year,month,day,14,15,0)
  SOUP_SALAD_END        = Time.gm(year,month,day,16,00,0)
  
  DINNER_START_TIME     = DINNER_START.strftime("%H:%M:%S")
  DINNER_END_TIME       = DINNER_END.strftime("%H:%M:%S")    
  BRUNCH_START_TIME     = BRUNCH_START.strftime("%H:%M:%S")    
  BRUNCH_END_TIME       = BRUNCH_END.strftime("%H:%M:%S")      
  AFTER_HOURS_START_TIME = AFTER_HOURS_START.strftime("%H:%M:%S")
  AFTER_HOURS_END_TIME   = AFTER_HOURS_END.strftime("%H:%M:%S")  
  BREAKFAST_START_TIME  = BREAKFAST_START.strftime("%H:%M:%S") 
  BREAKFAST_END_TIME    = BREAKFAST_END.strftime("%H:%M:%S")   
  SALAD_START_TIME      = SALAD_START.strftime("%H:%M:%S")     
  SALAD_END_TIME        = SALAD_END.strftime("%H:%M:%S")       
  LUNCH_START_TIME      = LUNCH_START.strftime("%H:%M:%S")     
  LUNCH_END_TIME        = LUNCH_END.strftime("%H:%M:%S")       
  SOUP_SALAD_START_TIME = SOUP_SALAD_START.strftime("%H:%M:%S")       
  SOUP_SALAD_END_TIME   = SOUP_SALAD_END.strftime("%H:%M:%S")         
  
end