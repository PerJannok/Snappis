class HomeController < ApplicationController

  def index
  	

  end
  
  def show
  	puts "home cntrl show"
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end
  
end
