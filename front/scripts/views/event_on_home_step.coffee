define [
  'jquery'
  'underscore'
  'backbone'
  'templates',
], ($, _, Backbone, JST) ->
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
