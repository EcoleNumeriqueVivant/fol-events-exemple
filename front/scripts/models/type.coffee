define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class TypeModel extends Backbone.Model
    urlRoot: '/types'
    idAttribute: 'id'
