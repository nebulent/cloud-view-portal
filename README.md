# Cloud View Portal
CVP depends on several services to connect to remote machines.

## SSH
You have to start the project "cloud-ssh-relay", and note at which port it is listening
To make CVP aware of this service, you have to pass it's external url as a environment variable: `CVP_SSH_RELAY=http://someurl:8080 rails s`
The SSH relay project is available at https://bitbucket.org/nebulent/cvp-ssh-relay

## VNC
To connect to VNC and RDP machines, CVP uses guacamole. We have implemented a guacamole authentication plugin, which queries available machines from CVP app and lists them in guacamole.
The guacamole plugin along with instructions how to set up guacamole is available at https://github.com/nebulent/guacamole-auth-plugin

## Sample data
after running rake db:seed the following logins are available

organization:
  email: 'test@org.com', password: 'qweqwe',

user:
  email: 'user@org.com', password: 'qweqwe',

## Also
### Gem build dependencies `libsqlite3-dev, libopenssl-dev, libqt4-dev, libqtwebkit-dev '
