#/*global require*/
'use strict'

require.config
  deps: ['app'],
  baseUrl: '/scripts'
  paths: # paths for 'grunt serve', see Gruntfile.js requirejs.dist.options for the 'grunt build' config
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/underscore/underscore'
    semanticui: 'semantic'
    leaflet: '../bower_components/leaflet/dist/leaflet-src'
    zoomorscroll: '../bower_components/zoomorscroll/dist/jquery.zoomorscroll'
    scrollTo: '../bower_components/jquery.scrollTo/jquery.scrollTo'
    serializeBackbone: '../bower_components/serializeBackbone/dist/jquery.serializebackbone'
    moment: '../bower_components/moment/moment'
  config:
    moment:
      noGlobal: true
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    semanticui:
      deps: ['jquery']
      exports: 'ui'
    leaflet:
      exports: 'L'


require ['app'], (App) ->
  App.init_env(api_root: '@@api_root')
  App.init_app()

