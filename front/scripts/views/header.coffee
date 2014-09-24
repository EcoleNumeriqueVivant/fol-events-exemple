define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'views/login_status',
  'views/semantic_checkbox'
  'models/account',
  'models/session',
  'collections/type',
  'collections/theme',
  'serializeBackbone'
], ($, _, Backbone, JST, LoginStatusView, SemanticCheckboxView, AccountModel, SessionModel, TypeCollection, ThemeCollection) ->
  class HeaderView extends Backbone.View
    template: JST['front/scripts/templates/header.ejs']
    events:
      'click #event_search_trigger':     'toggleEventForm'
      'click #login_form_trigger':       'toggleLoginForm'
      'submit form#event_search':        'search'
      'change form#event_search':        'search_autosubmit'
      'submit form#login_form':          'login'
      'submit form#account_form':        'account'
      'click #logout_trigger':           'logout'
    
    login_view: null
    
    initialize: ->
      @on 'render', -> 
        @login_view = new LoginStatusView(model: @model, el: @$('#session_menu'))
        
        types = new TypeCollection()
        types.on('add', (type) => 
          view = new SemanticCheckboxView (
            model: new Backbone.Model(value: type.get('name'), label: type.get('name'), name: 'type'),
            container: @$('#types_list_container')
          )
        )
        types.fetch()
        
        themes= new ThemeCollection()
        themes.on('add', (theme) => 
          view = new SemanticCheckboxView (
            model: new Backbone.Model(value: theme.get('name'), label: theme.get('name'), name: 'theme'),
            container: @$('#themes_list_container')
          )
        )
        themes.fetch()
        
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

    search_autosubmit: ->
      _(@$('form#event_search').submit()).defer()

    search: (event) ->
      event.preventDefault()
      @trigger('search:params', $(event.target).serializeBackbone(array_as_string: true))
      #@toggleEventForm(event)
      
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