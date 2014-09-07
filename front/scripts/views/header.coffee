define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'views/login_status',
  'models/account',
  'models/session',
  'serializeBackbone'
], ($, _, Backbone, JST, LoginStatusView, AccountModel, SessionModel) ->
  class HeaderView extends Backbone.View
    template: JST['front/scripts/templates/header.ejs']
    events:
      'click #event_search_trigger':     'toggleEventForm'
      'click #login_form_trigger':       'toggleLoginForm'
      'submit form#event_search':        'search'
      'submit form#login_form':          'login'
      'submit form#account_form':        'account'
      'click #logout_trigger':           'logout'
    
    session_view: null
    
    initialize: ->
      @on( 'render', ->  @session_view = new LoginStatusView(model: @model, el: @$('#session_menu')) )
    
    destroy: ->
      @session_view.destroy()
      super()
    
    toggleLoginForm: (event) =>
      event.preventDefault()
      @$('#user_forms').toggleClass('displayed')
      @$('#login_form_trigger').toggleClass('active')
    
    toggleEventForm: (event) =>
      event.preventDefault();
      @$('#event_search').toggleClass('displayed')
      @$('#event_search_trigger').toggleClass('active')

    closeIfOpen: ->
      if @$('#event_search_trigger').hasClass('active')
        $.scrollTo( $(window).prop('scrollY') - @$('#event_search').outerHeight(true))
        @toggleForm(preventDefault: ->)

    search: (event) ->
      event.preventDefault()
      @trigger('search:params', $(event.target).serializeBackbone())
      @toggleForm(event)
      
    login: (event) ->
      event.preventDefault()
      session = new SessionModel()
      session.save($(event.target).serializeBackbone(), success: => @model.fetch())
      
    logout: (event) ->
      event.preventDefault()
      session = new SessionModel()
      session.destroy(success: => @model.fetch())
      
    account: (event) ->
      event.preventDefault()
      account = new AccountModel()
      account.save($(event.target).serializeBackbone())