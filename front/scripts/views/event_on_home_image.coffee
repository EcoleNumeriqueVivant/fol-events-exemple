define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
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
