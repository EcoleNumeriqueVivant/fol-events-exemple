FolEvents::Application.routes.draw do

  namespace :backend do
     root :to => "application#index"
     resources :users
     resources :comments
  end

end
