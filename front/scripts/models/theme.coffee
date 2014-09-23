define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class ThemeModel extends Backbone.Model
   urlRoot: '/themes'
   idAttribute: 'id'
