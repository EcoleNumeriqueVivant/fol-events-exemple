define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class SemanticCheckboxView extends Backbone.View
    template: JST['front/scripts/templates/semantic_checkbox.ejs']
    tagName: 'li'
    className: 'step'

    initialize: (options) ->
      @container = options.container
      @listenTo @model, 'change', @render
      @render()

    render: () ->
      super()
      @container.append(@$el)
      @$('.ui.checkbox').checkbox()
      @