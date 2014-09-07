FolEvents::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # TODO
  # take a look at this gem
  # https://github.com/pluff/grape-devise/blob/master/lib/grape/devise/endpoints/authentication.rb
  devise_for :users, path: "auth", path_names: {
    sign_in:      'login',
    sign_out:     'logout',
    password:     'secret',
    confirmation: 'verification',
    unlock:       'unlock',
    registration: 'register',
    sign_up:      'sign_up'
  }, controllers: {sessions: 'sessions'}


  mount FOL::API::Root => 'api'

  get 'admin' => 'admin#index', :as => :admin_index
  root to: "home#index"
end
