class Authentication
  include Mongoid::Document
  
  belongs_to :user
  
  attr_accessible :user_id, :provider, :uid
end
