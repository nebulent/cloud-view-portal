require 'proxy_daemon'

class RemoteSession < ActiveRecord::Base

  attr_accessible :pid, :connection_id, :host, :port

  belongs_to :connection
  validates_presence_of :connection

  before_create  :launch_proxy
  before_destroy :stop_proxy

  private

  def launch_proxy
    daemon = ProxyDaemon.new(connection)
    self.pid = daemon.start!
    self.host = daemon.host
    self.port = daemon.port
  end

  def stop_proxy
    ProxyDaemon.new(terminal, self).stop!
  end

end
