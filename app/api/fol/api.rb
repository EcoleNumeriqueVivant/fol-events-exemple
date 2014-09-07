require './app/api/fol/v1/root.rb'

module FOL
  module API
    class Root < Grape::API

      default_error_status 400
      rescue_from :all
      content_type :json, "application/json;charset=utf-8"
      format :json

      helpers do
        def warden
          env['warden']
        end

        def current_user
          warden.user
        end

        def authenticated?
          if warden.authenticated?
            true
          else
            error!({ message: '401 Unauthorized'}, 401)
          end
        end

        def logout!
          warden.logout
        end
      end

      desc "Here just a welcome message"
      get do
        {message:'Welcome to the API'}
      end

      desc "Return pong"
      get :ping do
        { message: "pong" }
      end

      mount FOL::API::V1::Root

      desc "404 for invalid routes"
      route :any, '*path' do
        error!({ message: 'This is not a valid route for our API'}, 404)
      end

    end
  end
end