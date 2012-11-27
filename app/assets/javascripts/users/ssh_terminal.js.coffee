$ ->
  $terminal = $('#sshTerminal')
  return unless $terminal.length

  term = new Terminal(80,24)
  socket = io.connect window._cvp.sshRelayHost

  beganToReceive = false

  doAutoLogin = (socket)->
    socket.emit 'data', window._cvp.credentials.credentials + "\r\n"
    delete window._cvp #remove any data

  socket.emit 'tty_connect', window._cvp.credentials
  socket.on 'tty_ready', ->
    term.on 'data', (data)-> socket.emit('data', data)

    socket.on 'data', (data)->
      term.write(data)
      return if beganToReceive
      doAutoLogin(socket)
      beganToReceive = true

    term.open()
