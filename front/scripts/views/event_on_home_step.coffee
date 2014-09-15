define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'moment'
], ($, _, Backbone, JST, moment) ->
  class EventOnHomeStepView extends Backbone.View
    template: JST['front/scripts/templates/event_on_home_step.ejs']
    tagName: 'li'
    className: 'ui step'

    initialize: ->
      @render() if not @model.isNew()
      @listenTo @model, 'change', @render

    activate: ->
      @$el.addClass('active')
      @

    deactivate: ->
      @$el.removeClass('active')
      @
    
    render: ->
      super(month_name: moment(@model.get('begin_date')).format('MMM'))
