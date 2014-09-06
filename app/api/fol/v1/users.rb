module FOL
  module API
    module V1
      class User < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        get :me do
          current_user.as_json if authenticated?
        end
      end
    end
  end
end