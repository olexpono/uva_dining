class LocationsController < ApplicationController
  def index
    #assigns @locations, renders JSON or XML
    @dininghalls = DiningHall.all
    @dininghalls.each(&:update)
    respond_to do |format|
      format.html
      format.xml { render :xml => @dininghalls }
    end
  end

  def show
    #assigns @location, @menu_items, etc, renders JSON or XML
  end

end
