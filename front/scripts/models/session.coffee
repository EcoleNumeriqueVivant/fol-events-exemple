define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class SessionModel extends Backbone.Model
    
    url: '/users/login'
  
    #initialize: ->
      
      # "sync" is called after a successful save or destroy
      #@on('sync', @checkStatus)
  
    ## fake new state before save and destroy in order for consistency with the API
    ## this behavior is really specific to the SessionModel
    #save: (attributes, options) ->
    #  @isNewState = true
    #  super(attributes, options)
    #
    #destroy: (options) ->
    #  @isNewState = false
    #  super(options)
    #
    #isNew: ->
    #  @isNewState
  
    #checkStatus: =>
    #  @updateLoginStatus(@isNew())
    #
    #updateLoginStatus: (new_status) ->
    #  if(new_status isnt @login_status)
    #    @login_status = new_status
    #    @trigger('auth:statuschanged', new_status)
