class Location
	include Mongoid::Document
	include Mongoid::Timestamps


	## Database authenticatable
	field :id, :type => Integer, :default => ""
	field :address, :type => String, :default => ""
	field :location_name, :type => String, :default => ""
	field :phone_number, :type => String, :default => ""
	field :district, :type => String, :default => ""
	field :postcode, :type => String, :default => ""
	field :city, :type => String, :default => ""
	field :country, :type => String, :default => ""
	field :lat, :type => Float, :default => ""
	field :lng, :type => Float, :default => ""
	field :created_at, :type => Time, :default => ""
	field :updated_at, :type => Time, :default => ""

   
	validates_presence_of :address
	validates_presence_of :location_name



	attr_accessible :address
	attr_accessible :location_name
	attr_accessible :phone_number
	attr_accessible :district
	attr_accessible :postcode
	attr_accessible :city
	attr_accessible :country
	attr_accessible :lat
	attr_accessible :lng
 
	has_many :ratings
	#has_many :raters, :through => :ratings, :source => :user
	
	def raters
    User.in(id: ratings.map(&:user_id))
  end
  
  def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value = @value + rating.value
    end
    @total = self.ratings.size
    @value = @value.to_f / @total.to_f
    @value = 0.0 unless @value.finite?
	end

end
