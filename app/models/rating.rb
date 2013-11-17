class Rating
  include Mongoid::Document
  field :user_id, type: String
  field :location_id, type: String
  field :Cat1value, type: Integer
  field :Cat1comment, type: String
  field :Cat2value, type: Integer
  field :Cat2comment, type: String
  
  
	attr_accessible :Cat1value
	attr_accessible :Cat1comment
	attr_accessible :Cat2value
	attr_accessible :Cat2comment
	attr_accessible :user_id
	attr_accessible :location_id

	belongs_to :user
	belongs_to :location
end
