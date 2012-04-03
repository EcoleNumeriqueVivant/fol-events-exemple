class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.build_address

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    if @event.address.nil?
      
      @event.build_address
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  
  
  # {"utf8"=>"✓",
  #    "_method"=>"put",
  #    "authenticity_token"=>"s9ovB5/EXHUXmefwMMsTm1jetArVQHZWfk5TGqu07II=",
  #    "event"=>{"name"=>"La librairie éphemère",
  #    "description"=>"Un évènement qui rend compte de la production d’une cinquantaine d’éditeurs peu présents en librairie,
  #    et aussi des lectures,
  #    des mises en scènes et expositions. ",
  #    "attendance"=>"",
  #    "contacts"=>"",
  #    "how_to_participate"=>"",
  #    "registration_fees"=>"",
  #    "participants"=>"",
  #    "related_events"=>"",
  #    "infos_extra"=>"",
  #    "address_attributes"=>{"line1"=>"",
  #    "line2"=>"",
  #    "city"=>"",
  #    "zip"=>"",
  #    "state"=>""}},
  #    "commit"=>"Update Event",
  #    "id"=>"2"}
  
  def update
    
    
    @event = Event.find(params[:id])
    
    @event.name = params[:event][:name]
    @event.begin_date = params[:event][:begin_date]
    @event.end_date = params[:event][:end_date]
    
    @event.description = params[:event][:description]
    @event.attendance = params[:event][:attendance]
    @event.contacts = params[:event][:contacts]
    @event.how_to_participate = params[:event][:how_to_participate]
    @event.registration_fees = params[:event][:registration_fees]
    @event.participants = params[:event][:participants]
    @event.related_events = params[:event][:related_events]
    @event.infos_extra = params[:event][:infos_extra]
    
    # address_attributes
    @event.build_address
    @event.address.update_attributes params[:event][:address_attributes]
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
end
