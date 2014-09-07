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
            Event.all.as_json
          end

          desc "Return an event by :id"
          get ':id' do
            event = Event.find(params[:id])
            error! {message:"Not Found"}  unless event
            event.as_json
          end

          desc "Update an event by :id",
           params: Hash[Event.attribute_names.map{|sym| [sym, {}]}].merge(
            "id" => { description: "event id", required: true }
           )
          put ':id' do
            event = Event.find(params[:id])
            error! {message:"Not Found"} unless event
            values = {}
            event.update_attributes!(values)
            event.as_json
          end

          desc "Delete an event by :id"
          delete ':id' do
            event = Event.find(params[:id])
            error! {message:"Not Found"} unless event
            event.destroy
            event.as_json
          end

          desc "Create an event"
          post do
            event = Event.create!()
            event.as_json
          end
        end
      end
    end
  end
end