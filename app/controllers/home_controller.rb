class HomeController < ApplicationController

  def index
  	puts "home controller"
  	@location = Location.new
    #@location = Location.find(params[:id])
    puts "got locations"

  end
  
  def show
  	puts "show..."
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

end
