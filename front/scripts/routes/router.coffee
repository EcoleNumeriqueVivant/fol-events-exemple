define [
  'backbone'
  'views/home'
  'views/event'
  'collections/event'
], (Backbone, HomeView, EventView, EventCollection) ->
  class Router extends Backbone.Router
    routes:
      "evenements":                   "events"
      "evenements/:focus":            "events"
      "evenements/:focus/details":    "eventfull"
    
    data: {}
    
    initialize: (options) ->
      @main_view = options.main_view
      @data.events = new EventCollection()
      @eventsfetched = @data.events.fetch(silent: true) 

    events: (focus_as_name = null) ->
      focus_as_name = if focus_as_name is null then null else decodeURIComponent(focus_as_name)
      if(@main_view?.current_page_view instanceof HomeView)
        @main_view.current_page_view.activateEventAsName(focus_as_name)
      else
        @main_view.injectPageView(HomeView, collection: @data.events.clone(), focus_as_name: focus_as_name)
        
    eventfull: (focus_as_name) ->
      focus_as_name = if focus_as_name is null then null else decodeURIComponent(focus_as_name)
      @eventsfetched.done => @main_view.injectPageView(EventView, model: @data.events.findWhere( 'name': focus_as_name ) )