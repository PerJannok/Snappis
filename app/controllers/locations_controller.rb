class LocationsController < ApplicationController

  # GET /locations
  # GET /locations.json
  def index
    #@locations = Location.order("id desc").page(params[:page]).per(50)
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
  
	  @stored_locations = Location.all.each

    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])
    
    if current_user.present?
    	@rating = Rating.new(:user_id => current_user.id, :location_id => @location.id, :value => params[:star1])
    	#@rating.location_id = @location.id
    	#@rating.user_id = current_user.id
    end
    
    #puts params.inspect
    
    respond_to do |format|
      if @location.save
      	if @rating.save
		      format.html { redirect_to @location, notice: 'Location was successfully created.' }
		      format.json { render json: @location, status: :created, location: @location }      	
      	else
		      format.html { render action: "new" }
		      format.json { render json: @rating.errors, status: :unprocessable_entity }      	
      	end
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end
end
