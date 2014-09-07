define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class UserModel extends Backbone.Model
    urlRoot: '/users'