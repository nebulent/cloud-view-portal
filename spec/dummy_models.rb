require 'securerandom'

#Classes to make FactoryGirl work in isolation without models
class User
  attr_accessor :email
end

class Connection
  PROTOCOLS = [:vnc, :ssh, :rdp]
  attr_accessor :terminal, :port, :user, :protocol, :credentials
end

class Terminal
  attr_accessor :uri, :name
end
