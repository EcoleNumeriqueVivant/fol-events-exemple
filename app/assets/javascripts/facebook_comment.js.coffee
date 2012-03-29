((d, s, id) ->
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/fr_FR/all.js#xfbml=1"
  fjs.parentNode.insertBefore js, fjs
) document, "script", "facebook-jssdk"