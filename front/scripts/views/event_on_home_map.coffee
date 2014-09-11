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
      @map.setView(@model.get('position'), 12, animate: true)
      @

    deactivate: ->

