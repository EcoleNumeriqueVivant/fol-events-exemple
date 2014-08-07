FolEvents::Application.routes.draw do

  devise_for :users
  get "help/index"
  get "account/index"
  get "account/show"
  
  get '/fiche' => 'doc_export#event'

  get "application/index"
  
  match '/add_to_list' => 'application#add_to_list', via: [:post]
  match '/dashboard' => 'application#dashboard', via: [:get]
  
  # post "events/search"
  get "events/future"
  get "events/past"
  
  resources :events do
    collection do
      post :search
      post :comment
      get :rate
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
     resources :users
     resources :comments
  end
  # /backend
  
  root 'application#index'
  # root :to => "users#new"
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  resources :users
  resources :sessions

end
