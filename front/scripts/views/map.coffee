define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'leaflet'
  'collections/region'
  'views/event_on_map',
], ($, _, Backbone, JST, L, RegionCollection, EventOnMapView) ->
  class MapView extends Backbone.View
    template: JST['front/scripts/templates/map.ejs']
    displayedEvents: []

    initialize: () ->
      @.on( 'render', ->
        @initMap()
        if @collection.length is 0
          @collection.fetch()
        else
          models = @collection.models
          @collection.reset(models, silent: false)
      )
      @listenTo( @collection, 'add', @displayEvent )
      @render()

    initMap: =>
      @map = new L.Map(@$('#tiles').get(0), zoomControl: false)
      @map.addLayer new L.TileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        minZoom: 2, maxZoom: 18,
        attribution: "Map data © <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors"
      )
      region_layer = L.geoJson().addTo(@map)
      @regions = new RegionCollection().on('add', (region) => region_layer.addData(region.attributes) ).fetch()
      $('#map').zoomorscroll(reset: {no_scroll_timer: 400, click: true})
               .on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', )
      @map.setView(L.latLng(48.853537, 2.348305), 4, animate: true)
      
      
    displayEvent: (event) ->
      view = new EventOnMapView(model: event, map: @map)
      @displayedEvents.push(view)

