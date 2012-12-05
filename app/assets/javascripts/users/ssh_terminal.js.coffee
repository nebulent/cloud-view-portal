initKbdHelpers = (socket)->
  $('button#CtrlC').click ->
    socket.emit 'data', "\u0003"

  $('button.fun').click ->
    key = parseInt $(this).attr('data-key')
    code = "\u001bO#{String.fromCharCode(79+key)}"
    socket.emit 'data', code


ttyReady = (socket, term, autoLogin)->
    beganToReceive = false
    initKbdHelpers(socket)

    term.on 'data', (data)->
      console.log JSON.stringify(data)
      socket.emit('data', data)

    socket.on 'data', (data)->
      term.write(data)
      return if beganToReceive
      setTimeout (-> autoLogin(socket)), 1000
      beganToReceive = true

    term.open()


initSSH = (credentials)->
  term = new Terminal(80,24)
  socket = io.connect window._cvp.sshRelayHost

  autoLogin = (socket)->
    socket.emit 'data', credentials.credentials + "\r\n"

  socket.emit 'tty_connect', credentials
  socket.on 'tty_ready', -> ttyReady(socket, term, autoLogin)


termInit = false
$ ->
  $terminal = $('#sshTerminal')
  return unless $terminal.length
  return if termInit
  termInit = true

  $.getJSON window.location.pathname + '/credentials', (data)->
    initSSH(data)
