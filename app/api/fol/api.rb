require './app/api/fol/v1/root.rb'

module FOL
  module API
    class Root < Grape::API

      default_error_status 400
      rescue_from :all
      content_type :json, "application/json;charset=utf-8"
      format :json

      helpers do
      end

      get :ping do
        { message: "pong" }
      end

      get do
        {message:'Welcome to the API'}
      end

      mount FOL::API::V1::Root

      route :any, '*path' do
        error!({ message: 'This is not a valid route for our API'}, 404)
      end

    end
  end
end