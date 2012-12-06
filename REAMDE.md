# Cloud View Portal
CVP depends on several services to connect to remote machines.

## SSH
You have to start the project "cloud-ssh-relay", and note at which port it is listening
To make CVP aware of this service, you have to pass it's external url as a environment variable: `CVP_SSH_RELAY=http://someurl:8080 rails s`
The SSH relay project is available at https://bitbucket.org/nebulent/cvp-ssh-relay

## VNC
At the moment, CVP relies on a simple daemon which proxies traffic from VNC via websockets, and this daemon doesn't do concurrent connections. This means that every time someone connects to a VNC terminal in the app, a new daemon is launched to listen on a random open port, and the JS client connects to this port.

## RDP
No support yet.

## Also
### Gem build dependencies `libsqlite3-dev, libopenssl-dev, libqt4-dev, libqtwebkit-dev '
