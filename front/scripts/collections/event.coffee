define ['backbone', 'models/event'], (Backbone, EventModel) ->
  class EventCollection extends Backbone.Collection
    model: EventModel
    url: '/api/v1/events'
    params: 
      type: [],
      theme: [],
      month: [],
      around: null
    
    setParams: (params) =>
      for name, value of params
        @setParam(name, value)
      @fetch()
      @
    
    setParam: (param, value) =>
      if typeof @params[param] isnt 'undefined'
        @params[param] = value
    
    fetch: (options={}) ->
      options = _.defaults(options, data: $.param(@params))
      super(options)