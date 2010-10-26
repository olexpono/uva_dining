class MealsController < ApplicationController
  def show
    @meal = MealTime.todays.where(:id => params[:id]).last
    if @meal
      @dining_hall_name = @meal.dining_hall.name
      @menu_items = @meal.menu_items.includes(:food_item)
      @nice_menu_items = @menu_items.map {|mi| {:food_item => mi.food_item.name, 
                                                :nutrition_url => mi.food_item.nutrition_url}}
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => {:meal => @meal.attributes, :menu_items => @nice_menu_items} }
      format.json { render :json => {:meal => @meal.attributes, :menu_items => @nice_menu_items} }
    end
  end

end
