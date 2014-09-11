#/*global require*/
'use strict'

require.config
  deps: ['app'],
  baseUrl: '/scripts'
  paths: # paths for 'grunt serve', see Gruntfile.js requirejs.dist.options for the 'grunt build' config
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/underscore/underscore'
    semanticui: '../bower_components/semantic-ui/build/packaged/javascript/semantic'
    leaflet: '../bower_components/leaflet/dist/leaflet-src'
    zoomorscroll: '../bower_components/zoomorscroll/dist/jquery.zoomorscroll'
    scrollTo: '../bower_components/jquery.scrollTo/jquery.scrollTo'
    serializeBackbone: '../bower_components/serializeBackbone/dist/jquery.serializebackbone'
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
  App.init_env(api_root: 'http://localhost:3000/api/v1') # TODO move this in a conf for each environment
  App.init_app()

