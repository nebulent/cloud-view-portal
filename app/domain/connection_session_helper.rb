class ConnectionSessionHelper

  def initialize (connection, session=nil)
    @connection = connection
    @session = session
  end

  def create_session
    daemon = ProxyDaemon.new(@connection)
    @session ||= @connection.create_session

    @session.update_attributes({
      pid: daemon.start!,
      host: daemon.host,
      port: daemon.port
    })

    @session
  end

  def destroy_session
    return false if @session.nil?
    ProxyDaemon.new(@connection, @session).stop!
    @session.destroy
  end

end
