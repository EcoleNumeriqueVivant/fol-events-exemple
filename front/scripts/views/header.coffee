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
    
    login_view: null
    
    initialize: ->
      @on( 'render', -> @login_view = new LoginStatusView(model: @model, el: @$('#session_menu')) )
      super()
    
    destroy: ->
      @login_view.destroy()
      super()
    
    toggleLoginForm: (event) =>
      event.preventDefault()
      @toggleEventForm(preventDefault: ->) if @$('#event_search_trigger').hasClass('active')
      @$('#user_forms').toggleClass('displayed')
      @$('#login_form_trigger').toggleClass('active')
    
    toggleEventForm: (event) =>
      event.preventDefault();
      @toggleLoginForm(preventDefault: ->) if @$('#login_form_trigger').hasClass('active')
      @$('#event_search').toggleClass('displayed')
      @$('#event_search_trigger').toggleClass('active')

    closeIfOpen: ->
      if @$('#event_search_trigger').hasClass('active')
        $.scrollTo( $(window).prop('scrollY') - @$('#event_search').outerHeight(true))
        @toggleEventForm(preventDefault: ->)
      if @$('#login_form_trigger').hasClass('active')
        $.scrollTo( $(window).prop('scrollY') - @$('#login_form').outerHeight(true))
        @toggleLoginForm(preventDefault: ->)

    search: (event) ->
      event.preventDefault()
      @trigger('search:params', $(event.target).serializeBackbone(array_as_string: true))
      @toggleEventForm(event)
      
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