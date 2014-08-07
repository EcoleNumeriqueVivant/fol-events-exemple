define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class HeaderView extends Backbone.View
    template: JST['front/scripts/templates/header.ejs']
    events:
      'click #event_search_trigger':  'toggleForm'
      'submit form':                  'search'

    toggleForm: (event) =>
      event.preventDefault();
      @$('#event_search').toggle()
      @$('#event_search_trigger').toggleClass('active')

    search: (event) ->
      event.preventDefault()
      @toggleForm(event)