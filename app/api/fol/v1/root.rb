require './app/api/fol/v1/auth.rb'
require './app/api/fol/v1/users.rb'
require './app/api/fol/v1/events.rb'
module FOL
  module API
    module V1
      class Root < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        mount FOL::API::V1::Auth
        mount FOL::API::V1::Users
        mount FOL::API::V1::Events
      end
    end
  end
end