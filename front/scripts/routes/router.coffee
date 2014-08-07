define [
  'backbone'
  'views/home'
  'collections/event'
], (Backbone, HomeView, EventCollection) ->
  class Router extends Backbone.Router
    routes:
      "home":              "home"
      "home/:focus":       "home"

    initialize: (options) ->
      @main_view = options.main_view

    home: (focus_as_name = null) ->
      focus_as_name = decodeURIComponent(focus_as_name)
      if(@main_view?.current_page_view instanceof HomeView)
        @main_view.current_page_view.activateEvent(focus_as_name)
      else
        @main_view.injectPageView(HomeView, collection: new EventCollection(), focus_as_name: decodeURIComponent(focus_as_name))