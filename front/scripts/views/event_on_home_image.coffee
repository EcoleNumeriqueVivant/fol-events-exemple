define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'moment'
], ($, _, Backbone, JST, moment) ->
  class EventOnHomeImageView extends Backbone.View
    template: JST['front/scripts/templates/event_on_home_image.ejs']
    tagName: 'li' 

    initialize: ->
      super()
      @.on 'render', => @ref_shift = parseInt($('#carousel_container').css('margin-top'))
      @render() if not @model.isNew()
      @listenTo @model, 'change', @render

    activate: (options = {}) ->
      if(@hasRendered)
        @$el.addClass('active')
        if(options.scroll)
          scroll = if @$el.filter(':first-child').length then 0 else ( @$el.offset().top - @ref_shift )
          @trigger('scroll:start')
          $.scrollTo( scroll , 500 , onAfter: => @trigger('scroll:stop'))
      else
        @once('render', _(@activate).bind(@, options))

    deactivate: ->
      @$el.removeClass('active')
      
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

