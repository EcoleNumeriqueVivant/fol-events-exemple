define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class RegionModel extends Backbone.Model
    url: '',

    initialize: () ->

    defaults: {}

    validate: (attrs, options) ->

    parse: (response, options) ->
      response
