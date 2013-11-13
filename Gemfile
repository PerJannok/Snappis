source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '3.2.14'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'devise'
gem 'omniauth'
gem 'twitter'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem "authbuttons-rails"
gem "nifty-generators"
gem 'figaro'
gem 'mongoid'

gem 'jquery-star-rating-rails'

gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :production do
  gem 'thin'
  gem 'rails_12factor'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'mongoid-rspec'
end

gem "mocha", :group => :test
