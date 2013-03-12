keyBinder = (sock)->
  (container, keycode)->
    $(container).click -> sock.emit 'data', keycode

initKbdHelpers = (socket)->
  bind = keyBinder(socket)
  bind('button#CtrlC', "\u0003")

  $('button.fun').click ->
    key = parseInt $(this).attr('data-key')
    code = "\u001bO#{String.fromCharCode(79+key)}"
    socket.emit 'data', code

  bind 'button#Ins', "\u001b[2~"
  bind 'button#Del', "\u001b[3~"
  bind 'button#Home', "\u001bOH"
  bind 'button#End', "\u001bOF"
  bind 'button#PgUp', "\u001b[5~"
  bind 'button#PgDown', "\u001b[6~"


ttyReady = (socket, term)->
    beganToReceive = false
    initKbdHelpers(socket)

    term.on 'data', (data)->
      socket.emit('data', data)

    socket.on 'data', (data)->
      term.write(data)

    term.open()


initSSH = ->
  term = new Terminal(80,24)
  socket = io.connect "http://cvp-ssh.nebulent.com"
  socket.emit 'tty_connect', window._vam.token
  socket.on 'tty_ready', -> ttyReady(socket, term)
  socket.on 'tty_error', (reason)-> alert(reason)


termInit = false
$ ->
  $terminal = $('#sshTerminalButtons')
  return unless $terminal.length
  return if termInit
  termInit = true
  initSSH()

  $("#input_area").bind "textarea", (e) ->
    changeVal = $(e.currentTarget).val()
    $(".terminal").html changeVal

  $(window).on "beforeunload", ->
    $.get "/leave?id=#{@connection.id}", null
    "Your connection will be closed."
