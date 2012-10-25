require_relative 'port_checker'

class ProxyDaemon
  EXECUTABLE  = 'websockify.py'

  def self.daemon_directory
    root = Rails.root rescue File.absolute_path(File.join(File.dirname(__FILE__), '../'))
    File.join(root, '/vendor/daemons/vnc-rebind/')
  end

  def self.daemon_executable
    File.join(daemon_directory, EXECUTABLE)
  end

  attr_reader :port, :target, :pid, :host

  def initialize (terminal, session=nil)
    @terminal = terminal
    @target = "#{terminal.host}:#{terminal.port}"
    @host = '192.168.88.250'

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
    @pid = Process.spawn command

    while PortChecker.open?(@port) do
      sleep 0.5
    end

    @attached = false
    @pid
  end

  def running?
    !@pid.nil? and process_running?(@pid) and (!PortChecker.open?(port) or @attached)
  end

  def stop!
    return unless @pid
    Process.kill 9, @pid
    Process.wait
    @pid = nil
  end

  def command
    "#{self.class.daemon_executable} 0.0.0.0:#{@port} #{@target} > /dev/null 2>&1"
  end

  private

  def process_running? (pid)
    begin
      Process.getpgid(pid)
      true
    rescue Errno::ESRCH
      false
    end
  end

end
