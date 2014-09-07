define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class AccountModel extends Backbone.Model
    url: '/users/'