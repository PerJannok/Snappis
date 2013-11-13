class RatingController < ApplicationController

  before_filter :authenticate_user!

  def create
    puts "create new rating!"
    puts params.inspect

    @location = Location.find(params[:location_id])
    
   	@rating = Rating.new(:user_id => current_user.id, :location_id => @location.id, :value => params[:star2])
    
    
    respond_to do |format|
    	if @rating.save
	      format.html { redirect_to @location, notice: 'Rating was successfully created.' }
	      format.json { render json: @location, status: :created, location: @location }      	
    	else
	      format.html { render action: "new" }
	      format.json { render json: @rating.errors, status: :unprocessable_entity }      	
    	end
    end
  end
    
	def update
		@rating = Rating.find(params[:id])
		@location = Location.find(@rating.location_id)
		
		@rating.value = params[:star2]
		    	
		#puts "update rating"
		#puts params.inspect
		
    respond_to do |format|
      	if @rating.save
					format.html { redirect_to location_path(@location), :notice => "Your rating has been updated" }
					format.js
				end
		end
	end

end

