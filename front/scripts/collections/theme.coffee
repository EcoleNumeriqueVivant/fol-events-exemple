define [
  'underscore'
  'backbone'
  'models/theme'
], (_, Backbone, ThemeModel) ->

  class ThemeCollection extends Backbone.Collection
    model: ThemeModel
    url: '/themes'