require_relative 'port_checker'
require 'posix/spawn' unless defined?(POSIX)
require 'sys/proctable' unless defined?(Sys::ProcTable)

class ProxyDaemon
  include POSIX::Spawn
  include Sys

  EXECUTABLE  = 'websockify'

  def self.daemon_directory
    root = Rails.root rescue File.absolute_path(File.join(File.dirname(__FILE__), '../'))
    File.join(root, '/vendor/daemons/vnc-rebind/')
  end

  def self.daemon_executable
    File.join(daemon_directory, EXECUTABLE)
  end

  attr_reader :port, :target, :pid, :host

  def initialize (connection, session=nil)
    @connection = connection
    @terminal = connection.terminal
    @target = "#{connection.host}:#{connection.port}"
    @host = '127.0.0.1'

    if session.nil?
      @port = PortChecker.rand_open
    else
      attach(session)
    end
  end

  def attach (session)
    raise InvalidProcess.new unless process_running?(session.pid)
    @pid = session.pid
    @attached = true
  end

  def start!
    return @pid unless @pid.nil?

    @port ||= PortChecker.rand_open # in case we attached and don't know the original port
    @pid, _, _, _ = popen4 command
    Process.detach(@pid)

    while PortChecker.open?(@port) do
      sleep 0.5
    end

    @attached = false
    @pid
  end

  def running?
    process_running?(@pid) and (!PortChecker.open?(port) or @attached)
  end

  def stop!
    return if @pid == nil

    if not process_running?(@pid)
      @pid = nil
      return
    end

    kill_process_and_children @pid
    @pid = nil
  end

  def command
    "#{self.class.daemon_executable} 0.0.0.0:#{@port} #{@target}"
  end

  private

  def kill_process_and_children (pid)
    to_kill = [pid]

    ProcTable.ps do |proc|
      to_kill << proc.pid if to_kill.include?(proc.ppid)
    end

    Process.kill(9, *to_kill)

    to_kill.each do |pid|
      Process.waitpid(pid) rescue nil
    end
  end

  def process_running? (pid)
    return false unless pid
    begin
      Process.getpgid(pid)
      true
    rescue Errno::ESRCH
      false
    end
  end

end
