require 'hpricot'
require 'open-uri'
require 'constants'

class Scraper
  def self.update_data
    meal_time = { :breakfast => "1", :lunch => "16", :dinner => "17", :brunch => "92"}
    @weekday = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @response = ''
    @baseUrls = {"newcomb"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/NewcombHallMenu.htm?LocationName=Newcomb%20Hall%20Menu&MealID=",
                "ohill"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/ObservatoryHillMenu.htm?LocationName=Observatory%20Hill%20Menu&MealID=",
                "runk"=>"http://www.campusdish.com/en-US/CSMA/Virginia/Locations/RunkHallMenu.htm?LocationName=Runk%20Hall%20Menu&MealID="}

    #iterate through each dining hall
    @baseUrls.each do |hall, hall_url|

        #iterate through each "time of day" (breakfast, lunch, dinner, and brunch)
        meal_time.each do |time, time_id|
            cur_url = hall_url+time_id+"&OrgID=113745&ShowPrice=False&ShowNutrition=True"

            #open the page using chrome's useragent
            open(cur_url, "User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.0 (KHTML, like Gecko) Chrome/3.0.183.1 Safari/531.0", "Referer" => "http://www.google.com") { |f|
                @response = f.read
            }

            doc = Hpricot(@response)

            #Find each of the day's menu items.  A day will show up multiple times because of the way the menu is divided by area's
            #I didnt pulle the area's because i dont think its super important, but i can if u want.
            doc.search(".menuBorder").each_with_index do |day, index|
                puts "For " + time.to_s + " at " + hall + " on: " + (@weekday[index % 7]).to_s
                day.search(".recipeLink").each do |item|
                    puts "            "+item.inner_html
                    #Uncomment this to print out the url for health facts
                    #puts "            "+item['href']
                    food_item = FoodItem.find_by_name(item.inner_html) || 
                                  FoodItem.create(:name => item.inner_html)
                end
            end
        end
    end
  end
end