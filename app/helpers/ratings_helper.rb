module RatingsHelper

	def current_user_cat1_rating
		if @rating = current_user.ratings.where(location_id: params[:id]).first
		    @rating.Cat1value
		else
		    "N/A"
		end
	end

	def current_user_cat2_rating
		if @rating = current_user.ratings.where(location_id: params[:id]).first
		    @rating.Cat2value
		else
		    "N/A"
		end
	end	
	
end
