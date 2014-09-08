module FOL
  module API
    module V1
      class Events < Grape::API
        content_type :json, "application/json;charset=utf-8"
        format :json
        version 'v1'

        helpers do
          def represent_list events
            events.map{|a| a.extend(EventRepresenter).to_hash}
          end
        end

        resource :types do
          get do
            Tag.typology
          end
        end

        resource :themes do
          get do
            Tag.theme
          end
        end

        resource :events do

          desc "Find events near a location"
          params do
            optional :location, type: String
            optional :radius, type: Integer
              optional :point, type: Array do
                requires :lat
                requires :lgt
              end
          end
          get :near do
            represent_list(Address.near(params[:location], params[:radius] ||= 20, :units => :km ).map(&:addressable).compact)
          end

          desc "Find events with any of the type or theme based on context or location"
          params do
            optional :type, type: String #, values: -> { Tag.typology.map(&:name) }
            optional :theme, type: String #, values: -> { Tag.theme.map(&:name) }
            optional :location, type: String
            optional :radius, type: Integer
          end
          get do
            events = if params[:type] && params[:theme]
              Event.tagged_with(params[:type].split(','), :on => :typology, :any => true).tagged_with(params[:theme].split(','), :on => :theme, :any => true)
            elsif params[:type]
              Event.tagged_with(params[:type].split(','), :on => :typology, :any => true)
            elsif params[:theme]
              Event.tagged_with(params[:theme].split(','), :on => :theme, :any => true)
            else
              Event.all
            end

            if params[:location]
              location = params[:location].split(',')
              location = location[0] if location.size == 1
              represent_list(events) & represent_list(Address.near(location, params[:radius] ||= 20, :units => :km ).map(&:addressable).compact)
            else
              represent_list(events)
            end

          end

          desc "Future events"
          get :future do
            represent_list(Event.future)
          end

          desc "Upcoming events (1 month)"
          get :upcoming do
            represent_list(Event.upcoming)
          end

          desc "Return an event by :id"
          params do
            requires :id, type: Integer, desc: "event id."
          end
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
          params do
            requires :id, type: Integer, desc: "event id."
          end
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

        end

      end
    end
  end
end