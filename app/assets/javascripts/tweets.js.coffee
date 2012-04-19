$ ->
  parseTwitterDate = ($stamp) ->
    date = new Date(Date.parse($stamp)).getDate() + "-" + new Date(Date.parse($stamp)).getMonth() + "-" + new Date(Date.parse($stamp)).getFullYear()

  replaceURLWithHTMLLinks = (text) ->
    exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i
    text.replace exp, "<a href='$1'>$1</a>"
 
  $.getJSON "http://twitter.com/statuses/user_timeline/fontaineolivres.json?callback=?", (data) ->
    _i = 0
    o = ""
    while _i < 8
      o += "<p><b>" + parseTwitterDate(data[_i].created_at) + "</b> - " + replaceURLWithHTMLLinks(data[_i].text)  + '</p>'
      _i++
    $("div.twitter").html o