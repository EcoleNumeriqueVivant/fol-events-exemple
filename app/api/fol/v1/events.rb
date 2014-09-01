module FOL
  module API
    module V1
      class Events < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        resource :events do
          desc "Return list of all events"
          get do
            Event.all
          end
          desc "Return an event by :id"
          get ':id' do
            Event.find(params[:id])
          end
        end
      end
    end
  end
end