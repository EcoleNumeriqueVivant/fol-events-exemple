define [
  'underscore'
  'backbone'
  'models/type'
], (_, Backbone, TypeModel) ->

  class TypeCollection extends Backbone.Collection
    model: TypeModel
    url: '/types'
    