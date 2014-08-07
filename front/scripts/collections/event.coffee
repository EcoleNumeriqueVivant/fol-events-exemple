define ['backbone', 'models/event'], (Backbone, EventModel) ->
  class EventCollection extends Backbone.Collection
    model: EventModel
    url: '/events.json'