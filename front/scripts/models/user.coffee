define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class UserModel extends Backbone.Model
    urlRoot: '/api/v1/users'
    
    login_status: null
    
    initialize: ->
      if(@.get('id') is 'me')
        @on( 'sync', -> @updateLoginStatus(true) )
        @on( 'error', (user, jQXHR) -> @updateLoginStatus(false) if jQXHR.status is 401 )
      else
        @login_status = false

    updateLoginStatus: (new_status) ->
      if(new_status isnt @login_status)
        @set('auth_status', new_status)
        @trigger('auth:statuschanged', new_status)