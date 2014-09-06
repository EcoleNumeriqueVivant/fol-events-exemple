module FOL
  module API
    module V1
      class Users < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        resource :events do
          desc "Return current_user"
          get :me do
            current_user.as_json if authenticated?
          end
        end
      end
    end
  end
end