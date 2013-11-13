class Rating
  include Mongoid::Document
  field :user_id, type: String
  field :location_id, type: String
  field :value, type: Integer
  
	attr_accessible :value
	attr_accessible :user_id
	attr_accessible :location_id

	belongs_to :user
	belongs_to :location
end
