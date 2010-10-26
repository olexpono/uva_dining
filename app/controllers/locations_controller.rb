class LocationsController < ApplicationController
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
    @dininghall = DiningHall.find_by_name!(params[:name].titleize)
    @dininghall.update_status
    @meals = MealTime.todays.where(:dining_hall_id => @dininghall.id).select(:meal, :id)
    respond_to do |format|
      format.html
      format.xml { render :text => {:dining_hall => @dininghall.attributes}.merge({:meals => @meals}).to_xml }
      format.json { render :text => {:dining_hall => @dininghall.attributes}.merge({:meals => @meals}).to_json }
    end
  end

end
