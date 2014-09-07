define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class LoginStatusView extends Backbone.View
    template: JST['front/scripts/templates/login_status.ejs']
    events: {}

    initialize: () ->
      @listenTo(@model, 'change', -> @render() )
      @model.fetch()
