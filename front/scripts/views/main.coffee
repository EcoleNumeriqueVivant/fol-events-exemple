define [
  'jquery'
  'underscore'
  'backbone'
  'templates',
  'views/header',
], ($, _, Backbone, JST, HeaderView) ->
  class MainView extends Backbone.View # no template view (handling the global page)
      
    initialize: (options) ->
      @$page_container = @$('#page_container')
      @$header_container = @$('#header_container')
      @
      
    setRouter: (router) ->
      @router = router
      
    render: ->
      # it's handling the whole document, so add things inside instead of actually render it
      @eventsearch_view = new HeaderView(el: @$header_container).render()
      @
      
    injectPageView: (sub_view, options) ->
      # clean and switch
      @current_page_view?.remove()
      # set up the new one
      @current_page_view = new sub_view(_(options).defaults(el: @$page_container))
      @listenTo(@current_page_view, 'url:fragment', (fragment) => @router.navigate("home/#{fragment}", trigger: false))
      
  