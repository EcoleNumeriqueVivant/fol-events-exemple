FolEvents::Application.routes.draw do

  # TODO
  # take a look at this gem
  # https://github.com/pluff/grape-devise/blob/master/lib/grape/devise/endpoints/authentication.rb
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'users/sign' => 'devise/sessions#new', :as => :new_user_session
    post 'users/sign' => 'devise/sessions#create', :as => :user_session
    delete 'users/sign' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  mount FOL::API::Root => 'api'

  root to: "home#index"
end
