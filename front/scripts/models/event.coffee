define ['backbone', 'leaflet'], (Backbone, L) ->
  class EventModel extends Backbone.Model
    urlRoot: '/events'
    idAttribute: 'id'
    
    parse: (response, options) ->
      _(['description', 'infos_extra', 'how_to_participate', 'contacts']).each((field) -> 
        if response[field]
          response[field] = $('<div></div>').html(response[field]).text() # get rid of HTML tags
      )
      _(['begin_date', 'end_date', 'subscribe_limit_date']).each((field) ->
        if response[field]
          date_digits = response[field].match(/^(\d{4})\-(\d{2})\-(\d{2})$/)
          response[field] = new Date(date_digits[1], date_digits[2], date_digits[3]) # get a Date object
      )
      response.position = if (typeof response.position isnt 'undefined') then L.latLng(response.position.lat, response.position.lon) else null
      response
