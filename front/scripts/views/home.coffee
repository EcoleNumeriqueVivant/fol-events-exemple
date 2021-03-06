define [
  'app',
  'jquery'
  'underscore'
  'backbone'
  'templates',
  'views/mail_alert',
  'views/event_on_home_proxy',
  'scrollTo'
  'zoomorscroll'
], (App, $, _, Backbone, JST, MailAlertView, EventOnHomeProxyView, RegionCollection) ->
  class HomeView extends Backbone.View
    template: JST['front/scripts/templates/home.ejs']
    displayedEvents: []

    events:
      #'click section.background:not(.uninitialized)':  'toggleBackground'
      'click #call_action_location':                    'askLocation'

    initialize: (options) ->
      super()
      # TODO: move in some conf
      L.Icon.Default.imagePath = '/images' unless L.Icon.Default.imagePath # for 'public' build

      @main_view = options.main_view
      @listenTo( @main_view.eventsearch_view, 'search:params', @collection.setParams )

      @listenTo( @collection, 'add', @displayEvent )
      @listenTo( @collection, 'remove', @hideEvent )
      @listenTo( @collection, 'sync', (collection) =>  
          @activateEventAsName(if options.focus_as_name then options.focus_as_name else collection.first().get('name'))
      )
      @.on( 'render', -> 
        @adaptResponsive()
        if @collection.length is 0
          @collection.fetch()
        else
          models = @collection.models
          @collection.reset(models, silent: false)
      )
      $(window).on( 'resize', @adaptResponsive )
      $(window).on( 'scroll', @adaptFixedElements )
      $(window).on( 'scroll', @activateFirstVisible )
      $(window).on( 'scroll', @itemsProportionalScroll )

      @render()

    render: ->
      super()
      @$items_list_container = @$('#steps_container ol')
      #@mailalert_view = new MailAlertView(el: @$('#mail_alert_container')).render()

    remove: ->
      $(window).off 'resize'
      _(@displayedEvents).each (view) ->
        view.remove()
      super()

    displayEvent: (event) ->
      view = new EventOnHomeProxyView(model: event, map: @map, $gallery: @$('#carousel_container') )
      view.on 'activate', (view, options) =>
        _(@displayedEvents).find((view) -> view.active)?.deactivate() # find the already active one and deactivate it)
        @trigger 'url:fragment', view.model.get('name') if options.url
      # requests to navigate to an event
      view.on 'navigate:self', (self) => self.activate(scroll: true, url: true, map: false)
      view.on 'navigate:next', (origin) => @displayedEvents[_(@displayedEvents).indexOf(origin) + 1].activate(scroll: true, url: true, map: false)
      view.on 'navigate:first', => @displayedEvents[0].activate(scroll: true, url: true, map: false)
      view.on 'scroll:start', => @scrolling = true
      view.on 'scroll:stop', => @scrolling = false
      @displayedEvents.push(view)

      @$('#steps_container ol').append(view.as_step.$el)
      @$('#carousel_container ol').append(view.as_image.$el)

    activateEventAsName: (event_as_name) ->
      # called by the router, find the new one and activate it
      event = if event_as_name then _(@displayedEvents).findWhere( 'name': event_as_name ) else @displayedEvents[0]
      event?.activate(map: false) if not event?.active

    hideEvent: (event) =>
      predicate = (view) -> view.model.id is event.id
      _(@displayedEvents).find( predicate )?.remove() # from the DOM
      @displayedEvents = _(@displayedEvents).reject( predicate ) # from the Array

    activateFirstVisible: (event) =>
      if not @scrolling
        visible = _(@displayedEvents).find( (view) -> view.as_image.$el.offset().top + view.as_image.$el.height() > $(window).prop('scrollY') )
        visible.activate(scroll: false, url: true, map: false) if visible and not visible?.active

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

    adaptFixedElements: =>
      if($(window).prop('scrollY') > @$el.offset().top)
        $('#page_container').addClass('header_shifted')
        @main_view.eventsearch_view.closeIfOpen()
      else
        $('#page_container').removeClass('header_shifted')

    itemsProportionalScroll: =>
      ratio = $(document).scrollTop() / ($(document.documentElement).prop('scrollHeight') - $(document.documentElement).prop('clientHeight'))
      magic_shift = (ratio - 0.5) * @$items_list_container.height() # makes it more natural on both start and end sides
      items_scroll = (@$items_list_container.prop('scrollHeight') - @$items_list_container.prop('clientHeight')) * ratio + magic_shift 
      @$items_list_container.prop('scrollTop', items_scroll)
      
    askLocation: (event) ->
      event.preventDefault()
      @$('#map_container').addClass('loading')
      navigator.geolocation.getCurrentPosition( @setLocation, ( (error) -> console.log(error)), maximumAge: 900000 )

    setLocation: (position) =>
      @$('#map_container').removeClass('loading').addClass('haslocation')
      _(@displayedEvents).find((view) -> view.active)?.activate(scroll: false, url: false, map: false)
      # update EventCollection according to the new location params
      @collection.setParams('location': "#{position.coords.latitude},#{position.coords.longitude}")

    #toggleBackground: (event) =>
    #  event.preventDefault()
    #  mapchange_timer = window.setInterval(_(@map.invalidateSize).bind(@map, { pan: true, debounceMoveend: false} ), 100)
    #  that = @
    #  @$('section')
    #    .addClass('transitioning').toggleClass('background')
    #    .on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', (event) ->
    #      if event.originalEvent.propertyName is 'width' # one of the transitioning property
    #        that.displayedEvents[0].activate()
    #        $(this).removeClass('transitioning').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd')
    #        window.clearInterval(mapchange_timer)
    #    )
