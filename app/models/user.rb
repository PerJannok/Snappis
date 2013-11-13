class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2, :twitter]

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  field :provider, :type => String, :default => "none"

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  validates_presence_of :name
  
  has_many :authentications

	has_many :ratings
	#has_many :rated_locations, :through => :ratings, :source => :locations  
	
attr_accessible :name, :provider, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  def rated_locations
    Location.in(id: ratings.map(&:location_id))
  end
  
	def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
	    		   email: data["email"],
	    		   provider: access_token["provider"],
	    		   password: Devise.friendly_token[0,20]
	    		  )
    end
    user
  end

  def self.find_for_twitter_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    
    user = User.where(:provider => access_token["provider"], :name => data["name"]).first

    unless user
        #create with a default email since it can not be empty, 
        #TODO: remove presence_of validation, but needs to handle email check at sign up
        user = User.create(name: data["name"], provider: access_token["provider"],
                        email: "default@defaulttwitter.com",
                        password: Devise.friendly_token[0,20])                              
    end
    
    user
  end
end
