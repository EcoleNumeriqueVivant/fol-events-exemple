define [
  'underscore'
  'backbone',
  'models/user'
], (_, Backbone, UserModel) ->
  'use strict';

  class LoggedUserModel extends UserModel

    initialize: ->
      @reset()
      @on('error', (model, jqXHR) -> model.reset() if jqXHR.status is 401)

    reset: =>
      @clear('silent': true)
      @set('id': 'me', authenticated: false)

    parse: (response, options) ->
      response.authenticated = response.id?
      response.id = 'me'
      response
