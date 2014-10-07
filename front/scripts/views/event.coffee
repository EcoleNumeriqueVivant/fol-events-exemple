define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'moment'
], ($, _, Backbone, JST, moment) ->
  class EventView extends Backbone.View
    template: JST['front/scripts/templates/event.ejs']

    initialize: () ->
      super()
      @listenTo @model, 'change', @render
      @render()

    render: ->
      begin_date = @model.get('begin_date')
      end_date= @model.get('end_date')
      time_advert_level = if begin_date.isSame(moment(), 'days') or end_date.isSame(moment(), 'days') or (begin_date.isBefore() and end_date.isAfter())
          0 # now
        else if begin_date.isAfter()
          if begin_date.diff(moment(), 'days') <= 30
            1 # soon
          else
            2 # in the future
        else 
         -1 # in the past
      super (time_advert_level: time_advert_level)