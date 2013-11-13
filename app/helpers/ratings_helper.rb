module RatingsHelper

	def current_user_rating
		if @rating = current_user.ratings.where(location_id: params[:id]).first
		    @rating.value
		else
		    "N/A"
		end
	end
	
end
