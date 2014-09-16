define [
  'underscore'
  'backbone'
  'models/region'
], (_, Backbone, RegionModel) ->

  class RegionCollection extends Backbone.Collection
    model: RegionModel
    url: 'http://localhost:9000/images/fakeapi/regions.json'