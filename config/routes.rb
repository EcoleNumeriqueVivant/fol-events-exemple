FolEvents::Application.routes.draw do

  namespace :backend do resources :users end

  get "application/index"
  
  match '/add_to_list', :via => :post, :to => 'application#add_to_list'
  match '/dashboard', :to => 'application#dashboard'
  
  # post "events/search"
  resources :events do
    collection do
      post :search
    end  
  end   
  
  resources :tags do
    collection do
      get :sort
    end  
  end  
  
  namespace :default do  
     get "application/index"
  end  
  
  namespace :backend do  
     root :to => "application#index"
  end
  # /backend
  
  root :controller => 'Default::Application', :action => 'index'
  # root :to => "users#new"
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  resources :users
  resources :sessions

end
