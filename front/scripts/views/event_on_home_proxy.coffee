define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'views/event_on_home_map',
  'views/event_on_home_step',
  'views/event_on_home_image',
], ($, _, Backbone, JST, EventOnHomeMapView, EventOnHomeStepView, EventOnHomeImageView) ->
  class EventOnHomeProxyView extends Backbone.View
    # not bound to the DOM, used as proxy for several views

    active: false;

    initialize: (options) ->
      super()
      @map = options.map
      @$gallery = options.gallery
      @render() if not @model.isNew()
    
    
    # display the event
    #  - on the map
    #  - on the steps list
    #  - on the images carousel
    render: ->
      @as_step = new EventOnHomeStepView(model: @model, events: 
        'click':            _(@trigger).bind(@, 'navigate:self', @)
      )
      @as_map = new EventOnHomeMapView(model: @model, map: @map)
      @as_image = new EventOnHomeImageView(model: @model, events: 
        'click .down.link': _(@trigger).bind(@, 'navigate:next', @), 
        'click .up.link':   _(@trigger).bind(@, 'navigate:first', @),
        'dblclick':      _(@trigger).bind(@, 'navigate:self', @)
      )
      # this events go up the View tree
      @listenTo(@as_image, 'scroll:start', _(@trigger).partial('scroll:start') )
      @listenTo(@as_image, 'scroll:stop', _(@trigger).partial('scroll:stop') )
      @

    remove: ->
      @as_step.remove()
      @as_map.remove()
      @as_image.remove()
      @

    activate: (options = {}) ->
      options = _.defaults(options, scroll: true)
      @trigger('activate', @, options)
      @active = true
      @as_step.activate(options)
      @as_map.activate(options) if options.map
      @as_image.activate(options)
      @
      
    deactivate: ->
      @trigger('deactivate')
      @active = false
      @as_step.deactivate()
      @as_map.deactivate()
      @as_image.deactivate()
      @