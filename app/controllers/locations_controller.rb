class LocationsController < ApplicationController
  def index
    DiningHall.all.each(&:update_status)
    @dininghalls = DiningHall.all
    respond_to do |format|
      format.html
      format.xml { render :xml => @dininghalls }
      format.json { render :json => @dininghalls }
    end
  end

  def show
    @dininghall = DiningHall.find_by_name!(params[:name].titleize)
    @dininghall.update_status
    respond_to do |format|
      format.html
      format.xml { render :xml => @dininghall }
      format.json { render :json => @dininghall }
    end
  end

end
