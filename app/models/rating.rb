class Rating
  include Mongoid::Document
  field :user_id, type: String
  field :location_id, type: String
  field :Cat1value, type: Integer
  field :Cat1comment, type: String
  field :Cat2value, type: Integer
  field :Cat2comment, type: String
  
#  after_initialize :migrate_data
  
	attr_accessible :Cat1value
	attr_accessible :Cat1comment
	attr_accessible :Cat2value
	attr_accessible :Cat2comment
	attr_accessible :user_id
	attr_accessible :location_id

#  def migrate_data
# 		if !self[:value].blank?
#      self.set(:Cat1value, self[:value])
#      self.remove_attribute(:value)
#		end
#  end
  
	belongs_to :user
	belongs_to :location
end
