define [
  'app',
  'jquery'
  'underscore'
  'backbone'
  'templates',
  'leaflet',
  'views/mail_alert',
  'views/event_on_home_proxy',
  'scrollTo'
  'zoomorscroll'
], (App, $, _, Backbone, JST, L, MailAlertView, EventOnHomeProxyView) ->
  class HomeView extends Backbone.View
    template: JST['front/scripts/templates/home.ejs']
    displayedEvents: []
    carouselTimer: null

    events:
      #'mouseenter':                                     'stopCarousel'
      #'mouseleave':                                     'startCarousel'
      'click section.background:not(.uninitialized)':   'toggleBackground'
      'click #map.background.uninitialized':            'askLocation'

    initialize: (options) ->
      super()
      # TODO: move in some conf
      L.Icon.Default.imagePath = '/images' unless L.Icon.Default.imagePath # for 'public' build

      @listenTo( @collection, 'add', @displayEvent )
      @listenTo( @collection, 'remove', @hideEvent )
      @listenTo( @collection, 'sync', =>  @activateEvent(options.focus_as_name) )
      @.on( 'render', -> @adaptResponsive(); @initMap(); @collection.fetch() )
      $(window).on( 'resize', @adaptResponsive )
      $(window).on( 'scroll', @adaptFixedElements )
      $(window).on( 'scroll', @activateFirstVisible )

      @render()

    render: ->
      super()
      #@mailalert_view = new MailAlertView(el: @$('#mail_alert_container')).render()

    remove: ->
      $(window).off 'resize'
      _(@displayedEvents).each (view) ->
        view.remove()
      super()

    displayEvent: (event) ->
      view = new EventOnHomeProxyView(model: event, map: @map, $gallery: @$('#gallery') )
      view.on 'activate', (view, options) =>
        _(@displayedEvents).find((view) -> view.active)?.deactivate() # find the already active one and deactivate it)
        @trigger 'url:fragment', view.model.get('name') if options.url
      # requests to navigate to an event
      view.on 'navigate:self', (self) => self.activate(scroll: true, url: true, map: true)
      view.on 'navigate:next', (origin) => @displayedEvents[_(@displayedEvents).indexOf(origin) + 1].activate(scroll: true, url: true, map: true)
      view.on 'navigate:first', => @displayedEvents[0].activate(scroll: true, url: true, map: true)
      view.on 'scroll:start', => @scrolling = true
      view.on 'scroll:stop', => @scrolling = false
      @displayedEvents.push(view)

      @$('#steps_container ol').append(view.as_step.$el)
      @$('#gallery ol').append(view.as_image.$el)

    activateEvent: (event_as_name) ->
      # called by the router, find the new one and activate it
      event = if event_as_name then _(@displayedEvents).find( (view) -> view.model.get('name') is event_as_name ) else @displayedEvents[0]
      event?.activate() if not event?.active

    hideEvent: (event) =>
      predicate = (view) -> view.model.id is event.id
      _(@displayedEvents).find( predicate )?.remove() # from the DOM
      @displayedEvents = _(@displayedEvents).reject( predicate ) # from the Array

    activateFirstVisible: (event) =>
      if not @scrolling
        visible = _(@displayedEvents).find( (view) -> view.as_image.$el.offset().top + view.as_image.$el.height() > $(window).prop('scrollY') )
        visible.activate(scroll: false, url: true, map: true) if visible and not visible?.active

    # TODO : check what it does and if it's still useful
    adaptResponsive: =>
      #$columns = @$('.column')
      #@vertical_setps_width = Math.ceil($columns.filter('#steps_container').outerWidth()) unless @vertical_setps_width
      #$map_column = $columns.filter('#carousel_container')
      #if(@$el.width() - @vertical_setps_width <= parseInt($map_column.css('min-width')))
      #  # take all the grid width and display steps horizontally
      #  $columns.addClass('sixteen wide').find('.steps').removeClass('vertical reversed')
      #else
      #  $columns.removeClass('sixteen wide').find('.steps').addClass('vertical reversed')

    adaptFixedElements: (event) =>
      if($(window).prop('scrollY') > @$el.offset().top)
        $('#page_container').addClass('header_shifted')
      else
        $('#page_container').removeClass('header_shifted')

    initMap: (position) ->
      @map = new L.Map($('#map .tiles').get(0), zoomControl: false)
      @map.addLayer new L.TileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        minZoom: 6, maxZoom: 18,
        attribution: "Map data © <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors"
      )
      $('#map').zoomorscroll(reset: {no_scroll_timer: 400, click: true})
               .on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', )

    askLocation: (event) ->
      event.preventDefault()
      @$('#map .ui.label .icon').addClass('loading').removeClass('map marker')
      navigator.geolocation.getCurrentPosition( @setLocation, ((error) -> console.log(error)), maximumAge: 900000 )

    setLocation: (position) =>
      @map.setView new L.latLng(position.coords.latitude, position.coords.longitude), 12
      @$('#map .ui.label .icon').removeClass('loading').addClass('map marker')
      $('#map').removeClass('uninitialized')
      _(@displayedEvents).find((view) -> view.active)?.activate(scroll: false, url: false, map: true)
      # TODO : update EventCollection according to the new location params

    toggleBackground: (event) =>
      event.preventDefault()
      mapchange_timer = window.setInterval(_(@map.invalidateSize).bind(@map, { pan: true, debounceMoveend: false} ), 100)
      that = @
      @$('section')
        .addClass('transitioning').toggleClass('background')
        .on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', (event) ->
          if event.originalEvent.propertyName is 'width' # one of the transitioning property
            that.displayedEvents[0].activate()
            $(this).removeClass('transitioning').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd')
            window.clearInterval(mapchange_timer)
        )