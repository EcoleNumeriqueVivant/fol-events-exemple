FolEvents::Application.routes.draw do

  # TODO
  # take a look at this gem
  # https://github.com/pluff/grape-devise/blob/master/lib/grape/devise/endpoints/authentication.rb
  devise_for :users, path: "api/auth", path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'register',
    sign_up: 'cmon_let_me_in'
  }

  mount FOL::API::Root => 'api'

  get 'admin' => 'admin#index', :as => :admin_index
  root to: "home#index"
end
