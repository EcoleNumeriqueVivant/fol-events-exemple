
$ ->
 update_order = (params)->
  console.log $( "#sortable" ).sortable( "toArray" ) 
  $.getJSON "/tags/sort",{ tags : $( "#sortable" ).sortable( "toArray" ) }, (data) ->
    alert "ok"

 $( "#sortable" ).sortable
   update: update_order
 $( "#sortable" ).disableSelection()

