require 'digest/sha1'

class GuacamoleEndpoint
  def self.create_token (user, connection)
    payload = build_payload(user, connection).to_json
    token = hash "#{Time.now.to_s} #{user.id} #{connection.id}"
    redis.set token, payload
    puts token, payload
    token
  end

  private

  def self.build_payload (user, conn)
    connection_data = {
      name: "#{conn.protocol}-#{conn.terminal.uri}",
      protocol: conn.protocol,
      host: conn.terminal.uri,
      port: conn.port,
      username: conn.user,
      password: conn.credentials
    }

    { username: user.email, connections: [connection_data] }
  end

  def self.redis
    @redis ||= Redis.new :host => '127.0.0.1', :port => 6379, :password => 'deadbeef'
  end

  def self.hash (string)
    Digest::SHA1.hexdigest string
  end
end
