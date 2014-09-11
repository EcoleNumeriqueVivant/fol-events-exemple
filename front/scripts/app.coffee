define ['jquery', 'underscore', 'backbone', 'semanticui', 'routes/router', 'views/main', 'models/logged_user' ], ($, _, Backbone, ui, Router, MainView, LoggedUserModel) ->

  init_env: (config) ->
    
    @config = config
    
    # custom initialize View method
    Backbone.View.prototype.initialize = ->
      # add some semantic-ui logic
      @on 'render', =>  
        @$('.ui.dropdown').dropdown()
        @$('.ui.checkbox').checkbox()
        @hasRendered = true
      @hasRendered = false
    
    # custom method to render a view
    Backbone.View.prototype.render = ->
      @$el.html(@template(@model?.attributes))
      _(_(@trigger).bind(@)).defer('render')
      @

    # custom method to remove a view
    Backbone.View.prototype.remove = ->
      @$el.remove()
      @stopListening()
      @undelegateEvents() # Unbind this view relating events
      @hasRendered = false
      @

    # add periodicfetch methods to Model and Collection (TODO: build a plugin)
    Backbone.Model.prototype.startperiodicfetch = Backbone.Collection.prototype.startperiodicfetch = ->
      # wrap the function so it can call itself from within the success callback
      wrappedfetch = _(@fetch).partial(success: =>
        # @periodicinterval may have changed between the call to fetch and its suceess callback
        if @periodicinterval then @periodictimer = setTimeout( wrappedfetch , @periodicinterval)
      ).bind(@)
      wrappedfetch()

    Backbone.Model.prototype.stopperiodicfetch = Backbone.Collection.prototype.stopperiodicfetch = ->
      if @periodictimer
        clearTimeout(@periodictimer)
        delete @periodictimer

    Backbone.Model.prototype.periodicfetch = Backbone.Collection.prototype.periodicfetch = (interval) ->
      if interval 
        if not @periodictimer
          @periodicinterval = interval
          @startperiodicfetch()
        else if @periodicinterval isnt interval
          # if a new interval is set, restart the timer with the good interval 
          @stopperiodicfetch()
          @periodicinterval = interval
          @startperiodicfetch()
      else
        # if interval is falsy, stop the timer
        @periodicinterval = interval
        @stopperiodicfetch()
    
    # intercept 'sync' calls to add the API root to urls
    backboneSync = Backbone.sync;
    Backbone.sync = (method, model, options) =>
      orginal_error_callback = options.error
      options = _.extend(options, {
          url: @config.api_root + _.result(model, 'url') || urlError()
          error: (jqXHR, statusText, error) -> # using the jQuery XHR object coming from the core Backbone sync method
            console.error("#{jqXHR.status} #{error} : #{jqXHR.responseText}")
            orginal_error_callback(jqXHR, statusText, error)
      })
      backboneSync(method, model, options)
  
  init_app: ->
    # set up the application main components
    @main_view = new MainView(el: document, model: new LoggedUserModel()).render()
    @app_router = new Router(main_view: @main_view)
    @main_view.setRouter(@app_router)
    # go live
    Backbone.history.navigate('home', trigger: true) if not Backbone.history.start(pushState: false)
