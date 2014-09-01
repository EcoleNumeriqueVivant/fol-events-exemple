define ['backbone', 'leaflet'], (Backbone, L) ->
  class EventModel extends Backbone.Model
    urlRoot: '/events'
    idAttribute: 'id'

    initialize: ->
    
    parse: (response, options) ->
      _(['description', 'infos_extra', 'how_to_participate', 'contacts']).each((field) -> 
        response[field] = $('<div></div>').html(response[field]).text() # get rid of HTML tags
      )
      response.position = L.latLng(response.position.lat, response.position.lon) if response.position
      response

