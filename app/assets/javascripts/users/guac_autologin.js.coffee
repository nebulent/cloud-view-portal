window._cvp ?= {}
c = _cvp

createFrame = (url)->
  $body = $('body')
  $frame = $('<iframe frameborder="0" width="100%" height="100%"></iframe>')
  $frame.attr 'src', url
  $body.append $frame
  $frame

createTempFrame = (url, callback=null)->
  $frame = createFrame(url)
  $frame.load ->
    $(this).remove()
    callback() if callback

c.guacAutoLogin = (relay, view_url, token)->
  console.log token
  LOGIN_URL = relay + "/login?username=#{token}&password=whatever"
  LOGOUT_URL = relay + "/logout"

  console.log 'logout..'
  createTempFrame LOGOUT_URL, ->
    console.log 'login'
    createTempFrame LOGIN_URL, ->
      console.log 'show'
      createFrame view_url
