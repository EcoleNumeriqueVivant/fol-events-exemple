define [
  'underscore'
  'backbone'
  'models/region'
], (_, Backbone, RegionModel) ->

  class RegionCollection extends Backbone.Collection
    model: RegionModel
    url: "#{location.protocol}//#{location.host}/images/fakeapi/regions.json"