class SshEndpoint
  ENDPOINT_URL = ENV['CVP_SSH_RELAY'] || "http://localhost:8080"
  TOKEN_PATH   = URI.join(ENDPOINT_URL, "token").to_s
  InvalidConnectionError = Class.new(StandardError)

  def self.create_token (connection)
    if connection.protocol != :ssh
      raise InvalidConnectionError.new 'The connection\'s protocol is not ssh'
    end

    client.post TOKEN_PATH, data(connection)
  end

  private

  def self.data (connection)
    attrs = {
      :host => connection.terminal.uri
    }

    if connection.has_certificate?
      attrs[:cert] = File.new(connection.certificate.path, 'rb')
    end
    p attrs
    attrs.merge(connection.attributes)
  end

  def self.client
    RestClient
  end

end
