class EventsController < ApplicationController
  
  def future
    @events = Event.future.paginate(:page => params[:page], :per_page => 6)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def past
    @events = Event.past.paginate(:page => params[:page], :per_page => 6)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
    
  # GET /events
  # GET /events.json
  def index
    @events   = Event.paginate(:page => params[:page], :per_page => 6)   
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show

    if params[:id] == "rate"
    else  
      @event = Event.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
        format.ics do
            calendar = Icalendar::Calendar.new
            calendar.add_event(@event.to_ics)
            calendar.publish
            render :text => calendar.to_ical
        end
      end
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
    
    @event = Event.new
    
    @event.name = params[:event][:name]
    @event.begin_date = params[:event][:begin_date]
    @event.end_date = params[:event][:end_date]
    @event.subscibe_limit_date = params[:event][:subscibe_limit_date]
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
    
    @event.theme_list = params[:event][:theme_list]
    @event.typology_list = params[:event][:typology_list]
   
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
    @event.subscibe_limit_date = params[:event][:subscibe_limit_date]
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
    
    @event.theme_list = params[:event][:theme_list]
    @event.typology_list = params[:event][:typology_list]
    
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
  
  def search
    @events = nil
    # raise params.inspect 
    region = params[:region]
  
    # if params[:search] != nil && params[:search][:tag_list].count > 0
    #       @events = Event.tagged_with(params[:search][:tag_list], :any => true).paginate(:page => params[:page], :per_page => 6)
    #     else
    #      @events = Event.paginate(:page => params[:page], :per_page => 6)
    #     end 
   
    # Event.tagged_with("Festival").by_month(4, :field => :begin_date)
     
    if params[:search] != nil && params[:search][:tag_list].count > 0
      if params[:mois].to_i == -1
        @events = Event.tagged_with(params[:search][:tag_list]) #, :any => true)   
      else
        @events = Event.tagged_with(params[:search][:tag_list]).by_month(params[:mois].to_i, :field => :begin_date)            
      end   
    else
       if params[:mois].to_i == -1
         @events = Event.all  
       else
         @events = Event.by_month(params[:mois].to_i, :field => :begin_date)  
       end
    end
       
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end
  
  def comment
    if params[:body] != ""
     c = Comment.build_from(Event.find(params[:event]),session[:user_id],params[:body])
     c.save
     # raise c.errors.inspect
    end
    redirect_to :back
  end  
    
  def rate  
    puts "rate"
    event = Event.find(params[:event])
    event.rate params[:rate].to_f , current_user
    render :nothing => true, :status => 200
  end  
    
end
