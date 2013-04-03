# VAM - vNOC Access Management
VAM depends on several services to connect to remote machines.

* * * *

## Prerequisites
- Refresh the package list, and install these packages: 

_Notes: the list of packages is specific for a Ubuntu machine, and it requires super user privilege._

```bash
sudo apt-get update
sudo apt-get install -y curl zlib1g-dev build-essential openjdk-6-jdk openjdk-6-jre openssl \
                        libreadline6 libreadline6-dev git-core libssl-dev libyaml-dev \
                        libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf \
                        libc6-dev ncurses-dev automake libtool bison subversion git nodejs guacd \
                        mongodb-server libqt4-dev libqtwebkit-dev redis-server npm libmysqlclient-dev
```

*Atention!*
You need another set of packages in order to have the guacamole relay working:

```
http://sourceforge.net/projects/guacamole/files/current/binary/ubuntu-12.10-amd64/packages/guacd_0.7.0-2_amd64.deb
http://sourceforge.net/projects/guacamole/files/current/binary/ubuntu-12.10-amd64/packages/libguac4_0.7.0-1_amd64.deb
http://sourceforge.net/projects/guacamole/files/current/binary/ubuntu-12.10-amd64/packages/libguac-client-rdp0_0.7.3-1_amd64.deb
http://sourceforge.net/projects/guacamole/files/current/binary/ubuntu-12.10-amd64/packages/libguac-client-vnc0_0.7.1-1_amd64.deb
```

Download them with wget, and install them with 

```bash
sudo dpkg -i <package name>
or
sudo dpkg -i *.deb
```
Once again, these packages are specific for Ubuntu (take a look on sourceforge to
find packages for Red Hat, Fedora; or compile them from source)

- rvm is and easy way to install, manage and work with multiple ruby environments.

```bash
\curl -L https://get.rvm.io | bash -s stable --ruby
```

Remember to check the dependencies with 

    rvm requirements
    
and install ruby 1.9.3

    rvm use 1.9.3 --install --default
    
* * * *

##Setup

- clone the repositories:

```bash
    git clone https://github.com/nebulent/cloud-view-portal.git
    git clone https://github.com/nebulent/cvp-ssh-relay
    git clone https://github.com/nebulent/cvp-tomcat-guacamole
```

- Launching the SSH Relay (at port 8080)

```bash
    cd cvp-ssh-relay
    npm install connect socket.io pty.js clone
    sudo npm install -g coffee-script
    nohup coffee server.coffee &
    cd ..
```

- Configure Redis

Append at the end of /etc/redis/redis.conf

```bash
    requirepass "password" 
```

without quotes and restart the server

```bash
    sudo service redis-server restart
```

- Launching the Guacamole Relay, with tomcat

```bash
    cd cvp-tomcat-guacamole
    echo "Starting tomcat on port 3032"
    mkdir logs
    sh startup
    cd ..
```

- Launching Cloud View Portal

```bash
    cd cloud-view-portal
    gem install bundler --no-ri --no-rdoc
    bundle install
```

Migrate the database

```bash
    RAILS_ENV=production rake db:create
    RAILS_ENV=production rake db:migrate
    RAILS_ENV=production rake db:seed
```

Precompile the assests

```bash
    rake assets:precompile
```

Set the environment variables, and run the app

```bash
    nohup RAILS_ENV=production VAM_SSH_RELAY=http://localhost:8080 VAM_GUAC_RELAY=http://localhost:3032 rails s &
```

DONE!

* * * *

## SSH

You have to start the project "cloud-ssh-relay", and note at which port it is listening
To make VAM aware of this service, you have to pass it's external url as a environment variable: 

```bash
VAM_SSH_RELAY=http://someurl:8080 rails s
```

The SSH relay project is available at https://github.com/nebulent/cvp-ssh-relay

* * * *

## Sample data
after running rake db:seed the following logins are available

organization:
  email: 'test@org.com', password: 'qweqwe',

user:
  email: 'user@org.com', password: 'qweqwe',

