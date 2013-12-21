class LocationsController < ApplicationController

			
	# GET /locations
  # GET /locations.json
  def index
    #@locations = Location.order("id desc").page(params[:page]).per(50)
    #@locations = Location.all
    
    puts "loc controller index"
    
    respond_to do |format|
      #format.html # index.html.erb
      #format.json { render json: @locations }
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
  
  	puts "loc controller new"
  
#	  @stored_locations = Location.all.each
	  #@stored_locations = Array.new

	  
		# construct a yelp client instance
#		client = Yelp::Client.new
		
		# perform an address/location-based search for cream puffs nearby
#		request = Yelp::V1::Review::Request::Location.new(
#					     :address => '650 Mission St',
#					     :city => 'San Francisco',
#					     :state => 'CA',
#					     :radius => 2,
#					     :term => 'cream puffs',
#					     :yws_id => 'H7JaEQfqf4qG-AvyBRIbgQ')
#		
#		response = client.search(request)
#		puts "yelp response"
#		businesses = response["businesses"]
#		
#		businesses.each do |singlebusiness|
#			puts singlebusiness["name"]	
#		end		
             
             
		# Make request to retrieve details of business vi yelp business id 
#		request = Yelp::V2::Business::Request::Id.new(
#				:yelp_business_id => "pjb2WMwa0AfK3L-dWimO8w",
#				:consumer_key     => 'bfGBEV3Ej3EQqo2vGta9ow',
#				:consumer_secret  => 'imgLOjWNHYERDU0D2FCJkMTlhf4',
#				:token            => 'vgAIJOqBJbzIY_9H5pTsheSP93xgUQzj',
#				:token_secret     => 'vDGFGE9pYzyGPdTVD8f1VYkg26Q')

#		singlebusiness = client.search(request)
#		puts "yelp response"
#		puts singlebusiness["name"]



 # search for businesses via bounding box geo coords'
# request = Yelp::V2::Search::Request::BoundingBox.new(
#						:term => "cream puffs",
#						:sw_latitude => 37.900000,
#						:sw_longitude => -122.500000,
#						:ne_latitude => 37.788022,
#						:ne_longitude => -122.399797,
#						:limit => 3,
#						:consumer_key     => 'bfGBEV3Ej3EQqo2vGta9ow',
#						:consumer_secret  => 'imgLOjWNHYERDU0D2FCJkMTlhf4',
#						:token            => 'vgAIJOqBJbzIY_9H5pTsheSP93xgUQzj',
#						:token_secret     => 'vDGFGE9pYzyGPdTVD8f1VYkg26Q')
# @yelpresponse = client.search(request)

# # perform an address/location-based search for cream puffs nearby
# request = Yelp::V1::Review::Request::Location.new(
#             :address => '650 Mission St',
#             :city => 'San Francisco',
#             :state => 'CA',
#             :radius => 2,
#             :term => 'cream puffs',
#             :yws_id => 'H7JaEQfqf4qG-AvyBRIbgQ')
# response = client.search(request)

	
	
	
		
#		response.each do |resp|
#			if resp.kind_of?(Array)
#				if resp[0] == "name"
#					puts resp[1]
#				end
#			end
#		end

		
#		if response.is_a?(Hash)
#			if response.has_key?("name")
#				puts singlebusiness["name"]	
#			end
#		end
		
#		keys = response.keys
#		puts "#{keys}"
		
#		response["businesses"].each { |x| puts x }
		

#		puts params['location_search']



    @location = Location.new

    respond_to do |format|
      #format.html # new.html.erb
      #format.html { redirect_to :controller=>'home', :action => 'index', :id => @location.id}
      format.html { redirect_to :controller=>'home', :action => 'index', :id => @location.id}
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
  	puts "loc controller create"
  	
  	loc = Location.where(:googleid => params[:hidden_googleid])
  	
		if loc.any?
			puts "found record in db"
			@location = loc.first
		else
  	
    	@location = Location.new(params[:location])
    
    	@location.yelpbusinessid = params[:yelpbusinessid]
    	@location.googleid = params[:googleid]
    	@location.googlereference = params[:googlereference]
    end
    
    if current_user.present?
    	@rating = Rating.new(:user_id => current_user.id, :location_id => @location.id, :Cat1value => params[:starCat1], :Cat1comment => params[:Cat1Comment], :Cat2value => params[:starCat2], :Cat2comment => params[:Cat2Comment])
    else
    	string = "anon"
		  length=6
			chars = ("A".."Z").to_a
			length.times do
		  	string << chars[rand(chars.length-1)]
			end
			
    	@rating = Rating.new(:user_id => string, :location_id => @location.id, :Cat1value => params[:starCat1], :Cat1comment => params[:Cat1Comment], :Cat2value => params[:starCat2], :Cat2comment => params[:Cat2Comment])
    end
    
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
  	puts "loc controller update"
  	
    @location = Location.find(params[:id])
    
    
    if current_user.present?
    
    	rat = Rating.where({:user_id => current_user.id, :location_id => @location.id})
  	
			if rat.any?
				puts "found rating in db"
				@rating = rat.first
				
				if @rating.update_attributes(params[:location])
					puts "rating updated"
				else
					puts "could not update rating"
				end
				
			else
    		@rating = Rating.new(:user_id => current_user.id, :location_id => @location.id, :Cat1value => params[:starCat1], :Cat1comment => params[:Cat1Comment], :Cat2value => params[:starCat2], :Cat2comment => params[:Cat2Comment])
    	
		  	if @rating.save
		  		puts "rating saved"
		  	else
		  		puts "couldn't save rating"
		  	end
		  end
    	
    else
    
		  string = "anon"
		  length=6
			chars = ("A".."Z").to_a
			length.times do
		  	string << chars[rand(chars.length-1)]
			end
	    @rating = Rating.new(:user_id => string, :location_id => @location.id, :Cat1value => params[:starCat1], :Cat1comment => params[:Cat1Comment], :Cat2value => params[:starCat2], :Cat2comment => params[:Cat2Comment])
	    
     	if @rating.save
	  		puts "rating saved"
	  	else
	  		puts "couldn't save rating"
	  	end
	    
    end

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

#####################  	
# should only be used as cleanup / administrative
#####################  	
#  	
#  	location = Location.find(params[:id])
#  	
#  	if !location.nil?
#	  	#puts location.location_name
#			location.ratings.each do |rating|
#				rating.destroy
#				#puts rating.Cat1value
#			end
#		  location.destroy
#    end
#  	
#  	respond_to do |format|
#      format.html { redirect_to locations_url, notice: 'Location was successfully deleted.' }
#      format.json { head :no_content }
#    end

  end
  
  def detail
  	puts "loc controller detail"
  	
  	loc = Location.where(:googleid => params[:hidden_googleid])
  	
		if loc.any?
			puts "found record in db"
			@location = loc.first
		else
			puts "new location"  	
			@location = Location.new(:googleid => params[:hidden_googleid], :googlereference => params[:hidden_googlereference], :yelpbusinessid => params[:hidden_yelpbusinessid2])
		end
	
  	respond_to do |format|
      format.html { render :template => "locations/detail" }
      format.json { render json: @location }
    end
  end
  
  def add_review
  	puts "loc controller add_review"
  	
  	@searchterm = params[:searchterm]

		if !params[:hidden_googleid].nil?
	  	loc = Location.where(:googleid => params[:hidden_googleid])

			if loc.any?
				puts "found record in db"
				@location = loc.first
			else
				puts "new location"  	
				@location = Location.new(:googleid => params[:hidden_googleid], :googlereference => params[:hidden_googlereference], :yelpbusinessid => params[:hidden_yelpbusinessid1])
			end
	  else
	  	@location = Location.new(:googleid => "", :googlereference => "", :yelpbusinessid => "")
		end
		 	
  	
  	respond_to do |format|
      format.html { render :template => "locations/addreview", :locals => {:location => @location}}
      format.json { render json: @location }
    end
  end
  
	def searchyelp
		puts "loc cntrl search yelp"
	
		@yelpresponse = String.new()
		@yelpbusinessid = String.new()
		
		client = Yelp::Client.new

		request = Yelp::V2::Search::Request::Location.new(
					     :address => params[:adr],
					     :city => params[:city],
					     :state => params[:state],
					     :radius => 1,
					     :term => params[:term],
					     :limit => 1,
					     :consumer_key     => 'bfGBEV3Ej3EQqo2vGta9ow',
					     :consumer_secret  => 'imgLOjWNHYERDU0D2FCJkMTlhf4',
					     :token            => 'vgAIJOqBJbzIY_9H5pTsheSP93xgUQzj',
					     :token_secret     => 'vDGFGE9pYzyGPdTVD8f1VYkg26Q')	

		response = client.search(request)
 		
 		businesses = response["businesses"]


		
		businesses.each do |singlebusiness|
			#keys = singlebusiness.keys
			#puts "#{keys}"
			
			#puts singlebusiness["name"]
			#puts singlebusiness["id"]
			#puts singlebusiness["location"]
			
			adr1 = params[:adr].sub(/Street/, 'St')
			adr2 = params[:adr].sub(/ St/, ' Street')
			
			#for all found businesses, check if address is the same as searched for,
			#if so return rating for that business
			if singlebusiness["location"]["display_address"][0] == params[:adr] or singlebusiness["location"]["display_address"][0] == adr1 or singlebusiness["location"]["display_address"][0] == adr2
				
				@yelpbusinessid = singlebusiness["id"]
				@yelpresponse = singlebusiness["rating"].to_s
			end		
			
		end
		
		puts "yelp search done."
		
	end
	
	def searchyelp_byid
		puts "loc cntrl searchyelp_byid"

		@yelpresponse = String.new()
		
		client = Yelp::Client.new
		
		# Make request to retrieve details of business vi yelp business id 
		request = Yelp::V2::Business::Request::Id.new(
				:yelp_business_id => params[:yelpid],
				:consumer_key     => 'bfGBEV3Ej3EQqo2vGta9ow',
				:consumer_secret  => 'imgLOjWNHYERDU0D2FCJkMTlhf4',
				:token            => 'vgAIJOqBJbzIY_9H5pTsheSP93xgUQzj',
				:token_secret     => 'vDGFGE9pYzyGPdTVD8f1VYkg26Q')

		singlebusiness = client.search(request)
		
		@yelpresponse = singlebusiness["rating"]
	end
	
  def searchresult
		puts "loc cntrl search result"

		@searchterm = params[:location_search]
		@googleref = params[:hidden_googlereference]


		respond_to do |format|
			format.html # searchresult.html.erb
		end
    
  end
  
end
