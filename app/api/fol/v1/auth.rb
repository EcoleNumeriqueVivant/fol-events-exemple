module FOL
  module API
    module V1
      class Auth < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        resource :auth do

          desc "Login user and create a new session"
          post do
            warden.authenticate(:api) ? current_user.as_json : error!({message: 'Invalid login or password'})
          end

          desc "Logout user"
          delete do
            logout!
          end

        end
      end
    end
  end
end