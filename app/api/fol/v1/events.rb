module FOL
  module API
    module V1
      class Events < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'
        resource :events do

          def represent_list events
            events.map{|a| a.extend(EventRepresenter).to_hash}
          end

          desc "Return list of all events"
          get do
            represent_list(Event.all)
          end

          desc "Return an event by :id"
          get ':id' do
            event = Event.find(params[:id])
            error! {message:"Not Found"}  unless event
            event.extend(EventRepresenter).to_hash
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
            event.extend(EventRepresenter).to_hash
          end

          desc "Delete an event by :id"
          delete ':id' do
            event = Event.find(params[:id])
            error! {message:"Not Found"} unless event
            event.destroy
            event.extend(EventRepresenter).to_hash
          end

          desc "Create an event"
          post do
            event = Event.create!()
            event.extend(EventRepresenter).to_hash
          end

          desc "Find events near a location"
          post :near do
            represent_list(Address.near(params[:location], params[:radius] ||= 20, :units => :km ).map(&:addressable))
          end

        end
      end
    end
  end
end