ReviewSite::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  
  
  resources :locations
  match '/locations' => 'locations#new'
  
  resources :rating
  match '/rating/:id/edit' => 'rating#update'
  match '/rating/new' => 'rating#create'
  #match '/rating', to: 'rating#index', via: :post
  
end
