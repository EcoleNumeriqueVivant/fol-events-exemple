define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class SessionModel extends Backbone.Model
    
    url: '/auth'
  
    # fake new state before save and destroy in order for consistency with the API
    # this behavior is really specific to the SessionModel
    save: (attributes, options) ->
      @isNewState = true
      super(attributes, options)
    
    destroy: (options) ->
      @isNewState = false
      super(options)
    
    isNew: ->
      @isNewState

