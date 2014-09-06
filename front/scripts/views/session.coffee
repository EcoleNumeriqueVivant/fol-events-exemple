define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class SessionView extends Backbone.View
    template: JST['front/scripts/templates/session.ejs']
    events: {}

    initialize: () ->
      @listenTo(@model, 'sync', @render)
      @listenTo(@model, 'error', @render)
      @model.fetch()

    render: ->
      @model.set('loggedin', not @model.isNew())
      super()
