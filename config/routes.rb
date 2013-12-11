ReviewSite::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  
  get '/locations/searchyelp', to: 'locations#searchyelp'
  
  post '/location/detail', to: 'locations#detail'
  post '/location/add_review', to: 'locations#add_review'
  
  resources :locations do
  	match '/locations/new' => 'locations#new'
  	match '/locations' => 'locations#new'
  end

  resources :rating
  match '/rating/:id/edit' => 'rating#update'
  match '/rating/new' => 'rating#create'
  #match '/rating', to: 'rating#index', via: :post
  
end
