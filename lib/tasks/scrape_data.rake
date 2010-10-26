require 'constants'
require 'open-uri'
include Constants
desc "Scrapes UVA Dining site to update current date's meals"
task :scrape_data => :environment do
  meal_time = { :breakfast => "1", :lunch => "16", :dinner => "17", :brunch => "92"}
  meal_time_hours = {:breakfast => [BREAKFAST_START, BREAKFAST_END],
                     :brunch => [BRUNCH_START, BRUNCH_END],
                     :dinner => [DINNER_START, DINNER_END],
                     :lunch => [LUNCH_START,LUNCH_END]}
  weekday = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  this_day = Constants::now.wday
  response = ''
  baseUrls = {"newcomb"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/NewcombHallMenu.htm?LocationName=Newcomb%20Hall%20Menu&MealID=",
              "ohill"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/ObservatoryHillMenu.htm?LocationName=Observatory%20Hill%20Menu&MealID=",
              "runk"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/RunkHallMenu.htm?LocationName=Runk%20Hall%20Menu&MealID="}

  #iterate through each dining hall
  baseUrls.each do |hall, hall_url|
    puts "Processing... #{hall.titleize} Dining Hall"
    #iterate through each "time of day" (breakfast, lunch, dinner, and brunch)
    meal_time.each do |time, time_id|
      puts "Processing... #{time.to_s.titleize}"
      cur_url = hall_url+time_id+"&OrgID=113745&ShowPrice=False&ShowNutrition=True"
      #open the page using chrome's useragent
      open(cur_url, "User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.0 (KHTML, like Gecko) Chrome/3.0.183.1 Safari/531.0", "Referer" => "http://www.google.com") do |f|
        response = f.read
      end
      
      doc = Hpricot(response)
      
      #Find each of the day's menu items.  A day will show up multiple times because of the way the menu is divided by area's
      #I didnt pulle the area's because i dont think its super important, but i can if u want.
      doc.search(".menuBorder").each_with_index do |day, index|
        if (index % 7) == this_day
          recipe_links = day.search(".recipeLink")
          mt = nil
          unless recipe_links.empty?
            mt = MealTime.send("#{time.to_s}!", :dining_hall_id => DiningHall.find_by_name(hall.titleize).id)
          end
          
          recipe_links.each do |item|
            fi = FoodItem.find_by_name(item.inner_html) || 
                          FoodItem.create(:name => item.inner_html, 
                                          :nutrition_url => item['href'],
                                          :type => item.inner_html.match(/[(][V§][)]/) ? "Vegetarian" : "Non-Vegetarian")
            MenuItem.create(:meal_time => mt, :food_item => fi)
          end
        end
      end
    end
  end
end