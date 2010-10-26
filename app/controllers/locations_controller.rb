class LocationsController < ApplicationController
  before_filter :get_dining_hall, :except => [:index]
  
  def index
    DiningHall.all.each(&:update_status)
    @dininghalls = DiningHall.all
    respond_to do |format|
      format.html
      format.xml { render :text => @dininghalls.to_xml }
      format.json { render :text => @dininghalls.to_json }
    end
  end

  def show
    @dininghall.update_status
    @meals = MealTime.todays.where(:dining_hall_id => @dininghall.id).select(:meal, :id)
    respond_to do |format|
      format.html
      format.xml { render :text => {:dining_hall => @dininghall.attributes}.merge({:meals => @meals}).to_xml }
      format.json { render :text => {:dining_hall => @dininghall.attributes}.merge({:meals => @meals}).to_json }
    end
  end

  def lunch
    @meal = @dininghall.meal_times.lunch.last
    render_meal
  end
  def dinner
    @meal = @dininghall.meal_times.dinner.last
  end
  def breakfast
    @meal = @dininghall.meal_times.breakfast.last
  end
  
  private
  def get_dining_hall
    @dininghall = DiningHall.find_by_name!(params[:name].titleize)
  end
  def render_meal
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
