sshReady = false

terminalHandler = (cmd, term)->
  switch cmd
    when 'connect'
      if sshReady
        term.echo 'ERROR: You are already connected'
      else
        initSession(window._cvp.sshRelayHost, term)
    else
      if sshReady
        executeCommand(cmd, term)
      else
        term.echo 'ERROR: You are not connected\nType "connect"'


cmdSuccess = (cmd, term, output)->
  term.echo output
  term.enable()

cmdError = (cmd, term, error)->
  term.echo "ERROR: #{error}"
  term.enable()

executeCommand = (cmd, term)->
  term.disable()
  window._cvp.socket.emit 'cmd', cmd
  window._cvp.socket.on 'cmd_result', (data)->
    if data.error
      cmdError(cmd, term, data.error)
    else
      cmdSuccess(cmd, term, data.result)

initSession = (sshRelay, term)->
  term.disable()
  socket = io.connect sshRelay
  cred = window._cvp.credentials
  socket.emit 'init', {
    host: cred.host,
    port: cred.port,
    username: cred.user,
    password: cred.credentials
  }

  socket.on 'ssh_ready', ->
    console.log 'ssh connection is ready'
    window._cvp.socket = socket
    sshReady = true
    term.enable()
    term.echo 'connected!'

$ ->
  $terminal = $('#sshTerminal')
  return unless $terminal
  $terminal.terminal terminalHandler, {
    greetings: 'Cloud view portal ssh relay'
    name: 'SSH'
    height: 500,
    prompt: '$ ',
    onInit: (term)->
      window._cvp.term = term
  }

