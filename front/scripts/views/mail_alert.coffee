define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class MailAlertView extends Backbone.View
    template: JST['front/scripts/templates/mail_alert.ejs']