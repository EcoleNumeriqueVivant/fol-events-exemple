require './app/api/fol/v1/events.rb'
module FOL
  module API
    module V1
      class Root < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        mount FOL::API::V1::Events
      end
    end
  end
end