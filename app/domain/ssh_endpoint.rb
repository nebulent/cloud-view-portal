class SshEndpoint
  ENDPOINT_URL = ENV['CVP_SSH_RELAY']
  TOKEN_PATH   = URI.join(ENDPOINT_URL, "token")
  InvalidConnectionError = Class.new(StandardError)

  def self.create_token (connection)
    if connection.protocol != :ssh
      raise InvalidConnectionError.new 'The connection\'s protocol is not ssh'
    end

    client.post TOKEN_PATH.to_s, data(connection)
  end

  private

  def self.data (connection)
    {
      :host => connection.terminal.uri
    }.merge(connection.attributes)
  end

  def self.client
    RestClient
  end

end
