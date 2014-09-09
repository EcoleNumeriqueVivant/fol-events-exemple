define ['backbone', 'models/event'], (Backbone, EventModel) ->
  class EventCollection extends Backbone.Collection
    model: EventModel
    url: '/events'
    params: {}
    
    setParams: (params) =>
      for name, value of params
        @setParam(name, value)
      @fetch()
      @
    
    setParam: (param, value) =>
      @params[param] = value
    
    fetch: (options={}) ->
      options = _.defaults(options, data: $.param(@params))
      super(options)