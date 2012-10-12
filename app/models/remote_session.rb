require 'proxy_daemon'

class RemoteSession < ActiveRecord::Base

  attr_accessible :pid, :terminal_id, :host, :port

  belongs_to :terminal
  validates_presence_of :terminal

  before_create  :launch_proxy
  before_destroy :stop_proxy

  def launch_proxy
    daemon = ProxyDaemon.new(terminal)
    self.pid = daemon.start!
    self.host = daemon.host
    self.port = daemon.port
  end

  def stop_proxy
    ProxyDaemon.new(terminal, self).stop!
  end

end
