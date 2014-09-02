define [
  'jquery'
  'underscore'
  'backbone'
  'templates',
  'leaflet',
], ($, _, Backbone, JST, L) ->
  class EventOnHomeMapView extends Backbone.View

    initialize: (options) ->
      @map = options.map
      @listenTo @model, 'change', @render
      @render() if not @model.isNew()

    render: ->
      if @model.get('position')
        L.marker(@model.get('position')).addTo(@map)
      
    activate: ->
      if @model.get('position')
        try 
          @map.getCenter()
          initialized = true
        catch
          initialized = false
        finally
          @map.setView(@model.get('position'), 12, animate: true) if initialized
      @
      
      
    deactivate: ->

