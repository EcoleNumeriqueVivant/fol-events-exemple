define ['jquery', 'underscore', 'backbone', 'semanticui', 'routes/router', 'views/main', 'models/logged_user', 'moment'], ($, _, Backbone, ui, Router, MainView, LoggedUserModel, moment) ->

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
    Backbone.View.prototype.render = (extra={}) ->
      data = _(@model?.attributes).extend(extra)
      @$el.html(@template(data))
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
      model_url = _.result(model, 'url')
      re = /^http:\/\//
      if re.test(model_url)
        url = model_url
      else
        url = @config.api_root + model_url
      options = _.extend(options, 
          url: url
          error: (jqXHR, statusText, error) -> # using the jQuery XHR object coming from the core Backbone sync method
            console.error("#{jqXHR.status} #{error} : #{jqXHR.responseText}")
            orginal_error_callback(jqXHR, statusText, error)
      )
      backboneSync(method, model, options)
      
    moment.locale 'fr',
      months : "janvier_février_mars_avril_mai_juin_juillet_août_septembre_octobre_novembre_décembre".split("_")
      monthsShort : "janv._févr._mars_avr._mai_juin_juil._août_sept._oct._nov._déc.".split("_")
      weekdays : "dimanche_lundi_mardi_mercredi_jeudi_vendredi_samedi".split("_")
      weekdaysShort : "dim._lun._mar._mer._jeu._ven._sam.".split("_")
      weekdaysMin : "Di_Lu_Ma_Me_Je_Ve_Sa".split("_")
      longDateFormat : 
        LT : "HH:mm"
        L : "DD/MM/YYYY"
        LL : "D MMMM YYYY"
        LLL : "D MMMM YYYY LT"
        LLLL : "dddd D MMMM YYYY LT"
      calendar : {
        sameDay: "[Aujourd'hui à] LT"
        nextDay: '[Demain à] LT'
        nextWeek: 'dddd [à] LT'
        lastDay: '[Hier à] LT'
        lastWeek: 'dddd [dernier à] LT'
        sameElse: 'L'
      relativeTime :
        future : "dans %s"
        past : "il y a %s"
        s : "quelques secondes"
        m : "une minute"
        mm : "%d minutes"
        h : "une heure"
        hh : "%d heures"
        d : "un jour"
        dd : "%d jours"
        M : "un mois"
        MM : "%d mois"
        y : "une année"
        yy : "%d années"
      },
      ordinal : (number) ->
        number + (if number is 1 then 'er' else 'ème')
      week :
        dow : 1, # Monday is the first day of the week.
        doy : 4  # The week that contains Jan 4th is the first week of the year.
  
  init_app: ->
    # set up the application main components
    @main_view = new MainView(el: document, model: new LoggedUserModel()).render()
    @app_router = new Router(main_view: @main_view)
    @main_view.setRouter(@app_router)
    # go live
    Backbone.history.navigate('home', trigger: true) if not Backbone.history.start(pushState: false)
