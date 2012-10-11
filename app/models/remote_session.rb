require 'proxy_daemon'

class RemoteSession < ActiveRecord::Base

  attr_accessible :pid, :terminal_id

  belongs_to :terminal
  validates_presence_of :terminal

  before_create  :launch_proxy
  before_destroy :stop_proxy

  def launch_proxy
    self.pid = ProxyDaemon.new(terminal).start!
  end

  def stop_proxy
    ProxyDaemon.new(terminal, self).stop!
  end

end
