module FOL
  module API
    module V1
      class Users < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        resource :users do
          desc "Return current_user"
          get :me do
            current_user.as_json if authenticated?
          end
          params do
          end
          desc "Add a new user"
          post do
            user = User.create(email: params[:email], password: params[:password])
            if user.valid?
              user
            else
              error!({message:user.errors}, 400)
            end
          end
        end
      end
    end
  end
end