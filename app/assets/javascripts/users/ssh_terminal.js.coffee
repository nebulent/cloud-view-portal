initSSH = (credentials)->
  term = new Terminal(80,24)
  socket = io.connect window._cvp.sshRelayHost

  beganToReceive = false

  doAutoLogin = (socket)->
    socket.emit 'data', credentials.credentials + "\r\n"

  socket.emit 'tty_connect', credentials
  socket.on 'tty_ready', ->
    term.on 'data', (data)-> socket.emit('data', data)

    socket.on 'data', (data)->
      term.write(data)
      return if beganToReceive
      setTimeout (-> doAutoLogin(socket)), 1000
      beganToReceive = true

    term.open()

$ ->
  $terminal = $('#sshTerminal')
  return unless $terminal.length

  $.getJSON window.location.pathname + '/credentials', (data)->
    initSSH(data)
