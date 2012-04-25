# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#events").carousel('cycle')
  $("#events").carousel
    interval: 5000

$().ready ->
  $(".tiny").tinymce
    theme: "advanced"
    theme_advanced_toolbar_location: "top"
    theme_advanced_toolbar_align: "center"